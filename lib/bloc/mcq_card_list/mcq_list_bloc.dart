import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/mcqtopic.dart';
import '../base/base_bloc.dart';
import '../base/base_state.dart';
import 'mcq_list_event.dart';
import 'mcq_list_state.dart';

class McqListBloc extends BaseBloc {
  McqListBloc({required super.dataRepository})
      : super(initialState: const McqCardListStateInitial()) {
    on<McqCardListEventLoadCards>(_onLoadCards);
    on<McqCardListEventTriggerLoadCards>(_onTriggerLoadCards);
    on<McqCardListEventLoadMoreCards>(_onLoadMoreCards);
  }

  FutureOr<void> _onLoadCards(
      McqCardListEventLoadCards event, Emitter<BaseState> emit) async {
    List<McqTopic> cards = await _getcards(false);
    emit(McqCardListStateCardsLoaded(cards: cards, page: 1, hasMore: true));
  }

  FutureOr<void> _onTriggerLoadCards(
      McqCardListEventTriggerLoadCards event, Emitter<BaseState> emit) {
    emit(const McqCardListStateLoadingCards());
    add(const McqCardListEventLoadCards());
  }

  FutureOr<void> _onLoadMoreCards(
      McqCardListEventLoadMoreCards event, Emitter<BaseState> emit) async {
    List<McqTopic> moreCards = await _getcards(true);
    emit(McqCardListStateCardsLoaded(cards: [
      ...(state as McqCardListStateCardsLoaded).cards,
      ...moreCards
    ], page: event.page + 1, hasMore: false));
  }

  Future<List<McqTopic>> _getcards([bool loadMore = false]) async {
    return Future.value(
        loadMore ? dummyMcqTopics.sublist(24) : dummyMcqTopics.sublist(0, 24));
  }
}
