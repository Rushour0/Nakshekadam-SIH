import 'package:flutter/material.dart';

import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:nakshekadam/classes/explore_person.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/chat_interface/chat.dart';
import 'package:nakshekadam/screens/main/tabs/counsellor_page/components/counsellor_dialogbox_button.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/counsellor_tabs/components/custom_text_form_field.dart';
import 'package:nakshekadam/services/Firebase/fireauth/fireauth.dart';
import 'package:nakshekadam/services/Firebase/firestore/firestore.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ExploreCounsellorCard extends StatefulWidget {
  const ExploreCounsellorCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final ExplorePerson data;

  @override
  State<ExploreCounsellorCard> createState() => _ExploreCounsellorCardState();
}

class _ExploreCounsellorCardState extends State<ExploreCounsellorCard> {
  TextEditingController _writeMessageController = TextEditingController();
  int requestStatus = 0;
  types.User? personUid, otherUser;
  bool isFirst = true;

  void checkIfPending(ExplorePerson user) async {
    Map<String, dynamic>? data;
    try {
      data = (await usersCollectionReference()
              .doc(getCurrentUserId())
              .collection('requests')
              .doc(user.uid)
              .get())
          .data()!;
    } catch (e) {
      requestStatus = 0;
      return;
    }
    if (data['requestStatus'] == 'pending') {
      requestStatus = 1;
    } else if (data['requestStatus'] == 'accepted') {
      requestStatus = 2;
    } else if (data['requestStatus'] == 'rejected') {
      requestStatus = -1;
    } else {
      requestStatus = -2;
    }

    if (isFirst) {
      setState(() {});
      isFirst = false;
    }
  }

  Future<void> loadUser(ExplorePerson user) async {
    final doc = await usersCollectionReference().doc(user.uid).get();

    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    // print(data);

    data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
    data['id'] = doc.id;
    data['lastSeen'] = data['lastSeen']?.millisecondsSinceEpoch;
    data['role'] = data['role'];
    data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

    personUid = types.User.fromJson(data);

    final otherDoc =
        await usersCollectionReference().doc(getCurrentUserId()).get();

    data = otherDoc.data()! as Map<String, dynamic>;
    // print(data);

    data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
    data['id'] = otherDoc.id;
    data['lastSeen'] = data['lastSeen']?.millisecondsSinceEpoch;
    data['role'] = data['role'];
    data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

    print(doc.id);
    otherUser = types.User.fromJson(data);

    // print(currentUser);
  }

  @override
  void initState() {
    super.initState();
    checkIfPending(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    checkIfPending(widget.data);
    print(widget.data);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      color: COLOR_THEME["backgroundComponents2"],
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.03, horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: screenWidth / 7,
                  height: screenWidth / 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.data.imageUrl,
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // Image.asset(
                //   // "$RESOURCE_CARD_IMAGES/${title.toLowerCase()}.png",
                //   ""
                //   width: screenWidth * 0.2,
                //   height: screenWidth * 0.2,
                //   fit: BoxFit.cover,
                // ),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.05),
                  child: SizedBox(
                    width: screenWidth * 0.55,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.data.name,
                          softWrap: true,
                          style: TextStyle(
                            fontFamily: "DM Sans",
                            fontSize: screenHeight * 0.027,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(top: screenHeight * 0.005),
                        //   child: Text(
                        //     "Available slots : 7",
                        //     softWrap: true,
                        //     style: TextStyle(
                        //       fontFamily: "DM Sans",
                        //       fontSize: screenHeight * 0.02,
                        //       // fontWeight: FontWeight.bold,
                        //       color: COLOR_THEME["descriptionText"],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            customTextField(
              "Qualification",
              widget.data.qualification,
              screenHeight,
              screenWidth,
            ),
            widget.data.experience != null
                ? customTextField(
                    "Experience",
                    "${widget.data.experience} years",
                    screenHeight,
                    screenWidth,
                  )
                : null,
            customTextField(
              "Specialisation",
              widget.data.specialisation,
              screenHeight,
              screenWidth,
            ),
            customTextField(
              "University Name",
              widget.data.universityName,
              screenHeight,
              screenWidth,
            ),
            const Divider(
              thickness: 2,
              color: Colors.grey,
            ),
            Text(
              "TOP REVIEW",
              softWrap: true,
              style: TextStyle(
                fontFamily: "DM Sans",
                fontSize: screenHeight * 0.025,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            ReadMoreText(
              "${widget.data.name} is an extremely helpful and experienced individual in this domain. Would definitely recommend him to others.",
              textAlign: TextAlign.left,
              trimLines: 3,
              colorClickableText: Colors.blue,
              trimMode: TrimMode.Line,
              trimCollapsedText: " Read More",
              trimExpandedText: " Read Less",
              style: TextStyle(
                fontFamily: "DM Sans",
                fontSize: screenWidth * 0.04,
                color: COLOR_THEME["descriptionText"],
              ),
              lessStyle: TextStyle(
                  decoration: TextDecoration.underline,
                  fontFamily: "Cabin",
                  fontSize: screenWidth * 0.04,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
              moreStyle: TextStyle(
                  decoration: TextDecoration.underline,
                  fontFamily: "Cabin",
                  fontSize: screenWidth * 0.04,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),

            const Divider(
              thickness: 2,
              color: Colors.grey,
            ),
            // Card(
            //   color: Colors.white,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(screenWidth * 0.05),
            //   ),
            //   child: mutliLineTestFormField(
            //       _writeMessageController, "Write a message", screenWidth, 6),
            // ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.01),
              child: GestureDetector(
                onTap: () async {
                  if (requestStatus == 0) {
                    await sendRequest(
                      professionalId: widget.data.uid,
                      userId: getCurrentUserId(),
                    );
                  }
                  setState(() {});
                },
                child: requestStatus != 2
                    ? counsellorDialogBoxButton(
                        screenHeight,
                        screenWidth,
                        requestStatus == -2
                            ? "Reported"
                            : requestStatus == 0
                                ? "Send Connection Request"
                                : requestStatus == 1
                                    ? "Pending"
                                    : "Retry Connecting?")
                    : ElevatedButton(
                        onPressed: () async {
                          await loadUser(widget.data);
                          final room = await FirebaseChatCore.instance
                              .createRoom(personUid!, otherUser!);
                          print(room);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => ChatPage(
                                room: room,
                              ),
                              // builder: (builder) => UsersPage(),
                            ),
                          );
                        },
                        child: Text('Open Chat')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
