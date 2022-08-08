import 'package:flutter/material.dart';
import 'package:studhub/services/firestore.dart';

class NewMessage extends StatefulWidget {
  final String roomId;
  const NewMessage({Key? key, required this.roomId}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _enteredMessage = "";

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    FirestoreService().uploadMessage(widget.roomId, _enteredMessage);
    _enteredMessage = "";
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: _controller,
              decoration: const InputDecoration(labelText: "Send a message..."),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            color: Theme.of(context).primaryColor,
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}
