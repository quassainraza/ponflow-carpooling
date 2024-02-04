import 'package:flutter/material.dart';

import '../../Model/PersonProfile.dart';

class DriverProfileWidget extends StatelessWidget {
  final DriverAttributes driver;
  final Color color;
  final GestureTapCallback onTap;

  const DriverProfileWidget({
    Key? key,
    required this.driver,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(driver.image),
                radius: 25,
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      driver.name,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SegoeUI',
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      "${driver.age} years old -${driver.gender}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SegoeUI',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        "${driver.rating}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SegoeUI',
                        ),
                      ),
                      const Icon(Icons.star, color: Colors.white, size: 12),
                    ],
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