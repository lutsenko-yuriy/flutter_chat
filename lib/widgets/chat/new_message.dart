import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _enteredMessage = "";

  void _sendEnteredMessage() {
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance
        .collection('chat')
        .add({'text': _enteredMessage, 'createdAt' : Timestamp.now()});
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
            controller: _controller,
            decoration: const InputDecoration(labelText: "Send a message..."),
            onChanged: (value) {
              setState(() {
                _enteredMessage = value;
              });
            },
          )),
          IconButton(
              onPressed:
                  _enteredMessage.trim().isEmpty ? null : _sendEnteredMessage,
              icon: const Icon(Icons.send),
              color: Theme.of(context).primaryColor)
        ],
      ),
    );
  }
}
