import 'package:flutter/material.dart';

void main() {
  runApp(const RideHistory());
}

class RideHistory extends StatelessWidget {
  const RideHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyRidePage(title: "Ride History");
  }
}

class MyRidePage extends StatefulWidget {
  const MyRidePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyRidePage> createState() => _MyRidePageState();
}

class _MyRidePageState extends State<MyRidePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Card(
              elevation: 1,
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1547721064-da6cfb341d50"),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Gopal Prasad Shrestha',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                        Row(
                          children: [
                            Column(children: const [
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.blue,
                              ),
                              Icon(Icons.share_location_rounded,
                                  color: Colors.blue),
                            ]),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Bagar',
                                  ),
                                  Text(
                                    'Chipledhunga',
                                    textAlign: TextAlign.left,
                                  ),
                                ]),
                          ],
                        ),
                        const Text(
                          'Distance travelled: 4.5km',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 127, 127, 127)),
                        ),
                        const Text(
                          'Date: 19/06/2022',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 127, 127, 127)),
                        ),
                        const Text(
                          'Time: 2pm',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 127, 127, 127)),
                        ),
                      ],
                    ),
                    const Text(
                      '\$200',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Color.fromARGB(255, 244, 129, 36)),
                    )
                  ],
                ),
              )),
          Card(
              elevation: 1,
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1547721064-da6cfb341d50"),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Gopal Prasad Shrestha',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                        Row(
                          children: [
                            Column(children: const [
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.blue,
                              ),
                              Icon(Icons.share_location_rounded,
                                  color: Colors.blue),
                            ]),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Naya Gaon, Pokhara',
                                  ),
                                  Text(
                                    'Lamachaur, Pokhara',
                                    textAlign: TextAlign.left,
                                  ),
                                ]),
                          ],
                        ),
                        const Text(
                          'Distance travelled: 4.5km',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 127, 127, 127)),
                        ),
                        const Text(
                          'Date: 19/06/2022',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 127, 127, 127)),
                        ),
                        const Text(
                          'Time: 2pm',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 127, 127, 127)),
                        ),
                      ],
                    ),
                    const Text(
                      '\$350',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Color.fromARGB(255, 244, 129, 36)),
                    )
                  ],
                ),
              )),
          Card(
              elevation: 1,
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1547721064-da6cfb341d50"),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Gopal Prasad Shrestha',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                        Row(
                          children: [
                            Column(children: const [
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.blue,
                              ),
                              Icon(Icons.share_location_rounded,
                                  color: Colors.blue),
                            ]),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Naya Gaon, Pokhara',
                                  ),
                                  Text(
                                    'Lamachaur, Pokhara',
                                    textAlign: TextAlign.left,
                                  ),
                                ]),
                          ],
                        ),
                        const Text(
                          'Distance travelled: 4.5km',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 127, 127, 127)),
                        ),
                        const Text(
                          'Date: 19/06/2022',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 127, 127, 127)),
                        ),
                        const Text(
                          'Time: 2pm',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 127, 127, 127)),
                        ),
                      ],
                    ),
                    const Text(
                      '\$250',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Color.fromARGB(255, 244, 129, 36)),
                    )
                  ],
                ),
              )),
          Card(
              elevation: 1,
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1547721064-da6cfb341d50"),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Gopal Prasad Shrestha',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                        Row(
                          children: [
                            Column(children: const [
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.blue,
                              ),
                              Icon(Icons.share_location_rounded,
                                  color: Colors.blue),
                            ]),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Bagar',
                                  ),
                                  Text(
                                    'Chipledhunga',
                                    textAlign: TextAlign.left,
                                  ),
                                ]),
                          ],
                        ),
                        const Text(
                          'Distance travelled: 4.5km',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 127, 127, 127)),
                        ),
                        const Text(
                          'Date: 19/06/2022',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 127, 127, 127)),
                        ),
                        const Text(
                          'Time: 2pm',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 127, 127, 127)),
                        ),
                      ],
                    ),
                    const Text(
                      '\$300',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Color.fromARGB(255, 244, 129, 36)),
                    )
                  ],
                ),
              )),
          const Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1547721064-da6cfb341d50"),
              ),
              title: Text('Bagar to Chipledhunga'),
              subtitle: Text('Driver: Harry Smith'),
              trailing: Text(r''),
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            ),
          ),
          const Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1547721064-da6cfb341d50"),
              ),
              title: Text('Bagar to Chipledhunga'),
              subtitle: Text('Driver: Harry Smith'),
              trailing: Text(r''),
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            ),
          ),
        ],
      ),
    );
  }
}
