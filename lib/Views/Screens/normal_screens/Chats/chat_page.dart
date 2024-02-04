import 'package:ponflow_carpoolingapp/constants.dart';
import 'package:flutter/material.dart';

import '../../../../Model/Chats.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final dummyList = List.generate(50, (index) => Chats.chats[0]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          Container(
            height: 50,
            color: Colors.white,
            child: Row(children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Image(
                  image: AssetImage(
                      "assets/pngicons/arrow_back_FILL0_wght500_GRAD0_opsz48.png"),
                  width: 40,
                  height: 40,
                  color: secondaryColor,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              CircleAvatar(
                backgroundImage: AssetImage(Chats.chats[0].image),
                radius: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  Chats.chats[0].DriverName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: "SegoeUI",
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: Container(
       // color: primaryColor,
        decoration: BoxDecoration(
          color: primaryColor,
          border: Border(
            top: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),

        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Write your message here..",
                    hintStyle: TextStyle(color: Colors.grey,fontSize: 20),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Image(
                image: AssetImage(
                    "assets/pngicons/send_FILL0_wght500_GRAD0_opsz48.png"),
                width: 40,
                height: 40,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
