import 'package:bloc_tutorial/bloc.dart';
import 'package:flutter/material.dart';
import 'package:bloc_tutorial/homepage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => PersonsBloc(),
        child: const HomePage(),
      ),
    );
  }
}
