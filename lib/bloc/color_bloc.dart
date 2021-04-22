import 'package:async/async.dart';
import 'dart:ui';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';


class ColorBloc extends BlocBase {

  ColorBloc();

  var colorController = BehaviorSubject<Color>.seeded(Colors.white); // 9anat

  Stream<Color> get colorStream => colorController.stream; // sortie

  Sink<Color> get colorSink => colorController.sink; // entree

  setColor(Color color) {
    colorSink.add(color);
  }

  @override
  void dispose() {
    colorController.close();
    super.dispose();
  }
}