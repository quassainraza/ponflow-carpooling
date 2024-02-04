import 'package:flutter/material.dart';

import '../../../../../Model/PersonProfile.dart';
import '../../../../../constants.dart';
import '../../../../widgets/avatar_image.dart';


class PassengerProfileOngoingRoute extends StatefulWidget {
  const PassengerProfileOngoingRoute({Key? key}) : super(key: key);

  @override
  State<PassengerProfileOngoingRoute> createState() => _PassengerProfileOngoingRouteState();
}

class _PassengerProfileOngoingRouteState extends State<PassengerProfileOngoingRoute> {

  late double screenWidth;
  @override
  Widget build(BuildContext context) {
    List<Widget> pastpassengers = getPassengersList();
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        toolbarHeight: 35,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Image(image: AssetImage(
              "assets/pngicons/arrow_back_FILL0_wght500_GRAD0_opsz48.png"),
            width: 10, // set the width of the image
            height: 10, // set the height of the image
            //fit: BoxFit.contain,
            color: Colors.white,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  AvatarImage(Drivers.drivers[0].image, radius: 50,
                    width: 100,
                    height: 100,
                    borderColor: primaryColor,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20,),
                        Text(Drivers.drivers[0].name,
                          style: const TextStyle(fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SegoeUI'),),

                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            Text(
                              "${Drivers.drivers[0].rating}",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'SegoeUI',
                              ),
                            ),
                            const Icon(Icons.star, color: Colors.white,
                                size: 15),
                          ],
                        ),

                      ],
                    ),
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text("Age: ", style: TextStyle(fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SegoeUI'),),
                      Text("${Drivers.drivers[0].age} years old",
                        style: const TextStyle(fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'SegoeUI'),),
                    ],
                  ),
                  const SizedBox(height: 5,),

                  Row(
                    children: [
                      const Text("Gender: ", style: TextStyle(fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SegoeUI'),),
                      Text(Drivers.drivers[0].gender, style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'SegoeUI'),),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Bio: ", style: TextStyle(fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SegoeUI'),),
                      Text(Drivers.drivers[0].bio ?? '', style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'SegoeUI'),),
                    ],
                  )

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: pastpassengers,
              ),
            )


          ],
        ),
      ),
    );
  }
  List<Widget> getPassengersList() {
    List<Widget> cards = [];
    screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double cardWidth = screenWidth - 10;
    for (int i = 0; i < 5; i++) {
      cards.add(Card(
        color: primaryColor,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: SizedBox(
            width: cardWidth, // set the width to 300
            height: 80,
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(height: 2,),
                    const AvatarImage("assets/person1.png", radius: 20,
                      width: 40,
                      height: 40,
                      borderColor: primaryColor,),
                    const SizedBox(width: 10,),
                    const Text("John Doe", style: TextStyle(fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SegoeUI'),),
                    const Spacer(),
                    Row(
                      children: List.generate(
                        5,
                            (index) =>
                        const Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    )

                  ],
                ),
                const SizedBox(height: 2,),
                const Text(
                  "Juan was great, we had great time and felt safe along the route. I would recommend Juan for sure.",
                  style: TextStyle(fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'SegoeUI'),),


              ],
            ),
          ),
        ),
      ));
    }
    return cards;
  }
}
