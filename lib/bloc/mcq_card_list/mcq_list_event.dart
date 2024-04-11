import '../base/base_event.dart';

class McqCardListEventLoadCards extends BaseEvent {
  const McqCardListEventLoadCards() : super(const []);
}

class McqCardListEventTriggerLoadCards extends BaseEvent {
  final int page;

  McqCardListEventTriggerLoadCards([this.page = 1]) : super([page]);
}

class McqCardListEventLoadMoreCards extends BaseEvent {
  final int page;

  McqCardListEventLoadMoreCards({required this.page}) : super([page]);
}
