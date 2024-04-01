import '../../models/topic.dart';
import '../base/base_state.dart';

class FlashCardListStateInitial extends BaseState {
  const FlashCardListStateInitial() : super(const []);
}

class FlashCardListStateLoadingCards extends BaseState {
  const FlashCardListStateLoadingCards() : super(const []);
}

class FlashCardListStateCardsLoaded extends BaseState {
  final List<Topic> cards;
  final int page;
  final bool hasMore;

  FlashCardListStateCardsLoaded(
      {required this.cards, required this.page, required this.hasMore})
      : super([cards, page, hasMore]);
}


