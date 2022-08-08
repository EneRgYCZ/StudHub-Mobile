import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

class MessageBubbleWidget extends StatelessWidget {
  final bool isMe;
  final String message;
  const MessageBubbleWidget(
      {Key? key, required this.message, required this.isMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bubble(
      margin: isMe
          ? const BubbleEdges.only(top: 10, left: 70)
          : const BubbleEdges.only(top: 10, right: 70),
      alignment: isMe ? Alignment.topRight : Alignment.topLeft,
      nip: isMe ? BubbleNip.rightTop : BubbleNip.leftTop,
      color: isMe
          ? Theme.of(context).cardColor
          : Theme.of(context).backgroundColor,
      child: Text(message, textAlign: isMe ? TextAlign.right : TextAlign.left),
    );
  }
}
