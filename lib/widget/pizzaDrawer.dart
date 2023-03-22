import 'package:flutter/material.dart';
import 'package:pizza_shop/theme.dart';
import 'package:pizza_shop/widget/circular_pizza.dart';

import '../data/local/model/pizza.dart';

class PizzaDrawer extends StatelessWidget {
  final List<Pizza> pizzas;

  const PizzaDrawer({Key? key, required this.pizzas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: ColorTheme.pink),
      child: ListView.builder(
          itemCount: pizzas.length,
          itemBuilder: (context, index) {
            final pizza = pizzas[index];

            return Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: CircularPizza(pizza: pizza, size: 80, padding: EdgeInsets.symmetric(vertical: 12)),
            );
          }),
    );
  }
}
