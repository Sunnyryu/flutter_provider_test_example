import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/src/provider/count_provider.dart';

class CountView extends StatelessWidget {
  const CountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        Provider.of<CounterProvider>(context).count.toString(),
      ),
    );
    // return Center(
    //   child: Consumer<CounterProvider>(builder: (context, provider, child) {
    //     return Text(
    //       provider.count.toString(),
    //     );
    //   }),
    // );
  }}