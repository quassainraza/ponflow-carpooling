import 'package:ponflow_carpoolingapp/Views/Screens/auth_screens/signup.dart';
import 'package:ponflow_carpoolingapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../../Model/PersonProfile.dart';
import '../../../../widgets/avatar_image.dart';
import '../../Home/homepage.dart';


class DriverReviewPage extends StatefulWidget {

  const DriverReviewPage({Key? key}) : super(key: key);
  @override
  State<DriverReviewPage> createState() => _DriverReviewPageState();
}

class _DriverReviewPageState extends State<DriverReviewPage> {
  double _rating = 0;

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
             Padding(
              padding: const EdgeInsets.only(top: 30),
              child: AvatarImage(Drivers.drivers[0].image, radius: 50,
                width: 100,
                height: 100,
                borderColor: primaryColor,),
            ),
            const  SizedBox(height: 20,),
            Text(Drivers.drivers[0].name,
              style: const TextStyle(fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SegoeUI'),),
            const  SizedBox(height: 20,),
            RatingBar.builder(
              initialRating: 0,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, index) {
                return index < _rating
                    ? Image.asset(
                  'assets/pngicons/star_FILL1_wght500_GRAD0_opsz48.png',
                  height: 40,
                  width: 40,
                  color: secondaryColor,
                )
                    : Image.asset(
                  'assets/pngicons/star_FILL0_wght500_GRAD0_opsz48.png',
                  height: 40,
                  width: 40,
                  color: secondaryColor,
                );
              },

              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            const SizedBox(height: 20,),
              Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20),
              child: Center(
                child: Text( "How was your experience travelling with ${Drivers.drivers[0].name}?" ,style: const TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
              ),

            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20),
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

            const  SizedBox(height: 40,),
            SizedBox(
              width: 100,
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
                          builder: (context) => HomeScreen(index: 2),
                        ));

                },
                child: const Text('Submit',style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
              ),
            ),
            const SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }
}
