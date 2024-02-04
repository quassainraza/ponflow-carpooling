import 'package:flutter/material.dart';

import '../../Model/PersonProfile.dart';

class PassengerProfileWidget extends StatelessWidget {
  final PassengerAttributes passenger;
  final Color color;
  final GestureTapCallback onTap;

  const PassengerProfileWidget({
    Key? key,
    required this.passenger,
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
                backgroundImage: AssetImage(passenger.image),
                radius: 25,
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      passenger.name,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SegoeUI',
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      "${passenger.age} years old -${passenger.gender}",
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
                        "${passenger.ratingGiventoDriver}",
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