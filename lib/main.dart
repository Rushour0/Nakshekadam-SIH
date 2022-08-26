import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/chat_interface/messages.dart';
import 'package:nakshekadam/screens/login_signup/aadhar_login.dart';
import 'package:nakshekadam/screens/login_signup/login.dart';
import 'package:nakshekadam/screens/login_signup/signup.dart';
import 'package:nakshekadam/screens/main/main_page.dart';
import 'package:nakshekadam/screens/splash/splash.dart';
import 'package:nakshekadam/screens/student_post_login/info_collection/student_parent.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/student_main_page.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/tests/take_test/display_test_result.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/tests/take_test/take_test.dart';
import 'package:nakshekadam/screens/verification&details/mobileVerification/phone_auth.dart';
import 'package:nakshekadam/screens/verification&details/personal_details.dart';
import 'package:nakshekadam/screens/vidya_bot/vidya_bot.dart';
import 'package:nakshekadam/screens/walkthrough/walkthrough.dart';
import 'package:nakshekadam/services/Firebase/firebase_options.dart';
import 'package:nakshekadam/services/Firebase/push_notification/push_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  await PushNotificationService().setupInteractedMessage();
  // print('TOKEN : ${await FirebaseMessaging.instance.getToken()}');
  // CollegeExtractionModel collegeExtractionModel = CollegeExtractionModel.getModel();
  // collegeExtractionModel.fetchCollegeInfo();

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
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/main': (context) => const MainPage(),
        '/wt': (context) => const WalkThrough(),
        '/login': (context) => const Login(),
        '/aadhar': (context) => const AadharLoginPage(),
        '/signup': (context) => const Signup(),
        '/mobno': (context) => const PhoneAuth(),
        '/personalDetails': (context) => const PersonalDetails(),
        '/aadharAuth': (context) => const AadharLoginPage(),
        '/postLogin': (context) => const StudentParent(),
        '/postLoginMain': (context) => const StudentMainPage(),
        '/messages': (context) => const MessagesPage(),
        '/': (context) => const Splash(),
        '/displayTestResult': (context) => const DisplayTestResult(),
        'vidya_bot': (context) => const VidyaBot(),
        '/takeTest': (context) => const TakeTest(
              testName: "Personality Test",
            ),
      },
    );
  }
}
