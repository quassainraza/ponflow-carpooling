import 'package:ponflow_carpoolingapp/Views/Screens/auth_screens/signup.dart';
import 'review_page.dart';
import 'package:ponflow_carpoolingapp/constants.dart';
import 'package:flutter/material.dart';


class ConfirmationPage extends StatefulWidget {


  final int index;
  const ConfirmationPage({Key? key, required this.index}) : super(key: key);
  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
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
            const Padding(
              padding: EdgeInsets.only(top: 30),
              child: Image(image: AssetImage("assets/ponflow.png"),
                width: 200, // set the width of the image
                height: 100, // set the height of the image
                fit: BoxFit.contain,
              ),
            ),
            const  SizedBox(height: 20,),

                   Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 35.0,left: 35),
                        child: Center(child: Text("Thankyou for using our platform!",style: TextStyle(color: Colors.white ,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 25),)),
                      ),
                       SizedBox(height: 10,),
                      Padding(
                        padding: EdgeInsets.only(right: 35.0, left: 35),
                        child: Center(child: Text("We hope you had a great experience with our platform. Leave us a review so other can hear about it",style: TextStyle(color: Colors.white ,fontFamily: "SegoeUI",fontWeight: FontWeight.w500,fontSize: 15),)),
                      ),

                    ],
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
                  if(widget.index==0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReviewPage(index: 0,)
                        ));
                  }else{
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReviewPage(index: 1,)
                        ));
                  }
                },

                child: const Text('Start',style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
              ),
            ),
            const SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }
}
