import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:provider_test/src/components/view_count.dart';
import 'package:provider_test/src/provider/count_provider.dart';

class CountHomeWidget extends StatelessWidget {
  CountHomeWidget({Key? key}) : super(key: key);
  late CounterProvider countProvider;

  @override
  Widget build(BuildContext context) {
    countProvider = Provider.of<CounterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counting Provider"),
      ),
      body: const CountView(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => countProvider.add(),
          ),
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () => countProvider.subtract(),
          ),
        ],
      ),
    );
  }
}