import 'package:early_warning_system/adapter/helper.dart';
import 'package:flutter/material.dart';

class BackgroundView extends StatelessWidget {
  const BackgroundView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: size.width,
          height: (size.height * 0.20) + 50,
          decoration: BoxDecoration(
            color: kPrimaryColor,
          ),
        ),
        Expanded(child: Container())
      ],
    );
  }
}
