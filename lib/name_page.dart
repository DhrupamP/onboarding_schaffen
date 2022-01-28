import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NamePage extends StatelessWidget {
  const NamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff037CD5),
      body: SafeArea(
        child: Center(
          child: RichText(
            text: TextSpan(
                style: GoogleFonts.actor(
                  fontSize: 50,
                  color: Colors.white,
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
        ),
      ),
    );
  }
}
