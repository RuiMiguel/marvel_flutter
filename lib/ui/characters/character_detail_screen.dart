import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marvel/core/model/character.dart';
import 'package:marvel/styles/colors.dart';
import 'package:marvel/styles/themes.dart';
import 'package:marvel/ui/commons/empty_content_view.dart';
import 'package:marvel/ui/commons/webview_screen.dart';
import 'package:marvel/ui/utils.dart';

class CharacterDetailScreen extends StatelessWidget {
  static const String routeName = "character-details";

  final Character character;

  const CharacterDetailScreen({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    setStatusBarTheme(
        color: Section.characters.color, brightness: Brightness.light);

    _printDescriptionView() {
      var view;
      if (character.description.isEmpty) {
        view =
            EmptyContentView(title: AppLocalizations.of(context)!.description);
      } else {
        view = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.description,
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(height: 10),
            Text(
              character.description,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        );
      }
      return view;
    }

    _printLinksView() {
      var view;
      if (character.urls.isEmpty) {
        view = EmptyContentView(title: AppLocalizations.of(context)!.links);
      } else {
        view = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.links,
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(height: 10),
          ],
        );

        character.urls.forEach((element) {
          view.children.add(
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  WebViewScreen.routeName,
                  arguments: element.url,
                );
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.link,
                    color: red,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "${element.type}",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 24,
                          color: red,
                        ),
                  ),
                ],
              ),
            ),
          );
        });
      }
      return view;
    }

    return WillPopScope(
      onWillPop: () {
        setStatusBarTheme(
          color: Theme.of(context).primaryColor,
        );
        return Future.value(true);
      },
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 400,
                floating: false,
                pinned: true,
                backgroundColor: Section.characters.color,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  stretchModes: const <StretchMode>[
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                    StretchMode.fadeTitle,
                  ],
                  collapseMode: CollapseMode.parallax,
                  title: Text(character.name),
                  titlePadding:
                      EdgeInsets.only(left: 45, bottom: 15, right: 15),
                  background: character.thumbnail.path.isEmpty
                      ? Image.asset(
                          'assets/images/placeholder.png',
                          fit: BoxFit.contain,
                        )
                      : Image.network(
                          '${character.thumbnail.path}/portrait_incredible.${character.thumbnail.extension}',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/placeholder.png',
                              fit: BoxFit.contain,
                            );
                          },
                        ),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _printDescriptionView(),
                  _printLinksView(),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.last_modified,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        character.modified.parseDate(),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
