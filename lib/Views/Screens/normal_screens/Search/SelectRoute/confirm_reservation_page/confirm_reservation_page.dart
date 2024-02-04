import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../../constants.dart';
import '../../../../../widgets/avatar_image.dart';
import '../../../Driver/confirmation_page.dart';


class ConfirmReservationPage extends StatefulWidget {
  const ConfirmReservationPage({Key? key}) : super(key: key);
  @override
  State<ConfirmReservationPage> createState() => _ConfirmReservationPageState();
}

class _ConfirmReservationPageState extends State<ConfirmReservationPage> {
  bool? _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        toolbarHeight: 40,
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Image(image: AssetImage("assets/pngicons/arrow_back_FILL0_wght500_GRAD0_opsz48.png"),
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
          children:  [
            const SizedBox(width: 10,),
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

                    ],
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Row(
                      children: [
                        const AvatarImage("assets/person1.png", radius: 20,width: 40,height: 40,borderColor: primaryColor,),
                        const SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Ian Miguel Velez Lerdo",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'SegoeUI'),),
                            Text("21 years old - Male",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w500,fontFamily: 'SegoeUI'),),
                          ],
                        ),

                        const Spacer(),
                        const Text("4.5",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w500,fontFamily: 'SegoeUI'),),
                        const Icon(Icons.star,color: Colors.white, size: 12,),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20,),

                  const Center(
                    child: Text("Tell your driver about you",style: TextStyle(color: secondaryColor,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10),
                    child: Container(
                      // color: primaryColor,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: secondaryColor,
                          width: 2.0,
                        ),
                      ),
                      child: const TextField(
                        //controller: email,
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Write here..',
                          hintStyle: TextStyle(color: Colors.white30,fontSize: 20),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        ),
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isChecked = !_isChecked!;
                            });
                          },
                          child: Container(
                            width: 30.0,
                            height: 30.0,
                            child: _isChecked!
                                ? Image.asset(
                              'assets/pngicons/check_box_FILL0_wght500_GRAD0_opsz48.png',
                              width: 30.0,
                              height: 30.0,
                              color: secondaryColor,
                            )
                                : Image.asset(
                              'assets/pngicons/check_box_outline_blank_FILL0_wght500_GRAD0_opsz48.png',
                              width: 30.0,
                              height: 30.0,
                              color: secondaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Flexible(
                          child: RichText(
                            text: TextSpan(
                              text: 'I accept the ',
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Terms and Conditions',
                                  style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Navigate to the terms and conditions screen
                                    },
                                ),
                                const TextSpan(
                                  text: ' of use and\nthe ',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Privacy Policies',
                                  style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Navigate to the privacy policies screen
                                    },
                                ),
                                const TextSpan(
                                  text: " of Ponflow's platform.",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )


                ],
              ),
            ),

            const SizedBox(height: 20,),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.5,
                height: 40,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return _isChecked! ? secondaryColor : greycolor; // set the button color when disabled
                        }
                        return _isChecked! ? secondaryColor : greycolor; // set the button color in other states
                      },
                    ),

                  ),
                  onPressed: () {

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>const ConfirmationPage( index: 0,),
                        ));

                  },
                  child: const Text('Confirm and Pay',style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 18),),
                ),
              ),
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),

    );
  }
}
