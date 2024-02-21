// ignore_for_file: avoid_print
import 'dart:math';
import 'package:get/get.dart';
import 'package:Electrical/Models/product.dart';
import 'package:Electrical/services/storage_service.dart';

class ProductController extends GetxController {
  bool isLoading = false;
  List<Product> _products = [];
  List<Product> filtered = [];

  @override
  Future<void> onReady() async {
    isLoading = true;
    update();
    print('products start');
    _products.addAll(await StorageService.getProducts());
    for (var pro in _products) {
      print('id : ${pro.id}, title : ${pro.title}');
      maxPrice = max<double>(maxPrice, (pro.price ~/ 100 + 1) * 100.0);
    }
    filtered.addAll(_products);
    print('products list lenght : ${_products.length}');
    print('products end');
    isExpanded.addAll(List.filled(_numberOfFilter, false));
    switchValues.addAll(List.filled(_numberOfFilter, false));
    isLoading = false;
    update();
  }

  // filters
  final int _numberOfFilter = 2;

  List<bool> isExpanded = []; // used to animation
  List<bool> switchValues = [];

  void switchOn(int index, bool val) {
    switchValues[index] = val;
    isExpanded[index] = val;
    update();
  }

  void withoutFilter() {
    isLoading = true;
    update();
    filtered.clear();
    filtered.addAll(_products);
    isLoading = false;
    update();
  }

  // Filter by price
  double minPrice = 0.0;
  double maxPrice = -1;
  void addToMaxPriceFilter(double value) {
    if (maxPrice + value >= 0) maxPrice += value;
    if (maxPrice < minPrice) {
      minPrice = (maxPrice ~/ 100) * 100.0;
    }
    update();
  }

  void addToMinPriceFilter(double value) {
    if (minPrice + value >= 0) {
      minPrice += value;
      if (minPrice > maxPrice) {
        maxPrice = minPrice;
      }
    }
    update();
  }

  void filterProductsByPrice() {
    isLoading = true;
    update();
    filtered.clear();
    filtered.addAll(_products);
    filtered = filtered.where((product) => (product.price >= minPrice && product.price <= maxPrice)).toList();
    filtered.forEach(
      (element) {
        print('id : ${element.id}, title: ${element.title}, price: ${element.price}');
      },
    );
    // to check if sorted is on
    if (switchValues[1]) {
      // sorted is on
      sortProductsByPrice();
    } else {
      // sorted is off
      sortProductsByIds();
    }
  }

  // Sort
  bool _ascending = true;
  bool get ascending => _ascending;
  void sortProductsByIds() {
    filtered.sort((a, b) => a.id.compareTo(b.id)); //: b.price.compareTo(a.price));
    isLoading = false;
    update();
  }

  void sortProductsByPrice() {
    filtered.sort((a, b) => _ascending ? a.price.compareTo(b.price) : b.price.compareTo(a.price));
    isLoading = false;
    update();
  }

  void toggelAscending() {
    _ascending = !_ascending;
    update();
  }
}
