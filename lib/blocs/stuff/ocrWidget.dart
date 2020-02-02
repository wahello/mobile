import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:football_system/blocs/stuff/ScannerUtils.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class OcrWidget extends StatefulWidget {
  OcrWidget();

  @override
  _OcrWidgetState createState() {
    return _OcrWidgetState();
  }
}

class _OcrWidgetState extends State<OcrWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  CameraLensDirection _direction = CameraLensDirection.back;
  CameraController _camera;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    final CameraDescription description =
        await ScannerUtils.getCamera(_direction);

    _camera = CameraController(
      description,
      ResolutionPreset.high,
    );

    await _camera.initialize();

    _camera.startImageStream(((CameraImage image) {}));
  }
}


