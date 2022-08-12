import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/login_signup/aadhar_login.dart';
import 'package:nakshekadam/screens/login_signup/login.dart';
import 'package:nakshekadam/screens/login_signup/signup.dart';
import 'package:nakshekadam/screens/main/main_page.dart';
import 'package:nakshekadam/screens/verification&details/mobileVerification/phone_auth.dart';
import 'package:nakshekadam/screens/verification&details/personal_details.dart';
import 'package:nakshekadam/screens/walkthrough/walkthrough.dart';
import 'package:nakshekadam/services/Firebase/firebase_options.dart';
import 'package:nakshekadam/services/PushNotifications/push_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await PushNotificationService().setupInteractedMessage();
  // print('TOKEN : ${await FirebaseMessaging.instance.getToken()}');

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
              buttonColor: const Color(0xff615793),
            ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: DEFAULT_TEXT_THEME,
      ),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: true,
      initialRoute: '/main',
      routes: {
        // '/wt': (context) => const WTOne(),
        // '/wt': (context) => const WalkThrough(),
        '/main': (context) => const Main(),
        '/wt': (context) => const WalkThrough(),
        '/login': (context) => const Login(),
        '/aadhar': (context) => const AadharLoginPage(),
        '/signup': (context) => const Signup(),
        '/mobno': (context) => const PhoneAuth(),
        '/personalDetails': (context) => const PersonalDetails(),
        '/aadharAuth': (context) => const AadharLoginPage(),
        // '/': (context) => const Splash(),
      },
    );
  }
}
