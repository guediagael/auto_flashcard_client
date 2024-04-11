import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/flashcard_topic.dart';
import '../base/base_bloc.dart';
import '../base/base_state.dart';
import 'flashcard_list_event.dart';
import 'flashcard_list_state.dart';

class FlashcardListBloc extends BaseBloc {
  FlashcardListBloc({required super.dataRepository})
      : super(initialState: const FlashcardListStateInitial()) {
    on<FlashcardListEventLoadCards>(_onLoadCards);
    on<FlashcardListEventTriggerLoadCards>(_onTriggerLoadCards);
    on<FlashcardListEventLoadMoreCards>(_onLoadMoreCards);
  }

  FutureOr<void> _onLoadCards(
      FlashcardListEventLoadCards event, Emitter<BaseState> emit) async {
    List<FlashcardTopic> cards = await _getcards(false);
    emit(FlashcardListStateCardsLoaded(cards: cards, page: 1, hasMore: true));
  }

  FutureOr<void> _onTriggerLoadCards(
      FlashcardListEventTriggerLoadCards event, Emitter<BaseState> emit) {
    emit(const FlashcardListStateLoadingCards());
    add(const FlashcardListEventLoadCards());
  }

  FutureOr<void> _onLoadMoreCards(
      FlashcardListEventLoadMoreCards event, Emitter<BaseState> emit) async {
    List<FlashcardTopic> moreCards = await _getcards(true);
    emit(FlashcardListStateCardsLoaded(cards: [
      ...(state as FlashcardListStateCardsLoaded).cards,
      ...moreCards
    ], page: event.page + 1, hasMore: false));
  }

  Future<List<FlashcardTopic>> _getcards([bool loadMore = false]) async {
    return Future.value(loadMore
        ? dummyFlashcardTopics.sublist(24)
        : dummyFlashcardTopics.sublist(0, 24));
  }
}
