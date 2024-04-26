import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movieapp_flutter/features/asset/domain/usecases/upload_image.dart';

part 'asset_event.dart';
part 'asset_state.dart';

class AssetBloc extends Bloc<AssetEvent, AssetState> {
  final UploadImageUseCase uploadImage;
  AssetBloc({required this.uploadImage}) : super(AssetStateInitial()) {
    on<AssetEvent>((event, emit) => emit(AssetStateLoading()));

    on<AssetUploadImageEvent>(_handleUploadImage);
  }

  FutureOr<void> _handleUploadImage(AssetUploadImageEvent event, Emitter<AssetState> emit) async {
    final result = await uploadImage(UploadImageParams(image: event.image));

    result.fold(
      (failure) => emit(AssetStateFailure(failure.message)),
      (url) => emit(AssetStateSuccess(url)),
    );
  }
}
