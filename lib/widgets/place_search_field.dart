import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PlaceSearchTextField extends StatefulWidget {
  const PlaceSearchTextField({
    Key? key,
    required this.destinationController,
    required this.sourceController,
    required this.callback,
    required this.callback2,
    required this.destinationNode,
    required this.isSearching,
  }) : super(key: key);

  final TextEditingController destinationController;
  final TextEditingController sourceController;
  final Function callback;
  final Function callback2;
  final FocusNode destinationNode;
  final bool isSearching;

  @override
  State<PlaceSearchTextField> createState() => _PlaceSearchTextFieldState();
}

class _PlaceSearchTextFieldState extends State<PlaceSearchTextField> {
  List places = [];

  void getplaces() async {
    places.clear();
    places.addAll([
      {
        'formated': 'Lamachour Marg',
        'latitude': '28.260957',
        'longitude': '83.973691',
        'street': 'Lamachour'
      },
      {
        'formated': 'Lamachaur Hemja Permanent Bridge, Kaski, Nepal',
        'latitude': '28.263177',
        'longitude': '83.960682',
        'street': 'Lamachaur Hemja Permanent Bridge, Kaski, Nepal'
      },
      {
        'formated': 'Lamachour Marg',
        'latitude': '28.260957',
        'longitude': '83.973691',
        'street': 'Lamachour'
      },
      {
        'formated': 'Lamachaur Hemja Permanent Bridge, Kaski, Nepal',
        'latitude': '28.263177',
        'longitude': '83.960682',
        'street': 'Lamachaur Hemja Permanent Bridge, Kaski, Nepal'
      },
      {
        'formated': 'Lamachour Marg',
        'latitude': '28.260957',
        'longitude': '83.973691',
        'street': 'Lamachour'
      },
      {
        'formated': 'Lamachaur Hemja Permanent Bridge, Kaski, Nepal',
        'latitude': '28.263177',
        'longitude': '83.960682',
        'street': 'Lamachaur Hemja Permanent Bridge, Kaski, Nepal'
      },
      {
        'formated': 'Lamachour Marg',
        'latitude': '28.260957',
        'longitude': '83.973691',
        'street': 'Lamachour'
      },
      {
        'formated': 'Lamachaur Hemja Permanent Bridge, Kaski, Nepal',
        'latitude': '28.263177',
        'longitude': '83.960682',
        'street': 'Lamachaur Hemja Permanent Bridge, Kaski, Nepal'
      },
    ]);
  }

  @override
  void initState() {
    super.initState();
    // widget.destinationNode.addListener(() {
    //   if (widget.destinationController.text.length >= 3) {
    //     setState(() {
    //       getplaces();
    //     });
    //   }
    // });
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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Pick up location',
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Destination',
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
                        title: Text(places[index]['formated']),
                        onTap: () {},
                      );
                    }),
                  ),
                ),
                widget.destinationController.text != ''
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
