import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_system/blocs/incontro/inserimento/index.dart';
import 'package:football_system/blocs/ocr/index.dart';
import 'package:football_system/blocs/stuff/index.dart';

class OcrScreen extends StatefulWidget {
  const OcrScreen({
    Key key,
    @required OcrBloc ocrBloc,
    @required this.camera,
    @required this.notifyParent,
    @required this.notifyAction,
    @required this.bloc,
    @required this.categoryId,
    @required this.teamId,
    @required this.isHome,
  })  : _ocrBloc = ocrBloc,
        super(key: key);

  final OcrBloc _ocrBloc;
  final CameraController camera;
  final InserimentoBloc bloc;
  final String categoryId;
  final String teamId;
  final bool isHome;
  final Function(Widget) notifyParent;
  final Function(Widget) notifyAction;

  @override
  OcrScreenState createState() {
    return OcrScreenState();
  }
}

class OcrScreenState extends State<OcrScreen> {
  OcrScreenState();

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
          if (currentState is OcrInitialState) {
            return Container(
                child: widget.camera == null
                    ? LoadingIndicator()
                    : Container(
                        height: MediaQuery.of(context).size.height,
                        child: CameraPreview(widget.camera),
                      ));
          }
          if (currentState is OcrCapturedFoto) {
            return OcrListPlayers(
              playersToShow: currentState.playersName,
              bloc: widget.bloc,
              categoryId: widget.categoryId,
              isHome: widget.isHome,
              teamId: widget.teamId,
            );
          }
          if (currentState is OcrFotoToCropState) {
            return DisplayPictureScreen(imagePath: currentState.imagePath);
          }
          if (currentState is OcrFotoCroppedState) {
            return DisplayPictureScreen(imagePath: currentState.imagePath);
          }
          return Container();
        });
  }
}
