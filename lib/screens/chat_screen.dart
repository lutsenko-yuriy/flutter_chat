import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/chat/messages.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Chat"),
        actions: [
          DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  value: "logout",
                  child: Row(
                    children: const [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Log out")
                    ],
                  ),
                )
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == "logout") {
                  FirebaseAuth.instance.signOut();
                }
              })
        ],
      ),
      body: Column(
        children: const [
          Expanded(child: Messages()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection("chats/Agodhvj7GD75OwNwWSfb/messages")
              .add({
            'text':
                "It is time to chew bubble gum and kick ass. And I'm all out of bubble gum."
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
