import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/notifications/components.dart';

import 'package:nakshekadam/services/Firebase/fireauth/fireauth.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    User? user = getCurrentUser();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NotificationCard(
                notification: notification,
              ),
              NotificationCard(
                notification: notification,
              ),
              NotificationCard(
                notification: notification,
              ),
              NotificationCard(
                notification: notification,
              ),
              NotificationCard(
                notification: notification,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

NotificationInfo notification = NotificationInfo(
  title: 'NaksheKADAM',
  description:
      'NaksheKADAM is a platform for students to get access to the best resources available in the field of engineering.',
  date: 'Today',
  subject: 'NaksheKADAM',
  read: false,
);
