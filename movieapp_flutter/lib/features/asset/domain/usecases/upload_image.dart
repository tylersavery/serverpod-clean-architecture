import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movieapp_flutter/core/error/failure.dart';
import 'package:movieapp_flutter/core/usecases/usecase.dart';
import 'package:movieapp_flutter/features/asset/domain/repositories/asset_repository.dart';

class UploadImageUseCase implements UseCase<String, UploadImageParams> {
  final AssetRepository assetRepository;

  const UploadImageUseCase(this.assetRepository);

  @override
  Future<Either<Failure, String>> call(UploadImageParams params) async {
    return await assetRepository.uploadImage(image: params.image);
  }
}

class UploadImageParams {
  final XFile image;

  const UploadImageParams({
    required this.image,
  });
}
