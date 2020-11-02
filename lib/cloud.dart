import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Cloud extends StatelessWidget {
  final String description;
  Cloud(this.description);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
            0.1,
            0.9
          ], colors: [
            Color(0xff815355).withOpacity(.3),
            Color(0xff523249).withOpacity(.7)
          ])),
      height: 100,
      width: 250,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Text(
          "Climate",
          textAlign: TextAlign.center,
          style: GoogleFonts.lemonada(
            letterSpacing: 2,
            textStyle: TextStyle(
              fontWeight: FontWeight.normal,
              // fontStyle: FontStyle.italic,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        Icon(
          Icons.cloud_outlined,
          color: Colors.white54,
          size: 35,
        ),
        Text("${description.toUpperCase()}",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff2E1F27),
                fontSize: 22))
      ]),
    );
  }
}
