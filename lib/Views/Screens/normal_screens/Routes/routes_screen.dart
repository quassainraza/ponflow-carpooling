import 'package:ponflow_carpoolingapp/constants.dart';
import 'package:flutter/material.dart';

import '../../../../Model/Routes.dart';
import '../../../widgets/items_widget.dart';
import 'Routeflow/routepage_ongoing.dart';
import 'Routeflow/routepage_past.dart';

class RoutesScreen extends StatefulWidget {
  const RoutesScreen({Key? key}) : super(key: key);


  @override
  _RoutesScreenState createState() => _RoutesScreenState();

}

class _RoutesScreenState extends State<RoutesScreen> {

  TextEditingController fromcities = TextEditingController();
  TextEditingController tocities =  TextEditingController();
  TextEditingController date =  TextEditingController();



  final List<String> _cities = [
    'Madrid',
    'Barcelona',
    'Valencia',
    'Sevilla',
    'Zaragoza',
    'Malaga',
    'Murcia',
    'Palma de Mallorca',
    'Las Palmas de Gran Canaria',
    'Bilbao',
    'Alicante',
    'Cordova',
    'Valladolid',
    'Vigo',
    'Gijon',
  ];
  bool displayfromcities = false;
  bool dispplaytocities = false ;
  getdialogbox(){
    return Padding(
      padding: const EdgeInsets.only(top: 20.0,),
      child: SizedBox(
        //width: MediaQuery.of(context).size.width,
        child: Dialog(
          alignment: Alignment.topCenter,
          backgroundColor: Colors.white,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius:
              BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15,top: 10,bottom: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Center(child: Text("Where from?",style: TextStyle(color: secondaryColor,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),)),
                  const SizedBox(height: 10,),
                  Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0,right: 5),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: secondaryColor,
                              width: 1.0,
                            ),

                          ),
                          child:  TextField(
                            controller: fromcities,
                            readOnly: true,
                            decoration:  InputDecoration(
                                hintText: 'from',
                                border: InputBorder.none,
                                hintStyle: const TextStyle(color: greycolor,fontSize: 20),
                                contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                                suffixIcon: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      displayfromcities = !displayfromcities;
                                    });
                                  },
                                  child:  const Image(image: AssetImage("assets/pngicons/arrow_drop_down_FILL0_wght500_GRAD0_opsz48.png"),color: secondaryColor,)

                                  ,)

                            ),
                          ),
                        ),
                      )
                  ),
                  displayfromcities || displayfromcities ?
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0,1),
                          )
                        ]
                    ),
                    child: ListView.builder(itemCount: _cities.length,itemBuilder: ((context,index){
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            displayfromcities ? fromcities.text = (_cities[index] ).toString() : tocities.text = (_cities[index] ).toString() ;
                          });
                        },
                        child: ListTile(
                          title: Text(_cities[index]),
                        ),
                      );
                    })),
                  ): const SizedBox() ,
                  const SizedBox(height: 5,),
                  const Center(child: Text("Where to?",style: TextStyle(color: secondaryColor,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),)),
                  const SizedBox(height: 10,),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0,right: 5),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: secondaryColor,
                            width: 1.0,
                          ),
                        ),
                        child:  TextField(
                          controller: tocities,
                          readOnly: true,
                          decoration:  InputDecoration(
                              hintText: 'To',
                              hintStyle:  const TextStyle(color: greycolor,fontSize: 20),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),

                              suffixIcon:  GestureDetector(
                                  onTap: (){
                                    dispplaytocities = !dispplaytocities;
                                  },
                                  child: const Image(image: AssetImage("assets/pngicons/arrow_drop_down_FILL0_wght500_GRAD0_opsz48.png"),color: secondaryColor,))

                          ),
                        ),
                      ),
                    ),
                  ),


                  const SizedBox(height: 5,),
                  const Center(child: Text("When?",style: TextStyle(color: secondaryColor,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),)),
                  const SizedBox(height: 10,),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0,right: 5),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: secondaryColor,
                            width: 1.0,
                          ),
                        ),
                        child:  TextField(
                          controller: date,
                          readOnly: true,
                          decoration: const InputDecoration(
                              hintText: 'Date',
                              hintStyle: TextStyle(color: greycolor,fontSize: 20),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                              suffixIcon: Image(image: AssetImage("assets/pngicons/calendar_today_FILL1_wght500_GRAD0_opsz48.png"),color: secondaryColor,)
                          ),
                        ),
                      ),
                    ),
                  ),



                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: 100,
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
                        Navigator.pop(context);
                      },
                      child: const Text('Search',style: TextStyle(color: Colors.white,fontFamily: "SegoeUI",fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 15),
              child: Container(
                width: MediaQuery.of(context).size.width-30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white
                ),
                child:InkWell(
                  onTap: () {
                    // Handle button tap
                  },
                  child: Row(
                    children:   <Widget>[
                      const SizedBox(width: 20,height: 70,),
                      const Text(
                        'Search',
                        style:  TextStyle(
                          color: greycolor,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'SegoeUI',
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                          onTap: (){

                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () => Navigator.of(context).pop(),
                                        child: const Padding(
                                          padding: EdgeInsets.only(left: 20.0,),
                                          child: Image(image: AssetImage("assets/pngicons/arrow_back_FILL0_wght500_GRAD0_opsz48.png"),
                                            width: 60, // set the width of the image
                                            height: 40, // set the height of the image
                                            //fit: BoxFit.contain,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:MediaQuery.of(context).size.width,
                                        child: getdialogbox(),
                                      )

                                    ],
                                  );
                                });
                          },
                          child: const Icon(Icons.search, color: secondaryColor, size: 35)),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
        body: getPlaces()
    );
  }


  Widget getPlaces() {
    final dummyList = List.generate(50, (index) => Routes.items[0]);
    return  SingleChildScrollView(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: dummyList.length,
        itemBuilder: (BuildContext context, int index) {
          final color = index < 10 ? secondaryColor : greycolor;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: AvailableRoutesWidget(
              onTap: (){

                if(color==secondaryColor && index >=0 && index <10 ) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  RoutePageOngoing(color: secondaryColor,index: index,),
                    ));
                }
                if(color == greycolor && index >= 10 ){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  const RoutePagePast(),
                      ));
                }

              }
              ,
              item: dummyList[index],color: color,),
          );
        },
      ),
    );
  }

}