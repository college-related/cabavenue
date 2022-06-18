import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

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
            // child:
            // FlutterMap(
            //   options: MapOptions(
            //     zoom: 18,
            //     center: LatLng(28.2624061, 83.9687894),
            //     plugins: [VectorMapTilesPlugin()],
            //   ),
            //   layers: [
            //     VectorTileLayerOptions(
            //         theme: _mapTheme(context),
            //         tileProviders: TileProviders({
            //           'openmaptiles': _cachingTileProvider(_urlTemplate())
            //         })),
            //     // TileLayerOptions(
            //     //   urlTemplate:
            //     //       "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            //     //   subdomains: ['a', 'b', 'c'],
            //     // ),
            //     new MarkerLayerOptions(
            //       markers: [
            //         new Marker(
            //           width: 20.0,
            //           height: 20.0,
            //           point: new LatLng(28.2624061, 83.9687894),
            //           builder: (ctx) => const FlutterLogo(),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
          ),
          Positioned(
            right: 10,
            top: MediaQuery.of(context).size.height * 0.08,
            child: FloatingActionButton(
              backgroundColor: Colors.redAccent,
              onPressed: () {},
              heroTag: 'emergency-services',
              child: const Icon(Icons.campaign_outlined),
            ),
          ),
          Positioned(
            left: 10,
            bottom: MediaQuery.of(context).size.height * 0.45,
            child: FloatingActionButton(
              onPressed: () {},
              heroTag: 'saved-places',
              child: const Icon(Icons.favorite_border_outlined),
            ),
          ),
          Positioned(
            left: 10,
            bottom: MediaQuery.of(context).size.height * 0.35,
            child: FloatingActionButton(
              onPressed: () {
                _key.currentState!.openDrawer();
              },
              heroTag: 'drawer',
              child: const Icon(Icons.menu),
            ),
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
                  const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Destination',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomChip extends StatelessWidget {
  const CustomChip({
    Key? key,
    required this.label,
    required this.icon,
  }) : super(key: key);

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Chip(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        shape: const StadiumBorder(
          side: BorderSide(
            color: Colors.blueAccent,
          ),
        ),
        avatar: Icon(
          icon,
          color: Colors.blueAccent,
        ),
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.blueAccent,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 4.0,
        shadowColor: Colors.blueAccent,
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key, required this.customKey}) : super(key: key);
  final GlobalKey customKey;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.blueAccent),
            accountName: Text('Salipa Gurung'),
            accountEmail: Text('salipagurung@gmail.com'),
            currentAccountPicture: FlutterLogo(),
          ),
          ListTile(
            leading: const Icon(
              Icons.history,
            ),
            title: const Text('Ride history'),
            onTap: () {
              Navigator.pushNamed(context, '/ride-history');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.edit_note_outlined,
            ),
            title: const Text('Edit Profile'),
            onTap: () {
              Navigator.pop(context);
              // Navigator.pushNamed(context, '/profile-edit');
            },
          ),
        ],
      ),
    );
  }
}
