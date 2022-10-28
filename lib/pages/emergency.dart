import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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
  @override
  Widget build(BuildContext context) {
    return   DefaultTabController(
    length: 2,      child: Scaffold(
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
          padding: const EdgeInsets.all(10),
          child: TabBarView(
            children:[
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.emergency),
                  title: const Text('Ambulance'),
                  isThreeLine: true,
                  subtitle: const Text('102'),
                  trailing: const Icon(Iconsax.call),
                  tileColor: Colors.blue[100],
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
                  horizontalTitleGap: 0,
                  minVerticalPadding: 0,
                  
                ), 
                ListTile(
                  leading: Icon(Icons.emergency),
                  title: Text('Police'),
                  isThreeLine: true,
                  subtitle: Text('100'),
                  trailing: Icon(Iconsax.call),
                ), 
                ListTile(
                  leading: Icon(Icons.emergency),
                  title: Text('Fire Brigade'),
                  isThreeLine: true,
                  subtitle: Text('101'),
                  trailing: Icon(Iconsax.call),
                ), 
                ListTile(
                  leading: Icon(Icons.emergency),
                  title: Text('Child help line'),
                  isThreeLine: true,
                  subtitle: Text('104'),
                  trailing: Icon(Iconsax.call),
                ), 
                ListTile(
                  leading: Icon(Icons.emergency),
                  title: Text('Tourist Police'),
                  isThreeLine: true,
                  subtitle: Text('1144'),
                  trailing: Icon(Iconsax.call),
                ), 
              ],
            ),
              ),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView(
              children: const [
                ListTile(
                  leading: Icon(Iconsax.car),
                  title: Text('Cars'),
                  isThreeLine: true,
                  subtitle: Text('9876543210'),
                  trailing: Icon(Iconsax.call),
                ),  
              ],
            ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
