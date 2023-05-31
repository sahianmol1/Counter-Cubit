import 'package:cubit_counter/cubits/counter/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'OtherPAge.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Cubit Counter',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CounterCubit, CounterState>(
      listener: (context, state) {
        if (state.counter == 3) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text("Current state is: ${state.counter}"),
                );
              });
        } else if (state.counter == -1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const OtherPage();
              },
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Cubit Counter"),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  // We can use any of the below approach

                  // BlocProvider.of<CounterCubit>(context).decrement();
                  context.read<CounterCubit>().decrement();
                },
                child: const Icon(Icons.remove),
              ),
              const SizedBox(
                width: 16,
              ),
              FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<CounterCubit>(context).increment();
                },
                child: const Icon(Icons.add),
              ),
            ],
          ),
          body: Center(
              child: Text(
            '${state.counter}',
            style: const TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.bold,
            ),
          )),
        );
      },
    );
  }
}
