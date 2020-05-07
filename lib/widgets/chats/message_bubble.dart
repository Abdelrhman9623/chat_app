import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class MessageBubble extends StatelessWidget {
  final String message;
  final String username;
  final bool isMe;
  final Key key;

  MessageBubble(
    this.message,
    this.username,
    this.isMe,
    {this.key}
  );
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          width: 150,
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
              // Text(
              //   username,
              //   style: TextStyle(
              //     color: isMe ? Colors.indigo : Theme.of(context).accentTextTheme.title.color,
              //     fontSize: 12,
              //     fontWeight: FontWeight.bold
              //   ),
              // ),
              Text(
                message,
                style: TextStyle(
                  color: isMe ? Colors.orange[600] : Theme.of(context).accentTextTheme.title.color
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}