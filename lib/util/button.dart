import 'package:flutter/material.dart';
import 'text.dart';

enum ButtonTypes { defaultButton, customButton, textButton, outLineButton }

class UTILButton extends StatelessWidget {
  final ButtonTypes btnType;
  final String btnText;
  final bool isDisable;
  final EdgeInsets? padding;
  final Color? btnColor;
  final Color? btnBorderColor;
  final BorderRadiusGeometry? borderRadius;
  final AlignmentGeometry? alignment;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextStyle? textStyle;
  final Color? prefixIconColor;
  final Color? sufixIconColor;
  final double? prefixIconSize;
  final double? sufixIconSize;
  final MainAxisAlignment? customButtonIconAlignment;

  final void Function()? onPressed;
  final void Function()? onLongPress;

  const UTILButton(
      {Key? key,
      required this.btnType,
      required this.btnText,
      this.isDisable = false,
      this.padding,
      this.btnColor,
      this.btnBorderColor,
      this.borderRadius,
      this.alignment,
      this.prefixIcon,
      this.suffixIcon,
      this.prefixIconColor,
      this.sufixIconColor,
      this.prefixIconSize,
      this.sufixIconSize,
      this.textStyle,
      this.customButtonIconAlignment,
      this.onPressed,
      this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (btnType) {
      case ButtonTypes.defaultButton:
        return defaultButton();
      case ButtonTypes.customButton:
        return customButton();
      case ButtonTypes.textButton:
        return textButton();
      case ButtonTypes.outLineButton:
        return outLineButton(context);

      default:
        return defaultButton();
    }
  }

  Widget defaultButton() {
    return ElevatedButton(
      onPressed: (!isDisable) ? onPressed : null,
      onLongPress: (!isDisable) ? onLongPress : null,
      style: ButtonStyle(
        // backgroundColor: MaterialStateProperty.all(Colors.green),
        padding: MaterialStateProperty.all(padding ?? const EdgeInsets.symmetric(horizontal: 30)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: borderRadius ?? BorderRadius.circular(15))),
      ),
      child: UTILText(btnText, style: textStyle),
    );
  }

  Widget customButton() {
    return ElevatedButton(
      onPressed: (!isDisable) ? onPressed : null,
      onLongPress: (!isDisable) ? onLongPress : null,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(padding ?? const EdgeInsets.symmetric(horizontal: 30)),
        backgroundColor: MaterialStateProperty.all(Colors.green),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        alignment: alignment,
      ),
      child: Row(
        mainAxisAlignment: customButtonIconAlignment ?? MainAxisAlignment.spaceEvenly,
        children: [
          if (prefixIcon != null)
            Icon(
              prefixIcon,
              color: prefixIconColor,
              size: prefixIconSize,
            ),
          if (prefixIcon != null && customButtonIconAlignment != null)
            const SizedBox(
              width: 5.0,
            ),
          UTILText(btnText, style: textStyle),
          if (suffixIcon != null)
            Icon(
              suffixIcon,
              color: sufixIconColor,
              size: sufixIconSize,
            ),
        ],
      ),
    );
  }

  Widget textButton() {
    return TextButton(
      onPressed: (!isDisable) ? onPressed : null,
      onLongPress: (!isDisable) ? onLongPress : null,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(padding ?? const EdgeInsets.symmetric(horizontal: 30)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: borderRadius ?? BorderRadius.circular(15))),
        alignment: alignment,
        backgroundColor: MaterialStateProperty.all(btnColor),
      ),
      child: UTILText(btnText, style: textStyle),
    );
  }

  Widget outLineButton(BuildContext context) {
    return OutlinedButton(
      onPressed: (!isDisable) ? onPressed : null,
      onLongPress: (!isDisable) ? onLongPress : null,
      style: OutlinedButton.styleFrom(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 30),
        shape:
            RoundedRectangleBorder(borderRadius: borderRadius ?? BorderRadius.circular(15), side: BorderSide(color: Theme.of(context).primaryColor, width: 2)),
        side: BorderSide(
          width: 1.0,
          color: btnBorderColor ?? Theme.of(context).primaryColor,
          style: BorderStyle.solid,
        ),
      ),
      child: UTILText(btnText, style: textStyle),
    );
  }
}
