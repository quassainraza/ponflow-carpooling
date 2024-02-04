import 'package:flutter/material.dart';

import '../../../../constants.dart';
import 'confirm_route_page.dart';

class ShareRoutePage extends StatefulWidget {
  const ShareRoutePage({Key? key}) : super(key: key);
  @override
  State<ShareRoutePage> createState() => _ShareRoutePageState();
}

class _ShareRoutePageState extends State<ShareRoutePage> {


  String dropdownValue = '';
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Padding(
              padding: const EdgeInsets.only(left: 10,top: 20,),
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: const Image(image: AssetImage("assets/pngicons/arrow_back_FILL0_wght500_GRAD0_opsz48.png"),
                  width: 40, // set the width of the image
                  height: 50, // set the height of the image
                  fit: BoxFit.contain,

                  color: Colors.white,
                ),
              ),
            ),
            const Center(child: Text("Where from?",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),)),
            const SizedBox(height: 10,),
            Center(
               child: Padding(
                 padding: const EdgeInsets.only(left: 25.0,right: 25),
                 child: Container(
                   height: 50,
                   width: double.infinity,
                   decoration: BoxDecoration(
                     color: primaryColor,
                     borderRadius: BorderRadius.circular(6),
                   ),
                   child: TextField(
                     readOnly: true,
                     decoration: InputDecoration(
                       hintText: 'From',
                       hintStyle: const TextStyle(color: Colors.white30,fontSize: 20),
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(10.0),
                         // gapPadding: 10.0,
                         borderSide: const BorderSide(color: secondaryColor, width: 2.0),
                       ),
                       enabledBorder: OutlineInputBorder(
                         borderSide: const BorderSide(color: secondaryColor),
                         borderRadius: BorderRadius.circular(10),
                       ),
                       focusedBorder: OutlineInputBorder(
                         borderSide: const BorderSide(color: secondaryColor),
                         borderRadius: BorderRadius.circular(10),
                       ),
                       suffixIcon: const Image(image: AssetImage("assets/pngicons/arrow_drop_down_FILL0_wght500_GRAD0_opsz48.png"),color: secondaryColor,)

                     ),
                   ),
                 ),
               ),
             ),

            const Center(child: Text("Where to?",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),)),
            const SizedBox(height: 10,),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0,right: 25),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: 'To',
                        hintStyle: const TextStyle(color: Colors.white30,fontSize: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          // gapPadding: 10.0,
                          borderSide: const BorderSide(color: secondaryColor, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: secondaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: secondaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: const Image(image: AssetImage("assets/pngicons/arrow_drop_down_FILL0_wght500_GRAD0_opsz48.png"),color: secondaryColor,)

                    ),
                  ),
                ),
              ),
            ),


            const Center(child: Text("When?",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),)),
            const SizedBox(height: 10,),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0,right: 25),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: 'Date',
                        hintStyle: const TextStyle(color: Colors.white30,fontSize: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          // gapPadding: 10.0,
                          borderSide: const BorderSide(color: secondaryColor, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: secondaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: secondaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: const Image(image: AssetImage("assets/pngicons/calendar_today_FILL1_wght500_GRAD0_opsz48.png"),color: secondaryColor,)
                    ),
                  ),
                ),
              ),
            ),


            const Center(child: Text("At what time?",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),)),
            const SizedBox(height: 10,),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0,right: 25),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: 'Time',
                        hintStyle: const TextStyle(color: Colors.white30,fontSize: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          // gapPadding: 10.0,
                          borderSide: const BorderSide(color: secondaryColor, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: secondaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: secondaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: const Image(image: AssetImage("assets/pngicons/schedule_FILL0_wght500_GRAD0_opsz48.png",),color: secondaryColor,),
                    ),
                  ),
                ),
              ),
            ),


            const Center(child: Text("How many seats are available?",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),)),
            const SizedBox(height: 10,),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0,right: 25),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: '#',
                        hintStyle: const TextStyle(color: Colors.white30,fontSize: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          // gapPadding: 10.0,
                          borderSide: const BorderSide(color: secondaryColor, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: secondaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: secondaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: const Image(image: AssetImage("assets/pngicons/arrow_drop_down_FILL0_wght500_GRAD0_opsz48.png"),color: secondaryColor,)
                    ),
                  ),
                ),
              ),
            ),


            const Center(child: Text("At what cost per seat?",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),)),
            const SizedBox(height: 10,),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0,right: 25),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: '\$',
                        hintStyle: const TextStyle(color: Colors.white30,fontSize: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          // gapPadding: 10.0,
                          borderSide: const BorderSide(color: secondaryColor, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: secondaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: secondaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: const Image(image: AssetImage("assets/pngicons/arrow_drop_down_FILL0_wght500_GRAD0_opsz48.png"),color: secondaryColor,)
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40,),
            Center(
              child: SizedBox(
                width: 140,
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
                        builder: (context) => const ConfirmRoutePage()
                    ));
                  },
                  child: const Text('Next',style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
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
