/*<--------Raw button widget------->*/
import 'dart:ui';

import 'package:flutter/material.dart';

class RawButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final double? borderRadiusValue;
  final Color? backgroundColor;

  const RawButtonWidget({
    Key? key,
    required this.child,
    this.onTap,
    this.borderRadiusValue,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Colors.transparent,
      borderRadius: borderRadiusValue != null
          ? BorderRadius.all(Radius.circular(borderRadiusValue!))
          : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadiusValue != null
            ? BorderRadius.all(Radius.circular(borderRadiusValue!))
            : null,
        child: child,
      ),
    );
  }
}
