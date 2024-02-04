
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ponflow_carpoolingapp/Controller/auth_service.dart';
import 'package:ponflow_carpoolingapp/constants.dart';
import 'package:flutter/material.dart';

import '../../../Home/homepage.dart';
import '../../profile_screen.dart';




class IdentityValidationPage extends StatefulWidget {
  const IdentityValidationPage({Key? key}) : super(key: key);

  @override
  State<IdentityValidationPage> createState() => _IdentityValidationPageState();
}

class _IdentityValidationPageState extends State<IdentityValidationPage> {

  XFile? licenseimage;
  XFile? goodstandingimage;

   AuthService authService = AuthService();
   late  TextEditingController _liscensefilePathController = TextEditingController();
   late TextEditingController _goodStandingfilePathController = TextEditingController();
  void _onLicenseSuffixIconPressed() async {
     final picker = ImagePicker();
      licenseimage = await picker.pickImage(source: ImageSource.gallery);

     if (licenseimage != null) {
       setState(() {
         _liscensefilePathController.text = licenseimage!.path;
       });

     }
   }
  void _onGoodStandingSuffixIconPressed() async {
    final picker = ImagePicker();
    goodstandingimage = await picker.pickImage(source: ImageSource.gallery);

    if (goodstandingimage != null) {
       setState(() {
         _goodStandingfilePathController.text = goodstandingimage!.path;
       });


    }
  }

   void onSaveandUploadImages() async {

     if(licenseimage!=null && goodstandingimage!= null){
       Fluttertoast.showToast(msg: "Your License and certificate is saved in our database!");
       authService.uploadLicenseImageToFirebase(licenseimage!);
       authService.UploadGoodStandingCertificateImagetoFirebase(goodstandingimage!);
     }else{
       Fluttertoast.showToast(msg: "You need to upload both images");
     }

   }
  @override
  void initState() {
    super.initState();
    _initAsyncState();
  }
  void _initAsyncState() {
    if (licenseimage != null && goodstandingimage != null) {
      authService
          .downloadLicenseImageUrlFromFirebase(licenseimage!.path)
          .then((downloadLicenseURL) {
        authService
            .downloadGoodStandingImageUrlFromFirebase(goodstandingimage!.path)
            .then((downloadGoodStandingURL) {
          setState(() {
            _liscensefilePathController =
                TextEditingController(text: downloadLicenseURL ?? '');
            _goodStandingfilePathController =
                TextEditingController(text: downloadGoodStandingURL ?? '');
          });
        });
      }).catchError((error) {
        Fluttertoast.showToast(msg: "Failed to get image URLs.");
        // Handle error here, for example by setting default values for the text fields
      });
    } else {
      // Handle null values here, for example by setting default values for the text fields
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          children:  [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 35.0,),
                  child: Text("License or Valid ID",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
                ),
                const SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0,right: 30),
                  child: Container(
                    // color: primaryColor,
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: _liscensefilePathController.text != '' ? secondaryColor : primaryColor,
                      border: Border.all(
                        color: secondaryColor,
                        width: 2.0,
                      ),
                    ),
                    child:  TextField(
                      readOnly: true,
                      controller: _liscensefilePathController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'filename.png',
                        hintStyle: const TextStyle(color: Colors.white54,fontSize: 20),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        suffixIcon: GestureDetector(
                            onTap: (){
                             _onLicenseSuffixIconPressed();
                            },
                            child:  Image(image: const AssetImage("assets/pngicons/upload_FILL0_wght500_GRAD0_opsz48.png",),color: _liscensefilePathController.text != ''? Colors.white : secondaryColor,)),
                      ),
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),


                const Padding(
                  padding: EdgeInsets.only(left: 35.0,),
                  child: Text("Good standing certificate",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
                ),
                const SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0,right: 30),
                  child: Container(
                    // color: primaryColor,
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: _goodStandingfilePathController.text != '' ? secondaryColor : primaryColor,
                      border: Border.all(
                        color: secondaryColor,
                        width: 2.0,
                      ),
                    ),
                    child:  TextField(
                      readOnly: true,
                      controller: _goodStandingfilePathController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'filename.png',
                        hintStyle: const TextStyle(color: Colors.white54,fontSize: 20),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        suffixIcon: GestureDetector(
                            onTap: (){
                              _onGoodStandingSuffixIconPressed();
                            },
                            child:  Image(image: const AssetImage("assets/pngicons/upload_FILL0_wght500_GRAD0_opsz48.png",),color: _goodStandingfilePathController.text != '' ? Colors.white : secondaryColor ,)),
                      ),
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            const  SizedBox(height: 50,),
            SizedBox(
              width: 120,
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
                  // Call the function from AuthService to upload the image to Firebase
                 // authService.UploadLicenseImagetoFirebase(image);
                  onSaveandUploadImages();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  HomeScreen(index: 4),
                      ));
                },
                child: const Text('Save',style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
              ),
            ),
            const SizedBox(height: 40,),



          ],
        ),
      ),

    );
  }
}
