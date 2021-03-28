import 'dart:math';

import 'package:flutter/material.dart';

class UnderConstructionController extends ChangeNotifier {
  final List<String> _sentences = [
    "House blowing up builds character.",
    "Bad Deadpool... Good Deadpool!",
    "Whose kitty litter did I just shit in?",
    "Say the magic words, Fat Gandalf.",
    "Happy Lent.",
    "Dad?",
    "This is my most prized possession...",
    "Guy came in here looking for you. Real Grim Reaper-type. I don't know. Might further the plot.",
    "If I ever decide to become a crime-fighting shit swizzler, who rooms with a bunch of other little whiners at Neverland Mansion with some creepy, old, bald, Heaven's Gate-looking motherfucker... on that day, I'll send your shiny, happy ass a friend request.",
    "All the dinosaurs feared the T-Rex.",
    "McAvoy or Stewart? These timelines are confusing.",
    "Ever see 127 Hours?",
    "I want to die a natural death at the age of 102 - like the city of Detroit.",
    "Please don't make the super suit green... or animated!",
    "You have something in your teeth.",
    "He got Ajax from the dish soap!",
    "You will die alone, if you could die - ideally, for others sake.",
    "Captain Deadpool! No, just Deadpool.",
    "Fourth wall break inside of a fourth wall break? That's like... 16 walls!",
    "You're about to be killed by a Zamboni.",
    "I bet it feels huge in this hand.",
    "Have fun at your midnight showing of Blade II.",
    "Listen Al, if I never see you again, I want you to know that I love you very much. I also buried 1,600 kilos of cocaine somewhere in the apartment -- right next to the cure for blindness. Good luck.",
    "It's a Big house. It's weird I only ever see two of you. Almost like the studio couldn't afford another X-Man.",
    "Superhero landing! She's going to do a superhero landing!",
    "When I'm finished parts will have to grow back you.",
    "You were droning on!",
    "You live in a house?",
    "After a brief adjustment period, and a couple of drinks, it's a face... I'd be happy to sit on.",
    "You're still here? It's over. Go home! Oh, you're expecting a teaser for Deadpool 2**. Well, we don't have that kind of money. What are you expecting? Sam Jackson showing up in an eyepatch and a saucy little leather number? Go!",
  ];

  String getSentence() {
    var index = Random().nextInt(_sentences.length);
    return _sentences[index];
  }
}
