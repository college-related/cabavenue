import 'package:cabavenue/providers/profile_provider.dart';
import 'package:cabavenue/services/report_service.dart';
import 'package:cabavenue/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:provider/provider.dart';

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
        title: Text(widget.title),
        elevation: 2,
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profile, child) {
          var history = profile.getUserData.rideHistory;

          return ListView.builder(
            itemCount: history!.length,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                margin: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 20.0),
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 6.0),
                              child: Icon(Iconsax.location, size: 20.0),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pickup point',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(history[index]['source']),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 6.0),
                              child: Icon(Iconsax.location, size: 20.0),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Destination',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(history[index]['destination']),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          Moment(DateTime.parse(history[index]['createdAt']))
                              .fromNow(form: UnitStringForm.short),
                        ),
                        Text(
                          "Rs. ${history[index]['price']}",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        Row(
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                showAlertDialog(
                                  context,
                                  history[index]['driver']['id'],
                                  history[index]['driver']['name'],
                                );
                              },
                              child: const Text(
                                'Report',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// show alert dialouge for confirmation of request rides
showAlertDialog(BuildContext context, id, name) {
  TextEditingController report = TextEditingController();
  final reportForm = GlobalKey<FormState>();

  Widget yesButton = ElevatedButton(
    onPressed: () {
      if (reportForm.currentState!.validate()) {
        ReportService().report(context, name, id, report.text);
        Navigator.of(context).pop();
        Future.delayed(
          const Duration(seconds: 2),
          () => Fluttertoast.showToast(
            msg: 'Reported successfully',
            backgroundColor: Colors.green[500],
          ),
        );
      }
    },
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
    child: const Text("Report"),
  );

//  Create cancel button
  Widget cancelButton = ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
    child: const Text("Cancel"),
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Report the passenger?"),
    content: SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: reportForm,
          child: CustomTextField(
            controller: report,
            hintText: 'Report description',
            icon: Iconsax.activity,
          ),
        ),
      ),
    ),
    actions: [
      cancelButton,
      yesButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
