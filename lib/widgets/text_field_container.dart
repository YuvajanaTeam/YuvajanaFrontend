import 'package:flutter/material.dart';

import '../config/size_config.dart';
import '../providers/constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: SizeConfig.safeBlockVertical * 2.5,
        horizontal: SizeConfig.safeBlockVertical * 3.5,
      ),
      width: SizeConfig.blockSizeHorizontal * 50,
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockSizeHorizontal * 1.8,
        vertical: SizeConfig.blockSizeVertical * 0.8,
      ),
      decoration: BoxDecoration(
        color: textFieldColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: child,
    );
  }
}
