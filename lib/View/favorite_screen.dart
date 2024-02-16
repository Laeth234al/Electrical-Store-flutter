import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/Controller/favorite_controller.dart';
import 'package:store_app/Helper/color_helper.dart';
import 'package:store_app/Helper/padding_helper.dart';

// TODO: REWRITE THIS PAGE

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;

    // /*24 is for notification bar on Android*/
    // final double itemHeight = (size.width) / 2 + 70;
    // final double itemWidth = size.width / 2;
    return Scaffold(
      backgroundColor: HelperColor.primaryColor,
      appBar: AppBar(
        backgroundColor: HelperColor.primaryColor,
        elevation: 0.0,
        title: const Text(
          'المفضلة',
        ),
        centerTitle: true,
      ),
      // body: SafeArea(
      //   bottom: false,
      //   child: Stack(
      //     children: [
      //       Container(
      //         decoration: const BoxDecoration(
      //           gradient: LinearGradient(
      //             begin: Alignment.topCenter,
      //             end: Alignment.bottomCenter,
      //             colors: [
      //               HelperColor.primaryColor,
      //               HelperColor.blueColor,
      //             ],
      //           ),
      //         ),
      //       ),
      //       Column(
      //         children: [
      //           const SizedBox(height: HelperPadding.defaultPadding / 2),
      //           Expanded(
      //             child: Padding(
      //               padding: const EdgeInsets.all(8.0),
      //               child: GetBuilder<FavoriteController>(
      //                 builder: (favoriteController) => favoriteController.favorite.isNotEmpty
      //                     ? GridView.builder(
      //                         itemCount: favoriteController.favorite.length,
      //                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //                           crossAxisCount: 2,
      //                           crossAxisSpacing: 15.0,
      //                           mainAxisSpacing: 15.0,
      //                           childAspectRatio: 3 / 4,
      //                         ),
      //                         itemBuilder: (context, cardIndex) {
      //                           return Stack(
      //                             children: [
      //                               Padding(
      //                                 padding: const EdgeInsets.only(top: HelperPadding.defaultPadding * 2),
      //                                 child: Container(
      //                                   decoration: BoxDecoration(
      //                                     color: HelperColor.backgroundColor,
      //                                     borderRadius: BorderRadius.circular(10.0),
      //                                     boxShadow: const [
      //                                       BoxShadow(
      //                                         offset: Offset(0.0, 15.0),
      //                                         blurRadius: 25.0,
      //                                         color: Colors.black26,
      //                                       ),
      //                                     ],
      //                                   ),
      //                                 ),
      //                               ),
      //                               Container(
      //                                 padding: const EdgeInsets.symmetric(horizontal: HelperPadding.defaultPadding),
      //                                 height: 144.0,
      //                                 width: 180.0,
      //                                 child: favoriteController.favorite[cardIndex].image.startsWith('https://')
      //                                     ? Image.network(
      //                                         favoriteController.favorite[cardIndex].image,
      //                                         fit: BoxFit.cover,
      //                                       )
      //                                     : Image.asset(
      //                                         favoriteController.favorite[cardIndex].image,
      //                                         fit: BoxFit.cover,
      //                                       ),
      //                                 // Image.asset(
      //                                 //   favoriteController.favorite[cardIndex].image,
      //                                 //   fit: BoxFit.cover,
      //                                 // ),
      //                               ),
      //                               Positioned(
      //                                 bottom: 0.0,
      //                                 child: Container(
      //                                   height: 80.0,
      //                                   // width: itemWidth - 15,
      //                                   decoration: BoxDecoration(
      //                                     gradient: const LinearGradient(
      //                                       colors: [
      //                                         HelperColor.primaryColor,
      //                                         HelperColor.blueColor,
      //                                       ],
      //                                     ),
      //                                     border: Border.all(width: 1.0),
      //                                     borderRadius: const BorderRadius.only(
      //                                       bottomLeft: Radius.circular(10.0),
      //                                       bottomRight: Radius.circular(10.0),
      //                                     ),
      //                                   ),
      //                                   child: Row(
      //                                     mainAxisAlignment: MainAxisAlignment.center,
      //                                     // mainAxisSize: MainAxisSize.min,
      //                                     children: [
      //                                       Text(
      //                                         favoriteController.favorite[cardIndex].title,
      //                                         maxLines: 1,
      //                                         overflow: TextOverflow.ellipsis,
      //                                       ),
      //                                       IconButton(
      //                                         onPressed: () {
      //                                           print('remove');
      //                                           favoriteController.removeFromFavo(favoriteController.favorite[cardIndex]);
      //                                         },
      //                                         icon: const Icon(
      //                                           Icons.favorite,
      //                                           color: Colors.red,
      //                                         ),
      //                                       ),
      //                                     ],
      //                                   ),
      //                                 ),
      //                               ),
      //                             ],
      //                           );
      //                         },
      //                       )
      //                     : const Center(
      //                         child: Text(
      //                           'القائمة فارغة',
      //                           style: TextStyle(fontSize: 24.0),
      //                         ),
      //                       ),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
