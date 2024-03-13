import 'choice.dart';

class Mcq {
  final int id;
  final String question;
  final List<Choice> choices;
  final bool isAnswered = false;
  final List<int> sourcePages;

  Mcq(
      {required this.id,
      required this.choices,
      required this.question,
      required this.sourcePages});
}
