import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movieapp_flutter/core/error/exceptions.dart';
import 'package:movieapp_flutter/core/error/failure.dart';
import 'package:movieapp_flutter/features/asset/data/datasources/asset_data_source.dart';
import 'package:movieapp_flutter/features/asset/domain/repositories/asset_repository.dart';

class AssetRepositoryImpl implements AssetRepository {
  final AssetDataSource dataSource;

  AssetRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, String>> uploadImage({required XFile image}) async {
    try {
      final result = await dataSource.uploadImage(image);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
