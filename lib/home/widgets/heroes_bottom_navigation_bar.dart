import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/home/home.dart';

class HeroesBottomNavigationBar extends StatelessWidget {
  const HeroesBottomNavigationBar({
    required this.items,
    super.key,
  });

  final List<HeroBottomNavigationItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: SizedBox(
        height: kBottomNavigationBarHeight + 16,
        child: Column(
          children: [
            Container(
              height: 2,
              color: AppColors.red,
            ),
            Theme(
              data: theme.copyWith(canvasColor: theme.primaryColor),
              child: BlocBuilder<SectionCubit, int>(
                builder: (context, state) {
                  return BottomNavigationBar(
                    unselectedItemColor: AppColors.lightGrey,
                    selectedItemColor: items[state].color,
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
                            icon: element.image.image(
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

class HeroBottomNavigationItem {
  HeroBottomNavigationItem({
    required this.image,
    required this.label,
    required this.color,
  });

  final String label;
  final AssetGenImage image;
  final Color color;
}
