import 'package:cabavenue/providers/ride_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class AcceptedContainer extends StatefulWidget {
  const AcceptedContainer({Key? key}) : super(key: key);

  @override
  State<AcceptedContainer> createState() => _AcceptedContainerState();
}

class _AcceptedContainerState extends State<AcceptedContainer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RideProvider>(
      builder: (context, value, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
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
              child: Center(
                child: Text(
                  'Your Ride',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text('Driver : '),
                            Text(value.getDriver['name']),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text('Vehicle : '),
                            Text(value.getDriver['model']),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text('Color : '),
                            Text(value.getDriver['color']),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text('Number plate : '),
                            Text(value.getDriver['plateNumber']),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Ride Accepted',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 30.0,
                          ),
                        ),
                        onPressed: () async {
                          await FlutterPhoneDirectCaller.callNumber(
                              value.getDriver['phone'].toString());
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Iconsax.call),
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text('Call'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
