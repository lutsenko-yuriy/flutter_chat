import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Chat"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chats/Agodhvj7GD75OwNwWSfb/messages")
            .snapshots(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (ctx, index) {
                    return Container(
                        padding: const EdgeInsets.all(8),
                        child: Text(snapshot.data?.docs[index]['text'] ?? ""));
                  });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection("chats/Agodhvj7GD75OwNwWSfb/messages")
              .add({
            'text' : "It is time to chew bubble gum and kick ass. And I'm all out of bubble gum."
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
