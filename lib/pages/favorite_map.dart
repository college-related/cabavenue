// ignore_for_file: depend_on_referenced_packages

import 'package:cabavenue/providers/favorite_provider.dart';
import 'package:cabavenue/services/favorite_service.dart';
import 'package:cabavenue/utils/icon_list.dart';
import 'package:cabavenue/widgets/custom_text_field.dart';
import 'package:cabavenue/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:iconsax/iconsax.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import 'package:vector_tile_renderer/vector_tile_renderer.dart' as vector_theme;

class FavoriteMap extends StatefulWidget {
  const FavoriteMap({Key? key}) : super(key: key);

  @override
  State<FavoriteMap> createState() => _FavoriteMapState();
}

class _FavoriteMapState extends State<FavoriteMap> {
  final MapController _mapController = MapController();
  LocationData? currentLocation;
  final favKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  double latitude = 28.2624061;
  double longitude = 83.9687894;

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
      body: Consumer<FavoriteProvider>(
        builder: (context, value, child) => Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.grey,
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  zoom: 18,
                  center: LatLng(
                    value.getFavoritePlace.latitude,
                    value.getFavoritePlace.longitude,
                  ),
                  plugins: [VectorMapTilesPlugin()],
                  onPositionChanged: (map, some) {
                    latitude = map.center!.latitude;
                    longitude = map.center!.longitude;
                  },
                ),
                layers: [
                  VectorTileLayerOptions(
                    theme: _mapTheme(context),
                    tileProviders: TileProviders(
                      {
                        'openmaptiles': _cachingTileProvider(_urlTemplate()),
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.5,
              left: MediaQuery.of(context).size.width * 0.5,
              child: IconList().getList[value.getFavoritePlace.iconIndex],
            ),
            CustomFAB(
              bgColor: Colors.redAccent,
              icon: const Icon(Iconsax.close_circle),
              herotag: 'drawer',
              left: 10,
              top: MediaQuery.of(context).size.height * 0.08,
              onClick: () {
                Navigator.of(context).pop();
              },
            ),
            Positioned(
              left: 20,
              bottom: 40,
              child: Form(
                key: favKey,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
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
                      value.isEdit
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomTextField(
                                controller: nameController,
                                hintText: 'Name for place',
                                icon: Iconsax.text,
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
                                horizontal: 55.0,
                              ),
                            ),
                            onPressed: () {
                              if (favKey.currentState!.validate()) {
                                if (!value.isEdit) {
                                  FavoriteService().addFavorite(
                                    context,
                                    value.getFavoritePlace.iconIndex,
                                    latitude,
                                    longitude,
                                    nameController.text,
                                  );
                                } else {
                                  Provider.of<FavoriteProvider>(context,
                                          listen: false)
                                      .setLatLng(latitude, longitude);
                                }
                                Navigator.of(context).pop();
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Iconsax.heart_add),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: value.isEdit
                                      ? const Text('Edit location')
                                      : const Text('Add to Favorite'),
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
            ),
          ],
        ),
      ),
    );
  }
}
