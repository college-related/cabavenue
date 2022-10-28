import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _storage = const FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    _checkUserAuth().then((value) => {
          if (value != null)
            {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/home', (route) => false)
            }
          else
            {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/auth', (route) => false)
            }
        });
  }

  Future _checkUserAuth() async {
    return await _storage.read(key: "CABAVENUE_USERDATA_PASSENGER");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
