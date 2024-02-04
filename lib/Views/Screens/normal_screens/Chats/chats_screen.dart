import 'package:ponflow_carpoolingapp/constants.dart';
import 'package:flutter/material.dart';

import '../../../../Model/Chats.dart';
import '../../../widgets/chat_widget.dart';
import 'chat_page.dart';


class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        toolbarHeight: 20,
        elevation: 0,
      ),
      body: getChats(),
    );
  }
  Widget getChats() {
    final dummyList = List.generate(50, (index) => Chats.chats[0]);
    return  SingleChildScrollView(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: dummyList.length,
        itemBuilder: (BuildContext context, int index) {
          //final color = index < 10 ? secondaryColor : const Color(0xff707070);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: ChatWidget(

              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  const ChatPage(),
                    ));
              },
              chatitem: dummyList[index],color: secondaryColor,),
          );
        },
      ),
    );
  }
}
