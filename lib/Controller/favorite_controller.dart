import 'package:get/get.dart';
import 'package:Electrical/Models/product.dart';
import 'package:Electrical/services/storage_service.dart';

class FavoriteController extends GetxController {
  List<Product> favorite = [];

  bool _isLoading = false;

  @override
  void onInit() async {
    super.onInit();
    _toggleLoading();
    favorite = await StorageService.getFavoritesProducts;
    _toggleLoading();
    update();
  }

  bool get isLoading => _isLoading;

  void _toggleLoading() {
    _isLoading = !_isLoading;
    update();
  }

  // is add before
  bool isAddIn(String productId) {
    for (var product in favorite) {
      if (product.id == productId) {
        print('added before');
        return true;
      }
    }
    print('not in');
    return false;
  }

  // add in
  void addToFavo(Product product) async {
    _toggleLoading();
    favorite.add(product);
    // add to firestore
    await StorageService.uploadFavorites(favorite);
    _toggleLoading();
  }

  // remove form
  void removeFromFavo(Product product) async {
    _toggleLoading();
    favorite.remove(
      favorite.firstWhere((element) => element.id == product.id),
    );
    // remove from firestore
    await StorageService.uploadFavorites(favorite);
    _toggleLoading();
  }
}
