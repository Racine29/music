import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'bottom_nav.dart';
import 'music.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  double pagePercent = 0;
  late PageController _pageController;

  listener() {
    currentIndex = _pageController.page!.floor();
    pagePercent = (_pageController.page! - currentIndex).abs();
    // setState(() {});
  }

  @override
  void initState() {
    _pageController = PageController(
      viewportFraction: .4,
    );
    _pageController.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(listener);
    super.dispose();
  }

  final generatedItem = 8;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final itemHeight = size.height * .4;
    return Scaffold(
      backgroundColor: Color(0xff1F1F1F),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Stack(
          //   children: List.generate(musics.length, (index) {
          //     return LayoutBuilder(builder: (context, constraints) {
          //       final height = constraints.maxHeight;
          //       final y = (height - itemHeight) * position;
          //       final endY = (height - itemHeight) * endPosition;

          //       return index > invertedIndex
          //           ? Transform.scale(
          //               scale: (lerpDouble(
          //                 lerpDouble(.5, 1.0, position),
          //                 lerpDouble(.5, 1.0, endPosition),
          //                 pagePercent,
          //               )),
          //               child: Transform(
          //                 transform: Matrix4.identity()
          //                   ..translate(
          //                       0.0, lerpDouble(y, endY, pagePercent)!, 0.0),
          //                 alignment: Alignment.center,
          //                 child: Container(
          //                   color: color,
          //                   margin: EdgeInsets.symmetric(horizontal: 20),
          //                   height: itemHeight,
          //                   // width: 100,
          //                 ),
          //               ),
          //             )
          //           : SizedBox();
          //     });
          //   }),
          // ),
          LayoutBuilder(builder: (context, constraints) {
            return PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: musics.length,
                controller: _pageController,
                // padEnds: false,
                itemBuilder: (_, index) {
                  Color color = Colors.primaries[index % musics.length];
                  final invertedIndex = (generatedItem - 2) - index;
                  final indexPlus = index + 1;
                  final position = indexPlus / generatedItem;
                  final endPosition = index / generatedItem;
                  final height = constraints.maxHeight;
                  final y = (height - itemHeight) * position;
                  final endY = (height - itemHeight) * endPosition;
                  return Transform.scale(
                    scale: (lerpDouble(
                      lerpDouble(.5, 1.0, position),
                      lerpDouble(.5, 1.0, endPosition),
                      pagePercent,
                    )),
                    child: Transform(
                      transform: Matrix4.identity()
                        ..translate(
                            0.0, lerpDouble(y, endY, pagePercent)!, 0.0),
                      alignment: Alignment.center,
                      child: Container(
                        color: color,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: itemHeight,
                        // width: 100,
                      ),
                    ),
                  );
                });
          }),
          // Bottom Navigation ----------------------------------------------------------------
          BottomNav(),
        ],
      ),
    );
  }
}

  //  Center(
  //                               child: Padding(
  //                                 padding: EdgeInsets.symmetric(
  //                                     horizontal: size.width * .15),
  //                                 child: Stack(
  //                                   children: [
  //                                     Image.asset(
  //                                       music.cd,
  //                                       fit: BoxFit.cover,
  //                                       height: size.height * .6,
  //                                       width: size.width * .8,
  //                                     ),
  //                                     Image.asset(
  //                                       music.cover,
  //                                       fit: BoxFit.cover,
  //                                       height: size.height * .6,
  //                                       width: size.width * .8,
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
                           
                           
                           