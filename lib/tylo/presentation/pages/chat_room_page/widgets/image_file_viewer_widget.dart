import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../controllers/file_picker_controller/file_picker_cubit.dart';

class ImageFileViewerWidget extends StatelessWidget {
  const ImageFileViewerWidget({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<FilePickerCubit, FilePickerState>(
      listener: (context, state){},
      builder: (context, state){
        return Image.file(
          context.read<FilePickerCubit>().pickedFile!.$1!,
          fit: BoxFit.cover,
          width: width,
          height: height,
        );
      },
    );
  }
}
