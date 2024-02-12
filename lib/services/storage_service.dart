import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store_app/Models/product.dart';

class StorageService {
  static Future<List<Product>> getProducts() async {
    print(11);
    List<Product> result = [];
    //QuerySnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection('products').get().then((snap) {
      for (var snapshot in snap.docs) {
        print('${snapshot.id} : ${snapshot.data()}');
        result.add(Product.fromJson(snapshot.data()));
      }
    });
    print(12);
    return result;
  }
}
