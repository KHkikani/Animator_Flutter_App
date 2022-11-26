import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "BMI Calculator",
            style: TextStyle(fontSize: 28),
          ),
          elevation: 0,
          backgroundColor: const Color(0xff090e21),
          centerTitle: true,
        ),
        body: const MyApp(),
        backgroundColor: const Color(0xff090e21),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  // ignore: non_constant_identifier_names
  double SliderValue = 120;
  Color maleActiveColor = const Color(0xff1d1e33);
  Color femaleActiveColor = const Color(0xff1d1e33);
  Color genderActiveColor = const Color(0xff3b3c4d);
  double? answer;

  int weight = 60;
  int age = 28;

  Widget iconUi(
      {required IconData iconName,
      required String name,
      required Color color,
      required Color iconColor}) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            iconName,
            size: 120,
            color: iconColor,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 20, color: iconColor),
          ),
        ],
      ),
    );
  }

  // late AnimationController weightAgeUiController;
  late AnimationController femaleIconUiController;
  late AnimationController maleIconUiController;
  late AnimationController weightTextController;
  late AnimationController ageTextController;

  late Animation femaleIconUiScaleAnimation;
  late Animation maleIconUiScaleAnimation;
  late Animation weightTextScaleAnimation;
  late Animation ageTextScaleAnimation;

  @override
  void initState() {
    super.initState();

    femaleIconUiController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    maleIconUiController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    weightTextController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    ageTextController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    femaleIconUiScaleAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 1.20), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 1.20, end: 1), weight: 1),
    ]).animate(femaleIconUiController);

    maleIconUiScaleAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 1.20), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 1.20, end: 1), weight: 1),
    ]).animate(maleIconUiController);

    weightTextScaleAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 1.5), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 1.5, end: 1), weight: 1),
    ]).animate(weightTextController);

    ageTextScaleAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 1.5), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 1.5, end: 1), weight: 1),
    ]).animate(ageTextController);
  }

  @override
  void dispose() {
    maleIconUiController.dispose();
    femaleIconUiController.dispose();
    super.dispose();
  }

  Widget weightAgeUi({
    required int weightAgevalue,
    required String name,
  }) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff1d1e33),
        // color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            name,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          AnimatedBuilder(
            animation:
                (name == "Weight") ? weightTextController : ageTextController,
            builder: (context, child) => Transform.scale(
              scale: (name == "Weight")
                  ? weightTextScaleAnimation.value
                  : ageTextScaleAnimation.value,
              child: Text(
                "$weightAgevalue",
                style: const TextStyle(
                  fontSize: 45,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Ink(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (weightAgevalue > 0) {
                        if (name == "Weight") {
                          weight--;
                          if (weightTextController.isCompleted) {
                            weightTextController.reverse();
                          } else if (weightTextController.isDismissed) {
                            weightTextController.forward();
                          }
                        } else {
                          age--;
                          if (ageTextController.isCompleted) {
                            ageTextController.reverse();
                          } else if (ageTextController.isDismissed) {
                            ageTextController.forward();
                          }
                        }
                      }
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: Color(0xff4c4f5e),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "-",
                      style: TextStyle(
                        fontSize: 25,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
              Ink(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (weightAgevalue > 0) {
                        if (name == "Weight") {
                          weight++;
                          if (weightTextController.isCompleted) {
                            weightTextController.reverse();
                          } else if (weightTextController.isDismissed) {
                            weightTextController.forward();
                          }
                        } else {
                          age++;
                          if (ageTextController.isCompleted) {
                            ageTextController.reverse();
                          } else if (ageTextController.isDismissed) {
                            ageTextController.forward();
                          }
                        }
                      }
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: Color(0xff6e6f7a),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "+",
                      style: TextStyle(
                        fontSize: 25,
                        color: Color(0xfff67fa4),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: TweenAnimationBuilder(
                      curve: Curves.bounceOut,
                      duration: Duration(milliseconds: 2000),
                      tween: Tween<Offset>(
                          begin: Offset(100, 200), end: Offset(0, 0)),
                      builder: (context, Offset value, child) =>
                          Transform.translate(
                            offset: value,
                            child: AnimatedBuilder(
                              animation: femaleIconUiController,
                              builder: (context, child) => Transform.scale(
                                scale: femaleIconUiScaleAnimation.value,
                                child: InkWell(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      print(femaleIconUiController.status);

                                      if (femaleIconUiController.isCompleted) {
                                        femaleIconUiController.reverse();
                                      } else if (femaleIconUiController
                                          .isDismissed) {
                                        femaleIconUiController.forward();
                                      }

                                      // print(femaleIconUiController.status);
                                      // femaleIconUiController.forward();
                                      // femaleIconUiController.repeat();
                                      // if(femaleIconUiController.isCompleted){
                                      // femaleIconUiController.forward();

                                      femaleActiveColor = genderActiveColor;
                                      maleActiveColor = const Color(0xff1d1e33);
                                    });
                                  },
                                  child: iconUi(
                                    color: femaleActiveColor,
                                    iconName: Icons.female,
                                    name: "Female",
                                    iconColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )),
                ),
                const SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: TweenAnimationBuilder(
                      curve: Curves.bounceOut,
                      duration: Duration(milliseconds: 2000),
                      tween: Tween<Offset>(
                          begin: Offset(-100, 200), end: Offset(0, 0)),
                      builder: (context, Offset value, child) =>
                          Transform.translate(
                            offset: value,
                            child: AnimatedBuilder(
                              animation: maleIconUiController,
                              builder: (context, child) => Transform.scale(
                                scale: maleIconUiScaleAnimation.value,
                                child: InkWell(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      // print(maleIconUiController.status);

                                      if (maleIconUiController.isCompleted) {
                                        maleIconUiController.reverse();
                                      } else if (maleIconUiController
                                          .isDismissed) {
                                        maleIconUiController.forward();
                                      }

                                      // maleIconUiController.forward();

                                      maleActiveColor = genderActiveColor;
                                      femaleActiveColor =
                                          const Color(0xff1d1e33);
                                    });
                                  },
                                  child: iconUi(
                                    color: maleActiveColor,
                                    iconName: Icons.male,
                                    name: "Male",
                                    iconColor: const Color(0xffeb1555),
                                  ),
                                ),
                              ),
                            ),
                          )),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: TweenAnimationBuilder(
                    duration: Duration(milliseconds: 15 00),
                    tween:
                        Tween<Offset>(begin: Offset(500, 0), end: Offset(0, 0)),
                    builder: (context, Offset value, child) =>
                        Transform.translate(
                      offset: value,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xff1d1e33),
                          // color: Color(0xff626473),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "HEIGHT",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff626473),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: "${SliderValue.toInt()}",
                                      style: const TextStyle(fontSize: 50)),
                                  const TextSpan(
                                      text: "   ",
                                      style: TextStyle(fontSize: 15)),
                                  const TextSpan(
                                      text: "cm",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xff626473))),
                                ],
                              ),
                            ),
                            Slider(
                              min: 0,
                              max: 250,
                              value: SliderValue,
                              activeColor: const Color(0xfff5c1d1),
                              inactiveColor: const Color(0xff555555),
                              onChanged: (val) {
                                setState(() {
                                  SliderValue = val;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TweenAnimationBuilder(
                    curve: Curves.bounceOut,
                    duration: Duration(milliseconds: 2000),
                    tween: Tween<Offset>(
                        begin: Offset(100, -200), end: Offset(0, 0)),
                    builder: (context, Offset value, child) =>
                        Transform.translate(
                            offset: value,
                            child: weightAgeUi(
                                weightAgevalue: weight, name: "Weight")),
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: TweenAnimationBuilder(
                    curve: Curves.bounceOut,
                    duration: Duration(milliseconds: 2000),
                    tween: Tween<Offset>(
                        begin: Offset(-100, -200), end: Offset(0, 0)),
                    builder: (context, Offset value, child) =>
                        Transform.translate(
                      offset: value,
                      child: weightAgeUi(weightAgevalue: age, name: "Age"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            alignment: Alignment.center,
            height: 50,
            child: Text(
              (answer != null) ? "${answer?.toStringAsFixed(2)}" : " ",
              style: const TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          InkWell(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(50),
              topLeft: Radius.circular(50),
            ),
            onTap: () {
              setState(() {
                answer =
                    ((weight) / ((SliderValue / 100) * (SliderValue / 100)))
                        .toDouble();
              });
            },
            child: Ink(
              decoration: const BoxDecoration(
                color: Color(0xffeb1555),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
              ),
              child: Container(
                height: 70,
                alignment: Alignment.center,
                child: const Text(
                  "Calculate",
                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
