
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/domain/entities/call.dart';
import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_expanded.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../controllers/local_storage_controller/local_storage_cubit.dart';
import 'call_dialer_icon_widget.dart';
import 'call_duration_widget.dart';
import 'call_time_created_widget.dart';
import 'caller_name_widget.dart';

class CallerDetailsWidget extends StatelessWidget {
  const CallerDetailsWidget({super.key, required this.call});
  final Call call;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final name = context.read<LocalStorageCubit>().getStoredContactName(id: call.secondUserId);
    return CustomExpanded(
      child: CustomColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CallerNameWidget(
                name: name,
                isDialed: call.isDialed,
              ),
              CallDurationWidget(duration: call.duration,),
            ],
          ),
          CustomSizedBox(height: size.height / 100),
          CustomRow(
            children: [
              CallDialerIconWidget(isDialed: call.isDialed,),
              CustomSizedBox(width: size.width / 50),
              CallTimeCreatedWidget(
                callCreated: call.callCreated,
                isDialed: call.isDialed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
