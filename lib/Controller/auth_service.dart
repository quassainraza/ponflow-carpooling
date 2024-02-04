import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../Model/UserModel.dart';
import '../Model/VehicleModel.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _storage= FirebaseStorage.instance;
  UserModel user=  UserModel();
  VehicleModel userVehicle = VehicleModel();

  // Sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result;
    } catch (error) {
      return null;
    }
  }

  // Register with email and password
  Future<UserCredential?> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return result;
    } catch (error) {
      return null;
    }
  }

  void updatePassword(String password) async {
    try {
      final User? currentUser = getCurrentUser();
      await currentUser?.updatePassword(password);
    } catch (error) {
      return null;
    }
  }

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Sign in with credential
      final UserCredential result = await _auth.signInWithCredential(credential);
      return result;
    } catch (error) {
      print(error);
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (error) {
      print(error);
    }
  }

  // Get the current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
  FirebaseFirestore getInstance(){
    return _firestore;
  }

  // Listen for user authentication state changes
  Stream<User?> get onAuthStateChanged => _auth.authStateChanges();

  //saving data to cloud firestore
  Future<void> storeUserDatatoCloudFirestore(String phone, String firstname, String lastname, bool offerings) async {
    User? currentUser= getCurrentUser();
    user.email = currentUser?.email;
    user.uid = currentUser?.uid;
    user.phoneNumber = phone;
    user.firstName = firstname;
    user.lastName = lastname;
    user.offerings = offerings;
  try {
    await _firestore
        .collection("Users")
        .doc(currentUser?.uid)
        .set(user.toMap());
  }catch (error){
    print(error);
      }
  }
  Future<void> UpdateMode(String mode)async {
    User? currentUser = getCurrentUser();
    try {
      await _firestore
          .collection("Users")
          .doc(currentUser?.uid)
          .update({'mode': mode});
    } catch (error) {
      print(error);
    }
  }
  Future<void> storeVehicleInfotoCloudFirestore(String make, String model, String year , String color, String mode ) async {
    User? currentUser= getCurrentUser();
    userVehicle.make =  make;
    userVehicle.model = model;
    userVehicle.year = year;
    userVehicle.color = color;
    try{
      UpdateMode(mode);
      await _firestore
          .collection("Users")
          .doc(currentUser?.uid)
          .collection("VehicleInformation")
          .doc("Information")
          .set(userVehicle.toMap());
    }catch (error){
      Fluttertoast.showToast(msg: "Error in saving vehicle info");
    }
  }


  Future<String> getProfileImage() async {

    User? firebaseUser = getCurrentUser();
    final _storageRef = FirebaseStorage.instance.ref().child('Images/Profile/${firebaseUser!.uid}');
    String imageUrl = await _storageRef.getDownloadURL();
    return imageUrl;
  }
  String getImageName(XFile image) {
    File file = File(image.path);
    return path.basename(file.path);
  }
  Future<void> UploadImagetoFirebase() async{
    User? firebaseUser =  getCurrentUser();
    //check for permisson

    final _picker= ImagePicker();
    //select image
    final XFile? image= (await _picker.pickImage(source: ImageSource.gallery));

    try{
      var file= File(image!.path);
      //upload tofirebase
      await  _storage.ref()
          .child('Images/Profile/${firebaseUser!.uid}')
          .putFile(file)
          .whenComplete(() => null);
    }
    catch(error) {
      Fluttertoast.showToast(msg: "No File Selected");
    }
  }

  Future<void> uploadLicenseImageToFirebase(XFile image) async {
    User? firebaseUser = getCurrentUser();

    try {
      if (firebaseUser != null) {
        var file = File(image.path);
        // Upload to Firebase Storage
        await _storage
            .ref()
            .child('Images/IdentityValidation/${firebaseUser.uid}/License Image')
            .putFile(file);
        // Display success message
        //Fluttertoast.showToast(msg: "Your License is uploaded to our database!");
      }
    } catch (error) {
     // Fluttertoast.showToast(msg: "Please select both images");
      rethrow; // rethrow the error to catch it in the calling code if needed
    }
  }
  Future<String> downloadLicenseImageUrlFromFirebase(String filePath) async {
    try {
      // Get download URL of the image
      var downloadURL = await _storage.ref(filePath).getDownloadURL();
      // Return download URL as string
      return downloadURL.toString();
    } catch (error) {
      Fluttertoast.showToast(msg: "Failed to get download URL.");
      rethrow; // rethrow the error to catch it in the calling code if needed
    }
  }
  Future<String> downloadGoodStandingImageUrlFromFirebase(String filePath) async {
    try {
      // Get download URL of the image
      var downloadURL = await _storage.ref(filePath).getDownloadURL();
      // Return download URL as string
      return downloadURL.toString();
    } catch (error) {
      Fluttertoast.showToast(msg: "Failed to get download URL.");
      rethrow; // rethrow the error to catch it in the calling code if needed
    }
  }

  Future<void> UploadGoodStandingCertificateImagetoFirebase(XFile image) async{
    User? firebaseUser =  getCurrentUser();
    //check for permisson

    try {
      if (firebaseUser != null) {
        var file = File(image.path);
        //upload tofirebase
        await _storage.ref()
            .child('Images/IdentityValidation/${firebaseUser.uid}/Good Standing Certificate')
            .putFile(file)
            .whenComplete(() => null);
      }
    }
    catch(error) {
      //Fluttertoast.showToast(msg: "No File Selected");
    }
  }



  Future<void> UploadVehicleCertificateImagetoFirebase(XFile image) async{
    User? firebaseUser =  getCurrentUser();
    //check for permisson

    try {
      if (firebaseUser != null) {
        var file = File(image.path);
        //upload tofirebase
        await _storage.ref()
            .child('Images/IdentityValidation/${firebaseUser.uid}/Vehicle Information/Vehicle Registration Certificate')
            .putFile(file)
            .whenComplete(() => null);
      }
    }
    catch(error) {
      //Fluttertoast.showToast(msg: "No File Selected");
    }
  }
  Future<void> UploadVehiclePictureImagetoFirebase(XFile image) async{
    User? firebaseUser =  getCurrentUser();
    //check for permisson

    try {
      if (firebaseUser != null) {
        var file = File(image.path);
        //upload tofirebase
        await _storage.ref()
            .child('Images/IdentityValidation/${firebaseUser.uid}/Vehicle Information/Vehicle Picture')
            .putFile(file)
            .whenComplete(() => null);
      }
    }
    catch(error) {
      //Fluttertoast.showToast(msg: "No File Selected");
    }
  }



  Future<void> SaverRemainingInfotoCloudFirestore(String gender, String birthdate , String Bio) async {
    User? currentUser = getCurrentUser();
    user.gender = gender;
    user.birthdate = birthdate;
    user.bio = Bio;
    user.mode = "Passenger";
    // Update the document in Firestore
    try {
      await _firestore
          .collection("Users")
          .doc(currentUser?.uid)
          .update(user.toMap());
    } catch (error) {
      print(error);
    }

  }

}