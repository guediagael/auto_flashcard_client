import '../../models/flashcard_topic.dart';
import '../base/base_state.dart';

class FlashcardListStateInitial extends BaseState {
  const FlashcardListStateInitial() : super(const []);
}

class FlashcardListStateLoadingCards extends BaseState {
  const FlashcardListStateLoadingCards() : super(const []);
}

class FlashcardListStateCardsLoaded extends BaseState {
  final List<FlashcardTopic> cards;
  final int page;
  final bool hasMore;

  FlashcardListStateCardsLoaded(
      {required this.cards, required this.page, required this.hasMore})
      : super([cards, page, hasMore]);
}


