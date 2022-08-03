import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fvm/Util/AppImages.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:image/image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fvm/Util/Util.dart';
import '../../Util/AppTheme.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

class TakePictureScreen extends StatefulWidget {
  static const name = '/takePictureScreen';

  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  List<XFile> images = <XFile>[];
  bool stateProcess = true;
  late CustomAppTheme customAppTheme;
  late ThemeData themeData;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
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
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          Text('Take a picture'),
          Expanded(child: Container()),
          TextButton(
            onPressed: () async {
              try {
                if (stateProcess)
                  images.length == 0
                      ? Navigator.pop(context)
                      : Navigator.pop(context, images);
                else
                  Util.createSnackBar("Please wait while image process",
                      context, customAppTheme.colorError, customAppTheme.white);
              } catch (e) {
                print(e);
              }
            },
            child: Stack(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.done,
                    size: 32,
                    color: stateProcess
                        ? customAppTheme.primary
                        : customAppTheme.btnDisable),
                Text("${images.length}",
                    style: TextStyle(
                        color: customAppTheme.colorError,
                        fontWeight: FontWeight.w800))
              ],
            ),
          ),
        ],
      )),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Stack(
              children: [
                !stateProcess
                    ? Center(
                        child: CircularProgressIndicator(
                        color: customAppTheme.primary,
                      ))
                    : CameraPreview(_controller),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 75.0,
                    width: 75.0,
                    child: FloatingActionButton(
                      backgroundColor: stateProcess
                          ? customAppTheme.primary
                          : customAppTheme.btnDisable,
                      // Provide an onPressed callback.
                      onPressed: () async {
                        if (!stateProcess) {
                          Util.createSnackBar(
                              "Please wait while image process",
                              context,
                              customAppTheme.colorError,
                              customAppTheme.white);
                          // return;
                        }


                        setState(() {
                          stateProcess = false;
                        });

                        try {
                          // Ensure that the camera is initialized.
                          await _initializeControllerFuture;
                          // var images;
                           var image = await _controller.takePicture();

                          final cPath = image.path;
                          final cBytes = await File(cPath).readAsBytes();
                          var captureImg = decodeImage(cBytes);
                          // img.Image thumbnail = copyResize(captureImg!, width: 150);

                          File wmFile = await getImageFileFromAssets(AppImages.watermark);
                          final wmByte = await wmFile.readAsBytes();
                          var wmImage = decodeImage(wmByte);


                          await drawImage(captureImg!, wmImage!);
                          img.Image thumbnail = copyResize(captureImg, height: 200);
                          File(image.path).writeAsBytesSync(encodePng(captureImg));

                          setState(() {
                            images.add(image);
                            stateProcess = true;
                          });
                        } catch (e) {
                          print(e);
                          stateProcess = true;
                        }
                      },
                      child: const Icon(Icons.camera_alt, size: 32),
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      // floatingActionButton: ,
    );
  }

  // Future<File> getImageFileFromAssets(String path) async {
  //   final byteData = await rootBundle.load(path);
  //    var pathTemp = await getTemporaryDirectory();
  //   final file = File("${pathTemp.path}"+"/"+path);
  //   await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  //
  //   return file;
  // }
  //

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load(path);
    final buffer = byteData.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath =
        tempPath + '/file_01.tmp'; // file_01.tmp is dump file, can be anything
    return File(filePath)
        .writeAsBytes(buffer.asUint8List(byteData.offsetInBytes,
        byteData.lengthInBytes));
  }


}

