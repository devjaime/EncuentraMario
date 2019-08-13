import 'package:flutter/material.dart';

import 'scratch_box.dart';

const tortuIcon = 'assets/tortu.png';
const koopaIcon = 'assets/koopa.png';
const marioIcon = 'assets/mario.png';

class AdvancedScreen extends StatefulWidget {
  @override
  _AdvancedScreenState createState() => _AdvancedScreenState();
}

class _AdvancedScreenState extends State<AdvancedScreen>
    with SingleTickerProviderStateMixin {
  double validScratches = 0;
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1200))
          ..addStatusListener(
            (listener) {
              if (listener == AnimationStatus.completed) {
                _animationController.reverse();
              }
            },
          );
    _animation = Tween(begin: 1.0, end: 1.25).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticIn,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Encuentra a Mario',
                  style: TextStyle(
                    fontFamily: 'SuperMario256',
                    color: Colors.redAccent,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Encuentra tu mario!',
                  style: TextStyle(
                    fontFamily: 'SuperMario256',
                    color: Colors.redAccent,
                    fontSize: 20,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 1,
                  width: 300,
                  color: Colors.black12,
                )
              ],
            ),
            buildRow(tortuIcon, marioIcon, tortuIcon),
            buildRow(
              koopaIcon,
              marioIcon,
              tortuIcon,
            ),
            buildRow(koopaIcon, marioIcon, koopaIcon),
          ],
        ),
      ),
    );
  }

  Widget buildRow(String left, String center, String right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScratchBox(image: left),
        ScratchBox(
          image: center,
          animation: _animation,
          onScratch: () {
            setState(() {
              validScratches++;
              if (validScratches == 3) {
                _animationController.forward();
              }
            });
          },
        ),
        ScratchBox(image: right),
      ],
    );
  }
}
