import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

enum Connection { Available, Unavailable }

class ConnectivityStatusCubit extends Cubit<Connection> {
  final Connectivity connectivity;
  late StreamSubscription _connectivityListener;

  ConnectivityStatusCubit()
      : connectivity = Connectivity(),
        super(Connection.Available) {
    _connectivityListener = _onConnectivityChangedListener();
    _setInitialConnectivity();
  }

  StreamSubscription _onConnectivityChangedListener() {
    return connectivity.onConnectivityChanged.listen(
      (event) {
        print('_onConnectivityChangedListener: $event');
        emit(
          event == ConnectivityResult.none
              ? Connection.Unavailable
              : Connection.Available,
        );
      },
    );
  }

  void _setInitialConnectivity() {
    connectivity.checkConnectivity().then(
      (event) {
        print('_setInitialConnectivity: $event');
        emit(
          event == ConnectivityResult.none
              ? Connection.Unavailable
              : Connection.Available,
        );
      },
    );
  }

  @override
  Future<void> close() async {
    await _connectivityListener.cancel();
    return super.close();
  }
}
