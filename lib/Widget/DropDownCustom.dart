import 'package:flutter/material.dart';
import 'package:fvm/Util/AppTheme.dart';
import 'package:fvm/Util/Util.dart';

class DropDownCustom extends StatefulWidget {
  var customAppTheme;
  var themeData;
  var selected;
  final Function onSelect;

  DropDownCustom(
      {super.key,
      required this.customAppTheme,
      required this.themeData,
      required this.onSelect,required this.selected});

  @override
  _DropDownCustom createState() => _DropDownCustom(selected);
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
  _DropDownCustom(selected){
    if(!(_chosenValue==null || _chosenValue!.isEmpty))
      _chosenValue = selected;
  }

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

            _chosenValue = newValue;
            widget.onSelect(_chosenValue);
            Util.consoleLog("dd select cate : "+_chosenValue.toString());

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
