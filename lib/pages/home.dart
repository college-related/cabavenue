// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:cabavenue/widgets/floating_action_button.dart';
import 'package:cabavenue/widgets/home/custom_chip.dart';
import 'package:cabavenue/widgets/home/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import 'package:vector_tile_renderer/vector_tile_renderer.dart' as vector_theme;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  late FocusNode myFocusNode;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
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
    return 'https://tiles.stadiamaps.com/data/openmaptiles/{z}/{x}/{y}.pbf?api_key=ed923bf6-7a17-4cec-aada-832cdb4050e7';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: CustomDrawer(
        customKey: _key,
      ),
      // backgroundColor: Colors.grey,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.grey,
            child: FlutterMap(
              options: MapOptions(
                zoom: 18,
                center: LatLng(28.2624061, 83.9687894),
                plugins: [VectorMapTilesPlugin()],
              ),
              layers: [
                VectorTileLayerOptions(
                    theme: _mapTheme(context),
                    tileProviders: TileProviders({
                      'openmaptiles': _cachingTileProvider(_urlTemplate())
                    })),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      width: 20.0,
                      height: 20.0,
                      point: LatLng(28.2624061, 83.9687894),
                      builder: (ctx) => const FlutterLogo(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          CustomFAB(
            bgColor: Colors.redAccent,
            icon: const Icon(Icons.campaign_outlined),
            herotag: 'emergency-services',
            right: 10,
            top: MediaQuery.of(context).size.height * 0.08,
            onClick: () {},
          ),
          CustomFAB(
            bgColor: Colors.blueAccent,
            icon: Icon(Icons.favorite_border_outlined),
            herotag: 'saved-places',
            left: 10,
            bottom: MediaQuery.of(context).size.height * 0.45,
            onClick: () {},
          ),
          CustomFAB(
            bgColor: Colors.blueAccent,
            icon: Icon(Icons.menu),
            herotag: 'drawer',
            left: 10,
            bottom: MediaQuery.of(context).size.height * 0.35,
            onClick: () {
              _key.currentState!.openDrawer();
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            top: MediaQuery.of(context).size.height * 0.65,
            bottom: MediaQuery.of(context).size.height * 0.25,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CustomChip(
                    label: 'Map',
                    icon: Icons.location_on_outlined,
                  ),
                  CustomChip(
                    label: 'Home',
                    icon: Icons.home_outlined,
                  ),
                  CustomChip(
                    label: 'Office',
                    icon: Icons.maps_home_work_outlined,
                  ),
                  CustomChip(
                    label: 'Cinema',
                    icon: Icons.camera_indoor_outlined,
                  ),
                  CustomChip(
                    label: 'Add new',
                    icon: Icons.add_location_alt_outlined,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, -1), // changes position of shadow
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select a destination',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  TextField(
                    readOnly: true,
                    onTap: () {
                      myFocusNode.requestFocus();
                      setState(() {
                        _isSearching = true;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Destination',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: _isSearching ? MediaQuery.of(context).size.height : 0,
            color: Colors.white,
            padding: const EdgeInsets.only(
              top: 35.0,
              left: 10.0,
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    setState(() {
                      _isSearching = false;
                    });
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    left: 20.0,
                    right: 20.0,
                    bottom: 5.0,
                  ),
                  child: TextFormField(
                    initialValue: 'Your current location',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Pick up location',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    focusNode: myFocusNode,
                    autofocus: _isSearching ? true : false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Destination',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
