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
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text(widget.title),

      ),
  body: 
  ListView(
    padding:const EdgeInsets.all(10),
    children: [
      Card(
        elevation: 1,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(backgroundImage: NetworkImage("https://images.unsplash.com/photo-1547721064-da6cfb341d50"),)
                ],
              ),
              Column(
                children: [
                      const Text('Driver Name', textAlign: TextAlign.left,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                  Row(
                    children: const [
                      Icon(Icons.location_on_outlined, color: Colors.blue,),
                      Text('Bagar', textAlign: TextAlign.left,),
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(Icons.share_location_rounded,color: Colors.blue),
                      // Text('Driver Name', textAlign: TextAlign.left,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                      Text('Chipledhunga', textAlign: TextAlign.left,),
                    ],
                  ),
                ],
              ),
              Column(
                children: const [
                  Text('\$350', textAlign: TextAlign.end,),
                ],
              )
            ],
          ),
        )
      ),
       const Card(
        child: ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage("https://images.unsplash.com/photo-1547721064-da6cfb341d50"),),
          title: Text('Bagar to Chipledhunga'),
          subtitle: Text('Driver: Harry Smith'),
          trailing: Text(r''),
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        ),
      ),
      const Card(
        child: ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage("https://images.unsplash.com/photo-1547721064-da6cfb341d50"),),
          title: Text('Bagar to Chipledhunga'),
          subtitle: Text('Driver: Harry Smith'),
          trailing: Text(r''),
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        ),
      ),
    ],
  ),
          //   Row(
          //   children: [
          //     Column(
          //       children: const [
          //         Text('Driver Name'),
          //         Text('Source Location: Bagar'),
          //         Text('Destination Location: Chipledhunga'),
          //       ],
          //     ),
          //     Column(
          //       children:const [
          //         Text(r''),
          //       ],
          //     )
          //   ],
          // ),
    );
  }
}