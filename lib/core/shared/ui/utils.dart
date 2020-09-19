import 'package:flutter/material.dart';

const double baseHeight = 640;

double screenAwareSize(double value, BuildContext context) {
  return value * (MediaQuery.of(context).size.height / baseHeight);
}
