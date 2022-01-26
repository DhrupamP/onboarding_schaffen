import 'dart:async';
import 'package:flutter/material.dart';

bool condition = false;
Duration transitionDuration = Duration(seconds: 1);

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void startTimer() {
    Timer(Duration(milliseconds: 1500), () {
      setState(() {
        condition = true;
      });
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff037CD5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                duration: transitionDuration,
                alignment: condition ? Alignment.topCenter : Alignment.center,
                child: Image(
                  image: NetworkImage(
                      'https://www.freepnglogos.com/uploads/flipkart-logo-png/flipkart-inventory-management-system-zap-inventory-1.png'),
                ),
                width: condition ? 40 : 180,
                height: condition ? 40 : 180,
              ),
            ),
            SizedBox(
              width: 7,
            ),
            AnimatedCrossFade(
              firstCurve: Curves.fastOutSlowIn,
              crossFadeState: !condition
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: transitionDuration,
              firstChild: Container(),
              secondChild: Text(
                'LIPKART',
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 30,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 4.0,
                ),
              ),
              alignment: Alignment.centerLeft,
              sizeCurve: Curves.easeInOut,
            ),
          ],
        ),
      ),
    );
  }
}
