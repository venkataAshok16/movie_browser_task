import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UTILTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? lableText;
  final String? errorText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isDisable;
  final bool isTextHide;
  final bool isAutoFocus;
  final bool isDensity;
  final bool isUnderLineTextFiled;
  final Widget? suffixWidget;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final Color? filledColor;
  final int maxLines;
  final int errorMaxLines;
  final TextInputType? keyboardType;
  final TextAlignVertical? textAlignVertical;
  final TextAlign textAlign;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? style;
  final void Function()? suffixIconResponse;
  final void Function(String)? onEnter;
  final void Function(String)? onChange;

  const UTILTextField(
      {Key? key,
      required this.controller,
      this.hintText,
      this.lableText,
      this.errorText,
      this.prefixIcon,
      this.suffixIcon,
      this.isDisable = false,
      this.isTextHide = false,
      this.isAutoFocus = false,
      this.isDensity = false,
      this.isUnderLineTextFiled = false,
      this.suffixWidget,
      this.prefixIconColor,
      this.suffixIconColor,
      this.filledColor,
      this.maxLines = 1,
      this.errorMaxLines = 1,
      this.keyboardType,
      this.textAlignVertical,
      this.textAlign = TextAlign.start,
      this.textInputAction,
      this.contentPadding,
      this.inputFormatters,
      this.style,
      this.suffixIconResponse,
      this.onEnter,
      this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: style,
      controller: controller,
      obscureText: isTextHide,
      readOnly: isDisable,
      autofocus: isAutoFocus,
      onChanged: onChange,
      maxLines: maxLines,
      decoration: defaultDecoration(context),
      onFieldSubmitted: onEnter,
      keyboardType: keyboardType,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: textInputAction,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      inputFormatters: inputFormatters,
    );
  }

  InputDecoration defaultDecoration(BuildContext context) {
    return InputDecoration(
      filled: (filledColor != null) ? true : false,
      fillColor: filledColor,
      hintStyle: style,
      contentPadding: contentPadding,
      enabledBorder:
          isUnderLineTextFiled ? null : OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.grey.shade300)),
      labelText: lableText,
      hintText: hintText,
      errorText: (errorText == "") ? null : errorText,
      errorMaxLines: errorMaxLines,
      prefixIcon: (prefixIcon == null) ? null : Icon(prefixIcon, color: prefixIconColor),
      suffixIcon: suffixIconWidget(),
      border: isUnderLineTextFiled
          ? null
          : OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
      focusedBorder: isUnderLineTextFiled
          ? null
          : OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1),
            ),
    );
  }

  Widget? suffixIconWidget() {
    if (suffixWidget != null) {
      return suffixWidget!;
    } else if (suffixIcon != null) {
      return IconButton(
        onPressed: () {
          suffixIconResponse!();
        },
        icon: Icon(
          suffixIcon,
          color: suffixIconColor,
        ),
      );
    } else {
      return null;
    }
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class CardExpirationFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueString = newValue.text;
    String valueToReturn = '';

    for (int i = 0; i < newValueString.length; i++) {
      if (newValueString[i] != '/') valueToReturn += newValueString[i];
      var nonZeroIndex = i + 1;
      final contains = valueToReturn.contains(RegExp(r'\/'));
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newValueString.length && !(contains)) {
        valueToReturn += '/';
      }
    }
    return newValue.copyWith(
      text: valueToReturn,
      selection: TextSelection.fromPosition(
        TextPosition(offset: valueToReturn.length),
      ),
    );
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var inputText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}
