import 'package:flutter/material.dart';
import 'package:pizza_shop/data/local/model/pizza.dart';
import 'package:pizza_shop/theme.dart';

class PizzaTitle extends StatelessWidget {
  final Pizza pizza;
  final VoidCallback? onTapLeft;
  final VoidCallback? onTapRight;

  const PizzaTitle(
      {Key? key, required this.pizza, this.onTapLeft, this.onTapRight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          InkWell(
            onTap: () => onTapLeft?.call(),
            child: const CircleAvatar(
              backgroundColor: ColorTheme.pinkLight,
              child: Icon(
                Icons.arrow_back,
                color: ColorTheme.pinkBlack,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                pizza.name,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => onTapRight?.call(),
            child: const CircleAvatar(
              backgroundColor: ColorTheme.pinkLight,
              child: Icon(
                Icons.arrow_forward,
                color: ColorTheme.pinkBlack,
              ),
            ),
          ),
        ],
      ),
    );  }
}
