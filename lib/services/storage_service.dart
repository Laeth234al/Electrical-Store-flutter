// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:Electrical/Models/cart.dart';
import 'package:Electrical/Models/product.dart';

class StorageService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static String get _uid => FirebaseAuth.instance.currentUser!.uid;

  static Future<void> setAsRole({required String uid, required String role}) async {
    await _firestore.collection('users').doc(uid).set(
      {
        'role': role,
      },
      SetOptions(merge: true),
    );
  }

  static Future<List<Product>> getProducts() async {
    print(11);
    List<Product> result = [];
    await _firestore.collection('products').get().then((snap) {
      for (var snapshot in snap.docs) {
        //print('${snapshot.id} : ${snapshot.data()}');
        result.add(Product.fromJson({...snapshot.data(), 'id': snapshot.id}));
      }
    });
    Reference storage = _storage.ref();
    storage.child('product images/airpod.png').getData();
    print(12);
    return result;
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    List<Map<String, dynamic>> result = [];
    await _firestore.collection('users').get().then((snap) {
      for (var snapshot in snap.docs) {
        result.add(
          {
            'uid': snapshot.id,
            'email': snapshot['email'],
            'role': snapshot['role'],
            'username': snapshot['username'],
          },
        );
      }
    });
    return result;
  }

  static Future<String?> uploadImage(File image) async {
    final String ref = 'product images/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final UploadTask uploadTask = _storage.ref(ref).putFile(image, SettableMetadata(contentType: 'image/jpg'));
    final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
    if (snapshot.state == TaskState.success) {
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    }
    return null;
  }

  static Future<String> uploadProductData({
    required String title,
    required String subTitle,
    required String description,
    required List<String> tags,
    required double price,
    required File image,
  }) async {
    String? imageUrl = await uploadImage(image);
    try {
      if (imageUrl != null) {
        var db = _firestore.collection('products');
        DocumentReference<Map<String, dynamic>> d = await db.add(Product(
          id: 'd',
          description: description,
          tags: tags,
          image: imageUrl,
          price: price,
          subTitle: subTitle,
          title: title,
        ).toJson());
        await d.get().then((value) {
          print('value : $value');
        });
        return 'done';
      }
    } catch (e) {
      print('Error : $e');
      return e.toString();
    }
    return 'not-valid';
  }

  static Future<void> uploadFavorites(List<Product> favoriteProduct) async {
    print('List of favo Ids : ${favoriteProduct.map((e) => e.id).toList()}');
    try {
      await _firestore.collection('users').doc(_uid).set({
        'favorites': favoriteProduct.map((e) => e.id).toList(),
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error uploading favorites: $e');
    }
  }

  static Future<void> uploadCart(List<Cart> carts) async {
    var f = carts.map((item) => {'id': item.product.id, 'quantity': item.quantity}).toList();
    print('List of cart : $f');
    try {
      List<Map<String, dynamic>> cartData = carts.map((item) {
        return {
          'id': item.product.id,
          'quantity': item.quantity,
        };
      }).toList();
      await _firestore.collection('users').doc(_uid).set({
        'cart': cartData,
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error uploading cart: $e');
    }
  }

  static Future<List<Cart>> get getCartProducts async {
    try {
      var snapshot = await _firestore.collection('users').doc(_uid).get();
      List<Cart> cartItems = [];
      if (snapshot.exists) {
        var cartData = snapshot.data()!['cart'];
        for (var item in cartData) {
          var productSnapshot = await _firestore.collection('products').doc(item['id']).get();
          print('productSnapshot.id : ${productSnapshot.id}');
          Product product = Product.fromJson({
            ...productSnapshot.data()!,
            'id': productSnapshot.id,
          });
          cartItems.add(Cart.fromJson2({
            'quantity': item['quantity'],
            'Product': product,
          }));
        }
      }
      print('get Cart Products DONE');
      return cartItems;
    } catch (e) {
      print('Error fetching cart items: $e');
      return [];
    }
  }

  static Future<List<Product>> get getFavoritesProducts async {
    var favoList = <Product>[];
    var favoListIds = await FirebaseFirestore.instance.collection('users').doc(_uid).get().then(
          (value) => value['favorites'],
        );
    print('favorites : ');
    print(favoListIds);
    var snapshot = await FirebaseFirestore.instance.collection('products').where(FieldPath.documentId, whereIn: favoListIds).get();
    favoList = snapshot.docs
        .map((doc) => Product.fromJson({
              ...doc.data(),
              'id': doc.id,
            }))
        .toList();
    return favoList;
  }

  // unused function in code just for upload data faster

  static Future<void> storeUserProducts(List<Product> pro) async {
    // final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
    final List<String> productsData = pro.map((proo) => proo.id).toList();
    print('data : ${productsData}');
    // await usersCollection.doc(_uid).set({
    //   'favorites': productsData,
    // }, SetOptions(merge: true));
  }

  static Future<void> uploadDataToFirestoreFromJsonFile(BuildContext context) async {
    // Parse JSON data
    String jsonData = await DefaultAssetBundle.of(context).loadString('assets/data.json');
    print(111);
    Map<String, dynamic> data = jsonDecode(jsonData);
    print(1);
    List<dynamic> products = data['products'];
    // Reference to Firestore collection
    CollectionReference productsCollection = _firestore.collection('products');

    // Upload each product to Firestore
    products.forEach((product) {
      print('${Product.fromJson(product).toJson()}');
      productsCollection.add(Product.fromJson(product).toJson());
    });

    print("Data uploaded successfully!");
  }
}
