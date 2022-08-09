import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nakshekadam/common_utils/bigThreeBg.dart';
import 'package:nakshekadam/common_utils/bigTwoSmallOneBg.dart';
import 'package:nakshekadam/screens/login_signup/login.dart';
import 'package:nakshekadam/screens/login_signup/signup.dart';
import 'package:nakshekadam/screens/walkthrough/walkthrough.dart';
import 'package:nakshekadam/screens/walkthrough/wtpages/wtone.dart';
import 'package:nakshekadam/screens/walkthrough/wtpages/wtthree.dart';
import 'package:nakshekadam/screens/walkthrough/wtpages/wttwo.dart';
import 'package:nakshekadam/services/Firebase/firebase_options.dart';
import 'package:nakshekadam/services/PushNotifications/push_notification_service.dart';
import 'package:nakshekadam/services/globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  // ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await PushNotificationService().setupInteractedMessage();
  print('TOKEN : ${await FirebaseMessaging.instance.getToken()}');

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  FirebaseMessaging.onBackgroundMessage((message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification!.android;
    print("CHANNEL ID : ${message.notification!.android!.channelId}");
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
              android.channelId!, android.channelId!,
              icon: android.smallIcon,
              playSound: true,
              importance: Importance.max,
              priority: Priority.max,
              visibility: NotificationVisibility.public,
              channelShowBadge: true,
              colorized: true),
        ),
      );
    }
  });
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_TITLE,
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: DEFAULT_TEXT_THEME,
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: COLOR_THEME['primary'],
              secondary: COLOR_THEME['secondary'],
            ),
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
              buttonColor: const Color(0xFFC1F0F6),
            ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: DEFAULT_TEXT_THEME,
      ),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: true,
      initialRoute: '/signup',
      routes: {
        // '/wt': (context) => const WTOne(),
        // '/wt': (context) => const WalkThrough(),
        '/wt': (context) => const BigTwoSmallOneBG(),
        '/login': (context) => const Login(),
        '/signup': (context) => const Signup(),
        // '/': (context) => const Splash(),
      },
    );
  }
}
