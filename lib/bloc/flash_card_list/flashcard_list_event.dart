import '../base/base_event.dart';

class FlashCardListEventLoadCards extends BaseEvent {
  const FlashCardListEventLoadCards() : super(const []);
}

class FlashCardListEventTriggerLoadCards extends BaseEvent {
  final int page;

  FlashCardListEventTriggerLoadCards([this.page = 1]) : super([page]);
}

class FlashCardListEventLoadMoreCards extends BaseEvent {
  final int page;

  FlashCardListEventLoadMoreCards({required this.page}) : super([page]);
}
