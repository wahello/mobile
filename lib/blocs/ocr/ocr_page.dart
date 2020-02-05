import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:football_system/blocs/ocr/index.dart';
import 'package:football_system/blocs/stuff/ScannerUtils.dart';

import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:shared/shared.dart';

class OcrPage extends StatefulWidget {
  @override
  State<OcrPage> createState() => OcrPageState();
}

class OcrPageState extends State<OcrPage> {
  static const String routeName = '/ocr';

  CameraLensDirection _direction = CameraLensDirection.back;

  CameraController _camera;

  bool _isDetecting = false;

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

    _camera.startImageStream(((CameraImage image) {
      if (_isDetecting) return;
      _isDetecting = true;
      try {
        // await doSomethingWith(image)
      } catch (e) {
        // await handleExepction(e)
      } finally {
        _isDetecting = false;
      }}));
  }

  @override
  Widget build(BuildContext context) {
    var _ocrBloc = OcrBloc();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            _camera.stopImageStream();

            final path = join(
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );

            await _camera.takePicture(path);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: path),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
      appBar: AppBar(
        backgroundColor: MainColors.PRIMARY,
      ),
      body: OcrScreen(
        ocrBloc: _ocrBloc,
        camera: _camera,
      ),
    );
  }
}
