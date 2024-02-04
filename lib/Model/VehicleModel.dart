class VehicleModel{
  String? make;
  String? model;
  String? year;
  String? color;

  VehicleModel({this.make, this.model, this.year, this.color});

  //fetching information from server

  factory VehicleModel.fromMap(Map<String, dynamic>? map){
    if (map == null) {
      return VehicleModel();
    }
    return VehicleModel(
      make : map['make'] ,
      model : map['model'],
      year : map['year'] ,
      color: map['color'],
    );
  }


  Map<String, dynamic> toMap(){
    return {
      'make' : make,
      'model' : model,
      'year' : year,
      'color' : color,
    };
  }






}



