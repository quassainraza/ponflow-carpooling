import 'package:ponflow_carpoolingapp/Views/Screens/normal_screens/Driver/passenger_profile.dart';
import 'package:ponflow_carpoolingapp/Views/Screens/normal_screens/Driver/passenger_profile_request.dart';
import 'package:ponflow_carpoolingapp/Views/Screens/normal_screens/Home/homepage.dart';
import 'package:flutter/material.dart';

import '../../../../../Model/PersonProfile.dart';
import '../../../../../constants.dart';
import '../../../widgets/avatar_image.dart';
import '../../../widgets/passenger_profile_widget.dart';


class DriverPastRoutePage extends StatefulWidget {
  final Color color;
  final int index;
  const DriverPastRoutePage({Key? key,required this.color, required this.index}) : super(key: key);

  @override
  State<DriverPastRoutePage> createState() => _DriverPastRoutePageState();
}

class _DriverPastRoutePageState extends State<DriverPastRoutePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Image(image: AssetImage("assets/pngicons/arrow_back_FILL0_wght500_GRAD0_opsz48.png"),
              width: 50, // set the width of the image
              height: 40, // set the height of the image
              //fit: BoxFit.contain,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children:  [
                const AvatarImage("assets/car.png", radius: 10,width: 190,height: 120,borderColor: primaryColor,),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 80,),
                    Text("Vehicle:",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'SegoeUI'),),
                    Text("Jeep Compass 2021",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w500,fontFamily: 'SegoeUI'),),

                  ],
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
                    SizedBox(height: 5,),
                    Text("Passengers:",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'SegoeUI'),),
                  ],
                ),


              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                getDriverProfileList(),
              ],
            ),
          ),

        ],
      ),

    );
  }

  getDriverProfileList() {
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
            if(widget.color == greycolor && widget.index >=10){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  PassengerProfile(color: greycolor, index: widget.index,)
                  ));
            }
            if(widget.color == secondaryColor &&widget.index >0 && widget.index <10 ){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  PassengerProfile(color: secondaryColor, index: widget.index,)
                  ));
            }
            },
            passenger: dummyList[index],color: secondaryColor,),
        );
      },
    );



  }
}
