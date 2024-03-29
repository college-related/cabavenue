import 'package:flutter/material.dart';

class RideList extends StatefulWidget {
  const RideList({
    Key? key,
    required this.callback,
    required this.callback2,
    required this.request,
    required this.drivers,
    required this.price,
  }) : super(key: key);

  final Function callback;
  final Function callback2;
  final Function request;
  final List drivers;
  final String price;

  @override
  State<RideList> createState() => _RideListState();
}

class _RideListState extends State<RideList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 30.0,
          ),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black26,
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Available Cabs',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                'Rs. ${num.parse(widget.price).toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.25,
                child: ListView.builder(
                  itemCount: widget.drivers.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 15.0,
                    ),
                    margin: const EdgeInsets.only(right: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2000),
                          child: Image.network(
                            widget.drivers[index]['img'] ??
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdc7e_UgMbxfQYnpCkxb0ff5btKUm9xuj99Q&usqp=CAU',
                            height: 90,
                            width: 90,
                          ),
                        ),
                        Text(
                          widget.drivers[index]['vehicle']['model'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.drivers[index]['vehicle']['color'],
                          style: const TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 35.0,
                            ),
                          ),
                          onPressed: () async {
                            await widget
                                .request(context, widget.drivers[index]['id'], {
                              'name': widget.drivers[index]['name'],
                              'model': widget.drivers[index]['vehicle']
                                  ['model'],
                              'color': widget.drivers[index]['vehicle']
                                  ['color'],
                              'plateNumber': widget.drivers[index]['vehicle']
                                  ['plateNumber'],
                              'phoneNumber': widget.drivers[index]['phone'],
                            });
                            widget.callback();
                          },
                          child: const Text(
                            'Request',
                            style: TextStyle(
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 55.0,
                    ),
                  ),
                  onPressed: () {
                    widget.callback2();
                  },
                  child: const Text('Cancel'),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
