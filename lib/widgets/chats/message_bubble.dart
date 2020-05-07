import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class MessageBubble extends StatelessWidget {
  final String message;
  final String username;
  final String userImage;
  final bool isMe;
  final Key key;

  MessageBubble(
    this.message,
    this.username,
    this.userImage,
    this.isMe,
    {this.key}
  );
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceSize = mediaQuery.size;
    return Stack(
      children: <Widget>[
        Row(
          mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
              width: deviceSize.width / 2 * 0.9,
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    username,
                    style: TextStyle(
                      color: isMe ? Colors.pink : Theme.of(context).accentTextTheme.title.color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: isMe ? Colors.black : Theme.of(context).accentTextTheme.title.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: isMe ? null : 150,
          right: isMe ? 150 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}