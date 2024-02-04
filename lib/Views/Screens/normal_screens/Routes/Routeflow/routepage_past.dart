import 'package:ponflow_carpoolingapp/Views/Screens/normal_screens/Routes/Routeflow/driver_review_page.dart';
import 'package:ponflow_carpoolingapp/Views/Screens/normal_screens/Routes/Routeflow/passenger_profile_ongoing_route.dart';
import 'package:ponflow_carpoolingapp/constants.dart';
import 'package:flutter/material.dart';

import '../../../../../Model/PersonProfile.dart';
import '../../../../../Model/Routes.dart';
import '../../../../widgets/passenger_profile_widget.dart';
import '../../Chats/chat_page.dart';
import '../../Driver/passenger_profile.dart';
import '../../Driver/passenger_profile_request.dart';
import '../../Home/homepage.dart';



class RoutePagePast extends StatefulWidget {

  const RoutePagePast({Key? key}) : super(key: key);

  @override
  State<RoutePagePast> createState() => _RoutePagePastState();
}

class _RoutePagePastState extends State<RoutePagePast> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.40,
            decoration:   const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/car.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Image(
                    image: AssetImage(
                        "assets/pngicons/arrow_back_FILL0_wght500_GRAD0_opsz48.png"),
                    width: 40,
                    height: 40,
                    color: Colors.white,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 190.0,left: 15),
                  child: Row(

                    children: const [
                      Text("Vehicle: ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15,fontFamily: "SegoeUI",shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: Colors.black,
                          offset: Offset(3, 2),
                        ),
                      ],),),
                      Text("Jeep Compas Sport 2021 ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 15,fontFamily: "SegoeUI",shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: Colors.black,
                          offset: Offset(2, 2),
                        ),
                      ],),)

                    ],
                  ),
                )

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text("From: ",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'SegoeUI'),),
                    Text("Plaza las Americas, San Juan",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w500,fontFamily: 'SegoeUI'),),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: const [
                    Text("To:  ",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'SegoeUI'),),
                    Text("Plaza dal Caribe, Ponce",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w500,fontFamily: 'SegoeUI'),),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: const [
                    Text("Date: ",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'SegoeUI'),),
                    Text("12 March 2023",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w500,fontFamily: 'SegoeUI'),),
                    Spacer(),
                    Text("Time: ",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'SegoeUI'),),
                    Text("12:00 PM",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w500,fontFamily: 'SegoeUI'),),

                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: const [
                    Text("Seats Available: ",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'SegoeUI'),),
                    Text("3",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w500,fontFamily: 'SegoeUI'),),
                    Spacer(),
                    Text("Price per seat: ",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'SegoeUI'),),
                    Text("\$20",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w500,fontFamily: 'SegoeUI'),),
                  ],
                ),
                const SizedBox(height: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Offerings:",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'SegoeUI'),),
                    Text("I want you to carpool with us and have a great time. We can play your favourite music. We have phone charging stations available, see you soon!",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w500,fontFamily: 'SegoeUI'),),

                  ],
                ),

              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                getPassengerProfileList(),
              ],
            ),
          ),

        ],
      ),

      bottomNavigationBar: Container(
        // color: primaryColor,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),

        child: Row(
          children: [
            SizedBox(
              width: 120,
              height: 40,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Colors.yellow; // set the button color when disabled
                      }
                      return Colors.yellow; // set the button color in other states
                    },
                  ),

                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DriverReviewPage(),
                      ));
                },

                child: const Text('Review', style: TextStyle(
                    color: Colors.white,
                    fontFamily: "SegoeUI",
                    fontWeight: FontWeight.bold,
                    fontSize: 20),)

                ,
              ),
            ),
            // const SizedBox(width: 10),
            const Spacer(),
            SizedBox(
              width: 120,
              height: 40,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return secondaryColor; // set the button color when disabled
                      }
                      return secondaryColor; // set the button color in other states
                    },
                  ),

                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatPage(),
                      ));
                },

                child: const Text('Message', style: TextStyle(
                    color: Colors.white,
                    fontFamily: "SegoeUI",
                    fontWeight: FontWeight.bold,
                    fontSize: 20),)

                ,
              ),
            ),
          ],
        ),
      ),

    );
  }
  getPassengerProfileList() {
    final dummyList = List.generate(10, (index) => Passengers.passengers[0]);
    return   ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: dummyList.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: PassengerProfileWidget(
            onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const PassengerProfileOngoingRoute()
                    ));

            },
            passenger: dummyList[index],color: secondaryColor,),
        );
      },
    );


  }
}
