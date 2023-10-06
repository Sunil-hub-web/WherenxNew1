import 'package:flutter/material.dart';
class GradiantBG extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
        Container(
          decoration: const BoxDecoration(
            gradient : LinearGradient(
                begin: Alignment(6.123234262925839e-17,1),
                end: Alignment(-1,6.123234262925839e-17),
                colors: [Color.fromRGBO(31, 203, 220, 1),Color.fromRGBO(0, 184, 202, 1)]
            ),
          ),

    );
  }
}