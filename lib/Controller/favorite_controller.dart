import 'package:get/get.dart';
import 'package:store_app/Models/product.dart';

class FavoriteController extends GetxController {
  List<Product> favorite = [
    // ...List.generate(
    //   20,
    //   (index) => Product(
    //     id: index.toString(),
    //     price: 100.0 * index,
    //     title: 'title $index',
    //     subTitle: 'subTitle $index',
    //     description: 'description $index',
    //     image: 'image $index',
    //     tags: [],
    //   ),
    // ),
  ];
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
  void addToFavo(Product product) {
    favorite.add(product);
    update();
  }

  // remove form
  void removeFromFavo(Product product) {
    favorite.remove(product);
    update();
  }
}
