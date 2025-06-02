import 'package:flutter/material.dart';

class KapiwaraHeader extends StatelessWidget {
  const KapiwaraHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Image.asset(
        'assets/images/language_choose_screen/kapiwara_icon.png',
        width: 200,
        height: 250,
        fit: BoxFit.contain,
      ),
    );
  }
} 