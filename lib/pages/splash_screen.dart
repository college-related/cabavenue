import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quick_actions/quick_actions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String quickActionType = '';

  final _storage = const FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    _checkUserAuth().then((value) {
      if (value != null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/auth', (route) => false);
      }
    });

    const QuickActions quickActions = QuickActions();
    quickActions.initialize((String type) {
      // setState(() {
      //   if (type != '') {
      //     quickActionType = type;
      //   }
      // });
      switch (type) {
        case 'emergency':
          Navigator.of(context).pushNamed('/emergency');
          break;
        default:
      }
    });
    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
        type: 'emergency',
        localizedTitle: 'Emergency',
        icon: 'ic_launcher',
      ),
    ]);
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
