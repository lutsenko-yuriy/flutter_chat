import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.value(FirebaseAuth.instance.currentUser),
        builder: (ctx, messagesSnapshot) {
          if (messagesSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("chat")
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  var docs = snapshot.data!.docs;
                  return ListView.builder(
                      reverse: true,
                      itemCount: docs.length,
                      itemBuilder: (ctx, index) {
                        final doc = docs[index];
                        return MessageBubble(
                            key: ValueKey(doc.id),
                            message: doc['text'],
                            isMe: doc['userId'] ==
                                messagesSnapshot.data!.uid,
                          );
                      });
                }
              }
          );
        }
    );
  }
}
