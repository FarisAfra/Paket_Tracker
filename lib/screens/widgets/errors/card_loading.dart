import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';

class CustomCardLoading extends StatelessWidget {
  final double height;
  final double radius;
  final double marginX;
  final double marginY;
  final int totalCard;

  const CustomCardLoading(
      {this.height = 58,
      this.radius = 10,
      this.marginX = 20,
      this.marginY = 5,
      required this.totalCard,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: List.generate(totalCard, (index) {
          return CardLoading(
            height: height,
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            margin:
                EdgeInsets.symmetric(horizontal: marginX, vertical: marginY),
          );
        }),
      ),
    );
  }
}
