import 'package:flutter/material.dart';
import 'package:nakshekadam/screens/login_signup/aadhar_login.dart';
import 'package:nakshekadam/screens/login_signup/login.dart';

import 'package:nakshekadam/screens/login_signup/signup.dart';
import 'package:nakshekadam/screens/walkthrough/walkthrough.dart';
import 'package:nakshekadam/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  // ));

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
      // debugShowCheckedModeBanner: true,
      initialRoute: '/login',
      routes: {
        // '/wt': (context) => const WTOne(),
        '/wt': (context) => const WalkThrough(),
        // '/wt': (context) => const BigTwoSmallOneBG(),
        '/login': (context) => const AadharLoginPage(),
        '/signup': (context) => const Signup(),
        // '/': (context) => const Splash(),
      },
    );
  }
}
