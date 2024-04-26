import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:movieapp_client/movieapp_client.dart';
import 'package:movieapp_flutter/core/error/exceptions.dart';
import 'package:movieapp_flutter/core/utils/strings.dart';

abstract interface class AssetDataSource {
  Future<String> uploadImage(XFile image);
}

class AssetDataSourceImpl implements AssetDataSource {
  final Client client;

  AssetDataSourceImpl(this.client);

  @override
  Future<String> uploadImage(XFile image) async {
    final name = "${generateRandomString(16)}.${image.path.split('.').last}";

    final uploadDescription = await client.asset.getUploadDescription(name);

    if (uploadDescription == null) {
      throw const ServerException("Upload not successful");
    }

    final uploader = FileUploader(uploadDescription);

    final stream = image.openRead();
    final length = (await image.readAsBytes()).length;

    await uploader.upload(stream, length);

    final success = await client.asset.verifyUpload(name);

    if (!success) {
      throw const ServerException("Upload failed");
    }

    final Map<String, dynamic> decodedDescription = jsonDecode(uploadDescription);

    if (!decodedDescription.containsKey('url')) {
      throw const ServerException("No Upload URL");
    }

    return "${decodedDescription['url']}/$name";
  }
}
