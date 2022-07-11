import 'package:flutter/material.dart';
import 'package:fvm/Util/AppTheme.dart';

class DropDownCustom extends StatefulWidget {
  var customAppTheme;
  var themeData;
  final Function onSelect;

  DropDownCustom(
      {super.key,
      required this.customAppTheme,
      required this.themeData,
      required this.onSelect});

  @override
  _DropDownCustom createState() => _DropDownCustom();
}

class _DropDownCustom extends State<DropDownCustom> {
  String? _chosenValue;
  final items = [
    'Accessories',
    'Fashion',
    'Home',
    'Garden',
    'Sport',
    'Health',
    'Pets',
    'Electric',
    'Others'
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        // dropdown below..
        child: DropdownButton<String>(
          elevation: 1,
          isExpanded: true,
          value: _chosenValue,
          dropdownColor: widget.customAppTheme.white,
          onChanged: (newValue) => setState(() {
            widget.onSelect(_chosenValue);
            _chosenValue = newValue;
          }),
          items: items
              .map<DropdownMenuItem<String>>(
                  (String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
              .toList(),
          // add extra sugar..
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 32,
          hint: Text(
            "Select Category",
            style: AppTheme.getTextStyle(widget.themeData.textTheme.bodyText1,
                fontWeight: 700, color: widget.customAppTheme.primary),
          ),
          // style: TextStyle(color: Colors.black),
          underline: SizedBox(),
        ),
      ),
    );
  }
}
