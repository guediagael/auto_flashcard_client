import 'package:client/models/flashcard.dart';
import 'package:client/widgets/flashcard_item.dart';
import 'package:flutter/material.dart';

class FlashcardQuestionAnswering extends StatelessWidget {
  final String topic;

  const FlashcardQuestionAnswering({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    final List<Flashcard> flashcards = [];
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Title(
          title: topic,
          color: Colors.black,
          child: Text(topic),
        ),
      ),
      body: PageView.builder(
          itemCount: flashcards.length,
          itemBuilder: (ctx, idx) =>
              FlashcardItem(flashcard: flashcards[idx], onCardFlipped: () {})),
    ));
  }
}
