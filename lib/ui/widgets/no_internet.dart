import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Transform.scale(
          scale: 1.5,
          child: Image.asset('assets/images/no_internet.gif'),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Iltimos internetingizni yoqing va dasturni yopib-oching !",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
              fontSize: 23,
            ),
          ),
        ),
      ],
    );
  }
}
