import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pizza_shop/data/local/model/pizza.dart';
import 'package:pizza_shop/data/local/model/shopping.dart';
import 'package:pizza_shop/theme.dart';
import 'package:pizza_shop/widget/circular_pizza.dart';
import 'package:pizza_shop/widget/piza_title_widget.dart';
import 'package:pizza_shop/widget/pizzaDrawer.dart';

const _pizzaMovementDuration = Duration(milliseconds: 1600);

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController();
  double page = 0;
  Pizza pizza = Pizza.pizzaList.first;
  final shopping = Shopping();

  @override
  void initState() {
    // TODO: implement initState
    pageController.addListener(_onListener);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.removeListener(_onListener);
    pageController.dispose();
    super.dispose();
  }

  void _onListener() {
    setState(() {
      page = pageController.page!;
    });
  }

  void _animateTo(
    int page, {
    Duration duration = const Duration(milliseconds: 700),
  }) {
    if (page < 0 || page > Pizza.pizzaList.length - 1) return;
    pageController.animateToPage(
      page.round(),
      duration: duration,
      curve: Curves.elasticOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.transparent,
      endDrawer: Drawer(
        width: 120,
        child: PizzaDrawer(pizzas: shopping.pizzas),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: LayoutBuilder(builder: (context, constraints) {
              final height = constraints.maxHeight;
              final width = constraints.maxWidth;
              final size = width * 0.6;
              final backgroundPosition = -height / 2;
              return Stack(
                children: [
                  // Create the background
                  Positioned(
                    top: backgroundPosition,
                    left: backgroundPosition,
                    right: backgroundPosition,
                    bottom: size / 2,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        color: ColorTheme.pinkLight,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  //Create the pizza
                  Listener(
                    onPointerUp: (_) {
                      _animateTo(page.round());
                    },
                    child: PageView.builder(
                      physics: BouncingScrollPhysics(),
                        controller: pageController,
                        itemCount: Pizza.pizzaList.length,
                        onPageChanged: (index) {
                          pizza = Pizza.pizzaList[index];
                        },
                        itemBuilder: (context, index) {
                          final pizza = Pizza.pizzaList[index];
                          final percent = page - index;
                          final opacity = 1.0 - percent.abs();
                          final verticalSpace = size / 1.2;
                          final radius = height - verticalSpace;
                          final x = radius * sin(percent);
                          final y =
                              radius * cos(percent) - height + verticalSpace;

                          return Opacity(
                            opacity:
                                opacity < 0.35 ? 0.0 : opacity.clamp(0.0, 1.0),
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..translate(x, y)
                                ..rotateZ(percent),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: CircularPizza(
                                  pizza: pizza,
                                  size: size,
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),

                  Positioned(
                    top: MediaQuery.of(context).viewPadding.top,
                    left: 20,
                    child: IconButton(
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      icon: const Icon(
                        Icons.menu,
                        color: ColorTheme.pinkBlack,
                      ),
                    ),
                  )
                ],
              );
            }),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  PizzaTitle(
                    pizza: pizza,
                    onTapLeft: () => _animateTo(page.round() - 1,
                        duration: _pizzaMovementDuration),
                    onTapRight: ()=>_animateTo(page.round() +1,
                        duration: _pizzaMovementDuration),
                  ),
                  MaterialButton(
                      color: Colors.black,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.shop,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Add to cart',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      onPressed: () {
                        shopping.add(pizza);
                      }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
