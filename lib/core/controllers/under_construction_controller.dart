import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UnderConstructionController extends ChangeNotifier {
  String getSentence(BuildContext _context) {
    final List<String> _sentences = [
      AppLocalizations.of(_context)!.deadpool_message1,
      AppLocalizations.of(_context)!.deadpool_message2,
      AppLocalizations.of(_context)!.deadpool_message3,
      AppLocalizations.of(_context)!.deadpool_message4,
      AppLocalizations.of(_context)!.deadpool_message5,
      AppLocalizations.of(_context)!.deadpool_message6,
      AppLocalizations.of(_context)!.deadpool_message7,
      AppLocalizations.of(_context)!.deadpool_message8,
      AppLocalizations.of(_context)!.deadpool_message9,
      AppLocalizations.of(_context)!.deadpool_message10,
      AppLocalizations.of(_context)!.deadpool_message11,
      AppLocalizations.of(_context)!.deadpool_message12,
      AppLocalizations.of(_context)!.deadpool_message13,
      AppLocalizations.of(_context)!.deadpool_message14,
      AppLocalizations.of(_context)!.deadpool_message15,
      AppLocalizations.of(_context)!.deadpool_message16,
      AppLocalizations.of(_context)!.deadpool_message17,
      AppLocalizations.of(_context)!.deadpool_message18,
      AppLocalizations.of(_context)!.deadpool_message19,
      AppLocalizations.of(_context)!.deadpool_message20,
      AppLocalizations.of(_context)!.deadpool_message21,
      AppLocalizations.of(_context)!.deadpool_message22,
      AppLocalizations.of(_context)!.deadpool_message23,
      AppLocalizations.of(_context)!.deadpool_message24,
      AppLocalizations.of(_context)!.deadpool_message25,
      AppLocalizations.of(_context)!.deadpool_message26,
      AppLocalizations.of(_context)!.deadpool_message27,
      AppLocalizations.of(_context)!.deadpool_message28,
      AppLocalizations.of(_context)!.deadpool_message29,
      AppLocalizations.of(_context)!.deadpool_message30,
    ];

    var index = Random().nextInt(_sentences.length);
    return _sentences[index];
  }
}
