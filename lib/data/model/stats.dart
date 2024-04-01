//Premium only feature
class Stats {
  final int documentId;
  final Map<DateTime, double>
      scores; //the number of correctly answered questions on a document
  final int questionCount;

  Stats(
      {required this.documentId,
      required this.scores,
      required this.questionCount});

  double getAverageScore() {
    throw UnimplementedError("");
  }

  double getProgressionGraph() {
    throw UnimplementedError("");
  }
}
