import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class InfoCard extends StatelessWidget {
  final Widget child;
  final double width, height;

  const InfoCard({
    super.key,
    required this.child,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 1,
          )
        ],
      ),
      width: width,
      height: height,
      child: child,
    );
  }
}
