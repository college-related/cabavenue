import 'package:cabavenue/services/places_api_service.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

// ignore: must_be_immutable
class PlaceSearchTextField extends StatefulWidget {
  PlaceSearchTextField({
    Key? key,
    required this.destinationController,
    required this.sourceController,
    required this.callback,
    required this.callback2,
    required this.destinationNode,
    required this.isSearching,
    required this.sourceLocation,
    required this.destinationLocation,
  }) : super(key: key);

  final TextEditingController destinationController;
  final TextEditingController sourceController;
  dynamic sourceLocation;
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
  bool isDestination = true;

  void getplaces(String text, bool isDestination) async {
    var result = await PlacesApiService().autocomplete(context, text);
    setState(() {
      places.clear();
      places.addAll(result['results']);
    });

    isDestination = isDestination;
  }

  @override
  void initState() {
    super.initState();
  }

  void clearField(String type) {
    setState(() {
      switch (type) {
        case 'source':
          widget.sourceController.text = '';
          widget.sourceController.value = TextEditingValue.empty;
          break;
        case 'destination':
          widget.destinationController.text = '';
          widget.destinationController.value = TextEditingValue.empty;
          break;
        default:
      }
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
            child: TextFormField(
              controller: widget.sourceController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Pick up location',
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        getplaces(widget.sourceController.text, false);
                      },
                      icon: const Icon(Iconsax.search_normal),
                    ),
                    IconButton(
                      onPressed: () {
                        clearField('source');
                      },
                      icon: const Icon(Iconsax.close_circle),
                    ),
                  ],
                ),
              ),
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
                            getplaces(widget.destinationController.text, true);
                          },
                          icon: const Icon(Iconsax.search_normal),
                        ),
                        IconButton(
                          onPressed: () {
                            widget.destinationNode.requestFocus();
                            clearField('destination');
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
                          if (isDestination) {
                            widget.destinationController.text =
                                places[index]['formatted'];
                            widget.destinationLocation = {
                              "name": places[index]['formatted'],
                              "latitude": places[index]['lat'],
                              "longitude": places[index]['lon'],
                            };
                          } else {
                            widget.sourceController.text =
                                places[index]['formatted'];
                            widget.sourceLocation = {
                              "name": places[index]['formatted'],
                              "latitude": places[index]['lat'],
                              "longitude": places[index]['lon'],
                            };
                          }
                          setState(() {
                            places.clear();
                          });
                        },
                      );
                    }),
                  ),
                ),
                (widget.destinationLocation != null &&
                        widget.sourceLocation != null)
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
                            onPressed: () {
                              widget.callback2();
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
