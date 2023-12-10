import 'package:flutter/material.dart';

double kheight(context) {
  return MediaQuery.sizeOf(context).height;
}

double kwidth(context) {
  return MediaQuery.sizeOf(context).width;
}

const kTextStyle =
    TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 22);
