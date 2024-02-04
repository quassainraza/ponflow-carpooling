import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ponflow_carpoolingapp/Views/Screens/auth_screens/signup.dart';
import 'package:ponflow_carpoolingapp/constants.dart';
import 'package:flutter/material.dart';
import '../../../Controller/auth_service.dart';
import '../normal_screens/Home/homepage.dart';
import '../normal_screens/Search/SelectRoute/select_route_page.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key, required this.index}) : super(key: key);
  int index;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  RegExp strongpassRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  RegExp normalpassRegex = RegExp(r'^.{6,}$');
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _onLoginPressed() async {
    if (_formKey.currentState!.validate()) {
      await _authService
          .signInWithEmailAndPassword(
              _emailController.text, _passwordController.text)
          .then((uid) => {
                if (uid != null)
                  {
                    Fluttertoast.showToast(msg: "Login is Succesful!"),
                    if (widget.index == 0)
                      {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SelectRoutePage()),
                        ),
                      }
                    else
                      {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                      index: widget.index,
                                    ))),
                      }
                  }
                else
                  {
                    Fluttertoast.showToast(msg: "User not found")
                  }
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  Future<void> _signInWithGoogle() async {
    UserCredential? userCredential = await _authService.signInWithGoogle();
    if (userCredential != null) {
      // Navigate to home screen
      if (widget.index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SelectRoutePage()),
        );
      } else {
        Navigator.pop(context, widget.index);
      }
    } else {
      // Show error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to sign in with Google.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 5, right: 5),
              child: Text(
                "Please log in to continue",
                style: TextStyle(
                    color: secondaryColor,
                    fontFamily: "SegoeUI",
                    fontWeight: FontWeight.bold,
                    fontSize: 27),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Image(
                image: AssetImage("assets/ponflow.png"),
                width: 200, // set the width of the image
                height: 100, // set the height of the image
                fit: BoxFit.contain,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 35.0,
                    ),
                    child: Text(
                      "Email",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "SegoeUI",
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
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
                          hintStyle: TextStyle(color: Colors.white30, fontSize: 20),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 5, horizontal: 16),
                        ),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 35.0),
                    child: Text(
                      "Password",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "SegoeUI",
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
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
                            return 'Please enter a password with Min 8 Chars, atleast 1 number and 1 letter';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _passwordController.text = value!;
                        },
                        decoration: const InputDecoration(
                          hintText: 'password',
                          hintStyle:
                              TextStyle(color: Colors.white30, fontSize: 20),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 5, horizontal: 16),
                        ),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
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
                    _onLoginPressed();

                },
                child: const Text(
                  'Log in',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "SegoeUI",
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                _signInWithGoogle();
                // Write Click Listener Code Here.
              },
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: const Text(
                  "Log in with Google",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "SegoeUI",
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Container(
                      height: 2.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "or",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "SegoeUI",
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 50.0),
                    child: Container(
                      height: 2.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 140,
              height: 40,
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
                        builder: (context) => SignupScreen(index: widget.index),
                      ));
                  // add button press logic here
                },
                child: const Text(
                  'Sign up',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "SegoeUI",
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
