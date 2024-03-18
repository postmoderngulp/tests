import 'package:flutter/material.dart';

class Holder extends StatelessWidget {
  const Holder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(child: Scaffold
      (
        backgroundColor: Colors.white,
        body: Column(
        children: [
        ],
      ),)),
    );
  }
}