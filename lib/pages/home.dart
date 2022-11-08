// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, use_build_context_synchronously
import 'dart:convert';

import 'package:cabavenue/models/user_model.dart';
import 'package:cabavenue/providers/destination_provider.dart';
import 'package:cabavenue/providers/profile_provider.dart';
import 'package:cabavenue/providers/ride_provider.dart';
import 'package:cabavenue/services/notifaction_service.dart';
import 'package:cabavenue/services/places_api_service.dart';
import 'package:cabavenue/services/ride_service.dart';
import 'package:cabavenue/utils/icon_list.dart';
import 'package:cabavenue/widgets/accepted_container.dart';
import 'package:cabavenue/widgets/floating_action_button.dart';
import 'package:cabavenue/widgets/home/drawer.dart';
import 'package:cabavenue/widgets/place_search_field.dart';
import 'package:cabavenue/widgets/requesting_container.dart';
import 'package:cabavenue/widgets/rides_list.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import 'package:vector_tile_renderer/vector_tile_renderer.dart' as vector_theme;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final _rideRequestFormKey = GlobalKey<FormState>();
  late FocusNode myFocusNode;
  double initialDestinationContainerPosition = 540.0;
  bool _isSearching = false,
      _isDestinationSet = false,
      _isRequesting = false,
      _isAccepted = false,
      _settingRating = false;
  DateTime? currentBackPressTime;

  final MapController _mapController = MapController();
  LocationData? currentLocation;

  final TextEditingController _destinationController = TextEditingController();
  final RideService _rideService = RideService();
  final NotificationService _notificationService = NotificationService();
  dynamic sourceLocation;
  // dynamic destinationLocation;
  List drivers = [];
  String price = '';
  double rating = 0;
  List<Polyline> polylines = [];

  getRoutePolylinePoints(startLat, startLng, desLat, desLng) async {
    var points = await PlacesApiService().getRoutingPolyPoint(
      context,
      startLat,
      startLng,
      desLat,
      desLng,
    );
    polylines.add(Polyline(
      points: points,
      color: Colors.purpleAccent,
      strokeWidth: 5,
    ));
    _mapController.move(
      LatLng(
        currentLocation?.latitude ?? 28.2624061,
        currentLocation?.longitude ?? 83.9687894,
      ),
      16,
    );
    setState(() {});
  }

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );
    location.onLocationChanged.listen((newLoc) {
      setState(() {
        currentLocation = newLoc;
        _mapController.move(LatLng(newLoc.latitude!, newLoc.longitude!), 18);
      });
    });
  }

  void getProfileData() async {
    /**
     * Add user data from localstorage to provider
     */
    UserModel oldUser = ProfileProvider().getUserData;

    if (oldUser.accessToken == '') {
      var u = await const FlutterSecureStorage()
          .read(key: "CABAVENUE_USERDATA_PASSENGER");
      if (u != null) {
        UserModel user = await UserModel.deserialize(u);
        Provider.of<ProfileProvider>(context, listen: false).setUserData(user);
      }
    }
  }

  void getInitialLocation() async {
    currentLocation = await Location().getLocation();
  }

  @override
  void initState() {
    super.initState();

    getInitialLocation();
    myFocusNode = FocusNode();
    getProfileData();
    checkInRide();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleNotification(message);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      handleNotification(message);
    });
    getCurrentLocation();
  }

  checkInRide() async {
    var user =
        await FlutterSecureStorage().read(key: "CABAVENUE_USERDATA_PASSENGER");
    if (jsonDecode(user.toString())['isInRide']) {
      var data = await _rideService.currentRide(context);

      Provider.of<RideProvider>(context, listen: false).setRide(data['ride']);
      Provider.of<RideProvider>(context, listen: false)
          .setDriver(data['driver']);
      Provider.of<DestinationProvider>(context, listen: false)
          .setDestination(data['destination']);
      setState(() {
        _isSearching = true;
        _isAccepted = true;
      });
    }
  }

  handleNotification(RemoteMessage message) {
    if (message.notification!.title == 'Request Accepted') {
      Provider.of<ProfileProvider>(context, listen: false).setInRide(true);
      Fluttertoast.showToast(
        msg: 'Your ride is accpeted',
        backgroundColor: Colors.green[600],
      );
    } else if (message.notification!.title == 'Request Cancelled') {
      Fluttertoast.showToast(
        msg: 'Your ride has been rejected',
        backgroundColor: Colors.red[600],
      );
    } else {
      Provider.of<ProfileProvider>(context, listen: false).setInRide(false);
      Fluttertoast.showToast(
        msg: 'Your ride has been completed',
        backgroundColor: Colors.green[600],
      );
    }
    setState(() {
      if (message.notification!.title == 'Request Accepted') {
        _isAccepted = true;
      }
      if (message.notification!.title == 'Ride Completed') {
        _isAccepted = false;
        _isSearching = false;
        _isDestinationSet = false;
        _settingRating = true;
        rating = 0;
        polylines.clear();
      }
      _isRequesting = false;
    });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  VectorTileProvider _cachingTileProvider(String urlTemplate) {
    return MemoryCacheVectorTileProvider(
      delegate: NetworkVectorTileProvider(
        urlTemplate: urlTemplate,
        maximumZoom: 14,
      ),
      maxSizeBytes: 1024 * 1024 * 2,
    );
  }

  _mapTheme(BuildContext context) {
    return vector_theme.ProvidedThemes.lightTheme();
  }

  String _urlTemplate() {
    // return 'https://api.maptiler.com/tiles/v3-4326/tiles.json?key=x0zt2WeTRQEvX2oFs7PX';
    return 'https://tiles.stadiamaps.com/data/openmaptiles/{z}/{x}/{y}.pbf?api_key=ed923bf6-7a17-4cec-aada-832cdb4050e7';
  }

  setRestFormBools(bool value, String type) {
    setState(() {
      switch (type) {
        case 'requesting':
          _isRequesting = value;
          break;
        case 'destination':
          _isDestinationSet = value;
          break;
        case 'accept':
          _isAccepted = value;
          break;
        case 'searching':
          _isSearching = value;
          break;
        default:
      }
    });
  }

  setSearchingAndSource() {
    setState(() {
      _isSearching = true;
    });
    sourceLocation = {
      "name": "Current Location",
      "latitude": currentLocation!.latitude,
      "longitude": currentLocation!.longitude,
    };
  }

  searchRides() async {
    var driverList = await _rideService.searchRides(
      context,
      currentLocation!.latitude.toString(),
      currentLocation!.longitude.toString(),
      sourceLocation,
      Provider.of<DestinationProvider>(context, listen: false).getDestination,
    );

    setState(() {
      drivers.clear();
      drivers.addAll(driverList['drivers']);
      price = driverList['price'].toString();
    });

    getRoutePolylinePoints(
      currentLocation!.latitude,
      currentLocation!.longitude,
      Provider.of<DestinationProvider>(context, listen: false)
          .getDestination['latitude'],
      Provider.of<DestinationProvider>(context, listen: false)
          .getDestination['longitude'],
    );
  }

  requestCab(BuildContext context, String id, dynamic driver) async {
    var ride = await _rideService.requestRide(
      context,
      id,
      Provider.of<DestinationProvider>(context, listen: false).getDestination,
      sourceLocation,
      price,
    );
    Provider.of<RideProvider>(context, listen: false).setRide(ride);
    Provider.of<RideProvider>(context, listen: false).setDriver({
      'name': driver['name'],
      'model': driver['model'],
      'color': driver['color'],
      'plateNumber': driver['plateNumber'],
      'phoneNumber': driver['phone'],
    });
    await _notificationService.sendRideRequestNotification(
      context,
      id,
      'New ride request',
      'Someone has request a ride',
    );
  }

  cancelRequest(BuildContext context, String id, String driverId) async {
    _rideService.cancelRequest(context, id);
    Provider.of<RideProvider>(context, listen: false).setRide({});
    await _notificationService.sendRideRequestNotification(
      context,
      driverId,
      'Ride request cancel',
      'A ride request has been cancelled',
    );
  }

  rateRide(BuildContext context, String id, String driverId) async {
    _rideService.rateRide(context, id, rating);
    Provider.of<DestinationProvider>(context, listen: false)
        .setDestination(null);
    Provider.of<RideProvider>(context, listen: false).setRide({});
    Provider.of<RideProvider>(context, listen: false).setDriver({});
    await _notificationService.sendRideRequestNotification(
      context,
      driverId,
      'Rating',
      'You got a rating of $rating from recent ride',
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: _key,
        drawer: CustomDrawer(
          customKey: _key,
        ),
        resizeToAvoidBottomInset: false,
        body: Consumer<DestinationProvider>(
          builder: (context, value, child) => Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6,
                color: Colors.grey,
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    // onPositionChanged: ((position, hasGesture) {

                    // }),
                    zoom: 18,
                    center: LatLng(
                      currentLocation?.latitude ?? 28.2624061,
                      currentLocation?.longitude ?? 83.9687894,
                    ),
                    plugins: [VectorMapTilesPlugin()],
                  ),
                  layers: [
                    VectorTileLayerOptions(
                        theme: _mapTheme(context),
                        tileProviders: TileProviders({
                          'openmaptiles': _cachingTileProvider(_urlTemplate()),
                        })),
                    PolylineLayerOptions(
                      polylines: polylines,
                    ),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          width: 20.0,
                          height: 20.0,
                          point: LatLng(
                            currentLocation?.latitude ?? 28.2624061,
                            currentLocation?.longitude ?? 83.9687894,
                          ),
                          builder: (ctx) => Icon(
                            Iconsax.direct_up5,
                            size: 22,
                            color: Colors.purple[600],
                            shadows: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 8,
                                blurRadius: 10,
                                offset: const Offset(2, 5),
                              ),
                            ],
                          ),
                        ),
                        value.getDestination != null
                            ? Marker(
                                width: 20.0,
                                height: 20.0,
                                point: LatLng(
                                  value.getDestination['latitude'],
                                  value.getDestination['longitude'],
                                ),
                                builder: (ctx) => Icon(
                                  Iconsax.gps5,
                                  size: 22,
                                  color: Colors.red[600],
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 8,
                                      blurRadius: 10,
                                      offset: const Offset(2, 5),
                                    ),
                                  ],
                                ),
                              )
                            : Marker(
                                width: 0.0,
                                height: 0.0,
                                point: LatLng(
                                  28.223877,
                                  83.987730,
                                ),
                                builder: (ctx) => Icon(
                                  Iconsax.gps5,
                                  size: 0,
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
              CustomFAB(
                bgColor: Colors.redAccent,
                icon: const Icon(Iconsax.radar_1),
                herotag: 'emergency-services',
                right: 10,
                top: MediaQuery.of(context).size.height * 0.08,
                onClick: () {
                  Navigator.pushNamed(context, '/emergency');
                },
              ),
              !_isAccepted
                  ? CustomFAB(
                      bgColor: Colors.blueAccent,
                      icon: Icon(Iconsax.menu5),
                      herotag: 'drawer',
                      left: 10,
                      top: MediaQuery.of(context).size.height * 0.08,
                      onClick: () {
                        _key.currentState!.openDrawer();
                      },
                    )
                  : Container(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, -1),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 30.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black26,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Select a destination',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 20.0,
                        ),
                        child: TextField(
                          readOnly: true,
                          onTap: () {
                            myFocusNode.requestFocus();
                            setSearchingAndSource();
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: const Icon(Iconsax.location),
                            labelText: 'Where do you want to go?',
                            isDense: true,
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.18,
                        child: Consumer<ProfileProvider>(
                          builder: (context, value, child) {
                            var fav = value.getUserData.favoritePlaces;

                            return ListView.builder(
                              padding: const EdgeInsets.all(0),
                              itemCount: fav!.length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  setSearchingAndSource();
                                  Provider.of<DestinationProvider>(
                                    context,
                                    listen: false,
                                  ).setDestination({
                                    "name": fav[index]['name'],
                                    "latitude": fav[index]['latitude'],
                                    "longitude": fav[index]['longitude'],
                                  });
                                  _destinationController.text =
                                      fav[index]['givenName'];
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: 20.0,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.black12,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.grey[400],
                                          foregroundColor: Colors.black,
                                          child: IconList()
                                              .getList[fav[index]['iconIndex']],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            fav[index]['givenName'],
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            '${fav[index]['latitude']}, ${fav[index]['longitude']}',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15.0,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed('/favorite-places');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Iconsax.heart_add),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text('Add Favorite'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: _isSearching
                      ? (!_isRequesting && !_isDestinationSet && !_isAccepted)
                          ? MediaQuery.of(context).size.height
                          : MediaQuery.of(context).size.height * 0.5
                      : 0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, -1),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _rideRequestFormKey,
                    child: _isAccepted
                        ? AcceptedContainer()
                        : _isRequesting
                            ? Consumer<RideProvider>(
                                builder: (context, value, child) =>
                                    RequestingContainer(
                                  callback: () {
                                    var ride = value.getRide;
                                    cancelRequest(
                                      context,
                                      ride['_id'].toString(),
                                      ride['driver'],
                                    );
                                    setState(() {
                                      polylines.clear();
                                    });
                                    setRestFormBools(false, 'requesting');
                                  },
                                ),
                              )
                            : _isDestinationSet
                                ? Consumer<RideProvider>(
                                    builder: (context, value, child) =>
                                        RideList(
                                      callback: () =>
                                          setRestFormBools(true, 'requesting'),
                                      callback2: () {
                                        setRestFormBools(false, 'destination');
                                        setRestFormBools(false, 'searching');
                                        Provider.of<DestinationProvider>(
                                                context,
                                                listen: false)
                                            .setDestination(null);
                                        setState(() {
                                          polylines.clear();
                                        });
                                      },
                                      request: requestCab,
                                      drivers: drivers,
                                      price: price,
                                    ),
                                  )
                                : PlaceSearchTextField(
                                    isSearching: _isSearching,
                                    destinationController:
                                        _destinationController,
                                    callback: () {
                                      setRestFormBools(false, 'searching');
                                      Provider.of<DestinationProvider>(context,
                                              listen: false)
                                          .setDestination(null);
                                    },
                                    callback2: () async {
                                      await searchRides();
                                      setRestFormBools(true, 'destination');
                                    },
                                    destinationNode: myFocusNode,
                                    destinationLocation: value.getDestination,
                                  ),
                  ),
                ),
              ),
              _settingRating
                  ? Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black26,
                    )
                  : Container(),
              _settingRating
                  ? Consumer<RideProvider>(
                      builder: (context, value, child) => Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 20,
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black38.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, -1),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () {
                                    Provider.of<DestinationProvider>(context,
                                            listen: false)
                                        .setDestination(null);
                                    Provider.of<RideProvider>(context,
                                            listen: false)
                                        .setRide({});
                                    Provider.of<RideProvider>(context,
                                            listen: false)
                                        .setDriver({});
                                    setState(() {
                                      _settingRating = false;
                                      rating = 0;
                                    });
                                  },
                                  icon: Icon(Iconsax.close_circle),
                                  iconSize: 45,
                                ),
                              ),
                              Text(
                                'Rate your recent ride',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: SmoothStarRating(
                                  allowHalfRating: false,
                                  starCount: 5,
                                  rating: rating,
                                  size: 50,
                                  spacing: 2,
                                  defaultIconData: Iconsax.star,
                                  filledIconData: Iconsax.star1,
                                  borderColor: Colors.orange,
                                  color: Colors.orange,
                                  onRatingChanged: (value) {
                                    setState(() {
                                      rating = value;
                                    });
                                  },
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green[700],
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  rateRide(
                                    context,
                                    value.getRide['_id'].toString(),
                                    value.getRide['driver'],
                                  );
                                  setState(() {
                                    _settingRating = false;
                                    rating = 0;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 40,
                                  ),
                                  child: Text('Submit'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    if (_isSearching) {
      setState(() {
        _isSearching = false;
      });
      return Future.delayed(const Duration(seconds: 1), () => false);
    }
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Click again to exit the app");
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
