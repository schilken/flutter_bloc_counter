import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore_for_file:avoid_print

class GlobalBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('Error in Bloc (${bloc.runtimeType}): $error, $stackTrace');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      print('${bloc.runtimeType}: $transition');
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      print('${bloc.runtimeType}: $change');
    }
  }
}
