import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_api/secendmethod/provider_state.dart';

class MyScreen extends ConsumerWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    Myproduct state = ref.watch(productProvider);

    return Scaffold(
      body: SafeArea(
        child: state is LoadproductState
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  if (state is LoadedproductState) ...[
                    for (int i = 0; i < state.product.length; i++) ...[
                      Text(state.product[i].title.toString())
                    ]
                  ]
                ],
              ),
      ),
    );
  }
}
