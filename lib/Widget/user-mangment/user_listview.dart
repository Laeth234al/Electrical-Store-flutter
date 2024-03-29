import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Electrical/Controller/users_controller.dart';
import 'package:Electrical/Helper/text_style_helper.dart';
import 'package:Electrical/Widget/spinket_indecator.dart';
import 'package:Electrical/Widget/user-mangment/role_choese.dart';

class ViewUserList extends StatelessWidget {
  const ViewUserList({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (userController) => userController.isLoading
          ? const SpinIndecator()
          : ListView.builder(
              itemCount: userController.users.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    userController.toggleExpansion(index);
                  },
                  child: Card(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: userController.isExpanded[index] ? 200.0 : 70.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  'أسم المستخدم : ${userController.users[index]['username']}',
                                  style: HelperText.ts14f(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Expanded(
                              child: Center(
                                child: Text(
                                  'المنصب : ${userController.users[index]['role']}', // change after set as role and accepet on set to
                                  style: HelperText.ts12f(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            if (userController.isExpanded[index])
                              Expanded(
                                flex: 3,
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        'البريد : ${userController.users[index]['email']}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                      RoleChoese(
                                        index: index,
                                        value: 'user',
                                        username: userController.users[index]['username'],
                                        uid: userController.users[index]['uid'],
                                      ),
                                      RoleChoese(
                                        index: index,
                                        value: 'admin',
                                        username: userController.users[index]['username'],
                                        uid: userController.users[index]['uid'],
                                      ),
                                      RoleChoese(
                                        index: index,
                                        value: 'manger',
                                        username: userController.users[index]['username'],
                                        uid: userController.users[index]['uid'],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
