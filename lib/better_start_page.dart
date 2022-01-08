import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_counter/cubit/connectivity_status_cubit.dart';
import 'package:flutter_bloc_counter/cubit/counter_cubit.dart';

class BetterStartPage extends StatefulWidget {
  const BetterStartPage({
    Key? key,
    required this.title,
    required this.connectivityStatusCubit,
  }) : super(key: key);

  final String title;
  final ConnectivityStatusCubit connectivityStatusCubit;

  @override
  State<BetterStartPage> createState() => _BetterStartPageState();
}

class _BetterStartPageState extends State<BetterStartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocProvider(
              create: (context) => widget.connectivityStatusCubit,
              child: BlocBuilder<ConnectivityStatusCubit, Connection>(
                builder: (context, connection) {
                  // ignore: avoid_print
                  print('builder: $connection');
                  return BlocBuilder<CounterCubit, CounterState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          if (connection != Connection.Available)
                            Text(
                              'You are offline!',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                              ),
                            ),
                          SizedBox(height: 32),
                          Text(
                            connection.toString(),
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          SizedBox(height: 32),
                          Text(
                            state.counterValue.toString(),
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<CounterCubit>(context).increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
