import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_system/blocs/ocr/index.dart';

class OcrScreen extends StatefulWidget {
  const OcrScreen({
    Key key,
    @required OcrBloc ocrBloc,
    @required this.camera,
  })  : _ocrBloc = ocrBloc,
        super(key: key);

  final OcrBloc _ocrBloc;
  final CameraController camera;

  @override
  OcrScreenState createState() {
    return OcrScreenState(_ocrBloc);
  }
}

class OcrScreenState extends State<OcrScreen> {
  final OcrBloc _ocrBloc;
  OcrScreenState(this._ocrBloc);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OcrBloc, OcrState>(
        bloc: widget._ocrBloc,
        builder: (
          BuildContext context,
          OcrState currentState,
        ) {
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              widget.camera == null
                  ? Container(
                      color: Colors.red,
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height - 150,
                      child: CameraPreview(widget.camera),
                    ),
            ],
          );
        });
  }
}
