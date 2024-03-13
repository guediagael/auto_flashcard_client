import 'package:client/widgets/mcq_item.dart';
import 'package:flutter/material.dart';

import '../models/mcq.dart';

class McqQandA extends StatelessWidget {
  final String topic;

  const McqQandA({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    final List<Mcq> questions = [];
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
          itemCount: questions.length,
          itemBuilder: (ctx, idx) => McqItem(
              item: questions[idx], onChoiceSelected: (String choice) {})),
    ));
  }
}
