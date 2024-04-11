import '../../models/mcqtopic.dart';
import '../base/base_state.dart';

class McqCardListStateInitial extends BaseState {
  const McqCardListStateInitial() : super(const []);
}

class McqCardListStateLoadingCards extends BaseState {
  const McqCardListStateLoadingCards() : super(const []);
}

class McqCardListStateCardsLoaded extends BaseState {
  final List<McqTopic> cards;
  final int page;
  final bool hasMore;

  McqCardListStateCardsLoaded(
      {required this.cards, required this.page, required this.hasMore})
      : super([cards, page, hasMore]);
}


