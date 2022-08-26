import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/models/user_details_model.dart';
import 'package:nakshekadam/services/Firebase/fireauth/fireauth.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.room,
  });

  final types.Room room;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isAttachmentUploading = false;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(screenWidth / 20),
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              // popupmenu item 1
              PopupMenuItem(
                padding: EdgeInsets.zero,
                value: 1,
                // row has two child icon and text.
                child: menuItem(
                  screenWidth,
                  Icon(
                    Icons.report,
                    color: Colors.red,
                  ),
                  "Report",
                  () async {
                    await report();
                  },
                ),
              ),
              // popupmenu item 2
              PopupMenuItem(
                value: 2,
                // row has two child icon and text
                child: menuItem(
                  screenWidth,
                  Icon(
                    Icons.call,
                    color: Colors.black,
                  ),
                  "Help",
                  () async {
                    showAboutDialog(
                        context: context,
                        children: [Text("Helpline number: +91-9888888888")]);
                  },
                ),
              ),
            ],
            elevation: 2,
          ),
        ],
        // automaticallyImplyLeading: false,
        backgroundColor: COLOR_THEME['drawerBackground'],
        title: Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.025),
          child: Row(
            children: [
              CircleAvatar(
                radius: screenWidth * 0.05,
                backgroundImage: NetworkImage(
                  widget.room.imageUrl ?? DEFAULT_PROFILE_PICTURE,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.025),
                child: Text(
                  widget.room.name ?? 'Chat',
                  style: TextStyle(
                    fontFamily: 'DM Sans',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.05,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenWidth / 20),
          color: Colors.white,
        ),
        child: StreamBuilder<types.Room>(
          initialData: widget.room,
          stream: FirebaseChatCore.instance.room(widget.room.id),
          builder: (context, snapshot) => StreamBuilder<List<types.Message>>(
              initialData: const [],
              stream: FirebaseChatCore.instance.messages(snapshot.data!),
              builder: (context, snapshot) {
                return Chat(
                  showUserAvatars: true,
                  theme: DefaultChatTheme(
                    primaryColor: COLOR_THEME['primary']!,
                    backgroundColor: COLOR_THEME['backgroundComponents2']!,
                    inputTextColor: Colors.black,
                    inputBackgroundColor: Colors.grey.shade200,
                  ),
                  isAttachmentUploading: _isAttachmentUploading,
                  messages: snapshot.data ?? [],
                  onSendPressed: _handleSendPressed,
                  user: types.User(
                    id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
                    role: UserDetailsModelOne.userDetailsModelOne.role ==
                            "student"
                        ? types.Role.student
                        : types.Role.parent,
                    imageUrl: FirebaseChatCore.instance.firebaseUser?.photoURL,
                  ),
                );
              }),
        ),
      ),
    );
  }

  Future<void> report() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Report"),
          content: Text("Report this counsellor?"),
          actions: <Widget>[
            ElevatedButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("Report"),
              onPressed: () async {
                String otherId = widget.room.users
                    .where((element) => element.id != getCurrentUserId())
                    .toList()[0]
                    .id;

                await reportPerson(id: otherId, roomId: widget.room.id);
                Navigator.of(context).pop();
                // Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget menuItem(
      double screenWidth, Icon icon, String title, void Function()? function) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth / 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            icon,
            SizedBox(
              width: screenWidth * 0.3,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleSendPressed(types.PartialText message) {
    FirebaseChatCore.instance.sendMessage(
      message,
      widget.room.id,
    );
  }
}
