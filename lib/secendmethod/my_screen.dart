import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_api/secendmethod/provider_state.dart';

class MyScreen extends ConsumerWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    Myproduct state = ref.watch(productProvider);
    String statn = ref.watch(tring);

    return Scaffold(
      appBar: AppBar(
        title: Text('$statn '),
      ),
      body: SafeArea(
        child: state is LoadproductState
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is LoadedproductState) ...[
                      for (int i = 0; i < state.product.length; i++) ...[
                        ListTile(
                          onTap: () {
                            ref
                                .read(productProvider.notifier)
                                .changeAppbar(ref, state.product[i].title!);
                          },
                          title: Text(state.product[i].title.toString()),
                          leading: Text(state.product[i].id.toString()),
                          trailing: InkWell(
                            onTap: () {
                              ref.read(productProvider.notifier).changeColor(state.product[i].id!);
                            },
                            child: Icon(
                              Icons.heart_broken_rounded,
                              color: state.product[i].isFav ? Colors.red : Colors.yellow,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ],
                ),
              ),
      ),
    );
  }
}
