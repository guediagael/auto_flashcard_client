class McqTopic {
  final int id;
  final String title;
  final int count;
  final String sourcePath;
  final DateTime dateTime;
  final int correctlyAnswered;
  final int totalOpened;

  McqTopic(
      {required this.id,
      required this.title,
      required this.count,
      required this.sourcePath,
      required this.dateTime,
      this.correctlyAnswered = 0,
      this.totalOpened = 0})
      : assert(totalOpened >= correctlyAnswered && totalOpened <= count);

  @override
  String toString() {
    return 'FlashcardStack{id: $id, title: $title, count: $count, sourcePath: $sourcePath, dateTime: $dateTime}';
  }
}

final dummyMcqTopics = [
  McqTopic(
      id: 1,
      title: "The Solar System",
      count: 10,
      sourcePath: "images/solar_system.jpg",
      totalOpened: 4,
      correctlyAnswered: 4,
      dateTime: DateTime.now()),
  McqTopic(
      id: 2,
      title: "Verbs in English",
      count: 25,
      totalOpened: 10,
      correctlyAnswered: 5,
      sourcePath: "data/english_verbs.json",
      dateTime: DateTime(2024, 3, 25)),
  McqTopic(
      id: 3,
      title: "Famous Landmarks",
      count: 50,
      totalOpened: 11,
      correctlyAnswered: 1,
      sourcePath: "[invalid URL removed]",
      dateTime: DateTime.parse("2023-12-01")),
  McqTopic(
      id: 4,
      title: "Chemical Reactions",
      count: 15,
      totalOpened: 10,
      sourcePath: "textbooks/chemistry.pdf",
      dateTime: DateTime(2024, 2, 14)),
  McqTopic(
      id: 5,
      title: "Great Mathematicians",
      count: 10,
      totalOpened: 8,
      sourcePath: " biographies/mathematicians.txt",
      dateTime: DateTime.now().subtract(Duration(days: 7))),
  McqTopic(
      id: 6,
      title: "Types of Government",
      count: 8,
      correctlyAnswered: 8,
      totalOpened: 8,
      sourcePath: "[invalid URL removed]",
      dateTime: DateTime(2024, 1, 10)),
  McqTopic(
      id: 7,
      title: "World's Oceans",
      count: 5,
      sourcePath: "videos/oceans.mp4",
      dateTime: DateTime.now().add(Duration(days: 2))),
  McqTopic(
      id: 8,
      title: "Shakespearean Plays",
      count: 12,
      sourcePath: "ebooks/shakespeare_collection.epub",
      dateTime: DateTime(2023, 11, 15)),
  McqTopic(
      id: 9,
      title: "Healthy Eating Habits",
      count: 20,
      sourcePath: "recipes/healthy_meals.doc",
      dateTime: DateTime.now().subtract(Duration(days: 3))),
  McqTopic(
      id: 10,
      title: "Parts of Speech",
      count: 8,
      sourcePath: "grammar_guide.html",
      dateTime: DateTime(2024, 3, 18)),
  McqTopic(
      id: 11,
      title: "Famous Artists",
      count: 30,
      sourcePath: "museums/art_history.com",
      dateTime: DateTime.now().add(Duration(days: 5))),
  McqTopic(
      id: 12,
      title: "World Mythology",
      count: 18,
      sourcePath: "books/myths_and_legends.pdf",
      dateTime: DateTime(2024, 2, 01)),
  McqTopic(
      id: 13,
      title: "Space Exploration",
      count: 12,
      sourcePath: "documentaries/space_travel.mp4",
      dateTime: DateTime.now().subtract(Duration(days: 10))),
  McqTopic(
      id: 14,
      title: "Types of Rocks",
      count: 7,
      sourcePath: "geology/rock_samples.jpg",
      dateTime: DateTime(2024, 3, 20)),
  McqTopic(
      id: 15,
      title: "Types of Rocks 15",
      count: 7,
      sourcePath: "geology/rock_samples.jpg",
      dateTime: DateTime(2024, 3, 20)),
  McqTopic(
      id: 16,
      title: "Types of Rocks 16",
      count: 7,
      sourcePath: "geology/rock_samples.jpg",
      dateTime: DateTime(2024, 3, 20)),
  McqTopic(
      id: 17,
      title: "Great Composers 17",
      count: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 17))),
  McqTopic(
      id: 18,
      title: "Great Composers 18",
      count: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 18))),
  McqTopic(
      id: 19,
      title: "Great Composers 19",
      count: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 19))),
  McqTopic(
      id: 20,
      title: "Great Composers 20",
      count: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 20))),
  McqTopic(
      id: 21,
      title: "Great Composers 21",
      count: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 21))),
  McqTopic(
      id: 22,
      title: "Great Composers 22",
      count: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 22))),
  McqTopic(
      id: 22,
      title: "Great Composers 22",
      count: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 22))),
  McqTopic(
      id: 22,
      title: "Great Composers 22",
      count: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 22))),
  McqTopic(
      id: 23,
      title: "Great Composers 23",
      count: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 23))),
  McqTopic(
      id: 24,
      title: "Great Composers 24",
      count: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 24))),
  McqTopic(
      id: 25,
      title: "Great Composers 25",
      count: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 25))),
  McqTopic(
      id: 26,
      title: "Great Composers 26",
      count: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 26))),
  McqTopic(
      id: 27,
      title: "Great Composers 27",
      count: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 27))),
  McqTopic(
      id: 28,
      title: "Great Composers 28",
      count: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 28))),
  McqTopic(
      id: 29,
      title: "Great Composers 29",
      count: 30,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 29))),
  McqTopic(
      id: 30,
      title: "Great Composers 30",
      count: 25,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 30))),
];
