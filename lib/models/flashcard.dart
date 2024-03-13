class Flashcard {
  final String recto;
  final String verso;
  final List<int> sourcePages;
  final int stackId;

  Flashcard(
      {required this.recto,
      required this.verso,
      required this.sourcePages,
      required this.stackId});
}
