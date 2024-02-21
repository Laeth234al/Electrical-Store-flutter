import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Electrical/services/auth_service.dart';
import 'package:Electrical/services/storage_service.dart';

class UserController extends GetxController {
  TextEditingController passwordOfManger = TextEditingController();
  var users = <Map<String, dynamic>>[];
  List<String> roles = <String>[];
  var isExpanded = <bool>[];
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _changeLoading() {
    _isLoading = !_isLoading;
    update();
  }

  @override
  void onInit() async {
    _changeLoading();
    users = await StorageService.getUsers();
    isExpanded = List.generate(users.length, (_) => false);
    roles = users.map((e) => e['role'].toString()).toList();
    print(isExpanded);
    _changeLoading();
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

  Future<void> setUserAs({required String role, required String uid}) async {
    _changeLoading();
    await StorageService.setAsRole(role: role, uid: uid);
    _changeLoading();
    update();
  }

  Future<bool> checkIfHeManger() async {
    _changeLoading();
    var connection = await AuthServic.checkIfHeManger(password: passwordOfManger.text);
    _changeLoading();
    return connection;
  }
}
