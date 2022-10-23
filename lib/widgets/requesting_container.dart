import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class RequestingContainer extends StatefulWidget {
  const RequestingContainer({
    Key? key,
    required this.callback,
  }) : super(key: key);

  final Function callback;

  @override
  State<RequestingContainer> createState() => _RequestingContainerState();
}

class _RequestingContainerState extends State<RequestingContainer> {
  double _scale = 1;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_scale == 1) {
          _scale = 1.1;
        } else {
          _scale = 1;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
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
              'Requesting Ride',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              children: [
                AnimatedScale(
                  duration: const Duration(seconds: 1),
                  scale: _scale,
                  child: const Icon(
                    Iconsax.smart_car,
                    size: 60.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    'Please wait a moment',
                    style: Theme.of(context).textTheme.headline6,
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
                      vertical: 10,
                      horizontal: 15.0,
                    ),
                  ),
                  onPressed: () {
                    widget.callback();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ))
      ],
    );
  }
}
