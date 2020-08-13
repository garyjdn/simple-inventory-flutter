import 'package:flutter/material.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';

class Wave extends StatelessWidget {
  final double height;

  Wave({this.height = 50});

  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      duration: 1,
      config: CustomConfig(
        colors: [
          Colors.blue[100],
          Colors.blue[200],
          Colors.blue[200],
          Colors.blue[300],
        ],
        // gradients: [
        //   [Color(0xFF3A2DB3), Color(0xFF3A2DB1)],
        //   [Color(0xFFEC72EE), Color(0xFFFF7D9C)],
        //   [Color(0xFFfc00ff), Color(0xFF00dbde)],
        //   [Color(0xFF396afc), Color(0xFF2948ff)]
        // ],
        durations: [35000, 19440, 10800, 6000],
        heightPercentages: [0.20, 0.23, 0.25, 0.30],
        // blur: MaskFilter.blur(BlurStyle.inner, 5),
        // gradientBegin: Alignment.centerLeft,
        // gradientEnd: Alignment.centerRight,
      ),
      waveAmplitude: 1.0,
      backgroundColor: Colors.blue[100],
      size: Size(double.infinity, height),
    );
  }
}
