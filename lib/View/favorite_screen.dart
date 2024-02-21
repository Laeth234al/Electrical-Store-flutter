import 'package:Electrical/Helper/text_style_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Electrical/Controller/favorite_controller.dart';
import 'package:Electrical/Helper/color_helper.dart';
import 'package:Electrical/Helper/padding_helper.dart';
import 'package:Electrical/View/details_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HelperColor.primaryColor,
      appBar: AppBar(
        backgroundColor: HelperColor.primaryColor,
        elevation: 0.0,
        title: Text(
          'المفضلة',
          style: HelperText.ts18f(),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    HelperColor.primaryColor,
                    HelperColor.blueColor,
                  ],
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: HelperPadding.defaultPadding / 2),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GetBuilder<FavoriteController>(
                      builder: (favoriteController) => favoriteController.favorite.isNotEmpty
                          ? ListView.builder(
                              itemCount: favoriteController.favorite.length,
                              itemBuilder: (context, cardIndex) {
                                return Card(
                                  child: SizedBox(
                                    child: ListTile(
                                      onTap: () {
                                        Get.to(
                                          () => DetailsScreen(
                                            product: favoriteController.favorite[cardIndex],
                                            page: 'favo',
                                          ),
                                        );
                                      },
                                      title: Text(
                                        favoriteController.favorite[cardIndex].title,
                                        overflow: TextOverflow.ellipsis,
                                        style: HelperText.ts14f(),
                                        maxLines: 1,
                                      ),
                                      subtitle: Text(
                                        favoriteController.favorite[cardIndex].subTitle,
                                        overflow: TextOverflow.ellipsis,
                                        style: HelperText.ts12f(),
                                        maxLines: 1,
                                      ),
                                      leading: Hero(
                                        tag: 'favo ${favoriteController.favorite[cardIndex].id}',
                                        child: Image(
                                          image: NetworkImage(favoriteController.favorite[cardIndex].image),
                                        ),
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {
                                          print('remove : ${favoriteController.favorite[cardIndex].title}');
                                          favoriteController.removeFromFavo(favoriteController.favorite[cardIndex]);
                                        },
                                        icon: const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                'القائمة فارغة',
                                style: HelperText.ts18f(),
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
