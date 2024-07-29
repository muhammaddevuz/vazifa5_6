import 'package:dars_5_3_getx/blocs/words_bloc/words_bloc.dart';
import 'package:dars_5_3_getx/ui/screens/words_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WordsBloc(),
      child: MaterialApp(
        home: WordsScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
