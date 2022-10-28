import 'package:cabavenue/providers/destination_provider.dart';
import 'package:cabavenue/services/places_api_service.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PlaceSearchTextField extends StatefulWidget {
  PlaceSearchTextField({
    Key? key,
    required this.destinationController,
    required this.callback,
    required this.callback2,
    required this.destinationNode,
    required this.isSearching,
    required this.destinationLocation,
  }) : super(key: key);

  final TextEditingController destinationController;
  dynamic destinationLocation;
  final Function callback;
  final Function callback2;
  final FocusNode destinationNode;
  final bool isSearching;

  @override
  State<PlaceSearchTextField> createState() => _PlaceSearchTextFieldState();
}

class _PlaceSearchTextFieldState extends State<PlaceSearchTextField> {
  List places = [];

  void getplaces(String text) async {
    var result = await PlacesApiService().autocomplete(context, text);
    setState(() {
      places.clear();
      places.addAll(result['results']);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void clearField() {
    setState(() {
      widget.destinationController.text = '';
      widget.destinationController.value = TextEditingValue.empty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, left: 10.0, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              widget.destinationController.text = '';
              widget.callback();
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Iconsax.location),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Pick up location'),
                    Text(
                      'Current Location',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  controller: widget.destinationController,
                  focusNode: widget.destinationNode,
                  autofocus: widget.isSearching,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Destination',
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            widget.destinationNode.unfocus();
                            getplaces(widget.destinationController.text);
                          },
                          icon: const Icon(Iconsax.search_normal),
                        ),
                        IconButton(
                          onPressed: () {
                            widget.destinationNode.requestFocus();
                            clearField();
                          },
                          icon: const Icon(Iconsax.close_circle),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 20),
                    itemCount: places.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        leading: const Icon(Iconsax.location),
                        title: Text(places[index]['formatted']),
                        onTap: () {
                          widget.destinationController.text =
                              places[index]['formatted'];

                          setState(() {
                            Provider.of<DestinationProvider>(
                              context,
                              listen: false,
                            ).setDestination({
                              "name": places[index]['formatted'],
                              "latitude": places[index]['lat'],
                              "longitude": places[index]['lon'],
                            });
                            places.clear();
                          });
                        },
                      );
                    }),
                  ),
                ),
                widget.destinationLocation != null
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 30.0,
                        ),
                        child: Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green[400],
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 35.0,
                              ),
                            ),
                            onPressed: () async {
                              await widget.callback2();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Iconsax.car),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text('Search Ride'),
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
        ],
      ),
    );
  }
}
