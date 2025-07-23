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
    // Ambil tema saat ini
    final theme = CupertinoTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        // Ganti Colors.white menjadi warna dari tema
        color: theme.barBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            // Ganti Colors.black12 agar lebih adaptif
            color: CupertinoColors.systemGrey4,
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
