import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:football_system/blocs/footballField/FootballFieldBloc.dart';
import 'package:shared/shared.dart';

class OptionsScreen extends StatefulWidget {
  int x;
  int y;
  FootballFieldBloc footballFieldBloc;
  OptionsScreen({this.x, this.y, this.footballFieldBloc});

  @override
  _OptionsScreenState createState() =>
      _OptionsScreenState(footballFieldBloc: footballFieldBloc, x: x, y: y);
}

class _OptionsScreenState extends State<OptionsScreen> {
  final noteController = TextEditingController();
  FootballFieldBloc footballFieldBloc;
  CarouselSlider carousel;
  int x;
  int y;

  _OptionsScreenState({this.footballFieldBloc, this.x, this.y}) {
    notes = footballFieldBloc.footballField.players[x][y].notes;
  }
  //#cartellino giallo
  var yellowCard = 0;
  //#cartellino rosso
  var redCard = 0;
  //#goal
  var goal = 0;
  //#assist
  var assist = 0;

  //note giocatore
  List<String> notes;

  void initState() {
    super.initState();
    noteController.addListener(() => {});
  }

  void submitNote(String note) {
    //TODO: handle save note

    setState(() => {
          notes.add(note),
          footballFieldBloc.footballField.players[x][y].notes =
              notes.where((note) => note != "").toList()
        });
  }

  void addNewNote() {
    notes.add('');
    setState(() {
      this.carousel.animateToPage(notes.length,
          duration: Duration(milliseconds: 1500), curve: Curves.elasticInOut);
    });
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.6,
      decoration: BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
        child: Container(
      width: 150.0,
      height: 150.0,
      decoration: BoxDecoration(
          color: Color(0xFFEFF4F7),
          image: DecorationImage(
              image: AssetImage('assets/images/maglia.png'), fit: BoxFit.cover),
          border: Border.all(width: 4.0, color: Colors.black),
          borderRadius: BorderRadius.circular(80.0)),
      child: Container(
        margin: EdgeInsets.only(top: 60.0),
        child: Center(
            child: Column(
          children: <Widget>[
            Text(footballFieldBloc.footballField.players[x][y].name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(footballFieldBloc.footballField.players[x][y].number,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          ],
        )),
      ),
    ));
  }

  Widget _buildPlayerEventStatus(String image, String label, int count) {
    bool disableAddAndRemove = ((label == 'C. giallo' && yellowCard == 2) ||
        ((label == 'C. rosso' || label == 'C. giallo') && redCard == 1));
    bool disableRemove = count == 0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          onPressed: () => {
            setState(() => {
                  ++count,
                  if (label == 'C. giallo' && redCard == 0 && count <= 2)
                    {
                      yellowCard = count,
                      if (yellowCard == 2) {redCard = 1}
                    }
                  else if (label == 'C. rosso' && yellowCard == 0 && count == 1)
                    {redCard = count}
                  else if (label == 'Assist')
                    {assist = count}
                  else if (label == 'Goal')
                    {goal = count}
                })
          },
          child: disableAddAndRemove
              ? null
              : Icon(
                  Icons.add,
                  color: MainColors.PRIMARY,
                ),
        ),
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('assets/images/' + image))),
        ),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(count != null ? count.toString() : 0),
        FlatButton(
          onPressed: () => {
            setState(() => {
                  if (count > 0) {count--},
                  if (label == 'C. rosso')
                    {redCard = count}
                  else if (label == 'C. giallo')
                    {yellowCard = count}
                  else if (label == 'Assist')
                    {assist = count}
                  else if (label == 'Goal')
                    {goal = count}
                })
          },
          child:
              disableAddAndRemove || disableRemove ? null : Icon(Icons.remove),
        ),
      ],
    );
  }

  Widget _buildRedCard(int count) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/red_card.png'))),
        ),
        Text(
          'Cartellino rosso',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(count != null ? count.toString() : 0)
      ],
    );
  }

  Widget _buildPlayerStatus() {
    return Container(
        height: 180.0,
        margin: EdgeInsets.only(top: 8.0),
        decoration: BoxDecoration(color: Color(0xFFEFF4F7)),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildPlayerEventStatus('red_card.png', 'C. rosso', redCard),
                _buildPlayerEventStatus(
                    'yellow_card.png', 'C. giallo', yellowCard),
                _buildPlayerEventStatus('goal.png', 'Goal', goal),
                _buildPlayerEventStatus('assist.png', 'Assist', assist),
                // _buildPlayerEventStatus('red_card.png', 'Cartellino rosso', 0),
              ],
            ),
          ],
        ));
  }

  Widget _buildNotesField(String note) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2)),
      margin: EdgeInsets.only(left: 20, right: 20),
      child: new Scrollbar(
        child: new SingleChildScrollView(
          scrollDirection: Axis.vertical,
          reverse: true,
          child: new TextFormField(
            initialValue: note,
            decoration: InputDecoration(
              suffixIcon:
                  FlatButton(onPressed: () => {}, child: Icon(Icons.edit)),
            ),
            maxLines: null,
            onSaved: (note) => {},
            onFieldSubmitted: (note) => {submitNote(note)},
            controller: note == null ? noteController : null,
            textInputAction: TextInputAction.done,
          ),
        ),
      ),
    );
  }

  Widget _buildNotesCarousel(Size screenSize) {
    this.carousel = CarouselSlider(
      height: screenSize.height / 7,
      //note salvate nel bloc

      items: notes.map((note) {
        return Builder(
          builder: (BuildContext context) {
            return _buildNotesField(note);
          },
        );
      }).toList(),
    );
    return Container(margin: EdgeInsets.only(top: 10), child: this.carousel);
  }

  Widget _buildCarouselButtons(Size screenSize) {
    return Container(
        margin: EdgeInsets.only(top: screenSize.height / 20.5),
        child: FloatingActionButton(
          backgroundColor: MainColors.PRIMARY,
          onPressed: () => {this.addNewNote()},
          child: Icon(Icons.add),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: MainColors.PRIMARY,
        ),
        body: Stack(
          children: <Widget>[
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: screenSize.height / 30.0),
                    _buildProfileImage(),
                    _buildPlayerStatus(),
                    _buildNotesCarousel(screenSize),
                    _buildCarouselButtons(screenSize)
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
