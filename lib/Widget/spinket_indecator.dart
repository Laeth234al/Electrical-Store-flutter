import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Electrical/Helper/color_helper.dart';

class SpinIndecator extends StatelessWidget {
  const SpinIndecator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitDoubleBounce(
        size: 40.0,
        color: HelperColor.primaryColor,
      ),
    );
  }
}
