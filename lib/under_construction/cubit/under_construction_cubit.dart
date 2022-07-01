import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:marvel/l10n/l10n.dart';

class UnderConstructionCubit extends Cubit<String> {
  UnderConstructionCubit() : super('');

  void getSentence(BuildContext _context) {
    final _sentences = <String>[
      _context.l10n.deadpool_message1,
      _context.l10n.deadpool_message2,
      _context.l10n.deadpool_message3,
      _context.l10n.deadpool_message4,
      _context.l10n.deadpool_message5,
      _context.l10n.deadpool_message6,
      _context.l10n.deadpool_message7,
      _context.l10n.deadpool_message8,
      _context.l10n.deadpool_message9,
      _context.l10n.deadpool_message10,
      _context.l10n.deadpool_message11,
      _context.l10n.deadpool_message12,
      _context.l10n.deadpool_message13,
      _context.l10n.deadpool_message14,
      _context.l10n.deadpool_message15,
      _context.l10n.deadpool_message16,
      _context.l10n.deadpool_message17,
      _context.l10n.deadpool_message18,
      _context.l10n.deadpool_message19,
      _context.l10n.deadpool_message20,
      _context.l10n.deadpool_message21,
      _context.l10n.deadpool_message22,
      _context.l10n.deadpool_message23,
      _context.l10n.deadpool_message24,
      _context.l10n.deadpool_message25,
      _context.l10n.deadpool_message26,
      _context.l10n.deadpool_message27,
      _context.l10n.deadpool_message28,
      _context.l10n.deadpool_message29,
      _context.l10n.deadpool_message30,
    ];

    final index = Random().nextInt(_sentences.length);
    emit(_sentences[index]);
  }
}
