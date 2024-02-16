import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/services/auth_service.dart';
import 'package:store_app/services/storage_service.dart';

class UserController extends GetxController {
  TextEditingController passwordOfManger = TextEditingController();

  var users = <Map<String, dynamic>>[
    // {'uid': '1', 'username': 'laeht 1', 'email': 'email11@gmail.com', 'role': 'manger'},
    // {'uid': '2', 'username': 'laeht 2', 'email': 'email22@gmail.com', 'role': 'admin'},
    // {'uid': '3', 'username': 'laeht 3', 'email': 'email33@gmail.com', 'role': 'admin'},
    // {'uid': '4', 'username': 'laeht 4', 'email': 'email44@gmail.com', 'role': 'user'},
    // {'uid': '5', 'username': 'laeht 5', 'email': 'email55@gmail.com', 'role': 'user'},
    // {'uid': '6', 'username': 'laeht 6', 'email': 'email66@gmail.com', 'role': 'user'},
    // {'uid': '7', 'username': 'laeht 7', 'email': 'email77@gmail.com', 'role': 'user'},
    // {'uid': '8', 'username': 'laeht 8', 'email': 'email88@gmail.com', 'role': 'user'},
    // {'uid': '9', 'username': 'laeht 9', 'email': 'email99@gmail.com', 'role': 'user'},
    // {'uid': '10', 'username': 'laeht 10', 'email': 'email1010@gmail.com', 'role': 'user'},
  ];

  List<String> roles = <String>[];

  var isExpanded = <bool>[];

  bool isLoading = false;

  void changeLoading() {
    isLoading = !isLoading;
    update();
  }

  @override
  void onInit() async {
    // get data and put in users list
    // then
    changeLoading();
    users = await StorageService.getUsers();
    isExpanded = List.generate(users.length, (_) => false);
    roles = users.map((e) => e['role'].toString()).toList();
    print(isExpanded);
    changeLoading();
    super.onInit();
  }

  var lastIndex = -1;

  void toggleExpansion(int index) {
    if (lastIndex == -1) {
      isExpanded[index] = (!isExpanded[index]);
    } else if (lastIndex == index) {
      isExpanded[index] = (!isExpanded[index]);
    } else {
      isExpanded[lastIndex] = false;
      isExpanded[index] = (!isExpanded[index]);
    }
    print('last : $lastIndex');
    lastIndex = index;
    print('index : $index');
    update();
  }

  void toggleRoles({required int index, required String role}) {
    // edit from firestore
    users[index]['role'] = role;
    roles[index] = role;
    update();
  }

  void setUserAs({required String role, required String uid}) async {
    await StorageService.setAsRole(role: role, uid: uid);
    update();
  }

  Future<bool> checkIfHeManger() async {
    return await AuthServic.checkIfHeManger(password: passwordOfManger.text);
  }
}
