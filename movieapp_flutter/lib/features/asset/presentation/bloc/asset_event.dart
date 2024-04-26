part of 'asset_bloc.dart';

@immutable
sealed class AssetEvent {}

final class AssetUploadImageEvent extends AssetEvent {
  final XFile image;

  AssetUploadImageEvent({required this.image});
}
