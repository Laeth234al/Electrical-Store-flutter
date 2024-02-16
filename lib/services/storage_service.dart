import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/Models/product.dart';

class StorageService {
  static Future<void> setAsRole({required String uid, required String role}) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set(
      {
        'role': role,
      },
      SetOptions(merge: true),
    );
  }

  static Future<List<Product>> getProducts() async {
    print(11);
    List<Product> result = [];
    //QuerySnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection('products').get().then((snap) {
      for (var snapshot in snap.docs) {
        print('${snapshot.id} : ${snapshot.data()}');
        result.add(Product.fromJson({...snapshot.data(), 'id': snapshot.id}));
      }
    });
    Reference storage = await FirebaseStorage.instance.ref();
    storage.child('product images/airpod.png').getData(); // NOOOOO
    print(12);
    return result;
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    List<Map<String, dynamic>> result = [];
    await FirebaseFirestore.instance.collection('users').get().then((snap) {
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
    final FirebaseStorage storage = FirebaseStorage.instance;
    final String ref = 'product images/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final UploadTask uploadTask = storage.ref(ref).putFile(image, SettableMetadata(contentType: 'image/jpg'));
    final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
    if (snapshot.state == TaskState.success) {
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    }
    return null;
  }

  static Future<void> uploadProductData({
    required String title,
    required String subTitle,
    required String description,
    required List<String> tags,
    required double price,
    required File image,
  }) async {
    String? imageUrl = await uploadImage(image);
    if (imageUrl != null) {
      //
      var db = FirebaseFirestore.instance.collection('products');
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
    }
  }

  // static Future<void> uploadDataToFirestore(BuildContext context) async {
  //   // Parse JSON data
  //   String jsonData = await DefaultAssetBundle.of(context).loadString('assets/data.json');
  //   print(111);
  //   Map<String, dynamic> data = jsonDecode(jsonData);
  //   print(1);
  //   List<dynamic> products = data['products'];
  //   // Reference to Firestore collection
  //   CollectionReference productsCollection = FirebaseFirestore.instance.collection('products');

  //   // Upload each product to Firestore
  //   products.forEach((product) {
  //     print('${Product.fromJson(product).toJson()}');
  //     productsCollection.add(Product.fromJson(product).toJson());
  //   });

  //   print("Data uploaded successfully!");
  // }
}
