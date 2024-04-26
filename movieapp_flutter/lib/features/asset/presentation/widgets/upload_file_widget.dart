import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movieapp_flutter/features/asset/presentation/bloc/asset_bloc.dart';

class UploadFileWidget extends StatelessWidget {
  final String url;
  final String label;
  final Function(String url) onComplete;
  const UploadFileWidget({
    super.key,
    required this.url,
    required this.onComplete,
    this.label = 'File',
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssetBloc, AssetState>(
      listener: (context, state) {
        if (state is AssetStateSuccess) {
          onComplete(state.url);
        }
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label),
                if (url.isNotEmpty)
                  Image.network(
                    url,
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      final picker = ImagePicker();
                      final image = await picker.pickImage(source: ImageSource.gallery);

                      if (image != null) {
                        if (context.mounted) {
                          context.read<AssetBloc>().add(AssetUploadImageEvent(image: image));
                        }
                      }
                    },
                    child: Text(url.isEmpty ? "Upload" : "Replace"))
              ],
            )
          ],
        );
      },
    );
  }
}
