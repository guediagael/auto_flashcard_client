import 'package:client/models/mcq.dart';
import 'package:client/models/topic.dart';
import 'package:flutter/material.dart';

import '../utils/screen_utils.dart';
import '../widgets/flashcard_group_list_item.dart';
import 'mcq_q_and_a.dart';

class McqScreen extends StatelessWidget {
  const McqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Topic> mcqs = [];
    ScreenUtils().init(context);
    return GridView.builder(
      itemCount: mcqs.length,
      itemBuilder: (ctx, idx) => InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => McqQandA(topic: mcqs[idx].title)));
        },
        child: TopicGroupListItem(
            key: Key(mcqs[idx].id.toString() + mcqs[idx].title),
            topicStack: mcqs[idx]),
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: getProportionateScreenWidth(98)),
    );
  }
}
