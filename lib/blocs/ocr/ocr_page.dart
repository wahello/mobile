import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_system/blocs/model/player_model.dart';
import 'package:football_system/blocs/ocr/index.dart';
import 'package:football_system/blocs/stuff/OcrPageArgument.dart';
import 'package:football_system/blocs/stuff/ScannerUtils.dart';
import 'package:football_system/generated/i18n.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:shared/shared.dart';
import 'package:validators/validators.dart';

class OcrPage extends StatefulWidget {
  final Function(Widget) notifyParent;
  final Function(Widget) notifyAction;
  final Key key;

  OcrPage(
      {@required this.notifyAction,
      @required this.key,
      @required this.notifyParent})
      : super(key: key);

  @override
  State<OcrPage> createState() => OcrPageState();
}

class OcrPageState extends State<OcrPage> {
  static const String routeName = '/ocr';

  bool _isDetecting = false;
  bool isHome;
  CameraController _camera;
  CameraLensDirection _direction = CameraLensDirection.back;
  String categoryId;
  String path;
  String teamId;

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

    List<Player> playersName = List();
    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        String name = '';
        String number;
        String anno;
        for (TextElement word in line.elements) {
          if (word.text.contains('/')) {
            anno = word.text;
          } else if (isNumeric(word.text)) {
            number = word.text;
          } else {
            name = name + '' + word.text;
          }
        }
        playersName.add(new Player(name: name, number: number, anno: anno));
      }
    }
    OcrBloc().add(OcrFotoCaptured(playersName));
  }

  Future backFoto() async {
    OcrBloc().add(OcrFotoToCapture());
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
    if (resized != null) {
      path = resized.path;
      _ocrBloc.add(OcrFotoCropped(resized.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.notifyParent(Text(I18n().inserimentoDistinta));
    final OCRPageArgument args = ModalRoute.of(context).settings.arguments;
    return BlocBuilder<OcrBloc, OcrState>(
        bloc: _ocrBloc,
        builder: (
          BuildContext context,
          OcrState currentState,
        ) {
          return Scaffold(
            floatingActionButton: currentState is OcrInitialState
                ? FloatingActionButton(
                    backgroundColor: MainColors.PRIMARY,
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
                : currentState is OcrFotoToCropState ||
                        currentState is OcrFotoCroppedState
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FloatingActionButton(
                              backgroundColor: MainColors.PRIMARY,
                              child: Icon(Icons.camera_alt),
                              onPressed: backFoto,
                              heroTag: "camera"),
                          Padding(padding: EdgeInsets.all(10)),
                          FloatingActionButton(
                              backgroundColor: MainColors.PRIMARY,
                              child: Icon(Icons.crop),
                              //Text("Ritaglia")
                              onPressed: cropImage,
                              heroTag: "crop"),
                          Padding(padding: EdgeInsets.all(10)),
                          FloatingActionButton(
                              backgroundColor: MainColors.PRIMARY,
                              child: Icon(Icons.check),
                              //Text("Conferma")
                              onPressed: readText,
                              heroTag: "crop"),
                        ],
                      )
                    : null,
            appBar: AppBar(
              backgroundColor: MainColors.PRIMARY,
            ),
            body: OcrScreen(
              notifyParent: widget.notifyParent,
              notifyAction: widget.notifyAction,
              ocrBloc: _ocrBloc,
              camera: _camera,
              bloc: args.inserimentoBloc,
              categoryId: args.categoryId,
              isHome: args.isHome,
              teamId: args.teamId,
            ),
          );
        });
  }
}
