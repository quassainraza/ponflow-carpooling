import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ponflow_carpoolingapp/Model/UserModel.dart';
import 'package:ponflow_carpoolingapp/constants.dart';
import 'package:flutter/material.dart';

import '../../../../../../Controller/auth_service.dart';
import '../../../Home/homepage.dart';


class ManageAccount extends StatefulWidget {
  const ManageAccount({Key? key}) : super(key: key);

  @override
  State<ManageAccount> createState() => _ManageAccountState();
}

class _ManageAccountState extends State<ManageAccount> {

  AuthService authService = AuthService();
  UserModel loggedInUser = UserModel();



  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  RegExp strongpassRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  RegExp normalpassRegex = RegExp(r'^.{6,}$');
  final _phoneNumberRegExp = RegExp(r'^1?\s*([2-9][0-9]{2})\s*[.-]?\s*([2-9][0-9]{2})\s*[.-]?\s*([0-9]{4})$');


  final _formKey = GlobalKey<FormState>();
  late  TextEditingController _emailController = TextEditingController();
  final TextEditingController _currentpasswordController = TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();
  final TextEditingController _newconfirmpasswordController = TextEditingController();
  late  TextEditingController _phoneController = TextEditingController();
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

     _emailController = TextEditingController(text: loggedInUser.email),
     _phoneController = TextEditingController(text: loggedInUser.phoneNumber),
     isFetched = true,
     setState(() {})
   });
 }


 //updating information like password
  void _onSave(){

   authService.updatePassword(_newpasswordController.text);
   Fluttertoast.showToast(msg: "Password is updated!");
   Navigator.pushReplacement(
     context,
     MaterialPageRoute(
       builder: (context) => HomeScreen(index: 4),
     ),
   );

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
          children:  [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 35.0,),
                    child: Text("Email",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
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
                        color: isFetched && _emailController.text != '' ? secondaryColor : primaryColor,
                        border: Border.all(
                          color: secondaryColor,
                          width: 2.0,
                        ),
                      ),
                      child:  TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email address';
                          }
                          if (!emailRegex.hasMatch(value)) {
                            return 'Please enter your valid email address';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _emailController.text = value!;
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding:  EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                        ),
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),


                  const Padding(
                    padding: EdgeInsets.only(left: 35.0,),
                    child: Text("Phone number",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                  const SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0,right: 30),
                    child: Container(
                      // color: primaryColor,
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isFetched && _phoneController.text != '' ? secondaryColor : primaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: secondaryColor,
                          width: 2.0,
                        ),
                      ),
                      child: TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if(!_phoneNumberRegExp.hasMatch(value)){
                            return 'Please enter valid phone number';
                          }
                          return null;
                        },
                        onSaved: (value){
                          _phoneController.text = value!;
                        },
                        decoration: InputDecoration(
                          hintText: '${loggedInUser.phoneNumber}',
                          hintStyle: const TextStyle(color: Colors.white54,fontSize: 20),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                        ),
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),

                  const Padding(
                    padding: EdgeInsets.only(left: 35.0),
                    child: Text("Current Password",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
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
                        border: Border.all(
                          color: secondaryColor,
                          width: 2.0,
                        ),
                      ),
                      child:  TextFormField(
                        obscureText: true,
                        controller: _currentpasswordController,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Current Password is required for updating';
                          }
                          if (!strongpassRegex.hasMatch(value)) {
                            return 'Please enter a password with Min 8 characters, atleast 1 number and 1 letter';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _currentpasswordController.text = value!;
                        },
                        decoration: const InputDecoration(
                          hintText: 'password',
                          hintStyle: TextStyle(color: Colors.white54, fontSize: 20),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                        ),
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),

                  const Padding(
                    padding: EdgeInsets.only(left: 35.0),
                    child: Text("New Password",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
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
                        border: Border.all(
                          color: secondaryColor,
                          width: 2.0,
                        ),
                      ),
                      child: TextFormField(
                        obscureText: true,
                        controller: _newconfirmpasswordController,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is required';
                          }
                          if (!strongpassRegex.hasMatch(value)) {
                            return 'Please enter a password with Min 8 characters, atleast 1 number and 1 letter';
                          }
                          if(_currentpasswordController.text == _newpasswordController.text){
                            return 'Please enter new password';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _newpasswordController.text = value!;
                        },
                        decoration: const InputDecoration(
                          hintText: 'password',
                          hintStyle: TextStyle(color: Colors.white54, fontSize: 20),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                        ),
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),



                  const Padding(
                    padding: EdgeInsets.only(left: 35.0),
                    child: Text("Confirm Password",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
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
                        border: Border.all(
                          color: secondaryColor,
                          width: 2.0,
                        ),
                      ),
                      child:  TextFormField(
                        obscureText: true,
                        controller: _newconfirmpasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field is required for confirmation';
                          }
                          if (_newpasswordController.text!= _newconfirmpasswordController.text) {
                            return 'Password not matched!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _newconfirmpasswordController.text = value!;
                        },
                        decoration: const InputDecoration(
                          hintText: 'password',
                          hintStyle: TextStyle(color: Colors.white54, fontSize: 20),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                        ),
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                ],
              ),
            ),
            const  SizedBox(height: 20,),
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
                 _onSave();//when user press on save button
                },
                child: const Text('Save',style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
              ),
            ),
            const SizedBox(height: 40,),
            GestureDetector(
              onTap: () {

                // Write Click Listener Code Here.
              },
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width:  MediaQuery.of(context).size.width*0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child:const Text(
                  "Connect with Google",
                  style: TextStyle(color: Colors.black,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),

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
