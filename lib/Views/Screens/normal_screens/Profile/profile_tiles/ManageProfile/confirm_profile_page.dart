import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ponflow_carpoolingapp/Views/Screens/normal_screens/Home/homepage.dart';
import 'package:ponflow_carpoolingapp/constants.dart';
import 'package:flutter/material.dart';

import '../../../../../../Controller/auth_service.dart';
import '../../../../../../Model/UserModel.dart';




class ConfirmProfilePage extends StatefulWidget {
  const ConfirmProfilePage({Key? key}) : super(key: key);

  @override
  State<ConfirmProfilePage> createState() => _ConfirmProfilePageState();
}

class _ConfirmProfilePageState extends State<ConfirmProfilePage> {

  AuthService authService = AuthService();
  UserModel loggedInUser = UserModel();


  RegExp firstNameRegex = RegExp(r'^[A-Za-z]{3,}$');
  RegExp genderRegex = RegExp(r'^(Male|Female|Non Binary)$', caseSensitive: false);
  bool pathtake = false;

  final _formKey = GlobalKey<FormState>();
  late  TextEditingController _firstnameController = TextEditingController();
  late TextEditingController _secondnameController = TextEditingController();
  late TextEditingController _genderController = TextEditingController();
  late TextEditingController _birthdateController = TextEditingController();
  late TextEditingController _bioController = TextEditingController();


  final List<String> _genders = [
    'Male',
    'Female',
    'Non-Binary',
  ];

  bool displaygender = false;
  bool isFetched = false;


//fetching information from firebase
  @override
  void initState(){
    super.initState();
    User? user = authService.getCurrentUser();
    FirebaseFirestore.instance.collection("Users")
        .doc(user?.uid)
        .get()
        .then((value) => {
      loggedInUser = UserModel.fromMap(value.data()),

      _firstnameController = TextEditingController(text: loggedInUser.firstName),
      _secondnameController = TextEditingController(text: loggedInUser.lastName),
      _genderController = TextEditingController(text: loggedInUser.gender),
      _birthdateController = TextEditingController(text: loggedInUser.birthdate),
      _bioController = TextEditingController(text: loggedInUser.bio),
      isFetched = true,
      setState(() {})
    });
  }


  void SaveInformationtoCloudFirestore(){

    if(_formKey.currentState!.validate()) {
      try {
        authService.storeUserDatatoCloudFirestore(
            loggedInUser.phoneNumber!, _firstnameController.text,
            _secondnameController.text, loggedInUser.offerings!);
        authService.SaverRemainingInfotoCloudFirestore(
            _genderController.text, _birthdateController.text,
            _bioController.text);
        Fluttertoast.showToast(msg: "Information is Saved on Firebase!");
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
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      // Update the birthdate controller with the selected date
      String formattedDate = DateFormat("MMMM d, y").format(picked);
      _birthdateController.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar:  AppBar(
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
            children: [
             // const SizedBox(width: 10,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child:
                    Row(
                      children:  [
                        Padding(
                         padding: const EdgeInsets.only(left: 30.0,bottom: 20),
                         child:  FutureBuilder(
                           future: authService.getProfileImage(),
                           builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                             if (snapshot.hasData && snapshot.data != null) {
                               return CircleAvatar(
                                 radius: 50,
                                 backgroundImage: NetworkImage(snapshot.data ?? ""),
                               );
                             } else {
                               return const CircleAvatar(
                                 backgroundColor: primaryColor,
                                 radius: 50,
                                 backgroundImage: AssetImage(
                                     'assets/profile.png'),
                               );
                             }
                           },
                         ),
                       ),
                       const SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           const SizedBox(height: 5,),
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text("Profile Picture",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
                            ),
                            const SizedBox(height: 5,),
                            Container(
                              // color: primaryColor,
                              height: 40,
                              width: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(
                                  color: secondaryColor,
                                  width: 2.0,
                                ),
                              ),
                              child:  TextField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  hintText:  'Upload picture',
                                  hintStyle: const TextStyle(color: Colors.white54,fontSize: 18),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal:5),
                                  suffixIcon:
                                     GestureDetector(
                                      onTap: (){
                                      //user image_picker to open the gallery....
                                        authService.UploadImagetoFirebase();
                                       },
                                      child: const Image(image: AssetImage("assets/pngicons/upload_FILL0_wght500_GRAD0_opsz48.png",),color: secondaryColor,)),
                                ),
                                style: const TextStyle(color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0,right: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      const SizedBox(height: 5,),
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0,),
                        child: Text("Public first name",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
                      ),
                      const SizedBox(height: 5,),
                      Container(
                        // color: primaryColor,
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: isFetched && _firstnameController.text != '' ? secondaryColor : primaryColor,
                          border: Border.all(
                            color: secondaryColor,
                            width: 2.0,
                          ),
                        ),
                        child: TextFormField(
                          controller: _firstnameController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your firstname';
                            }
                            if(!firstNameRegex.hasMatch(value)){
                              return 'First name should be Min 3 Characters';
                            }
                            return null;
                          },
                          onSaved: (value){
                            _firstnameController.text = value!;
                          },
                          decoration: const InputDecoration(
                            hintText: 'first name',
                            hintStyle: TextStyle(color: Colors.white54,fontSize: 20),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          ),
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),

                      const SizedBox(height: 10,),
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0,),
                        child: Text("Public last name",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
                      ),
                      const SizedBox(height: 5,),
                      Container(
                        // color: primaryColor,
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: isFetched && _secondnameController.text != ''? secondaryColor : primaryColor,
                          border: Border.all(
                            color: secondaryColor,
                            width: 2.0,
                          ),
                        ),
                        child:  TextFormField(
                          controller: _secondnameController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: 'last name',
                            hintStyle: TextStyle(color: Colors.white54,fontSize: 20),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          ),
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0,),
                        child: Text("Gender",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
                      ),
                      const SizedBox(height: 5,),
                      Container(
                        // color: primaryColor,
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: isFetched && _genderController.text != '' ? secondaryColor : primaryColor,
                          border: Border.all(
                            color: secondaryColor,
                            width: 2.0,
                          ),
                        ),
                        child:  TextFormField(
                          controller: _genderController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if(!genderRegex.hasMatch(value!)){
                              return 'Gender is not correct';
                            }
                            return null;
                          },
                          onSaved: (value){
                            _genderController.text = value!;
                          },
                          decoration:  InputDecoration(
                              hintText: 'Write or select',
                              hintStyle: const TextStyle(color: Colors.white54,fontSize: 20),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              suffixIcon:  GestureDetector(
                                  onTap: (){
                                    //for clicking dropdown menu
                                    setState(() {
                                      displaygender = !displaygender;
                                    });

                                  },
                                  child: Image(image: const AssetImage("assets/pngicons/arrow_drop_down_FILL0_wght500_GRAD0_opsz48.png"),color: isFetched && _genderController.text != ''? Colors.white : secondaryColor ,))
                          ),
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      ////drop down container here
                      displaygender ?
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          border: Border.all(
                            color: secondaryColor,
                            width: 2.0,
                          ),
                        ),
                        child: ListView.builder(itemCount: _genders.length,itemBuilder: ((context,index){

                          return  GestureDetector(
                            onTap: (){
                             setState(() {
                               _genderController.text =  _genders[index].toString();
                             });
                            },
                            child: ListTile(
                              title: Text(_genders[index]),
                            ),
                          );
                        })),

                      ): const SizedBox(),



                      /////////////////////////////////////////////////////////////////
                      const SizedBox(height: 10,),

                      const Padding(
                        padding: EdgeInsets.only(left: 10.0,),
                        child: Text("Birth date",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
                      ),
                      const SizedBox(height: 5,),
                      Container(
                        // color: primaryColor,
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: isFetched && _birthdateController.text != '' ? secondaryColor : primaryColor,
                          border: Border.all(
                            color: secondaryColor,
                            width: 2.0,
                          ),
                        ),
                        child: TextFormField(
                         controller: _birthdateController,
                          //enabled: false,
                          decoration:  InputDecoration(
                            hintText: 'Date',
                            hintStyle: const TextStyle(color: Colors.white54,fontSize: 20),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            suffixIcon:
                            GestureDetector(
                                onTap: (){
                                  //select date from calender
                                  setState(() {
                                    _selectDate(context);
                                  });

                                },
                                child:  Image(image: const AssetImage("assets/pngicons/calendar_today_FILL1_wght500_GRAD0_opsz48.png",),color: isFetched && _birthdateController.text != '' ? Colors.white : secondaryColor)),
                          ),
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0,),
                        child: Text("Profile description",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
                      ),
                      const SizedBox(height: 5,),
                      Container(
                        // color: primaryColor,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: isFetched && _bioController.text != ''? secondaryColor : primaryColor,
                          border: Border.all(
                            color: secondaryColor,
                            width: 2.0,
                          ),
                        ),
                        child:  TextFormField(
                          controller: _bioController,
                          maxLines: 5,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: 'Write here..',
                            hintStyle: TextStyle(color: Colors.white54,fontSize: 20),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          ),
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      const  SizedBox(height: 40,),
                      Center(
                        child: SizedBox(
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
                              SaveInformationtoCloudFirestore();
                            },

                            child: const Text('Submit',style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),


                    ],
                  ),
                ),
              ),

            ],
          ),
      ),
    );
  }
}
