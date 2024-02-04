

class Drivers{

  static final drivers = [
    DriverAttributes(id: 1, image: "assets/person1.png", name: "Juan P. Perez Rodriguez", age: 25,gender: "Male", rating: 4.5, bio: "I am a jeep vendor, I love to go on road trips on weekend especially to the south of island. I like to meet new people and make new friends around Puerto Rico" ,),
  ];
}

class Passengers{

  static final passengers = [
    PassengerAttributes(id:1, image: "assets/person1.png", name: "Ian Miguel",age: 21, ratingGiventoDriver: 4.5, gender: 'Male', bio: 'I will recommend Juan!', )

  ];
}
class PassengerAttributes{

  final int id;
  final String image;
  final String name;
  final int age;
  final String gender;
  final double ratingGiventoDriver;
  final String? bio;

  PassengerAttributes({required this.id , required this.image, required this.name, required this.age, required this.ratingGiventoDriver, required this.gender, required this.bio});
}

class DriverAttributes{

  final int id;
  final String image;
  final String name;
  final int age;
  final String gender;
  final double rating;
  final String? bio;

  DriverAttributes({required this.id , required this.image, required this.name, required this.age, required this.rating, required this.gender, required this.bio});
}