import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/topic.dart';
import '../base/base_bloc.dart';
import '../base/base_state.dart';
import 'flashcard_list_event.dart';
import 'flashcard_list_state.dart';

class FlashCardListBloc extends BaseBloc {
  FlashCardListBloc({required super.dataRepository})
      : super(initialState: const FlashCardListStateInitial()) {
    on<FlashCardListEventLoadCards>(_onLoadCards);
    on<FlashCardListEventTriggerLoadCards>(_onTriggerLoadCards);
    on<FlashCardListEventLoadMoreCards>(_onLoadMoreCards);
  }

  FutureOr<void> _onLoadCards(
      FlashCardListEventLoadCards event, Emitter<BaseState> emit) async {
    List<Topic> cards = await _getcards(false);
    emit(FlashCardListStateCardsLoaded(cards: cards, page: 1, hasMore: true));
  }

  FutureOr<void> _onTriggerLoadCards(
      FlashCardListEventTriggerLoadCards event, Emitter<BaseState> emit) {
    emit(const FlashCardListStateLoadingCards());
    add(const FlashCardListEventLoadCards());
  }

  FutureOr<void> _onLoadMoreCards(
      FlashCardListEventLoadMoreCards event, Emitter<BaseState> emit) async {
    List<Topic> moreCards = await _getcards(true);
    emit(FlashCardListStateCardsLoaded(
        cards: moreCards, page: event.page + 1, hasMore: false));
  }

  Future<List<Topic>> _getcards([bool loadMore = false]) async {

    return Future.value(
        loadMore ? dummyTopics.sublist(10) : dummyTopics.sublist(0, 10));
  }
}
