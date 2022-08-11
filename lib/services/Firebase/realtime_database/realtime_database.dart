import 'dart:collection';

// import 'package:nakshekadam/services/Firebase/FireAuth/fireauth.dart';
import 'package:nakshekadam/services/Firebase/fireauth/fireauth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
// Admin commands

// Fetch Order Confirmations
Future<Map<String, dynamic>> fetchAdminOrders() async {
  Map<String, dynamic> ordersMap = {};

  // Database reference
  final DatabaseReference database = FirebaseDatabase.instance.ref("orders");

  // No Orders
  if (!(await database.get()).exists) {
    print("No Orders");
    return ordersMap;
  }

  // Get orders
  Map<dynamic, dynamic> orders =
      ((await database.once()).snapshot.value! as Map<dynamic, dynamic>);

  ordersMap = orders.map((key, value) {
    Map<String, dynamic> temp = {};
    temp.putIfAbsent("orderId", () => value["orderId"]);
    temp.putIfAbsent("orderStatus", () => value["orderStatus"]);
    temp.putIfAbsent("orderType", () => value["orderType"]);
    temp.putIfAbsent("orderName", () => value["name"]);
    temp.putIfAbsent("addressType", () => value["addressType"]);

    return MapEntry<String, Map<String, dynamic>>(key.toString(), temp);
  });

  return ordersMap;
}

// Fetch Order Subscriptions
Future<Map<String, dynamic>> fetchAdminSubscriptions() async {
  Map<String, dynamic> subscriptionsMap = {};

  // Database reference
  final DatabaseReference database =
      FirebaseDatabase.instance.ref("subscriptions");

  // No Orders
  if (!(await database.get()).exists) {
    print("No Orders");
    return subscriptionsMap;
  }

  // Get orders
  Map<dynamic, dynamic> orders =
      ((await database.once()).snapshot.value! as Map<dynamic, dynamic>);

  subscriptionsMap = orders.map((key, value) {
    Map<String, dynamic> temp = {};
    temp.putIfAbsent("deliveryAddress", () => value["deliveryAddress"]);
    temp.putIfAbsent("endDate", () => value["endDate"]);
    temp.putIfAbsent("isRenew", () => value["isRenew"]);
    temp.putIfAbsent("number", () => value["number"]);
    temp.putIfAbsent("subscriptionType", () => value["subscriptionType"]);
    temp.putIfAbsent("addressType", () => value["addressType"]);
    temp.putIfAbsent("takeAwayAddress", () => value["takeAwayAddress"]);
    temp.putIfAbsent("subscriptionId", () => key.toString());
    temp.putIfAbsent("subscriptionStatus", () => value["subscriptionStatus"]);
    temp.putIfAbsent("name", () => value["name"]);
    // print(temp);
    return MapEntry<String, Map<String, dynamic>>(key.toString(), temp);
  });

  return subscriptionsMap;
}

// Place subscription on the admin side
Future<bool> placeSubscriptionInAdmin({
  required String subscriptionId,
  required Timestamp endDate,
  required Timestamp startDate,
  required String subscriptionType,
  required String deliveryAddress,
  required String takeAwayAddress,
  required int addressType,
  required String name,
}) async {
  // Database reference
  final DatabaseReference database =
      FirebaseDatabase.instance.ref("subscriptions");

  User user = getCurrentUser()!;

  DatabaseReference newSubscription = database.child(subscriptionId);
  await newSubscription.set({
    'phoneNumber': user.phoneNumber,
    'userId': user.email,
    'subscriptionStatus': 0,
    'subscriptionId': subscriptionId,
    'endDate': endDate.toDate().toIso8601String(),
    'startDate': startDate.toDate().toIso8601String(),
    'subscriptionType': subscriptionType,
    'addressType': addressType.toInt(),
    'deliveryAddress': deliveryAddress,
    'takeAwayAddress': takeAwayAddress,
    'name': name,
  });

  return false;
}

// Place subscription on the admin side
Future<bool> placeOrderInAdmin({
  required String orderId,
  required Timestamp forDate,
  required int orderType,
  required String deliveryAddress,
  required String takeAwayAddress,
  required int addressType,
  required String name,
}) async {
  // Database reference
  final DatabaseReference database = FirebaseDatabase.instance.ref("orders");
  User user = getCurrentUser()!;

  DatabaseReference newSubscription = database.child(orderId);
  await newSubscription.set({
    'phoneNumber': user.phoneNumber,
    'userId': user.email,
    'orderStatus': 1,
    'addressType': addressType.toInt(),
    'deliveryAddress': deliveryAddress,
    'takeAwayAddress': takeAwayAddress,
    'name': name,
    'orderId': orderId,
    'forDate': forDate.toDate().toIso8601String(),
    'orderType': orderType,
  });

  return false;
}

// User commands
// Common functionality

// Check Order Confirmations
Future<int> checkOrderStatus({
  required String orderId,
}) async {
  Map<String, dynamic> ordersMap = {};

  // Database reference
  final DatabaseReference database = FirebaseDatabase.instance.ref("orders");

  // No Orders
  if (!(await database.get()).exists) {
    print("No Orders");
    return -2;
  }

  // Get orders
  Map<dynamic, dynamic> orders =
      ((await database.once()).snapshot.value! as Map<dynamic, dynamic>);

  return (orders[orderId]['orderStatus']);
}

// Update the order status for a given order
Future<bool> updateOrderStatus({
  required String orderId,
}) async {
  bool isError = false;
  final DatabaseReference order =
      FirebaseDatabase.instance.ref("orders").child(orderId);
  Map<dynamic, dynamic> orderData =
      (await order.once()).snapshot.value! as Map<dynamic, dynamic>;

  // await order.update({"orderStatus": orderStatus.index}).catchError((onError) {
  //   print(onError);
  //   isError = true;
  // });
  if (isError) {
    return false;
  }
  String userId = orderData['userId'];
  // String orderStringStatus = OrderConfirmationStatus.values[orderStatus.index]
  //     .toString()
  //     .split('.')[1];
  // await http.get(Uri.parse(
  //     'https://Rushour-APIs.rushour0.repl.co/sendNotification?userId=$userId&message=$orderStringStatus&orderId=$orderId'));
  return true;
}

// Check Subscription Confirmations
Future<int> checkSubscriptionStatus({
  required String subscriptionId,
}) async {
  Map<String, dynamic> subscriptionsMap = {};

  // Database reference
  final DatabaseReference database =
      FirebaseDatabase.instance.ref("subscriptions");

  // No Subscriptions
  if (!(await database.get()).exists) {
    print("No Subscriptions");
    return -2;
  }

  // Get subscriptions
  Map<dynamic, dynamic> subscriptions =
      ((await database.once()).snapshot.value! as Map<dynamic, dynamic>);
  // print(subscriptions);
  return (subscriptions[subscriptionId]['subscriptionStatus']);
}

// Update the subscription status for a given subscription
Future<bool> updateSubscriptionStatus({
  required String subscriptionId,
  // required SubscriptionStatus subscriptionStatus,
}) async {
  bool isError = false;
  final DatabaseReference subscription =
      FirebaseDatabase.instance.ref("subscriptions").child(subscriptionId);
  // await subscription.update(
  //     {"subscriptionStatus": subscriptionStatus.index}).catchError((onError) {
  //   // print(onError);
  //   isError = true;
  // });
  if (isError) {
    // return false;
  }
  Map<dynamic, dynamic> orderData =
      (await subscription.once()).snapshot.value! as Map<dynamic, dynamic>;
  String userId = orderData['userId'];
  print(userId);
  // String orderStringStatus = SubscriptionStatus.values[subscriptionStatus.index]
  //     .toString()
  //     .split('.')[1];
  // await http.get(Uri.parse(b
  return true;
}

Future<bool> sendFeedback({required String feedback}) async {
  // Database reference
  final DatabaseReference database = FirebaseDatabase.instance.ref("feedbacks");

  // DatabaseReference newFeedback = database.child(orderId);
  await database.push().set({
    'feedback': feedback,
  });

  return false;
}

Future<bool> reportProblem({
  required String name,
  required String email,
  required String phoneNumber,
  required String problem,
}) async {
  // Database reference
  final DatabaseReference database = FirebaseDatabase.instance.ref("feedbacks");

  await database.push().set({
    'name': name,
    'email': email,
    'phoneNumber': phoneNumber,
    'complaint': problem,
  });

  return false;
}
