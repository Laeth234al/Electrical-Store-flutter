import 'package:flutter/material.dart';
import 'package:Electrical/Helper/color_helper.dart';
import 'package:Electrical/Helper/padding_helper.dart';
import 'package:Electrical/Helper/text_style_helper.dart';
import 'package:Electrical/Widget/settingPage/switch_filter_onprice.dart';
import 'package:Electrical/Widget/settingPage/switch_sort_list.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: HelperColor.primaryColor,
        title: const Text(
          'الأعدادات',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
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
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'الفلترة : ',
                            style: HelperText.ts18f(),
                          ),
                          Expanded(
                            child: ListView(
                              children: const [
                                SizedBox(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: FilterProductOnPrice(),
                                  ),
                                ),
                                SizedBox(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: SortProductList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
