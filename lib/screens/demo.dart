// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // appBar: AppBar(title: Text("Flutter")),
          body: Column(
        children: [
          Expanded(
              flex: 1,
              child: ClipPath(
                clipper: FirstContainerClipper(),
                child: Container(
                  color: Color(0xff2D9EE0),
                ),
              )),
          Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Image(image: AssetImage("images/text.png")),
                  Image(image: AssetImage("images/image.png")),
                ],
              )),
          Expanded(
              flex: 1,
              child: ClipPath(
                clipper: SecondContainerClipper(),
                child: Container(
                  color: Color(0xff2D9EE0),
                  // color: Colors.blue,
                ),
              )),
        ],
      )),
    );
  }
}

class FirstContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(30, size.height, size.width / 6, size.height - 30);
    path.quadraticBezierTo(size.width / 3 + 20, size.height - 120,
        size.width / 1.5, size.height - 50);
    path.quadraticBezierTo(
        size.width / 1.2, size.height - 20, size.width, size.height / 2);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class SecondContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(0, 30);
    path.quadraticBezierTo(size.width / 6, 0, size.width / 5 + 25, 30);
    path.quadraticBezierTo(size.width / 1.5, size.height / 2 + 30, size.width,
        size.height / 2 - 30);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    // path.lineTo(0, size.height);
    // path.lineTo(size.width, size.height);

    // path.close();
    // path.quadraticBezierTo(
    //     size.width / 2, size.height / 2, size.width / 3, 100);
    // path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
