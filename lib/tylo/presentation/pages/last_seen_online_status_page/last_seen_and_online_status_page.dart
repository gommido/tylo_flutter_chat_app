import 'package:flutter/material.dart';
import 'package:tylo/tylo/presentation/pages/last_seen_online_status_page/widgets/last_seen_and_online_radio_list_widget.dart';
import 'package:tylo/tylo/presentation/pages/last_seen_online_status_page/widgets/last_seen_and_online_status_app_bar_title_widget.dart';
import 'package:tylo/tylo/presentation/pages/last_seen_online_status_page/widgets/who_can_see_last_seen_and_online_status_widget.dart';
import '../../../core/components/custom_widgets/custom_app_bar.dart';
import '../../../core/components/custom_widgets/custom_column.dart';
import '../../../core/components/custom_widgets/custom_padding.dart';
import '../../../core/components/custom_widgets/custom_scaffold.dart';
import '../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../core/helper_functions/navigator/navigator_pop.dart';

class LastSeenAndOnlineStatusPage extends StatelessWidget {
  const LastSeenAndOnlineStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomScaffold(
      appBar: customAppBar(
        context: context,
        title: const LastSeenAndOnlineStatusAppBarTitleWidget(),
        onPressed: (){
          navigateAndPop(context);
        },
      ),
      body: CustomPadding(
        padding: const EdgeInsets.all(10.0),
        child: CustomColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSizedBox(height: size.height / 50,),
            const WhoCanSeeLastSeenAndOnlineStatusWidget(),
            CustomSizedBox(height: size.height / 50,),
            const LastSeenAndOnlineRadioListWidget(),
            CustomSizedBox(height: size.height / 25,),
          ],
        ),
      ),
    );
  }
}
