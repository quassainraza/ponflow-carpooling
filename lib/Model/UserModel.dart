class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  bool? offerings;
  String? gender;
  String? birthdate;
  String? bio;
  String? mode;

  UserModel({
     this.uid,
     this.email,
     this.firstName,
     this.lastName,
     this.phoneNumber,
    this.offerings,
    this.gender,
    this.birthdate,
    this.bio,
    this.mode,
  });

//fetching data from Cloud Server
  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstname'],
      lastName: map['lastname'],
      phoneNumber: map['phoneNumber'],
      offerings: map['offerings'],
      gender: map['gender'],
      birthdate: map['birthdate'],
      bio: map['bio'],
      mode: map['mode'],
    );

  }
  //sending data to Cloud Server
Map<String,dynamic> toMap(){
    return {
      'uid':uid,
      'email' : email,
      'firstname' : firstName,
      'lastname': lastName,
      'phoneNumber': phoneNumber,
      'offerings' : offerings,
      'gender' : gender,
      'birthdate': birthdate,
      'bio': bio,
      'mode': mode,
    };
}




}
