import 'dart:math';

import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation rotationAnimation;

  TextStyle txtStyle = const TextStyle(
    color: Colors.white70,
    fontWeight: FontWeight.w600,
    letterSpacing: 1,
  );
  TextStyle headStyle = const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 1,
  );

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    rotationAnimation =
        Tween<double>(begin: 0, end: pi * 2).animate(animationController);

    animationController.repeat();
  }

  @override
  void dispose() {

    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dynamic res = ModalRoute.of(context)!.settings.arguments;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.blueGrey,
        child: Column(
          children: [
            const SizedBox(height: 120),
            Stack(
              alignment: const Alignment(0,-1.35),
              children: [
                Container(
                  width: width,
                  height: 240,
                  margin: const EdgeInsets.only(
                      top: 65, left: 14, right: 14, bottom: 14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 0),
                        ),
                      ]),
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      Text(
                        "${res['name']}".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "${res['galaxy']}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          const Spacer(flex: 1),
                          const Icon(
                            Icons.location_on_sharp,
                            size: 18,
                            color: Colors.white70,
                          ),
                          Text(
                            "${res['surface_area']}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                          const Spacer(flex: 2),
                          const Icon(Icons.compare_arrows,
                              size: 20, color: Colors.white70),
                          Text(
                            "${res['gravity']}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                          const Spacer(flex: 1),
                        ],
                      )
                    ],
                  ),
                ),
                AnimatedBuilder(
                  animation: animationController,
                  builder: (context, widget) {
                    return Transform.rotate(
                      angle: rotationAnimation.value,
                      child: widget,
                    );
                  },
                  child: Hero(
                    tag: res['name'],
                    child: Container(
                      height: 150,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("${res['image']}"),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),

            const Text(
              "OVERVIEW",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(14),
              width: width,
              child: Text(
                "${res['overview']}",
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
