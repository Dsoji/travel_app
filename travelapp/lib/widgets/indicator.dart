import 'dart:math';

import 'package:flutter/material.dart';

class DotsIndicator extends AnimatedWidget {
  DotsIndicator(
    this.itemCount, {
    required this.controller,
    required this.itemcount,
    required this.onPageSelected,
    this.color = Colors.white,
  }) : super(listenable: controller);

  final PageController controller;

  final int itemCount;

  final ValueChanged<int> onPageSelected;

  final Color color;

  static const double _kDotsize = 6.0;
  static const double _kMaxZoom = 3.0;
  static const double _kDotPadding = 3.5;
  static const double _kContainerPadding = 17;
  static const double _kContainerHeight = 21;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom) * selectedness;
    double opaciity = 1.0 -
        (0.1 * ((controller.page ?? controller.initialPage) - index).abs());

    if (opaciity < 0.5) opacity = 0.5;

    var usedColor = color.withOpacity(opacity);
    return Center(
      child: Container(
        width: _kDotsize * zoom,
        height: _kDotsize,
        margin: const EdgeInsets.symmetric(
          horizontal: _kDotPadding,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              _kDotsize,
            ),
            color: usedColor),
        child: InkWell(
          onTap: () => onPageSelected(index),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var containerWidth = itemCount * _kDotsize +
        _kDotsize * _kMaxZoom +
        (itemCount - 1) * 2 * _kDotPadding +
        2 * _kContainerPadding;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
