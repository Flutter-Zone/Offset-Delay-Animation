import 'package:flutter/material.dart';

class OffsetDelay extends StatefulWidget{
  @override
  _OffsetDelayState createState() => _OffsetDelayState();
}

class _OffsetDelayState extends State<OffsetDelay> with SingleTickerProviderStateMixin{

  Animation animation;

  Animation lateAnimation;

  AnimationController animationController;

  @override
  void initState() {

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn
      ),
    )..addStatusListener((status){
      if(status == AnimationStatus.completed){
        animationController.reset();
        animation = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Curves.fastOutSlowIn
          )
        );

        lateAnimation = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval(
              0.2,
              1.0,
              curve: Curves.fastOutSlowIn
            ),
          ),
        )..addStatusListener((status){
          if(status == AnimationStatus.completed){
            Navigator.of(context).pop();
          }
        });

        animationController.forward();
      }
    });

    lateAnimation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.2,
          1.0,
          curve: Curves.fastOutSlowIn
        ),
      ),
    );

    animationController.forward();

    super.initState();
  }

  Widget buildContainer(){
    return  Container(
      margin: EdgeInsets.only(bottom: 2.0),
      height: 20.0,
      width: 120.0,
      color: Colors.blueAccent,
    );
  }

  @override
  Widget build(BuildContext context){
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Offset & Delay Animation"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget child){
                return Transform(
                  transform: Matrix4.translationValues(animation.value * deviceWidth, 0.0, 0.0),
                  child: buildContainer(),
                );
              },
            ),
            AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget child){
                return Transform(
                  transform: Matrix4.translationValues(animation.value * deviceWidth, 0.0, 0.0),
                  child: buildContainer(),
                );
              },
            ),
            AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget child){
                return Transform(
                  transform: Matrix4.translationValues(lateAnimation.value * deviceWidth, 0.0, 0.0),
                  child: buildContainer(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}