import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NamePage extends StatefulWidget {
  const NamePage({Key? key}) : super(key: key);

  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff037CD5),
      body: Container(
        child: Center(
          child: TweenAnimationBuilder<Color?>(
            duration: const Duration(seconds: 2),
            //Smooth Text Popup Effect
            tween: ColorTween(begin: Color(0xff037CD5), end: Colors.white),
            builder: (_, Color? col, __) {
              return Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: GoogleFonts.actor(
                        fontSize: 50,
                        color: col,
                      ),
                      children: [
                        TextSpan(
                            text: 'D',
                            style: TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                            )),
                        TextSpan(text: 'hrupam '),
                        TextSpan(
                            text: 'P',
                            style: TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                            )),
                        TextSpan(text: 'atel\n'),
                        TextSpan(
                            text: 'U',
                            style: TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                            )),
                        TextSpan(text: 'dit '),
                        TextSpan(
                            text: 'J',
                            style: TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                            )),
                        TextSpan(text: 'arwal'),
                      ]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
