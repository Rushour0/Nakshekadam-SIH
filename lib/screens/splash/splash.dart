import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nakshekadam/common_widgets/customPageRouter.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/student_post_login/info_collection/student_parent.dart';
import 'package:nakshekadam/services/Firebase/fireauth/fireauth.dart';
import 'package:nakshekadam/services/Firebase/firestore/firestore.dart';
import 'package:nakshekadam/services/Firebase/push_notification/push_notification_service.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  bool isFirst = true;
  late final AnimationController _controller = AnimationController(
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  Future<void> check() async {
    if (checkLoggedIn()) {
      // if (await checkAdmin() == null) {
      //   await signOut();
      //   await signOutGoogle();
      //   Navigator.pushNamedAndRemoveUntil(
      //       context, '/login_signup_page', (route) => false);
      // } else if ((await checkAdmin())!) {
      //   print("I AM ADMIN");
      //   Navigator.pushNamedAndRemoveUntil(
      //       context, '/admin_main_page', (route) => false);
      // }
      if (await checkFormFilled()) {
        String id = await userDocumentReference().get().then((value) =>
            value.data()!['role'] + value.data()!['question'].toString());
        PushNotificationService.registerCustomNotificationListeners(
            id: id, title: id, description: id);
        print("WHATS UP !");
        Navigator.pushNamedAndRemoveUntil(
            context, '/postLoginMain', (route) => false);
      } else {
        Navigator.of(context)
            .push(CustomPageRouter(child: const StudentParent()));
      }
    } else {
      Navigator.pushNamedAndRemoveUntil(context, '/wt', (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.forward) {
        if (isFirst) {
          isFirst = false;
          await Future.delayed(Duration(seconds: 5), () async => await check());
        }

        return;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: COLOR_THEME['background'],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.width / 2,
              child: Lottie.network(
                'https://nakshekadam.rushour0.repl.co/lottieJson',
                fit: BoxFit.contain,
                controller: _controller,
                onLoaded: (composition) {
                  _controller
                    ..duration = composition.duration
                    ..repeat();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
