import 'package:ponflow_carpoolingapp/constants.dart';
import 'package:flutter/material.dart';

import '../../Model/Routes.dart';


class AvailableRoutesWidget extends StatelessWidget {

  final Items item;
  Color color;
  final GestureTapCallback onTap;
  AvailableRoutesWidget({Key? key, required this.item, required this.color, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 3.0),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            // side: const BorderSide(color: Colors.white60),
          ),
          leading: CircleAvatar(
            backgroundImage: AssetImage(item.image),
            radius: 25,
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5,),
              Text(item.fromLoc,style: const TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'SegoeUI'),),
              const SizedBox(height: 8,),
              Text(item.toLoc,style: const TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'SegoeUI'),),
              const SizedBox(height: 5,),
            ],
          ),
          tileColor: color,
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 2,),
              Text("\$${item.price}",style: const TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'SegoeUI')),
              const SizedBox(height: 10,),
              Text(item.date,style: const TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'SegoeUI')),
              const SizedBox(height: 8,),


            ],
          ),

        ),
      ),
    );
  }
}
