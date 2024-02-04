
class Routes{

  static final items = [
    Items(id: 1, image: "assets/tempplace.png", fromLoc: "Plaza lez Americaz", toLoc: "Plaza del Caribe", date: "MAR 12- 12:00 PM", price: 15)

  ];



}


class Items {

  final int id;
  final String image;
  final String fromLoc;
  final String toLoc;
  final String date;
  final num price;

  Items({required this.id,required this.image,required this.fromLoc,required this.toLoc,required this.date,required this.price});
}