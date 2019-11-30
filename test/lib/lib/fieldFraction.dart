import 'package:flutter/material.dart';
import 'package:football_field/presentation/soccerplayer_icons.dart';

//UNA CASELLA DELLA SCACCHIERA
class FieldFraction extends StatelessWidget {
  final int occupied;
  //COORDINATE DELLA CASELLA
  List<int> actual_position;

  FieldFraction({this.occupied, this.actual_position}) {
    print('building fieldfraction...');
  }
  @override
  Widget build(BuildContext context) {
    return DragTarget(
        builder: (context, accepted, rejected) {
          return (occupied != null && occupied > 0)
              ? Draggable(
                  child: Container(
                    child: Icon(
                      Soccerplayer.soccer_player,
                      size: 22,
                    ),
                  ),
                  feedback: Icon(
                    Soccerplayer.soccer_player,
                    size: 22,
                  ),
                  childWhenDragging: Container(
                    child: Icon(
                      Soccerplayer.soccer_player,
                      size: 22,
                      color: Colors.transparent,
                    ),
                  ),
                  onDragCompleted: () {},
                  data: [actual_position],
                )
              /*
                SO CHE PU0' SEMBRARE STRANO MA A QUANTO PARE SE AVESSI FATTO RITORNARE
                UN CONTAINER SENZA CHILD (O CHILD NULL) LE ICONE DELL'OGGETTO DRAGGABLE
                NON AVREBBERO OCCUPATO LE POSIZIONI CORRETTE. PER CAPIRE DI COSA PARLO
                PROVATE A COMMENTARE IL BODY DEL SEGUENTE CONTAINER
                 */
              : Container(
                  color: Colors.transparent,
                  child: Icon(
                    Icons.offline_bolt,
                    color: Colors.transparent,
                  ),
                );
        },
        onWillAccept: (willAccept) {
          return true;
        },
        onAccept: (List data) {});
  }
}
