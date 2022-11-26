import 'dart:math';
import 'package:flutter/material.dart';
import '../global/global.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController animationController;

  late Animation rotationAnimation;

  int initIndex = 0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

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
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Galaxy Planets"),
            centerTitle: true,
            elevation: 0,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (initIndex == 0)
                        ? Container()
                        : ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                initIndex--;
                              });
                            },
                            icon: const Icon(Icons.arrow_back_ios_new_rounded),
                            label: const Text("Back"),
                          ),
                    (initIndex == Global.planetDetails.length - 1)
                        ? Container()
                        : ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                initIndex++;
                              });
                            },
                            icon: const Icon(Icons.arrow_forward_ios_rounded),
                            label: const Text("Next"),
                          )
                  ],
                ),
              ),
              IndexedStack(
                index: initIndex,
                children: Global.planetDetails
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed('detail_page', arguments: e);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 35),
                          height: 400,
                          alignment: Alignment.centerRight,
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
                          margin: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              AnimatedBuilder(
                                animation: animationController,
                                builder: (context, widget) {
                                  return Transform.rotate(
                                    angle: rotationAnimation.value,
                                    child: widget,
                                  );
                                },
                                child: Hero(
                                  tag: e['name'],
                                  child: Container(
                                    height: 150,
                                    width: 150,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      // color: Colors.white,
                                      image: DecorationImage(
                                        image: AssetImage("${e['image']}"),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${e['name']}".toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "${e['galaxy']}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.location_on_sharp,
                                        size: 18,
                                        color: Colors.white70,
                                      ),
                                      Text(
                                        "${e['surface_area']}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      const Icon(Icons.compare_arrows,
                                          size: 20, color: Colors.white70),
                                      Text(
                                        "${e['gravity']}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white70,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          )),
    );
  }
}
