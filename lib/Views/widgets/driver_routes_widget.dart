
import 'package:flutter/material.dart';

import '../../Model/Routes.dart';

class DriverRoutesWidget extends StatelessWidget {
  final Items item;
  final Color color;
  final GestureTapCallback onTap;
  const DriverRoutesWidget({Key? key, required this.item, required this.color,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "From:",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'SegoeUI',
                          ),
                        ),
                        Text(
                          item.fromLoc,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'SegoeUI',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3,),
                    Row(
                      children: [
                        const Text(
                          "To:",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'SegoeUI',
                          ),
                        ),
                        Text(
                          item.toLoc,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'SegoeUI',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${item.price}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SegoeUI',
                    ),
                  ),
                  const SizedBox(height: 3,),
                  Text(
                    item.date,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'SegoeUI',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
