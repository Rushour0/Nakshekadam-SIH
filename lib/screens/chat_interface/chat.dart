import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/models/user_details_model.dart';

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
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
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

  void _handleSendPressed(types.PartialText message) {
    FirebaseChatCore.instance.sendMessage(
      message,
      widget.room.id,
    );
  }
}
