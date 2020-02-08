import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_system/blocs/ocr/index.dart';
import 'package:football_system/blocs/stuff/ScannerUtils.dart';
import 'package:image_cropper/image_cropper.dart';

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

  String path;

  var _ocrBloc = OcrBloc();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    super.dispose();
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
      setState(() {});
      try {
        // await doSomethingWith(image)
      } catch (e) {
        // await handleExepction(e)
      } finally {
        _isDetecting = false;
      }
    }));
  }

  Future readText() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(File(path));
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);

    List<String> playersName = List();
    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        playersName.add(line.text);
      }
    }
    OcrBloc().add(OcrFotoCaptured(playersName));
  }

  void cropImage() async {
    File resized = await ImageCropper.cropImage(
        sourcePath: path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: MainColors.PRIMARY,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    setState(() {
      path = resized.path;
      _ocrBloc.add(OcrFotoCropped(path));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OcrBloc, OcrState>(
        bloc: _ocrBloc,
        builder: (
          BuildContext context,
          OcrState currentState,
        ) {
          return Scaffold(
            floatingActionButton: currentState is OcrInitialState
                ? FloatingActionButton(
                    child: Icon(Icons.camera_alt),
                    onPressed: () async {
                      try {
                        _camera.stopImageStream();

                        path = join(
                          (await getTemporaryDirectory()).path,
                          '${DateTime.now()}.png',
                        );

                        await _camera.takePicture(path);

                        _ocrBloc.add(OcrFotoToCrop(path));
                      } catch (e) {
                        // If an error occurs, log the error to the console.
                        print(e);
                      }
                    },
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FloatingActionButton(
                          child: Icon(Icons.camera_alt),
                          onPressed: readText,
                          heroTag: "camera"),
                      Padding(padding: EdgeInsets.all(10)),
                      FloatingActionButton(
                          child: Icon(Icons.crop),
                          onPressed: cropImage,
                          heroTag: "crop")
                    ],
                  ),
            appBar: AppBar(
              backgroundColor: MainColors.PRIMARY,
            ),
            body: OcrScreen(
              ocrBloc: _ocrBloc,
              camera: _camera,
            ),
          );
        });
  }
}
