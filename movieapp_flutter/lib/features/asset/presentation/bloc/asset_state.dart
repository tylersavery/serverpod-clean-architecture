part of 'asset_bloc.dart';

@immutable
sealed class AssetState {}

final class AssetStateInitial extends AssetState {}

final class AssetStateLoading extends AssetState {}

final class AssetStateSuccess extends AssetState {
  final String url;

  AssetStateSuccess(this.url);
}

final class AssetStateFailure extends AssetState {
  final String message;

  AssetStateFailure(this.message);
}
