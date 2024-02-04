import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ponflow_carpoolingapp/constants.dart';
import 'package:flutter/material.dart';
import '../../../../../../Controller/auth_service.dart';
import '../../../../../../Model/VehicleModel.dart';
import '../../../Home/homepage.dart';

class VehicleInformation extends StatefulWidget {
  const VehicleInformation({Key? key}) : super(key: key);

  @override
  State<VehicleInformation> createState() => _VehicleInformationState();
}

class _VehicleInformationState extends State<VehicleInformation> {

  AuthService authService = AuthService();
  VehicleModel userVehicle = VehicleModel();





  final _formKey = GlobalKey<FormState>();
  late TextEditingController makeController = TextEditingController();
  late TextEditingController modelController = TextEditingController();
  late TextEditingController yearController = TextEditingController();
  late TextEditingController colorController = TextEditingController();
  late TextEditingController vehicleRegPicPathController = TextEditingController();
  late TextEditingController vehiclePicPathController = TextEditingController();

  bool isFetched = false;

  Color _maketextFieldColor = primaryColor;
  Color _modeltextFieldColor = primaryColor;
  Color _yeartextFieldColor = primaryColor;
  Color _colortextFieldColor = primaryColor;

   XFile? vehicleRegImage;
   XFile? vehicleImage;


  void _onVehicleRegSuffixIconPressed() async {
    final picker = ImagePicker();
    vehicleRegImage = await picker.pickImage(source: ImageSource.gallery);

    if (vehicleRegImage != null) {
      setState(() {
        vehicleRegPicPathController.text = vehicleRegImage!.path;
      });

    }
  }
  void _onVehiclePictureSuffixIconPressed() async {
    final picker = ImagePicker();
    vehicleImage = await picker.pickImage(source: ImageSource.gallery);

    if (vehicleImage != null) {
      setState(() {
        vehiclePicPathController.text = vehicleImage!.path;
      });

    }
  }

  void onSaveandUploadImages() async {

    if (vehicleRegImage == null && vehicleImage == null &&
        vehicleRegPicPathController.text.trim().isEmpty &&
        vehiclePicPathController.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: "Please upload both images");
    }else {
      authService.UploadVehicleCertificateImagetoFirebase(vehicleRegImage!);
      authService.UploadVehiclePictureImagetoFirebase(vehicleImage!);
    }

  }







  String? validateMake(String? value) {
    if (value == null || value.isEmpty) {
      return 'Make is required';
    }
    return null;
  }

  String? validateModel(String? value) {
    if (value == null || value.isEmpty) {
      return 'Model is required';
    }
    return null;
  }

  String? validateYear(String? value) {
    if (value == null || value.isEmpty) {
      return 'Year is required';
    }
    // Check if the input is a valid year between 1900 and the current year
    final year = int.tryParse(value);
    if (year == null || year < 1900 || year > DateTime.now().year) {
      return 'Please enter a valid year';
    }
    return null;
  }

  String? validateColor(String? value) {
    if (value == null || value.isEmpty) {
      return 'Color is required';
    }
    return null;
  }
  String? validateVehicleRegPicPath(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vehicle registration image is required';
    }
    return null;
  }

  String? validateVehiclePicPath(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vehicle image is required';
    }
    return null;
  }
  //fetching info from firebase
  @override
  void initState(){
    super.initState();
    User? user = authService.getCurrentUser();
    FirebaseFirestore.instance.collection("Users")
        .doc(user?.uid)
        .collection("VehicleInformation")
        .doc("Information")
        .get()
        .then((value) => {
      userVehicle = VehicleModel.fromMap(value.data()),

      makeController = TextEditingController(text: userVehicle.make),
      modelController = TextEditingController(text: userVehicle.model),
      yearController = TextEditingController(text: userVehicle.year),
      colorController = TextEditingController(text: userVehicle.color),
      isFetched = true,
      setState(() {})
    });


  }





 void SaveVehicleInformationToCloudFireStore(){

    if(_formKey.currentState!.validate()){
      try{
        authService.storeVehicleInfotoCloudFirestore(makeController.text,modelController.text, yearController.text, colorController.text, "Driver");
        onSaveandUploadImages();
        Fluttertoast.showToast(msg: "Congrats, you're in Driver Mode!");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(index: 4),
            ));

      }catch(e){
        Fluttertoast.showToast(msg: e.toString());
      }
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
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0,),
                      child: Text("Make",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                    const SizedBox(height: 5,),
                     Container(

                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(10.0),
                          color: isFetched ? secondaryColor : _maketextFieldColor,
                          border: Border.all(
                            color: secondaryColor,
                            width: 2.0,
                          ),
                        ),
                        child: TextFormField(
                          //controller: email,
                          controller: makeController,
                          keyboardType: TextInputType.text,
                          validator: validateMake,
                          decoration: const InputDecoration(
                            hintText: 'Jeep',
                            hintStyle: TextStyle(color: Colors.white54,fontSize: 20),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          ),
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                          onChanged: (value) {
                            setState(() {
                              // update the container's color based on whether the TextField is empty or not
                              if (value.isEmpty) {
                                _maketextFieldColor = primaryColor;
                              } else {
                                _maketextFieldColor = secondaryColor;
                              }
                            });
                          },
                        ),
                      ),
                    const SizedBox(height: 15,),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0,),
                      child: Text("Model",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                    const SizedBox(height: 5,),
                     Container(
                        // color: primaryColor,
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isFetched ? secondaryColor : _modeltextFieldColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: secondaryColor,
                            width: 2.0,
                          ),
                        ),
                        child:  TextFormField(
                          controller: modelController,
                          keyboardType: TextInputType.text,
                          validator: validateModel,
                          decoration: const InputDecoration(
                            hintText: 'Compass Sport',
                            hintStyle: TextStyle(color: Colors.white54,fontSize: 20),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          ),
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                          onChanged: (value) {
                            setState(() {
                              // update the container's color based on whether the TextField is empty or not
                              if (value.isEmpty) {
                                _modeltextFieldColor = primaryColor;
                              } else {
                                _modeltextFieldColor = secondaryColor;
                              }
                            });
                          },
                        ),
                      ),

                    const SizedBox(height: 15,),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0,),
                      child: Text("Year",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                    const SizedBox(height: 5,),
                     Container(
                        // color: primaryColor,
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isFetched ? secondaryColor : _yeartextFieldColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: secondaryColor,
                            width: 2.0,
                          ),
                        ),
                        child:  TextFormField(
                          controller: yearController,
                          //controller: email,
                          keyboardType: TextInputType.number,
                          validator: validateYear,
                          decoration: const InputDecoration(
                            hintText: '2021',
                            hintStyle: TextStyle(color: Colors.white54,fontSize: 20),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          ),
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                          onChanged: (value) {
                            setState(() {
                              // update the container's color based on whether the TextField is empty or not
                              if (value.isEmpty) {
                                _yeartextFieldColor = primaryColor;
                              } else {
                                _yeartextFieldColor = secondaryColor;
                              }
                            });
                          },
                        ),
                      ),



                    const SizedBox(height: 15,),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0,),
                      child: Text("Color",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                    const SizedBox(height: 5,),
                     Container(
                        // color: primaryColor,
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isFetched ? secondaryColor : _colortextFieldColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: secondaryColor,
                            width: 2.0,
                          ),
                        ),
                        child:  TextFormField(
                          controller: colorController,
                          //controller: email,
                          keyboardType: TextInputType.text,
                          validator: validateColor,
                          decoration: const InputDecoration(
                            hintText: 'Charcol Gray',
                            hintStyle: TextStyle(color: Colors.white54,fontSize: 20),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          ),
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                          onChanged: (value) {
                            setState(() {
                              // update the container's color based on whether the TextField is empty or not
                              if (value.isEmpty) {
                                _colortextFieldColor = primaryColor;
                              } else {
                                _colortextFieldColor = secondaryColor;
                              }
                            });
                          },
                        ),
                      ),

                    const SizedBox(height: 15,),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0,),
                      child: Text("Vehicle Registration Certificate",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                    const SizedBox(height: 5,),
                    Container(
                        // color: primaryColor,
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: vehicleRegPicPathController.text != '' ? secondaryColor : primaryColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: secondaryColor,
                            width: 2.0,
                          ),
                        ),
                        child:  TextFormField(
                          controller: vehicleRegPicPathController,
                          readOnly: true,
                          //validator: validateVehicleRegPicPath,
                          decoration:  InputDecoration(
                            hintText: 'filename.png',
                            hintStyle: const TextStyle(color: Colors.white54,fontSize: 20),
                            border: InputBorder.none,
                            contentPadding:const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            suffixIcon: GestureDetector(
                                onTap: (){
                                  _onVehicleRegSuffixIconPressed();
                                },
                                child:  Image(image: const AssetImage("assets/pngicons/upload_FILL0_wght500_GRAD0_opsz48.png",),color: vehicleRegPicPathController.text != '' ? Colors.white : secondaryColor,)),
                          ),
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),




                    const SizedBox(height: 15,),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0,),
                      child: Text("Vehicle picture",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                    const SizedBox(height: 5,),
                     Container(
                        // color: primaryColor,
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: vehiclePicPathController.text != '' ? secondaryColor : primaryColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: secondaryColor,
                            width: 2.0,
                          ),
                        ),
                        child:  TextFormField(
                          //controller: email,
                          controller: vehiclePicPathController,
                          readOnly: true,
                         // validator: validateVehiclePicPath,
                          decoration:  InputDecoration(
                            hintText: 'filename.png',
                            hintStyle: const TextStyle(color: Colors.white54,fontSize: 20),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            suffixIcon: GestureDetector(

                                onTap: (){
                                  _onVehiclePictureSuffixIconPressed();
                                },
                                child: Image(image: const AssetImage("assets/pngicons/upload_FILL0_wght500_GRAD0_opsz48.png",),color: vehiclePicPathController.text != '' ? Colors.white : secondaryColor)),
                          ),
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),

                  ],
                ),
              ),
            ),
            const  SizedBox(height: 50,),
            Center(
              child: SizedBox(
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


                    SaveVehicleInformationToCloudFireStore();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  HomeScreen(index: 4),
                        ));
                  },
                  child: const Text('Save',style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
                ),
              ),
            ),
            const SizedBox(height: 40,),



          ],
        ),
      ),
    );
  }
}
