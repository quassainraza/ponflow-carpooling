import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:ponflow_carpoolingapp/Controller/stripeAccountForDrivers.dart';
import 'package:ponflow_carpoolingapp/Views/Screens/normal_screens/Profile/profile_tiles/DriverVehicleInformation/driver_vehicle_info.dart';
import 'package:ponflow_carpoolingapp/Views/Screens/normal_screens/Profile/profile_tiles/IdentityValidation/identity_validation.dart';
import 'package:ponflow_carpoolingapp/Views/Screens/normal_screens/Profile/profile_tiles/ManageAccount/manage_account.dart';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Controller/auth_service.dart';
import '../../../../constants.dart';
import '../../auth_screens/login.dart';
import 'profile_tiles/ManageProfile/confirm_profile_page.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;




const String _stripeClientId = 'ca_MAWttb3CTXFNwTMRXcU6AH9wZ567fS6e';
const String _stripeAuthorizeUrl = 'https://connect.stripe.com/oauth/authorize';
const String _stripeRedirectUri = 'https://www.ponflow.com/stripe/callback';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final AuthService _authService = AuthService();
  String? authorizationCode;
  MyStripeConnect myStripeConnect = MyStripeConnect();
  String _driverId = '';
  String _email = '';
  String _bankAccountNumber = '';
  String _routingNumber = '';

  //final authorizationUrl = 'https://connect.stripe.com/oauth/authorize?response_type=code&client_id=<YOUR_CLIENT_ID>&scope=read_write';
  StreamSubscription? _sub;


  Future<void> _launchStripeAuthorization() async {
    Uri url =  Uri.parse( '$_stripeAuthorizeUrl?response_type=code&client_id=$_stripeClientId&scope=read_write&redirect_uri=$_stripeRedirectUri');
    if (await canLaunchUrl(url)) {
      await launchUrl(url,mode: LaunchMode.externalApplication,);
    } else {
      throw 'Could not launch $url';
    }
    // Listen to incoming URL changes

    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null && uri.toString().startsWith(_stripeRedirectUri)) {
        setState(() {
          authorizationCode = uri.queryParameters['code'];
          Navigator.pop(context);
          myStripeConnect.getAuthCode(authorizationCode!);
        });
      }
      // Handle the incoming URI link here
      // The authorization code will be in the query parameter of the URI
    });


  }

  @override
  void dispose() {
    super.dispose();
    _sub?.cancel();
  }





  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        toolbarHeight: 40,
        elevation: 0,
        title:  const Text("Profile",style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ConfirmProfilePage(),
                      ));
                },
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  leading: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                       SizedBox(height: 2),
                      Icon(
                        Icons.account_circle_outlined,
                        size: 50,
                        color: Colors.white,
                      ),
                     // Image.asset("assets/pngicons/account_circle_FILL0_wght500_GRAD0_opsz48.png", color: Colors.white,height: 50,width: 50,),
                    ],
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Manage Profile" ,style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'SegoeUI'),),
                      SizedBox(height: 2,),
                      Text("Name, gender , Birth Date, etc..",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w500,fontFamily: 'SegoeUI'),),
                    ],
                  ),
                  trailing: Image.asset("assets/pngicons/chevron_right_FILL0_wght500_GRAD0_opsz48.png",color: Colors.white,height: 55,width: 50),
                  tileColor: secondaryColor,
                ),
              ),
            ),
            const SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ManageAccount(),
                      ));
                },
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    // side: const BorderSide(color: Colors.white60),
                  ),
                  leading: SizedBox(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children:  [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:const [
                                SizedBox(height: 8,),
                                Text("Manage Account" ,style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'SegoeUI'),),
                                SizedBox(height: 5,),
                                Text("Email,password,phone..",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w500,fontFamily: 'SegoeUI'),),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  trailing: Image.asset("assets/pngicons/chevron_right_FILL0_wght500_GRAD0_opsz48.png",color: Colors.white,height: 55,width: 50),
                  tileColor: secondaryColor,

                ),
              ),
            ),
            const SizedBox(height: 10,),



            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const IdentityValidationPage(),
                      ));
                },
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    // side: const BorderSide(color: Colors.white60),
                  ),
                  leading: SizedBox(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children:  [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:const [
                                SizedBox(height: 8,),
                                Text("Identity Validation" ,style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'SegoeUI'),),
                                SizedBox(height: 5,),
                                Text("License, good standing,address,vehicle etc",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w500,fontFamily: 'SegoeUI'),),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  tileColor: secondaryColor,
                  trailing: Image.asset("assets/pngicons/chevron_right_FILL0_wght500_GRAD0_opsz48.png",color: Colors.white,height: 55,width: 50),

                ),
              ),
            ),
            const SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VehicleInformation(),
                      ));
                },
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    // side: const BorderSide(color: Colors.white60),
                  ),
                  leading: SizedBox(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children:  [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:const [
                                SizedBox(height: 8,),
                                Text("Driver vehicle information" ,style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'SegoeUI'),),
                                SizedBox(height: 5,),
                                Text("Vehicle registration, picture etc",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w500,fontFamily: 'SegoeUI'),),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  tileColor: secondaryColor,
                  trailing: Image.asset("assets/pngicons/chevron_right_FILL0_wght500_GRAD0_opsz48.png",color: Colors.white,height: 55,width: 50),

                ),
              ),
            ),
            const SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GestureDetector(
                onTap: _launchStripeAuthorization,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    // side: const BorderSide(color: Colors.white60),
                  ),
                  leading: SizedBox(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children:  [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:const [
                                SizedBox(height: 8,),
                                Text("Make driver bank account" ,style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'SegoeUI'),),
                                SizedBox(height: 5,),
                                Text("Credit Cards, balance, payment history..",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w500,fontFamily: 'SegoeUI'),),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  tileColor: secondaryColor,
                  trailing: Image.asset("assets/pngicons/chevron_right_FILL0_wght500_GRAD0_opsz48.png",color: Colors.white,height: 55,width: 50),

                ),
              ),
            ),
            const SizedBox(height: 10,),



            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GestureDetector(
                onTap: () async {
                  Uri url = Uri.parse('https://www.ponflow.com/');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url,mode: LaunchMode.externalApplication,);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    // side: const BorderSide(color: Colors.white60),
                  ),
                  leading: SizedBox(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children:  [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:const [
                                SizedBox(height: 8,),
                                Text("About Ponflow" ,style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'SegoeUI'),),
                                SizedBox(height: 5,),
                                Text("Information,support,contact",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w500,fontFamily: 'SegoeUI'),),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  tileColor: secondaryColor,
                  trailing: Image.asset("assets/pngicons/chevron_right_FILL0_wght500_GRAD0_opsz48.png",color: Colors.white,height: 55,width: 50),

                ),
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GestureDetector(
                onTap: () async{
                  Uri url = Uri.parse('https://www.ponflow.com/terminos-y-politica');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url,mode: LaunchMode.externalApplication,);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    // side: const BorderSide(color: Colors.white60),
                  ),
                  leading: const Text("Terms and Conditions" ,style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'SegoeUI'),),

                  tileColor: secondaryColor,
                  trailing: Image.asset("assets/pngicons/chevron_right_FILL0_wght500_GRAD0_opsz48.png",color: Colors.white,height: 55,width: 50),

                ),
              ),
            ),
            const SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GestureDetector(
                onTap: ()async{
                  Uri url = Uri.parse('https://www.ponflow.com/terminos-y-politica');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url,mode: LaunchMode.externalApplication,);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    // side: const BorderSide(color: Colors.white60),
                  ),
                  leading: const Text("Privacy Policy" ,style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'SegoeUI'),),
                  tileColor: secondaryColor,
                  trailing: Image.asset("assets/pngicons/chevron_right_FILL0_wght500_GRAD0_opsz48.png",color: Colors.white,height: 55,width: 50),

                ),
              ),
            ),
            const SizedBox(height: 10,),
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
                  _authService.signOut();
                  Fluttertoast.showToast(msg: "You're logout");
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(index: 4,),
                    ),
                  );
                },
                child: const Text('Log out',style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
              ),
            ),
            const SizedBox(height: 10,),

          ],
        ),

      ),
    );
  }
}
