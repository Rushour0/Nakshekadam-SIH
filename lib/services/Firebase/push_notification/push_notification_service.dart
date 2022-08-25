import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupInteractedMessage() async {
    // This function is called when the app is in the background and user clicks on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Get.toNamed(NOTIFICATIOINS_ROUTE);
      print('new notification');
      if (message.data['type'] == 'chat') {
        // Navigator.pushNamed(context, '/chat',
        //     arguments: ChatArguments(message));
      }
    });
    await enableIOSNotifications();
    await registerNotificationListeners();
  }

  registerNotificationListeners() async {
    AndroidNotificationChannel channel = androidNotificationChannel();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const IOSInitializationSettings iOSSettings = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    const InitializationSettings initSetttings =
        InitializationSettings(android: androidSettings, iOS: iOSSettings);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: (message) async {});
    // onMessage is called when the app is in foreground and a notification is received
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      RemoteNotification? notification = message!.notification;
      AndroidNotification? android = message.notification?.android;
      print("CHANNEL ID : ${message.notification!.android!.channelId}");
      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
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
              icon: android.smallIcon,
              playSound: true,
              importance: Importance.max,
              priority: Priority.max,
              visibility: NotificationVisibility.public,
              channelShowBadge: true,
            ),
          ),
        );
      }
    });
  }

  enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  static androidNotificationChannel() => AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.high,
        enableLights: true,
      );

  static customGroupWiseNotificationChannel({
    required String id,
    required String title,
    required String description,
  }) =>
      AndroidNotificationChannel(
        id, // id
        title, // title
        description: description, // description
        importance: Importance.high,
        enableLights: true,
      );

  static registerCustomNotificationListeners({
    required String id,
    required String title,
    required String description,
  }) async {
    print('I am $title');
    AndroidNotificationChannel channel = customGroupWiseNotificationChannel(
      id: id,
      title: title,
      description: description,
    );
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const IOSInitializationSettings iOSSettings = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    const InitializationSettings initSetttings =
        InitializationSettings(android: androidSettings, iOS: iOSSettings);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: (message) async {});
    // onMessage is called when the app is in foreground and a notification is received
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      RemoteNotification? notification = message!.notification;
      AndroidNotification? android = message.notification?.android;
      print("CHANNEL ID : ${message.notification!.android!.channelId}");
      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
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
              icon: android.smallIcon,
              playSound: true,
              importance: Importance.max,
              priority: Priority.max,
              visibility: NotificationVisibility.public,
              channelShowBadge: true,
            ),
          ),
        );
      }
    });
  }
}
