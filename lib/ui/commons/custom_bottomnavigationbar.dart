import 'package:flutter/material.dart';
import 'package:marvel/styles/colors.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  CustomBottomNavigationBar({
    Key? key,
    required this.children,
    required this.onChange,
    this.currentIndex = 0,
  }) : super(key: key);

  final List<CustomBottomNavigationItem> children;
  final int currentIndex;

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();

  final Function(int) onChange;
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentIndex = 0;

  @override
  void initState() {
    _currentIndex = widget.currentIndex;
    super.initState();
  }

  void _changeIndex(int index) {
    widget.onChange(index);
    setState(() {
      _currentIndex = index;
    });
  }

  Color _getSelectedItemColor() {
    return widget.children[_currentIndex].color;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: kBottomNavigationBarHeight + 16,
        child: Column(
          children: [
            Container(
              height: 2,
              color: Theme.of(context).accentColor,
            ),
            new Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Theme.of(context).primaryColor,
              ),
              child: BottomNavigationBar(
                unselectedItemColor: lightGrey,
                selectedItemColor: _getSelectedItemColor(),
                selectedLabelStyle: TextStyle(fontFamily: "Oswald"),
                iconSize: 32,
                selectedFontSize: 12,
                unselectedFontSize: 12,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                currentIndex: _currentIndex,
                onTap: _changeIndex,
                items: widget.children
                    .map(
                      (element) => BottomNavigationBarItem(
                        label: element.label,
                        icon: Image.asset(
                          element.image,
                          fit: BoxFit.contain,
                          height: 40,
                          color: element.color,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomBottomNavigationItem {
  final String label;
  final String image;
  final Color color;

  CustomBottomNavigationItem(
      {required this.image, required this.label, required this.color});
}
