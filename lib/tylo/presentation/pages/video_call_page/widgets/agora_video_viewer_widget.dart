import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/agora_call_controller/agora_call_cubit.dart';

class AgoraVideoViewerWidget extends StatelessWidget {
  const AgoraVideoViewerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AgoraVideoViewer(
      client: context.read<AgoraCallCubit>().client!,
      layoutType: Layout.oneToOne,
    );
  }
}
