import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:football_system/blocs/footballField/FootBallField.dart';
import 'package:football_system/blocs/footballField/FootballFieldBloc.dart';
import 'package:football_system/blocs/footballField/FootballFieldEvent.dart';
import 'package:football_system/blocs/incontro/inserimento/index.dart';
import 'package:football_system/blocs/model/player_model.dart';
import 'package:football_system/custom_icon/soccerplayer_icons.dart';
import 'package:shared/shared.dart';

class PlayerScreen extends StatefulWidget {
  FootballFieldBloc footballFieldBloc;
  int posizione;

  PlayerScreen({this.footballFieldBloc, this.posizione});
  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  FootballFieldBloc footballFieldBloc;
  int posizione;

  _PlayerScreenState({this.footballFieldBloc, this.posizione});
  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.6,
      decoration: BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
    );
  }

  Widget _buildProfileImage() {
    Player player = footballFieldBloc.footballField.players[posizione];
    String name = player.name;
    String number = player.id.toString();
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
            Text(name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(number,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          ],
        )),
      ),
    ));
  }

  Widget _buildPlayerEventStatus(String image, String label, int count) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          onPressed: () => {},
          child: Icon(Icons.add),
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
          onPressed: () => {},
          child: Icon(Icons.remove),
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
                _buildPlayerEventStatus('red_card.png', 'C. rosso', 0),
                _buildPlayerEventStatus('yellow_card.png', 'C. giallo', 1),
                _buildPlayerEventStatus('goal.png', 'Goal', 2),
                _buildPlayerEventStatus('assist.png', 'Assist', 2),
                // _buildPlayerEventStatus('red_card.png', 'Cartellino rosso', 0),
              ],
            ),
          ],
        ));
  }

  Widget _buildNotesField() {
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
            decoration: InputDecoration(
              suffixIcon: FlatButton(
                  onPressed: () => {}, child: Icon(Icons.add_comment)),
            ),
            maxLines: null,
          ),
        ),
      ),
    );
  }

  Widget _buildNotesCarousel(Size screenSize) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: CarouselSlider(
        height: screenSize.height / 7,
        //note salvate nel bloc
        items: [
          'molto veloce nel recupero palla',
          'ottimo dribling',
          'ottima resistenza'
        ].map((note) {
          return Builder(
            builder: (BuildContext context) {
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
                        suffixIcon: FlatButton(
                            onPressed: () => {}, child: Icon(Icons.edit)),
                      ),
                      maxLines: null,
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCarouselButtons(Size screenSize) {
    return Container(
        margin: EdgeInsets.only(top: screenSize.height / 12.5),
        child: FloatingActionButton(
          onPressed: () => {},
          child: Icon(Icons.add),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(),
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
