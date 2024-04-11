class FlashcardTopic {
  final int id;
  final String title;
  final int count;
  final String sourcePath;
  final DateTime dateTime;
  final int openedCount;

  FlashcardTopic(
      {required this.id,
        required this.title,
        required this.count,
        required this.sourcePath,
        this.openedCount = 0,
        required this.dateTime}):assert(count >= openedCount);

  @override
  String toString() {
    return 'FlashcardStack{id: $id, title: $title, count: $count, sourcePath: $sourcePath, dateTime: $dateTime}';
  }
}

final dummyFlashcardTopics = [
  FlashcardTopic(
      id: 1,
      title: "The Solar System",
      count: 10,
      sourcePath: "images/solar_system.jpg",
      openedCount: 2,
      dateTime: DateTime.now()),
  FlashcardTopic(
      id: 2,
      title: "Verbs in English",
      count: 25,
      sourcePath: "data/english_verbs.json",
      openedCount: 10,
      dateTime: DateTime(2024, 3, 25)),
  FlashcardTopic(
      id: 3,
      title: "Famous Landmarks",
      count: 50,
      openedCount: 20,
      sourcePath: "[invalid URL removed]",
      dateTime: DateTime.parse("2023-12-01")),
  FlashcardTopic(
      id: 4,
      title: "Chemical Reactions",
      count: 15,
      openedCount: 1,
      sourcePath: "textbooks/chemistry.pdf",
      dateTime: DateTime(2024, 2, 14)),
  FlashcardTopic(
      id: 5,
      title: "Great Mathematicians",
      count: 10,
      openedCount: 9,
      sourcePath: " biographies/mathematicians.txt",
      dateTime: DateTime.now().subtract(Duration(days: 7))),
  FlashcardTopic(
      id: 6,
      title: "Types of Government",
      count: 8,
      sourcePath: "[invalid URL removed]",
      dateTime: DateTime(2024, 1, 10)),
  FlashcardTopic(
      id: 7,
      title: "World's Oceans",
      count: 5,
      sourcePath: "videos/oceans.mp4",
      dateTime: DateTime.now().add(Duration(days: 2))),
  FlashcardTopic(
      id: 8,
      title: "Shakespearean Plays",
      count: 12,
      sourcePath: "ebooks/shakespeare_collection.epub",
      dateTime: DateTime(2023, 11, 15)),
  FlashcardTopic(
      id: 9,
      title: "Healthy Eating Habits",
      count: 20,
      sourcePath: "recipes/healthy_meals.doc",
      dateTime: DateTime.now().subtract(Duration(days: 3))),
  FlashcardTopic(
      id: 10,
      title: "Parts of Speech",
      count: 8,
      sourcePath: "grammar_guide.html",
      dateTime: DateTime(2024, 3, 18)),
  FlashcardTopic(
      id: 11,
      title: "Famous Artists",
      count: 30,
      sourcePath: "museums/art_history.com",
      dateTime: DateTime.now().add(Duration(days: 5))),
  FlashcardTopic(
      id: 12,
      title: "World Mythology",
      count: 18,
      sourcePath: "books/myths_and_legends.pdf",
      dateTime: DateTime(2024, 2, 01)),
  FlashcardTopic(
      id: 13,
      title: "Space Exploration",
      count: 12,
      sourcePath: "documentaries/space_travel.mp4",
      dateTime: DateTime.now().subtract(Duration(days: 10))),
  FlashcardTopic(
      id: 14,
      title: "Types of Rocks",
      count: 7,
      sourcePath: "geology/rock_samples.jpg",
      dateTime: DateTime(2024, 3, 20)),
  FlashcardTopic(
      id: 15,
      title: "Types of Rocks 15",
      count: 7,
      sourcePath: "geology/rock_samples.jpg",
      dateTime: DateTime(2024, 3, 20)),
  FlashcardTopic(
      id: 16,
      title: "Types of Rocks 16",
      count: 7,
      openedCount: 7,
      sourcePath: "geology/rock_samples.jpg",
      dateTime: DateTime(2024, 3, 20)),
  FlashcardTopic(
      id: 17,
      title: "Great Composers 17",
      count: 20,
      openedCount: 10,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 17))),
  FlashcardTopic(
      id: 18,
      title: "Great Composers 18",
      count: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 18))),
  FlashcardTopic(
      id: 19,
      title: "Great Composers 19",
      count: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 19))),
  FlashcardTopic(
      id: 20,
      title: "Great Composers 20",
      count: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 20))),
  FlashcardTopic(
      id: 21,
      title: "Great Composers 21",
      count: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 21))),
  FlashcardTopic(
      id: 22,
      title: "Great Composers 22",
      count: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 22))),
  FlashcardTopic(
      id: 22,
      title: "Great Composers 22",
      count: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 22))),
  FlashcardTopic(
      id: 22,
      title: "Great Composers 22",
      count: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 22))),
  FlashcardTopic(
      id: 23,
      title: "Great Composers 23",
      count: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 23))),
  FlashcardTopic(
      id: 24,
      title: "Great Composers 24",
      count: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 24))),
  FlashcardTopic(
      id: 25,
      title: "Great Composers 25",
      count: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 25))),
  FlashcardTopic(
      id: 26,
      title: "Great Composers 26",
      count: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 26))),
  FlashcardTopic(
      id: 27,
      title: "Great Composers 27",
      count: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 27))),
  FlashcardTopic(
      id: 28,
      title: "Great Composers 28",
      count: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 28))),
  FlashcardTopic(
      id: 29,
      title: "Great Composers 29",
      count: 30,
      openedCount: 20,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 29))),
  FlashcardTopic(
      id: 30,
      title: "Great Composers 30",
      count: 25,
      openedCount: 15,
      sourcePath: "music/classical_collection.mp3",
      dateTime: DateTime.now().subtract(Duration(days: 30))),
];
