import 'package:flutter/material.dart';
import 'text.dart';

class DropDownModal {
  DropDownDataModal selectedName;
  List<DropDownDataModal> data = [];

  DropDownModal(this.selectedName, this.data);
}

class DropDownDataModal {
  dynamic id;
  String name;

  DropDownDataModal(this.id, this.name);
}

class UTILDropdownButton extends StatelessWidget {
  final DropDownDataModal selectedName;
  final List<DropDownDataModal> data;
  final Color? bgColor;
  final bool isCenter;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  final Decoration? decoration;
  final void Function(DropDownDataModal)? callBack;

  const UTILDropdownButton(
      {Key? key,
      required this.selectedName,
      required this.data,
      required this.callBack,
      this.bgColor,
      this.decoration,
      this.prefixIcon,
      this.prefixIconColor,
      this.suffixIcon,
      this.suffixIconColor,
      this.isCenter = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          // height: 40,
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          decoration: decoration ??
              BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Theme.of(context).primaryColorLight)), //  color: Theme.of(context).backgroundColor,
          child: Row(
            children: [
              if (prefixIcon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Icon(
                    prefixIcon,
                    color: prefixIconColor,
                  ),
                ),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<DropDownDataModal>(
                    value: selectedName,
                    dropdownColor: (Theme.of(context).brightness == Brightness.dark) ? Colors.white38 : null,
                    iconEnabledColor: Theme.of(context).primaryColor,
                    icon: Icon(
                      suffixIcon,
                      color: suffixIconColor ?? ((Theme.of(context).brightness == Brightness.light) ? Colors.black : Colors.white),
                    ),
                    items: data.map((DropDownDataModal modal) {
                      return DropdownMenuItem<DropDownDataModal>(
                        value: modal,
                        child: Container(alignment: (isCenter) ? Alignment.center : Alignment.centerLeft, child: UTILText(modal.name)),
                      );
                    }).toList(),
                    onChanged: (DropDownDataModal? newValue) {
                      if (newValue != null) {
                        callBack!(newValue);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
