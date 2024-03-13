class Topic {
  final int id;
  final String title;
  final String count;
  final String sourcePath;
  final DateTime dateTime;

  Topic(
      {required this.id,
      required this.title,
      required this.count,
      required this.sourcePath,
      required this.dateTime});

  @override
  String toString() {
    return 'FlashcardStack{id: $id, title: $title, count: $count, sourcePath: $sourcePath, dateTime: $dateTime}';
  }
}
