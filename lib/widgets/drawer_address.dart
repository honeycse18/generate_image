import 'package:flutter/cupertino.dart';
import 'package:image_api_project/widgets/raw_button.dart';

/*<------- Single drawer menu widget ------>*/
class DrawerMenuSvgWidget extends StatelessWidget {
  final String text;

  final void Function()? onTap;
  const DrawerMenuSvgWidget({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                text,
              ),
            ),
          ],
        ));
  }
}

/*<------- Single drawer menu widget ------>*/
class DrawerMenuPngWidget extends StatelessWidget {
  final String text;

  final void Function()? onTap;
  const DrawerMenuPngWidget({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                text,
              ),
            ),
          ],
        ));
  }
}
