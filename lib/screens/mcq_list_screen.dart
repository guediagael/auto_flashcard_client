import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/base/base_bloc_builder.dart';
import '../bloc/base/base_bloc_listener.dart';
import '../bloc/mcq_card_list/mcq_list_bloc.dart';
import '../bloc/mcq_card_list/mcq_list_event.dart';
import '../bloc/mcq_card_list/mcq_list_state.dart';
import '../data/data_repository.dart';
import '../utils/messenger.dart';
import '../utils/screen_utils.dart';
import '../widgets/mcq_topic_group_list_item.dart';
import 'mcq_q_and_a.dart';

class McqListScreen extends StatelessWidget {
  McqListScreen({super.key});

  final ScrollController _scrollController = ScrollController();

  static Widget buildMcqCardScreen({Key? key}) {
    return BlocProvider(
      create: (ctx) =>
          McqListBloc(dataRepository: ctx.read<DataRepository>()),
      child: McqListScreen(
        key: key,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    final flashcardBloc = context.read<McqListBloc>();
    return BaseBlocListener(
      bloc: flashcardBloc,
      messenger: Messenger(context),
      listener: (listenerCtx, listenerState) {
        if (listenerState is McqCardListStateLoadingCards) {
          flashcardBloc.add(const McqCardListEventLoadCards());
        }
      },
      child: BaseBlocBuilder(
        bloc: flashcardBloc..add(McqCardListEventTriggerLoadCards()),
        builder: (builderCtx, builderState) {
          if (builderState is McqCardListStateLoadingCards) {
            return const Center(
              child: LinearProgressIndicator(),
            );
          } else if (builderState is McqCardListStateCardsLoaded) {
            return GridView.builder(
              itemCount: builderState.cards.length + 1,
              shrinkWrap: true,
              itemBuilder: (ctx, idx) => (idx < builderState.cards.length)
                  ? InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => McqQandA(
                                topic: builderState.cards[idx].title)));
                      },
                      child: McqTopicGroupListItem(
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
                  if (_scrollController.position.atEdge &&
                      (_scrollController.position.maxScrollExtent ==
                          _scrollController.offset)) {
                    if (builderState.hasMore) {
                      flashcardBloc.add(McqCardListEventLoadMoreCards(
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
