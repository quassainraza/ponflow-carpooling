

import 'package:flutter/material.dart';

import '../../../../Model/PersonProfile.dart';
import '../../../../constants.dart';
import '../../../widgets/avatar_image.dart';
import '../Chats/chat_page.dart';
import 'confirmation_page.dart';
import 'driver_ongoing_route_page.dart';


class PassengerProfileRequest extends StatefulWidget {

  final Color color;
  final int index;
  const PassengerProfileRequest({Key? key, required this.color,required this.index}) : super(key: key);

  @override
  State<PassengerProfileRequest> createState() => _PassengerProfileRequestState();
}

class _PassengerProfileRequestState extends State<PassengerProfileRequest> {


  late double screenWidth;


  @override
  Widget build(BuildContext context) {
    List<Widget> pastpassengers = getPassengersList();
    return  Scaffold(
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
        actions: (widget.index==0) ? [
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: ElevatedButton(
              onPressed: () {
                // do something when button is pressed
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              child: const Text(
                'Request',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ] : null,

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
            GestureDetector(
                onTap: () {
                  getDialogbox();
                },
                child: (widget.index==0) ? const Text("Decline", style: TextStyle(fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SegoeUI'),) : const Text("Remove", style: TextStyle(fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SegoeUI'),)),
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
                  if(widget.index==0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          const ConfirmationPage(index: 1,),
                        ));
                  }else{
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          const ChatPage(),
                        ));
                  }
                },

                child: (widget.index==0) ? const Text('Accept', style: TextStyle(
                    color: Colors.white,
                    fontFamily: "SegoeUI",
                    fontWeight: FontWeight.bold,
                    fontSize: 20),):
                    const Text('Message', style: TextStyle(
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

  Future getDialogbox() {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Text(
                    (widget.index==0) ? 'Are you sure you want to decline this request?' : 'Are you sure you want to remove this passenger?',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 80,
                        height: 45,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return greycolor; // set the button color when disabled
                                }
                                return greycolor; // set the button color in other states
                              },
                            ),

                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DriverOngoingRoutePage(),
                                ));
                          },
                          child: const Text('yes',style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        height: 45,
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
                                  builder: (context) => const DriverOngoingRoutePage(),
                                ));
                          },
                          child: const Text('no',style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


