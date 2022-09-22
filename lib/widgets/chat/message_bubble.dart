import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  final String username;
  final String imageUrl;

  const MessageBubble(
      {Key? key,
      required this.message,
      required this.username,
      required this.imageUrl,
      this.isMe = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageContainer = CircleAvatar(
      backgroundColor: Colors.grey,
      foregroundImage: NetworkImage(imageUrl),
      radius: 24,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) imageContainer,
          Container(
            decoration: BoxDecoration(
                color: isMe
                    ? Colors.grey[300]
                    : Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft:
                      isMe ? const Radius.circular(12) : const Radius.circular(0),
                  bottomRight:
                      isMe ? const Radius.circular(0) : const Radius.circular(12),
                )),
            width: MediaQuery.of(context).size.width / 2,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(username,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe
                            ? Colors.black
                            : Theme.of(context).secondaryHeaderColor)),
                Text(message,
                    style: TextStyle(
                        color: isMe
                            ? Colors.black
                            : Theme.of(context).secondaryHeaderColor)),
              ],
            ),
          ),
          if (isMe) imageContainer,
        ],
      ),
    );
  }
}
