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

final dummyTopics = [
  Topic(
      id: 1,
      title: "The Solar System",
      count: "10",
      sourcePath: "images/solar_system.jpg",
      dateTime: DateTime.now()),
  Topic(
      id: 2,
      title: "Verbs in English",
      count: "25",
      sourcePath: "data/english_verbs.json",
      dateTime: DateTime(2024, 3, 25)),
  Topic(
      id: 3,
      title: "Famous Landmarks",
      count: "50",
      sourcePath: "[invalid URL removed]",
      dateTime: DateTime.parse("2023-12-01")),
  Topic(
      id: 4,
      title: "Chemical Reactions",
      count: "15",
      sourcePath: "textbooks/chemistry.pdf",
      dateTime: DateTime(2024, 2, 14)),
  Topic(
      id: 5,
      title: "Great Mathematicians",
      count: "10",
      sourcePath: " biographies/mathematicians.txt",
      dateTime: DateTime.now().subtract(Duration(days: 7))),
  Topic(
      id: 6,
      title: "Types of Government",
      count: "8",
      sourcePath: "[invalid URL removed]",
      dateTime: DateTime(2024, 1, 10)),
  Topic(
      id: 7,
      title: "World's Oceans",
      count: "5",
      sourcePath: "videos/oceans.mp4",
      dateTime: DateTime.now().add(Duration(days: 2))),
  Topic(
      id: 8,
      title: "Shakespearean Plays",
      count: "12",
      sourcePath: "ebooks/shakespeare_collection.epub",
      dateTime: DateTime(2023, 11, 15)),
  Topic(
      id: 9,
      title: "Healthy Eating Habits",
      count: "20",
      sourcePath: "recipes/healthy_meals.doc",
      dateTime: DateTime.now().subtract(Duration(days: 3))),
  Topic(
      id: 10,
      title: "Parts of Speech",
      count: "8",
      sourcePath: "grammar_guide.html",
      dateTime: DateTime(2024, 3, 18)),
  Topic(
      id: 11,
      title: "Famous Artists",
      count: "30",
      sourcePath: "museums/art_history.com",
      dateTime: DateTime.now().add(Duration(days: 5))),
  Topic(
      id: 12,
      title: "World Mythology",
      count: "18",
      sourcePath: "books/myths_and_legends.pdf",
      dateTime: DateTime(2024, 2, 01)),
  Topic(
      id: 13,
      title: "Space Exploration",
      count: "12",
      sourcePath: "documentaries/space_travel.mp4",
      dateTime: DateTime.now().subtract(Duration(days: 10))),
  Topic(
      id: 14,
      title: "Types of Rocks",
      count: "7",
      sourcePath: "geology/rock_samples.jpg",
      dateTime: DateTime(2024, 3, 20)),
  Topic(
      id: 15,
      title: "Great Composers",
      count: "20",
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().add(Duration(days: 1)))
];
