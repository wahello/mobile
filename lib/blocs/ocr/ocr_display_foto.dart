import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:football_system/blocs/ocr/ocr_bloc.dart';
import 'package:football_system/blocs/ocr/ocr_event.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:shared/shared.dart';

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  DisplayPictureScreenState createState() => DisplayPictureScreenState();
}

class DisplayPictureScreenState extends State<DisplayPictureScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => new AlertDialog(
          title: new Text("Label titolo"),
          content: new Text("Controlla di selezionare solo i giocatori, non date, non numeri"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    });
  }

  Future readText() async {
    FirebaseVisionImage ourImage =
        FirebaseVisionImage.fromFile(File(widget.imagePath));
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

  Future<File> cropImage() async {
    return await ImageCropper.cropImage(
        sourcePath: widget.imagePath,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        children: <Widget>[
          FloatingActionButton(
              child: Icon(Icons.camera_alt), onPressed: readText),
          FloatingActionButton(child: Icon(Icons.crop), onPressed: cropImage)
        ],
      ),
      appBar: AppBar(
        backgroundColor: MainColors.PRIMARY,
      ),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(widget.imagePath)),
    );
  }
}
