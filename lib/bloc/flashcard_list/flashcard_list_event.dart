import '../base/base_event.dart';

class FlashcardListEventLoadCards extends BaseEvent {
  const FlashcardListEventLoadCards() : super(const []);
}

class FlashcardListEventTriggerLoadCards extends BaseEvent {
  final int page;

  FlashcardListEventTriggerLoadCards([this.page = 1]) : super([page]);
}

class FlashcardListEventLoadMoreCards extends BaseEvent {
  final int page;

  FlashcardListEventLoadMoreCards({required this.page}) : super([page]);
}
