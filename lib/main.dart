/* import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const platform = MethodChannel('com.example.nome_app/channel');

  Future<void> callNativeMethod() async {
    try {
      final String result =
          await platform.invokeMethod('metodoNativo', {"param": "esempio"});
      print("Risultato da Kotlin: $result");
    } on PlatformException catch (e) {
      print("Errore: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Flutter con Kotlin")),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              callNativeMethod();
            },
            child: Text("Chiama metodo nativo"),
          ),
        ),
      ),
    );
  }
} */

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PoseLandmarkScreen(),
    );
  }
}

class PoseLandmarkScreen extends StatefulWidget {
  @override
  _PoseLandmarkScreenState createState() => _PoseLandmarkScreenState();
}

class _PoseLandmarkScreenState extends State<PoseLandmarkScreen> {
  static const platform = MethodChannel('pose_landmarker_channel');

  List<List<Map<String, dynamic>>>? poseData;

  @override
  void initState() {
    super.initState();
    _initializeMethodChannel();
  }

  void _initializeMethodChannel() {
    platform.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onPoseDetected':
          setState(() {
            poseData = List<List<Map<String, dynamic>>>.from(call.arguments);
          });
          break;
        case 'onError':
          print("Error from Kotlin: ${call.arguments}");
          break;
        default:
          print("Unknown method: ${call.method}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pose Landmarker'),
      ),
      body: poseData == null
          ? const Center(child: Text('Waiting for pose data...'))
          : CustomPaint(
              painter: PosePainter(poseData!),
              child: Container(),
            ),
    );
  }
}

class PosePainter extends CustomPainter {
  final List<List<Map<String, dynamic>>> poseData;

  PosePainter(this.poseData);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    for (var pose in poseData) {
      for (var landmark in pose) {
        final x = landmark['x'] as double;
        final y = landmark['y'] as double;
        canvas.drawCircle(Offset(x * size.width, y * size.height), 5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
