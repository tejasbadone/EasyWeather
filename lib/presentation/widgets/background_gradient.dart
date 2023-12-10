import 'dart:ui';

import 'package:flutter/material.dart';

class BackgroundGradient extends StatelessWidget {
  const BackgroundGradient({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          top: 300,
          child: CircleContainer(),
        ),
        const Positioned(
          top: 300,
          right: 0,
          child: CircleContainer(),
        ),
        Positioned(
          top: 0,
          left: MediaQuery.sizeOf(context).width * 0.15,
          child: Container(
            height: 350,
            width: 300,
            decoration: const BoxDecoration(
              color: Color(0xffffab40),
            ),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
          ),
        ),
      ],
    );
  }
}

class CircleContainer extends StatelessWidget {
  const CircleContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: 300,
      decoration:
          const BoxDecoration(color: Colors.deepPurple, shape: BoxShape.circle),
    );
  }
}
