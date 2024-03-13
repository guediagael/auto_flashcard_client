import 'package:flutter/material.dart';

import '../models/topic.dart';
import '../utils/screen_utils.dart';
import '../widgets/flashcard_group_list_item.dart';
import 'flashcards_question_answering.dart';

class FlashcardScreen extends StatelessWidget {
  const FlashcardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Topic> flashcards = [];
    ScreenUtils().init(context);
    return GridView.builder(
      itemCount: flashcards.length,
      itemBuilder: (ctx, idx) =>
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) =>
                      FlashcardQuestionAnswering(
                          topic: flashcards[idx].title)));
            },
            child: TopicGroupListItem(
                key: Key(flashcards[idx].id.toString() + flashcards[idx].title),
                topicStack: flashcards[idx]),
          ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: getProportionateScreenWidth(98)),
    );
  }

}