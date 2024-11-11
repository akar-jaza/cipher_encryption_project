import 'package:flutter/material.dart';

Column footer() {
  return const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image(
        image: AssetImage('assets/wave.png'),
      ),
      SizedBox(
        height: 20,
      ),
      Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Text(
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
          ),
          'Designed By: Akar Jaza\nSulaymaniyah Polytechnic University',
        ),
      ),
    ],
  );
}
