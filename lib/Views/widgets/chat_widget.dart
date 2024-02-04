
import 'package:flutter/material.dart';

import '../../Model/Chats.dart';


class ChatWidget extends StatelessWidget {
  final ChatItems chatitem;
  final Color color;
  final GestureTapCallback onTap;
  const ChatWidget({Key? key, required this.chatitem, required this.color,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            // side: const BorderSide(color: Colors.white60),
          ),
          leading: CircleAvatar(
            backgroundImage: AssetImage(chatitem.image),
            radius: 25,
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5,),
              Text(chatitem.DriverName,style: const TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'SegoeUI'),),
              const SizedBox(height: 8,),
              Text(chatitem.Message,style: const TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.w500,fontFamily: 'SegoeUI'),),
              const SizedBox(height: 5,),
            ],
          ),
          tileColor: color,

        ),







      ),
    );
  }
}
