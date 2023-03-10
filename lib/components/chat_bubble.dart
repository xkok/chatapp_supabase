import 'package:chatapp_supabase/common/constants.dart';
import 'package:chatapp_supabase/models/message.dart';
import 'package:chatapp_supabase/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message, this.profile});

  final Message message;
  final Profile? profile;

  @override
  Widget build(BuildContext context) {
    List<Widget> chatContent = [
      if (!message.isMine)
        CircleAvatar(
          child: profile == null
              ? preloader
              : Text(
                  profile!.username.substring(0, 1).toUpperCase(),
                ),
        ),
      const SizedBox(width: 12),
      Flexible(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            color: message.isMine
                ? Theme.of(context).primaryColor
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            message.content,
            style: TextStyle(
                color: message.isMine ? Colors.white : Colors.black,
                fontSize: 16),
          ),
        ),
      ),
      const SizedBox(width: 12),
      Text(format(message.createdAt, locale: 'en_short')),
      const SizedBox(width: 60),
    ];
    if (message.isMine) {
      chatContent = chatContent.reversed.toList();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
      child: Row(
        mainAxisAlignment:
            message.isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: chatContent,
      ),
    );
  }
}
