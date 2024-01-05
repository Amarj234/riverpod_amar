import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_api/model/product_model.dart';
import 'package:riverpod_api/secendmethod/api_call.dart';

final productProvider = StateNotifierProvider<ProductNotifire, Myproduct>(
  (ref) => ProductNotifire(),
);

final tring = StateProvider<String>((ref) => "amar");

abstract class Myproduct {}

class InitialproductState extends Myproduct {}

class LoadproductState extends Myproduct {}

class LoadedproductState extends Myproduct {
  LoadedproductState({required this.product, this.title = 'frist'});
  List<ProductModel> product;
  String? title;
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
    try {
      state = LoadproductState();
      final res = await ApiCall().getApi();
      List data = res?.data;
      List<ProductModel> product = [];
      for (var dat in data) {
        ProductModel dataa = ProductModel.fromJson(dat);
        product.add(dataa);
      }
      state = LoadedproductState(product: product);
    } catch (e) {
      state = ErrorproductState(err: '$e');
      rethrow;
    }
  }

  changeAppbar(WidgetRef ref, String title) {
    ref.read(tring.notifier).state = title;
  }

  changeColor(num id) {
    Myproduct pro = state;
    if (pro is LoadedproductState) {
      int index = pro.product.indexWhere((item) => item.id == id);
      pro.product[index].isFav = !pro.product[index].isFav;
      state = LoadedproductState(product: pro.product, title: pro.product[index].title);
    }
  }
}
