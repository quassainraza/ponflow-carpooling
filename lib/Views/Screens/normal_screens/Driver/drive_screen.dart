import 'package:ponflow_carpoolingapp/Views/Screens/normal_screens/Driver/share_route_page.dart';
import 'package:flutter/material.dart';

import '../../../../Model/Routes.dart';
import '../../../../constants.dart';
import '../../../widgets/driver_routes_widget.dart';
import 'driver_ongoing_route_page.dart';
import 'driver_past_route_page.dart';

class DriveScreen extends StatefulWidget {
   DriveScreen({Key? key}) : super(key: key);

  @override
  State<DriveScreen> createState() => _DriveScreenState();
}

class _DriveScreenState extends State<DriveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 15),
              child: Container(
                width: MediaQuery.of(context).size.width-30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: secondaryColor
                ),
                child:InkWell(
                  onTap: () {
                    // Handle button tap
                  },
                  child: Row(
                    children:   <Widget>[
                      const SizedBox(width: 20,height: 70,),
                      const Text(
                        'Share new route',
                        style:  TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SegoeUI',
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ShareRoutePage(),
                              ));
                        },
                        child: Image.asset('assets/pngicons/add_FILL0_wght500_GRAD0_opsz48.png',color: Colors.white,width: 50,height: 70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
        body: getPlaces()
    );
  }
  Widget getPlaces() {
    final dummyList = List.generate(50, (index) => Routes.items[0]);
    final currentDate = DateTime.now();
    return  SingleChildScrollView(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: dummyList.length,
        itemBuilder: (BuildContext context, int index) {
          //final route = dummyList[index];
         // final routeDate = DateTime.parse(route.date);
          //final color = routeDate.isBefore(currentDate) ? const Color(0xffe1e1e1) : Colors.white;
          final color = index < 10 ? secondaryColor : const Color(0xff707070);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: DriverRoutesWidget(
            onTap: (){
              if(color == secondaryColor && index==0){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DriverOngoingRoutePage(),
                    ));
              }
              if(color == secondaryColor && index > 0 ){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  DriverPastRoutePage(color: color , index : index),
                    ));

              }
              if(color ==greycolor && index >=10){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  DriverPastRoutePage(color: color , index : index),
                    ));

              }
              }
            ,item: dummyList[index],color: color ),
          );
        },
      ),
    );
  }
}
