import 'package:cabavenue/pages/favorite_map.dart';
import 'package:cabavenue/pages/favorite_places.dart';
import 'package:cabavenue/pages/splash_screen.dart';
import 'package:cabavenue/providers/destination_provider.dart';
import 'package:cabavenue/providers/device_provider.dart';
import 'package:cabavenue/providers/favorite_provider.dart';
import 'package:cabavenue/providers/profile_provider.dart';
import 'package:cabavenue/providers/ride_provider.dart';
import 'package:cabavenue/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cabavenue/pages/home.dart';
import 'package:cabavenue/pages/auth.dart';
import 'package:cabavenue/pages/profile_edit.dart';
import 'package:cabavenue/pages/ride_history.dart';
import 'package:cabavenue/pages/emergency.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await setupFlutterNotifications();
  showFlutterNotification(message);
}

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launch_background',
        ),
      ),
    );
  }
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => DestinationProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(create: (context) => RideProvider()),
        ChangeNotifierProvider(create: (context) => DeviceProvider(context)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.main(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => Consumer<DeviceProvider>(
                builder: (context, value, child) => const SplashScreen(),
              ),
          '/home': (context) => const HomePage(),
          '/ride-history': (context) => const RideHistory(),
          '/profile-edit': (context) => const EditProfilePage(),
          '/emergency': (context) => const EmergencyPage(),
          '/auth': (context) => const AuthPage(),
          '/favorite-places': (context) => const FavoritePlaces(),
          '/favorite-map': (context) => const FavoriteMap(),
        },
        // home: const MyHomePage(),
      ),
    );
  }
}
