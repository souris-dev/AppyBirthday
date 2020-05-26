import 'package:flutter/material.dart';
import 'dart:math';

class DiscData {
  static final _rng = Random();

  double size;
  Color color;
  Alignment alignment;

  DiscData() {
    color = Color.fromARGB(
      _rng.nextInt(50),
      _rng.nextInt(255),
      _rng.nextInt(255),
      _rng.nextInt(255),
    );
    size = _rng.nextDouble() * 82 + 10;
    alignment = Alignment(
      _rng.nextDouble() * 2 - 1,
      _rng.nextDouble() * 2 - 1,
    );
  }
}
