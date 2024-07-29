import 'package:dars_5_3_getx/blocs/words_bloc/words_bloc.dart';
import 'package:dars_5_3_getx/utils/words_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordsScreen extends StatefulWidget {
  WordsScreen({super.key});

  @override
  State<WordsScreen> createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WordsBloc>().add(RoundStartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordsBloc, WordsState>(builder: (context, state) {
      return curIndex == 4
          ? Scaffold(
              backgroundColor: Colors.blue,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Congratulations! You Won The Game",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<WordsBloc>().add(NextRoundEvent());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      "Restart",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Scaffold(
              backgroundColor: Colors.blue,
              appBar: AppBar(
                  backgroundColor: Colors.blue,
                  title: Text("Round ${curIndex + 1}"),
                  actions: !checkWin
                      ? [
                          TextButton(
                              onPressed: () {
                                context.read<WordsBloc>().add(NextRoundEvent());
                              },
                              child: const Text("Skip Round"))
                        ]
                      : null),
              body: BlocBuilder<WordsBloc, WordsState>(
                builder: (context, state) {
                  if (state is WordsLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is WordsErrorState) {
                    return Center(child: Text(state.error));
                  }
                  if (state is WordsLoadedState) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 130,
                            child: checkWin
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        answer.join(),
                                        style: const TextStyle(
                                            fontSize: 50,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 5),
                                      )
                                    ],
                                  )
                                : GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 6,
                                            mainAxisSpacing: 15,
                                            crossAxisSpacing: 15),
                                    itemCount: state.answer.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          context.read<WordsBloc>().add(
                                              CancelAnswerLetterEvent(
                                                  index: index));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.white,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              state.answer[index],
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          SizedBox(
                            height: 300,
                            width: 300,
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                for (var image in questionPics[curIndex])
                                  Container(
                                    height: 145,
                                    width: 145,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                    ),
                                    child: Image.asset(
                                      image,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          checkWin
                              ? ElevatedButton(
                                  onPressed: () {
                                    context
                                        .read<WordsBloc>()
                                        .add(NextRoundEvent());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: const Text(
                                    "Next",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 200,
                                  child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 6,
                                      crossAxisSpacing: 15,
                                      mainAxisSpacing: 15,
                                    ),
                                    itemCount: state.letters.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          context
                                              .read<WordsBloc>()
                                              .add(MakeTryEvent(index: index));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              state.letters[index],
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
            );
    });
  }
}
