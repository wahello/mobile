import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class SplashPage extends StatelessWidget {
  Key key;

  SplashPage({this.key});
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: this.key,
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlipLoader(
                  loaderBackground: Colors.red,
                  iconColor: Colors.white,
                  icon: Icons.score,
                  animationType: "full_flip"),
            ],
          ),
        ));
  }
}

class FlipLoader extends StatefulWidget {
  FlipLoader(
      {this.loaderBackground = MainColors.PRIMARY,
      this.iconColor = Colors.white,
      this.icon = Icons.sync,
      this.animationType = "full_flip",
      this.shape = "square",
      this.rotateIcon = true});

  final String animationType;
  final IconData icon;
  final Color iconColor;
  final Color loaderBackground;
  final bool rotateIcon;
  final String shape;

  @override
  _FlipLoaderState createState() => _FlipLoaderState(
      this.loaderBackground,
      this.iconColor,
      this.icon,
      this.animationType,
      this.shape,
      this.rotateIcon);
}

class _FlipLoaderState extends State<FlipLoader>
    with SingleTickerProviderStateMixin {
  _FlipLoaderState(this.loaderColor, this.iconColor, this.icon,
      this.animationType, this.shape, this.rotateIcon);

  String animationType;
  AnimationController controller;
  IconData icon;
  Color iconColor;
  Color loaderColor;
  Widget loaderIconChild;
  bool rotateIcon;
  Animation<double> rotationHorizontal;
  Animation<double> rotationVertical;
  String shape;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = createAnimationController(animationType);

    controller.addStatusListener((status) {
      // Play animation backwards and forwards for full flip
      if (animationType == "half_flip") {
        if (status == AnimationStatus.completed) {
          setState(() {
            controller.repeat();
          });
        }
      }
      // play animation on repeat for half flip
      else if (animationType == "full_flip") {
        if (status == AnimationStatus.dismissed) {
          setState(() {
            controller.forward();
          });
        }
        if (status == AnimationStatus.completed) {
          setState(() {
            controller.repeat();
          });
        }
      }
      // custom animation state
      else {
        print("TODO not sure yet");
      }
    });

    controller.forward();
  }

  AnimationController createAnimationController([String type = 'full_flip']) {
    AnimationController animCtrl;

    switch (type) {
      case "half_flip":
        animCtrl = AnimationController(
            duration: const Duration(milliseconds: 4000), vsync: this);

        // Horizontal animation
        this.rotationHorizontal = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: animCtrl,
                curve: Interval(0.0, 0.50, curve: Curves.linear)));

        // Vertical animation
        this.rotationVertical = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: animCtrl,
                curve: Interval(0.50, 1.0, curve: Curves.linear)));
        break;
      case "full_flip":
      default:
        animCtrl = AnimationController(
            duration: const Duration(milliseconds: 2000), vsync: this);

        this.rotationHorizontal = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: animCtrl,
                curve: Interval(0.0, 0.50, curve: Curves.linear)));
        this.rotationVertical = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: animCtrl,
                curve: Interval(0.50, 1.0, curve: Curves.linear)));
        break;
    }

    return animCtrl;
  }

  Widget buildHalfFlipper(BuildContext context) {
    return new AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Container(
          child: new Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.006)
              ..rotateX(sin(2 * pi * rotationVertical.value))
              ..rotateY(sin(2 * pi * rotationHorizontal.value)),
            alignment: Alignment.center,
            child: Container(
                decoration: BoxDecoration(
                  shape:
                      shape == "circle" ? BoxShape.circle : BoxShape.rectangle,
                  borderRadius: shape == "circle"
                      ? null
                      : new BorderRadius.all(const Radius.circular(8.0)),
                  color: loaderColor,
                ),
                width: 40.0,
                height: 40.0,
                child: rotateIcon == true
                    ? new RotationTransition(
                        turns: rotationHorizontal.value == 1.0
                            ? rotationVertical
                            : rotationHorizontal,
                        child: new Center(
                          child: Icon(
                            icon,
                            color: iconColor,
                            size: 20.0,
                          ),
                        ),
                      )
                    : Center(
                        child: Icon(
                          icon,
                          color: iconColor,
                          size: 20.0,
                        ),
                      )),
          ),
        );
      },
    );
  }

  Widget buildFullFlipper(BuildContext context) {
    return new AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Container(
          child: new Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.006)
              ..rotateX((2 * pi * rotationVertical.value))
              ..rotateY((2 * pi * rotationHorizontal.value)),
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                shape: shape == "circle" ? BoxShape.circle : BoxShape.rectangle,
                borderRadius: shape == "circle"
                    ? null
                    : new BorderRadius.all(const Radius.circular(8.0)),
                color: loaderColor,
              ),
              width: 40.0,
              height: 40.0,
              child: new Center(
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 20.0,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (animationType == "half_flip") {
      return buildHalfFlipper(context);
    } else {
      return buildFullFlipper(context);
    }
  }
}
