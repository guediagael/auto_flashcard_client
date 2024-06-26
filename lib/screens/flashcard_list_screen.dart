import 'package:client/bloc/flashcard_list/flashcard_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/base/base_bloc_builder.dart';
import '../bloc/base/base_bloc_listener.dart';
import '../bloc/flashcard_list/flashcard_list_event.dart';
import '../bloc/flashcard_list/flashcard_list_state.dart';
import '../data/data_repository.dart';
import '../utils/messenger.dart';
import '../utils/screen_utils.dart';
import '../widgets/flashcard_topic_group_list_item.dart';
import 'flashcards_question_answering.dart';


class FlashcardListScreen extends StatelessWidget {
  FlashcardListScreen({super.key});

  final ScrollController _scrollController = ScrollController();

  static Widget buildFlashcardScreen({Key? key}) {
    return BlocProvider(
      create: (ctx) =>
          FlashcardListBloc(dataRepository: ctx.read<DataRepository>()),
      child: FlashcardListScreen(
        key: key,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    final flashcardBloc = context.read<FlashcardListBloc>();
    return BaseBlocListener(
      bloc: flashcardBloc,
      messenger: Messenger(context),
      listener: (listenerCtx, listenerState) {
        if (listenerState is FlashcardListStateLoadingCards) {
          flashcardBloc.add(const FlashcardListEventLoadCards());
        }
      },
      child: BaseBlocBuilder(
        bloc: flashcardBloc..add(FlashcardListEventTriggerLoadCards()),
        builder: (builderCtx, builderState) {
          if (builderState is FlashcardListStateLoadingCards) {
            return const Center(
              child: LinearProgressIndicator(),
            );
          } else if (builderState is FlashcardListStateCardsLoaded) {
            return GridView.builder(
              itemCount: builderState.cards.length + 1,
              shrinkWrap: true,
              itemBuilder: (ctx, idx) => (idx < builderState.cards.length)
                  ? InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => FlashcardQuestionAnswering(
                          topic: builderState.cards[idx].title)));
                },
                child: FlashcardTopicGroupListItem(
                    key: Key(builderState.cards[idx].id.toString() +
                        builderState.cards[idx].title),
                    topicStack: builderState.cards[idx]),
              )
                  : (builderState.hasMore)
                  ? const CircularProgressIndicator()
                  : Container(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: getProportionateScreenWidth(48)),
              controller: _scrollController
                ..addListener(() {
                  if (_scrollController.position.atEdge &&
                      (_scrollController.position.maxScrollExtent ==
                          _scrollController.offset)) {
                    if (builderState.hasMore) {
                      flashcardBloc.add(FlashcardListEventLoadMoreCards(
                          page: builderState.page));
                    }
                  }
                }),
            );
          }
          return Container();
        },
      ),
    );
  }
}
