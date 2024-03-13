import 'package:flutter/material.dart';

class Summary extends StatelessWidget {
  const Summary(
      {super.key,
      required this.summary,
      required this.source,
      required this.pages});

  final String summary;
  final String source;
  final List<int> pages;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(summary),
          Text(("Pages: ${pages.join(", ")}")),
        ],
      ),
    );
  }
}
