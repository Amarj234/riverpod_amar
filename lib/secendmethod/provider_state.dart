import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_api/features/products/data/model/product_model.dart';

import 'api_call.dart';

final productProvider = StateNotifierProvider<ProductNotifire, Myproduct>(
  (ref) => ProductNotifire(),
);

abstract class Myproduct {}

class InitialproductState extends Myproduct {}

class LoadproductState extends Myproduct {}

class LoadedproductState extends Myproduct {
  LoadedproductState({required this.product});
  final List<ProductModel> product;
}

class ErrorproductState extends Myproduct {
  ErrorproductState({required this.err});
  final String err;
}

class ProductNotifire extends StateNotifier<Myproduct> {
  ProductNotifire() : super(InitialproductState()) {
    fetchProductsApiRequest();
  }

  Future fetchProductsApiRequest() async {
    print("pageload");
    try {
      state = LoadproductState();
      final res = await ApiCall().getApi();
      log("pageload2 $res");
      List data = res?.data;
      List<ProductModel> product = [];

      for (var dat in data) {
        ProductModel dataa = ProductModel.fromJson(dat);
        product.add(dataa);
      }

      state = LoadedproductState(product: product);

      // state=
    } catch (e) {
      state = ErrorproductState(err: "$e");
      rethrow;
    }
  }

  changeColor() {}
}
