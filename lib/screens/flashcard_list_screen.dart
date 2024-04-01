import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/base/base_bloc_builder.dart';
import '../bloc/base/base_bloc_listener.dart';
import '../bloc/flash_card_list/flashcard_list_bloc.dart';
import '../bloc/flash_card_list/flashcard_list_event.dart';
import '../bloc/flash_card_list/flashcard_list_state.dart';
import '../data/data_repository.dart';
import '../utils/messenger.dart';
import '../utils/screen_utils.dart';
import '../widgets/flashcard_group_list_item.dart';
import 'flashcards_question_answering.dart';

class FlashcardScreen extends StatelessWidget {
  FlashcardScreen({super.key});

  final ScrollController _scrollController = ScrollController();

  static Widget buildFlashcardScreen({Key? key}) {
    return BlocProvider(
      create: (ctx) =>
          FlashCardListBloc(dataRepository: ctx.read<DataRepository>()),
      child: FlashcardScreen(
        key: key,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    final flashcardBloc = context.read<FlashCardListBloc>();
    return BaseBlocListener(
      bloc: flashcardBloc,
      messenger: Messenger(context),
      listener: (listenerCtx, listenerState) {
        if (listenerState is FlashCardListStateLoadingCards) {
          flashcardBloc.add(const FlashCardListEventLoadCards());
        }
      },
      child: BaseBlocBuilder(
        bloc: flashcardBloc..add(FlashCardListEventTriggerLoadCards()),
        builder: (builderCtx, builderState) {
          if (builderState is FlashCardListStateLoadingCards) {
            return const Center(
              child: LinearProgressIndicator(),
            );
          } else if (builderState is FlashCardListStateCardsLoaded) {
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
                      child: TopicGroupListItem(
                          key: Key(builderState.cards[idx].id.toString() +
                              builderState.cards[idx].title),
                          topicStack: builderState.cards[idx]),
                    )
                  : (builderState.hasMore)
                      ? const CircularProgressIndicator()
                      : Container(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: getProportionateScreenWidth(72)),
              controller: _scrollController
                ..addListener(() {
                  if (_scrollController.offset >=
                          _scrollController.position.maxScrollExtent &&
                      !_scrollController.position.outOfRange) {
                    if (builderState.hasMore) {
                      flashcardBloc.add(FlashCardListEventLoadMoreCards(
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
