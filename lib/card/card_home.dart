import 'dart:ui';

import 'package:flutter/material.dart';

import 'card_model.dart';

class CardHome extends StatelessWidget {
  const CardHome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black87,
      body: PerspectiveList(
        children: List.generate(cardList.length, (index) {
          final card = cardList[index];
          final color = Colors.primaries[index % Colors.primaries.length];
          return Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: color,
                width: 4,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    card.name,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  card.details,
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }),
        itemExtent: size.height * .3,
        visualizedItems: 8,
        initialIndex: 2,
        padding: EdgeInsets.all(20),
      ),
    );
  }
}

class PerspectiveList extends StatefulWidget {
  PerspectiveList({
    required this.children,
    required this.itemExtent,
    required this.visualizedItems,
    this.initialIndex = 0,
    this.padding = EdgeInsets.zero,
    this.onChangedItem,
    this.onTapFrontItem,
    this.backItemShadowColor = Colors.black,
  });

  final List<Widget> children;

  final double itemExtent;
  final int visualizedItems;
  final int initialIndex;
  final EdgeInsetsGeometry padding;
  final ValueChanged<int>? onChangedItem;
  final ValueChanged<int>? onTapFrontItem;
  final Color backItemShadowColor;

  @override
  State<PerspectiveList> createState() => _PerspectiveListState();
}

class _PerspectiveListState extends State<PerspectiveList> {
  late PageController _pageController;
  late double _pagePercent;

  late int _currentIndex;

  void _pageListener() {
    _currentIndex = _pageController.page!.floor();
    _pagePercent = (_pageController.page! - _currentIndex).abs();
    setState(() {});
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.initialIndex,
      viewportFraction: 1 / widget.visualizedItems,
    );
    _currentIndex = widget.initialIndex;
    _pagePercent = 0.0;

    _pageController.addListener(_pageListener);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Padding(
          padding: widget.padding,
          child: PerspectiveItem(
              generatedItems: widget.visualizedItems - 1,
              pagePercent: _pagePercent,
              currentIndex: _currentIndex,
              heightItem: widget.itemExtent,
              children: widget.children),
        ),
        PageView.builder(
            itemCount: widget.children.length,
            scrollDirection: Axis.vertical,
            controller: _pageController,
            // onPageChanged: (value) {
            //   if (widget.onChangedItem != null) {
            //     widget.onChangedItem!(value);
            //   }
            // },
            itemBuilder: (_, index) {
              final color = Colors.primaries[index % Colors.primaries.length];
              return Container(
                  // color: color,
                  );
            }),
      ],
    );
  }
}

class PerspectiveItem extends StatelessWidget {
  PerspectiveItem({
    super.key,
    required this.generatedItems,
    required this.pagePercent,
    required this.currentIndex,
    required this.heightItem,
    required this.children,
  });
  final int generatedItems;
  final double pagePercent;
  final int currentIndex;
  final double heightItem;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final height = constraints.maxHeight;

      return Stack(
        fit: StackFit.expand,
        children: List.generate(generatedItems, (index) {
          final invertedIndex = (generatedItems - 2) - index;
          final indexPlus = (index + 1);
          final positionPercent = indexPlus / generatedItems;
          final endPositionPercent = index / generatedItems;

          return currentIndex > invertedIndex
              ? TransformList(
                  child: children[currentIndex - (invertedIndex + 1)],
                  factorChange: pagePercent,
                  heightItem: heightItem,
                  scale: lerpDouble(.5, 1.0, positionPercent)!,
                  endScale: lerpDouble(.5, 1.0, endPositionPercent)!,
                  translateY: (height - heightItem) * positionPercent,
                  endtranslateY: (height - heightItem) * endPositionPercent,
                )
              : SizedBox();
        })
          ..add(
            currentIndex < (children.length - 1)
                ? TransformList(
                    child: children[currentIndex + 1],
                    factorChange: pagePercent,
                    heightItem: heightItem,
                    translateY: height + 20,
                    endtranslateY: height - heightItem,
                  )
                : SizedBox(),
          ),
      );
    });
  }
}

class TransformList extends StatelessWidget {
  const TransformList({
    super.key,
    required this.child,
    required this.factorChange,
    required this.heightItem,
    this.scale = 1.0,
    this.endScale = 1.0,
    this.translateY = 0.0,
    this.endtranslateY = 0.0,
  });

  final Widget child;

  final double scale;

  final double endScale;

  final double translateY;
  final double endtranslateY;
  final double factorChange;
  final double heightItem;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..scale(lerpDouble(scale, endScale, factorChange))
        ..translate(
            0.0, lerpDouble(translateY, endtranslateY, factorChange)!, 0.0),
      alignment: Alignment.topCenter,
      child: SizedBox(height: heightItem, child: child),
    );
  }
}
