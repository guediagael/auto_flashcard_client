import 'package:client/models/flashcard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flip_card/flip_card.dart';

class FlashcardItem extends StatelessWidget {
  final Flashcard flashcard;
  final Function() onCardFlipped;

  const FlashcardItem(
      {super.key, required this.flashcard, required this.onCardFlipped});

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      fill: Fill.fillBack,
      // Fill the back side of the card to make in the same size as the front.
      direction: FlipDirection.HORIZONTAL,
      // default
      side: CardSide.FRONT,
      // The side to initially display.
      onFlip: onCardFlipped,
      front: Text(flashcard.recto),
      back: Text(flashcard.verso),
    );
  }
}
