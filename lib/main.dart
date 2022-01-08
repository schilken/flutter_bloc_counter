import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_counter/better_start_page.dart';
import 'package:flutter_bloc_counter/cubit/connectivity_status_cubit.dart';
import 'package:flutter_bloc_counter/start_page.dart';
import 'cubit/counter_cubit.dart';

void main() {
//  runApp(const MiniBlocApp());
  runApp(const BetterMiniBlocApp());
}

class MiniBlocApp extends StatelessWidget {
  const MiniBlocApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'MiniBlocCounter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const StartPage(title: 'Minimal Bloc App'),
      ),
    );
  }
}

class BetterMiniBlocApp extends StatelessWidget {
  const BetterMiniBlocApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'MiniBlocCounter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BetterStartPage(
          title: 'Better Minimal Bloc App',
          connectivityStatusCubit: ConnectivityStatusCubit(),
        ),
      ),
    );
  }
}
