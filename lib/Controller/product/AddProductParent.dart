import 'dart:convert';
import 'package:fvm/Controller/product/AddProductController.dart';
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Util/ApiList.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/Headers.dart';
import 'package:fvm/Util/Util.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AddProductParent {
  AddProductController contract;

  AddProductParent(this.contract);

  Future<void> loadData(bodyData, images, tagsJson) async {
    Util.consoleLog(bodyData.toString());
    Util.checkInternet().then((value) async {
      if (value) {
        var request = http.MultipartRequest('POST', Api.addProduct);
        request.fields.addAll(bodyData);
        request.fields.addAll(tagsJson);
        String ext = "PNG";
        if (images != null && images.length != 0) {
          String basename = images[0].path.split('/').last;
          ext = basename.split('.').last;
          for (var i in images) {
            request.files.add(await http.MultipartFile.fromPath(
                'images', i.path.toString(),
                contentType: MediaType('image', ext)));
          }
        }

        request.headers.addAll(Headers.instance.getHeaderForUpload());

        var streamResponse = await request.send();

        final response = await http.Response.fromStream(streamResponse);

        final statusCode = response.statusCode;
        var data = json.decode(response.body);

        if (statusCode != 200 && data['data'] == null) {
          contract.onLoadError(CommonModel.fromJson(data));
          return;
        }
        contract.onLoadCompleted(CommonModel.fromJson(data));
      } else {
        contract.onLoadConnection(AppString.noInternetConnection);
      }
    });
  }
}
