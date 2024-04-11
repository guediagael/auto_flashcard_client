
import 'package:client/app_localization.dart';
import 'package:flutter/material.dart';

import '../localization/en_us.dart';
import '../models/flashcard_topic.dart';
import '../utils/screen_utils.dart';

class FlashcardTopicGroupListItem extends StatelessWidget {
  final FlashcardTopic topicStack;

  const FlashcardTopicGroupListItem({super.key, required this.topicStack});

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            width: getProportionateScreenWidth(48),
            height: getProportionateScreenHeight(48),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text( topicStack.title.length <20 ?
                  topicStack.title : topicStack.title.substring(0,20),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Text(
                  "${topicStack.openedCount}/ ${topicStack.count}",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  "${openedText.tr(context)} / ${totalAnsweredTxt.tr(context)}",
                  style: Theme.of(context).textTheme.labelLarge,
                )
              ],
            )),
      ),
    );
  }
}
