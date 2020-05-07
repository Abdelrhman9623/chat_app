import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../widgets/chats/new_message.dart';
import '../widgets/chats/messages_widget.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    final fsm = FirebaseMessaging();
      fsm.requestNotificationPermissions();
      fsm.configure(
        onMessage: (msg) {
          print(msg);
          return;
        },
        onLaunch: (msg) {
          print(msg);
          return;
        },
        onResume: (msg) {
          print(msg);
          return;
        }
      );
      fsm.subscribeToTopic('chat');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chat-app'.toUpperCase()),
        // centerTitle: true,
        actions: <Widget>[
          DropdownButton(
            icon: Icon(Icons.more_vert, color: Theme.of(context).primaryIconTheme.color,),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8,),
                      Text('logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifire) {
              if(itemIdentifire == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages()
            ),
            NewMessages(),
          ],
        ),
      ), 
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //   },
      // ),
    );
  }
}