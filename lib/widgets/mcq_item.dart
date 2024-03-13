import 'package:client/models/mcq.dart';
import 'package:flutter/material.dart';

class McqItem extends StatelessWidget {
  final Mcq item;
  final void Function(String) onChoiceSelected;

  const McqItem(
      {super.key, required this.item, required this.onChoiceSelected});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(item.question),
          ...item.choices.map((e) => RadioListTile<String>(
              value: e.statement,
              groupValue: null,
              onChanged: (selected) {
                if (selected != null) {
                  onChoiceSelected(selected);
                }
              }))
        ],
      ),
    );
  }
}
