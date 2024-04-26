import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movieapp_flutter/core/error/failure.dart';

abstract interface class AssetRepository {
  Future<Either<Failure, String>> uploadImage({required XFile image});
}
