import 'package:client/models/topic.dart';
import 'package:client/utils/screen_utils.dart';
import 'package:flutter/material.dart';

class TopicGroupListItem extends StatelessWidget {
  final Topic topicStack;

  const TopicGroupListItem({super.key, required this.topicStack});

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Card(
      child: SizedBox(
          width: getProportionateScreenWidth(98),
          height: getProportionateScreenHeight(98),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text(topicStack.title), Text(topicStack.count)],
          )),
    );
  }
}
