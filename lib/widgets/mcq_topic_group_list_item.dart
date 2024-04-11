import 'package:client/app_localization.dart';
import 'package:flutter/material.dart';

import '../localization/en_us.dart';
import '../models/mcqtopic.dart';
import '../utils/screen_utils.dart';

class McqTopicGroupListItem extends StatelessWidget {
  final McqTopic topicStack;

  const McqTopicGroupListItem({super.key, required this.topicStack});

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            width: getProportionateScreenWidth(72),
            height: getProportionateScreenHeight(72),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    topicStack.title.length < 20
                        ? topicStack.title
                        : topicStack.title.substring(0, 20),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Text(
                  "${totalTxt.tr(context)} ${topicStack.count}",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  "${topicStack.correctlyAnswered}/ ${topicStack.totalOpened}",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  "${correctTxt.tr(context)} / ${totalAnsweredTxt.tr(context)}",
                  style: Theme.of(context).textTheme.labelLarge,
                )
              ],
            )),
      ),
    );
  }
}
