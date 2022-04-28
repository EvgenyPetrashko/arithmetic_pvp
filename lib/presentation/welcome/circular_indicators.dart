import 'package:flutter/material.dart';

class CircularIndicators extends StatelessWidget {
  const CircularIndicators(
      {Key? key, required this.controller, required this.amount})
      : super(key: key);
  final CircularIndicatorController controller;
  final int amount;

  AnimatedBuilder circularIndicators(CircularIndicatorController _controller) {
    List<Widget> _constructList(page) {
      List<Widget> _circularIndicatorList = [];
      for (var i in [for (var j = 0; j < amount; j++) j]) {
        _circularIndicatorList.add(Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: (i == page) ? Colors.blue : Colors.grey,
            shape: BoxShape.circle,
          ),
        ));
        if (i != amount - 1) {
          _circularIndicatorList.add(const SizedBox(width: 3));
        }
      }
      return _circularIndicatorList;
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _constructList(_controller.currentPage),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return circularIndicators(controller);
  }
}

class CircularIndicatorController extends ChangeNotifier {
  int currentPage;

  CircularIndicatorController(this.currentPage);

  void pageChange(double pageValue) {
    if ((pageValue < 0.70) ||
        (pageValue >= 0.70 && pageValue < 1.70) ||
        (pageValue >= 1.70 && pageValue < 2.70) ||
        (pageValue >= 2.70) && currentPage != pageValue.round()) {
      currentPage = pageValue.round();
      notifyListeners();
    }
  }
}
