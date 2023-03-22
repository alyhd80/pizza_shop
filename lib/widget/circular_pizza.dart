import 'package:flutter/material.dart';
import 'package:pizza_shop/data/local/model/pizza.dart';

class CircularPizza extends StatelessWidget {
  final Pizza pizza;
  final double size;
  final EdgeInsets padding;

  const CircularPizza(
      {Key? key,
      required this.pizza,
      required this.size,
      required this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
        BoxShadow(
            color: Colors.black26,
            blurRadius: 15,
            spreadRadius: 1,
            offset: Offset(3, 3))
      ]),
      child: Padding(
        padding: padding,
        child: ClipOval(
          child: Image.asset(
            pizza.asset,
            height: size,
          ),
        ),
      ),
    );
  }
}
