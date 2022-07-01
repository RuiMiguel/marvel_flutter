import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/home/cubit/section_cubit.dart';
import 'package:marvel/styles/colors.dart';

class HeroesBottomNavigationBar extends StatelessWidget {
  const HeroesBottomNavigationBar({super.key, required this.items});

  final List<CustomBottomNavigationItem> items;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: kBottomNavigationBarHeight + 16,
        child: Column(
          children: [
            Container(
              height: 2,
              color: red,
            ),
            Theme(
              data: Theme.of(context)
                  .copyWith(canvasColor: Theme.of(context).primaryColor),
              child: BlocBuilder<SectionCubit, int>(
                builder: (context, state) {
                  return BottomNavigationBar(
                    unselectedItemColor: lightGrey,
                    selectedItemColor: items[state].color,
                    selectedLabelStyle: const TextStyle(fontFamily: 'Oswald'),
                    iconSize: 32,
                    selectedFontSize: 12,
                    type: BottomNavigationBarType.fixed,
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    currentIndex: state,
                    onTap: (index) =>
                        context.read<SectionCubit>().selectItem(index),
                    items: items
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomBottomNavigationItem {
  CustomBottomNavigationItem({
    required this.image,
    required this.label,
    required this.color,
  });

  final String label;
  final String image;
  final Color color;
}
