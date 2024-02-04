import 'package:fluttertoast/fluttertoast.dart';
import 'package:ponflow_carpoolingapp/Views/Screens/normal_screens/Home/homepage.dart';
import 'package:ponflow_carpoolingapp/constants.dart';
import 'package:flutter/material.dart';

import '../../../Controller/auth_service.dart';
import '../normal_screens/Search/SelectRoute/select_route_page.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key , required this.index}) : super(key: key);
  int index;
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isChecked = false;
  final AuthService _authService = AuthService();


  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  RegExp strongpassRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  RegExp normalpassRegex = RegExp(r'^.{6,}$');
  final _phoneNumberRegExp = RegExp(r'^1?\s*([2-9][0-9]{2})\s*[.-]?\s*([2-9][0-9]{2})\s*[.-]?\s*([0-9]{4})$');
  //final _phoneFocusNode = FocusNode();
  //String _phoneNumber = '';



  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();



  Future<void> _onSignUpPressed(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
          await _authService.registerWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        );
        _authService.storeUserDatatoCloudFirestore(_phoneController.text, _firstnameController.text, _lastnameController.text,_isChecked);
        Fluttertoast.showToast(msg: "SignUp is Successful!");
        _navigateToNextScreen(context);
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  void _navigateToNextScreen(BuildContext context) {
    if (widget.index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SelectRoutePage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(index: widget.index),
        ),
      );
    }
  }



  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }


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
                        border: Border.all(
                          color: secondaryColor,
                          width: 2.0,
                        ),
                      ),
                      child: TextFormField(
                        autofocus: false,
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
                          hintText: 'email',
                          hintStyle: TextStyle(color: Colors.white30,fontSize: 20),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                        ),
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  const Padding(
                    padding: EdgeInsets.only(left: 35.0),
                    child: Text("Password",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
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
                        controller: _passwordController,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is required for login';
                          }
                          if (!strongpassRegex.hasMatch(value)) {
                            return 'Please enter a password with Min 8 characters, atleast 1 number and 1 letter';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _passwordController.text = value!;
                        },
                        //controller: password,
                        decoration: const InputDecoration(
                          hintText: 'password',
                          hintStyle: TextStyle(color: Colors.white30, fontSize: 20),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                        ),
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),

                  const SizedBox(height: 5,),
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
                      child: TextFormField(
                        obscureText: true,
                        controller: _confirmpasswordController,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is required for login';
                          }
                          if (_passwordController.text!= _confirmpasswordController.text) {
                            return 'Password not matched!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _confirmpasswordController.text = value!;
                        },
                        decoration:const InputDecoration(
                          hintText: 'confirm password',
                          hintStyle: TextStyle(color: Colors.white30, fontSize: 20),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                        ),
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  const Padding(
                    padding: EdgeInsets.only(left: 35.0,),
                    child: Text("First name",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
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
                        controller: _firstnameController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your firstname';
                          }
                          return null;
                        },
                        onSaved: (value){
                          _firstnameController.text = value!;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration:const InputDecoration(
                          hintText: 'first name',
                          hintStyle: TextStyle(color: Colors.white30,fontSize: 20),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                        ),
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  const Padding(
                    padding: EdgeInsets.only(left: 35.0,),
                    child: Text("Last name",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
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
                        controller: _lastnameController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your lastname';
                          }
                          return null;
                        },
                        onSaved: (value){
                          _lastnameController.text = value!;
                        },
                        decoration: const InputDecoration(
                          hintText: 'last name',
                          hintStyle: TextStyle(color: Colors.white30,fontSize: 20),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                        ),
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),

                  const SizedBox(height: 5,),

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
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: secondaryColor,
                          width: 2.0,
                        ),
                      ),
                      child:  TextFormField(
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
                        decoration: const InputDecoration(
                          hintText: 'phone number',
                          hintStyle: TextStyle(color: Colors.white30,fontSize: 20),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                        ),
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isChecked = !_isChecked;
                            });
                          },
                          child: SizedBox(
                            width: 30.0,
                            height: 30.0,
                            child: _isChecked
                                ? Image.asset(
                              'assets/pngicons/check_box_outline_blank_FILL0_wght500_GRAD0_opsz48.png',
                              width: 30.0,
                              height: 30.0,
                              color: secondaryColor,
                            )
                                : Image.asset(
                              'assets/pngicons/check_box_FILL0_wght500_GRAD0_opsz48.png',
                              width: 30.0,
                              height: 30.0,
                              color: secondaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isChecked = !_isChecked;
                              });
                            },
                            child: const Text(
                              "I accept receiving promotional material from \nPonflow's offering",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )

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
                  !_isChecked ? _onSignUpPressed(context) : Fluttertoast.showToast(msg: "Please check the box");
                  },
                child: const Text('Sign up',style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
              ),
            ),
            const SizedBox(height: 20,),
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
                  "Sign up with Google",
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
