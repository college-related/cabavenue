import 'dart:convert';

import 'package:cabavenue/models/emergency_model.dart';
import 'package:cabavenue/services/emergency_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:iconsax/iconsax.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class Emergency extends StatelessWidget {
  const Emergency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const EmergencyPage();
  }
}

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({Key? key}) : super(key: key);

  @override
  State<EmergencyPage> createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  late Future<List<EmergencyModel>> emergencyCabs;
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  Future<List<EmergencyModel>> getEmergencyCabs() async {
    var cabs = await EmergencyService().getEmergencyCabs(context);
    List<EmergencyModel> drivers = [];

    if (cabs != null) {
      for (var cab in cabs) {
        drivers
            .add(await EmergencyModel.deserialize(jsonEncode(cab).toString()));
      }
    }
    return drivers;
  }

  @override
  void initState() {
    super.initState();
    emergencyCabs = getEmergencyCabs();
  }

  Future<void> _onRefresh() async {
    setState(() {
      emergencyCabs = getEmergencyCabs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Emergency Services'),
          elevation: 2,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.emergency)),
              Tab(icon: Icon(Icons.directions_car)),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: TabBarView(
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.emergency),
                      title: const Text('Ambulance'),
                      subtitle: const Text('102'),
                      trailing: const Icon(Iconsax.call),
                      tileColor: Colors.blue[100],
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10.0),
                      horizontalTitleGap: 0,
                      minVerticalPadding: 0,
                      onTap: () async {
                        await FlutterPhoneDirectCaller.callNumber('102');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Iconsax.alarm),
                      title: const Text('Police'),
                      subtitle: const Text('100'),
                      trailing: const Icon(Iconsax.call),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10.0),
                      horizontalTitleGap: 0,
                      minVerticalPadding: 0,
                      onTap: () async {
                        await FlutterPhoneDirectCaller.callNumber('100');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Iconsax.radar_1),
                      title: const Text('Fire Brigade'),
                      subtitle: const Text('101'),
                      trailing: const Icon(Iconsax.call),
                      tileColor: Colors.blue[100],
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10.0),
                      horizontalTitleGap: 0,
                      minVerticalPadding: 0,
                      onTap: () async {
                        await FlutterPhoneDirectCaller.callNumber('101');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Iconsax.security_user),
                      title: const Text('Child help line'),
                      subtitle: const Text('104'),
                      trailing: const Icon(Iconsax.call),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10.0),
                      horizontalTitleGap: 0,
                      minVerticalPadding: 0,
                      onTap: () async {
                        await FlutterPhoneDirectCaller.callNumber('104');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Iconsax.security_safe),
                      title: const Text('Tourist Police'),
                      subtitle: const Text('1144'),
                      trailing: const Icon(Iconsax.call),
                      tileColor: Colors.blue[100],
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10.0),
                      horizontalTitleGap: 0,
                      minVerticalPadding: 0,
                      onTap: () async {
                        await FlutterPhoneDirectCaller.callNumber('1144');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.emergency),
                      title: const Text('Test'),
                      subtitle: const Text('982514080*'),
                      trailing: const Icon(Iconsax.call),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10.0),
                      horizontalTitleGap: 0,
                      minVerticalPadding: 0,
                      onTap: () async {
                        await FlutterPhoneDirectCaller.callNumber('9825140802');
                      },
                    ),
                  ],
                ),
              ),
              LiquidPullToRefresh(
                key: _refreshIndicatorKey,
                showChildOpacityTransition: false,
                onRefresh: _onRefresh,
                child: FutureBuilder<List<EmergencyModel>>(
                  future: emergencyCabs,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) => ListTile(
                            leading: const Icon(Iconsax.car),
                            title: Text(snapshot.data![index].name),
                            isThreeLine: true,
                            subtitle:
                                Text(snapshot.data![index].phone.toString()),
                            trailing: const Icon(Iconsax.call),
                            onTap: () async {
                              await FlutterPhoneDirectCaller.callNumber(
                                  snapshot.data![index].phone.toString());
                            },
                          ),
                        ),
                      );
                    }
                    return SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
