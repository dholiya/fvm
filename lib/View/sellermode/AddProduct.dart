import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/AppTheme.dart';
import 'package:fvm/Widget/DropDownCustom.dart';
import 'dart:math' as math;

import '../../Util/Util.dart';
import '../ViewProductDetails.dart';
import 'TakePictureScreen.dart';

class AddProduct extends StatefulWidget {
  static const name = '/addProduct';
  @override
  _AddProduct createState() => _AddProduct();
}

class _AddProduct extends State<AddProduct> {
  late CustomAppTheme customAppTheme;
  late ThemeData themeData;
  final nameController = TextEditingController();
  final shortController = TextEditingController();
  final longController = TextEditingController();
  final tagController = TextEditingController();
  final priceController = TextEditingController();
  List<String> tagList = <String>[];

  late CameraController _controller;
  var firstCamera;
  var image;
  var selectedCategory="";

  DateTime date = new DateTime(2000);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    customAppTheme = CustomAppTheme();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 64),
          child: Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    final cameras = await availableCameras();
                    firstCamera = cameras.first;
                    await Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => TakePictureScreen(
                          camera: firstCamera,
                        ),
                      ),
                    )
                        .then((image) {
                      if (image != null)
                        setState(() {
                          this.image = image;
                        });
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Icon(Icons.add_a_photo_rounded,
                            color: customAppTheme.primarylite, size: 48),
                      ),
                      Text(
                        'Capture Item Images',
                        style: AppTheme.getTextStyle(
                            color: customAppTheme.primary,
                            themeData.textTheme.bodyText1,
                            fontWeight: 700),
                      ),
                    ],
                  ),
                ),
                image == null
                    ? Container()
                    : Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              for (var i in image)
                                Container(
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    padding: EdgeInsets.only(right: 10),
                                    child: Stack(
                                      children: [
                                        Image.file(File(i.path)),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              image.remove(i);
                                            });
                                          },
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: CircleAvatar(
                                                radius: 15,
                                                backgroundColor:
                                                    customAppTheme.blackTrans22,
                                                child: Icon(Icons.close_rounded,
                                                    color:
                                                        customAppTheme.white)),
                                          ),
                                        ),
                                      ],
                                    )),
                            ],
                          ),
                        ),
                      ),
                Container(
                  padding: EdgeInsets.only(bottom: 10, top: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Name",
                    style: AppTheme.getTextStyle(
                        color: customAppTheme.primary,
                        themeData.textTheme.bodyText1,
                        fontWeight: 700),
                  ),
                ),
                userInput(nameController, 'Enter product name',
                    TextInputType.name, 1),
                Container(
                  padding: EdgeInsets.only(bottom: 10, top: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Price",
                    style: AppTheme.getTextStyle(
                        color: customAppTheme.primary,
                        themeData.textTheme.bodyText1,
                        fontWeight: 700),
                  ),
                ),
                userInput(priceController, 'Enter initial price',
                    TextInputType.number, 1),
                Container(
                  padding: EdgeInsets.only(bottom: 10, top: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Short description",
                    style: AppTheme.getTextStyle(
                        color: customAppTheme.primary,
                        themeData.textTheme.bodyText1,
                        fontWeight: 700),
                  ),
                ),
                userInput(shortController, 'Enter short description',
                    TextInputType.name, 2),
                Container(
                  padding: EdgeInsets.only(bottom: 10, top: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Long description",
                    style: AppTheme.getTextStyle(
                        color: customAppTheme.primary,
                        themeData.textTheme.bodyText1,
                        fontWeight: 700),
                  ),
                ),
                userInput(longController, 'Enter Long description',
                    TextInputType.multiline, 5),
                DropDownCustom(
                  customAppTheme: customAppTheme,
                  themeData: themeData,
                  onSelect: (category) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10, top: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Add tags",
                    style: AppTheme.getTextStyle(
                        color: customAppTheme.primary,
                        themeData.textTheme.bodyText1,
                        fontWeight: 700),
                  ),
                ),
                userInput(
                    tagController, 'Enter tag name', TextInputType.name, 1),
                Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 8.0, // gap between adjacent chips
                      runSpacing: 4.0, // gap between lines
                      children: tagList
                          .map((item) => Container(
                              padding: EdgeInsets.all(6),
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                color: customAppTheme.white,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(item),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        tagList.remove(item);
                                      });
                                    },
                                    child: Icon(Icons.close_rounded,
                                        size: 16,
                                        color: customAppTheme.primary),
                                  ),
                                ],
                              )))
                          .toList()),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10, top: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Bid end Date",
                    style: AppTheme.getTextStyle(
                        color: customAppTheme.primary,
                        themeData.textTheme.bodyText1,
                        fontWeight: 700),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    color: customAppTheme.white,
                  ),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      final current = new DateTime.now();
                      final newDate = current.add(Duration(days: 10));
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(current.year, current.month,
                              current.day + 1, current.hour),
                          maxTime: DateTime(newDate.year, newDate.month,
                              newDate.day, newDate.hour), onChanged: (date) {
                        setState(() {
                          this.date = date;
                        });
                      }, onConfirm: (date) {
                        setState(() {
                          this.date = date;
                        });
                      },
                          currentTime: DateTime.now().add(Duration(days: 1)),
                          locale: LocaleType.en);
                    },
                    child: Row(children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Icon(
                          Icons.calendar_today_rounded,
                          color: customAppTheme.primary,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          date.year == 2000
                              ? "Please select end date of bid"
                              : date.year.toString() +
                                  "-" +
                                  date.month.toString() +
                                  "-" +
                                  date.day.toString() +
                                  " " +
                                  date.hour.toString() +
                                  ":" +
                                  date.minute.toString(),
                          style: TextStyle(
                              fontWeight: date.year == 2000
                                  ? FontWeight.w600
                                  : FontWeight.w600,
                              letterSpacing: 1.1,
                              color: date.year == 2000
                                  ? customAppTheme.blackTrans88
                                  : customAppTheme.blackTransBB),
                        ),
                      )
                    ]),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewProductDetails(
                                  image,
                                  nameController.text.toString(),
                                  priceController.text.toString(),
                                  shortController.text.toString(),
                                  longController.text.toString(),
                                  selectedCategory,
                              tagList,
                              date
                                )));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: customAppTheme.primary,
                      ),
                      child: Text(
                        'List Product',
                        style: AppTheme.getTextStyle(
                            color: customAppTheme.white,
                            themeData.textTheme.headline6,
                            fontWeight: 700),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget userInput(TextEditingController controller, String hintTitle,
      TextInputType keyboardType, int maxline) {
    return Container(
      child: TextFormField(
        inputFormatters: [
          if (controller == priceController)
            FilteringTextInputFormatter.allow(RegExp(r'^\d{1,4}\.?\d{0,2}')),
          // if (controller == priceController)
          //   new LengthLimitingTextInputFormatter(4)
          // else
          if (controller == nameController)
            new LengthLimitingTextInputFormatter(15)
          else if (controller == shortController)
            new LengthLimitingTextInputFormatter(100)
          else if (controller == tagController)
            new LengthLimitingTextInputFormatter(10)
        ],
        controller: controller,
        textInputAction: controller == tagController
            ? TextInputAction.go
            : TextInputAction.next,
        autofocus: false,
        maxLines: maxline,
        onFieldSubmitted: (value) {
          Util.consoleLog("onEditingComplete");
          setState(() {
            if (controller == tagController &&
                (tagController.text != null && tagController.text != "")) {
              if (tagList.length > 6) {
                Util.createSnackBar("Max 7 tag allowed", context,
                    customAppTheme.colorError, customAppTheme.white);
                return;
              }
              tagList.add(tagController.text);
              tagController.text = "";
              value == "";
            }
          });
        },
        obscureText:
            keyboardType == TextInputType.visiblePassword ? true : false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: customAppTheme.white,
          hintText: hintTitle,
          prefix: controller == priceController
              ? Text(AppString.doller + " ",
                  style: TextStyle(color: customAppTheme.black))
              : Container(width: 0),
          hintStyle: TextStyle(color: customAppTheme.blackTrans88),
          contentPadding: EdgeInsets.all(14),
          focusedBorder: Util.noBorder8(),
          enabledBorder: Util.noBorder8(),
        ),
      ),
    );
  }
}
