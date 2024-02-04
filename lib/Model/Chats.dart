

class Chats{

  static final chats = [
    ChatItems(id: 1, image: "assets/person.png", DriverName: "Juan P. Perez Rodriguez", Message: "Hello John, where is the exact pickup point?")

  ];
}






class ChatItems{

  final int id;
  final String image;
  final String DriverName;
  final String Message;

  ChatItems({ required this.id, required this.image,required this.DriverName, required this.Message });
}