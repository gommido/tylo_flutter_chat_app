import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_sized_box.dart';

import '../../services/localization/localization.dart';
import 'custom_text.dart';

class CustomPopMenuWidget extends StatelessWidget {
  const CustomPopMenuWidget({super.key, this.onSelected, required this.itemBuilder});
  final  Function(Object?)? onSelected;
  final List<PopupMenuEntry<Object?>> Function(BuildContext) itemBuilder;
  @override
  Widget build(BuildContext context) {
    return CustomSizedBox(
      child: PopupMenuButton(
        icon: const Icon(
          Icons.more_vert,
        ),
        onSelected: onSelected,
        itemBuilder: itemBuilder,
      ),
    );
  }
}


List<PopupMenuItem> popMenuItemsWidget(List<String> items, context){
  return List.generate(items.length, (index){
    return _buildPopItem(items[index], context);
  });
}


PopupMenuItem _buildPopItem(String value, context){
  final mediaQuery = MediaQuery.of(context).size;
  return PopupMenuItem(
      value: translate(context, value),
      child: Container(
        alignment: AlignmentDirectional.topStart,
        width: mediaQuery.width / 3,
        height: mediaQuery.height / 15 ,
        child: CustomText(
            data: translate(context, value),
            style: Theme.of(context).textTheme.bodyMedium!,
        ),
      )
  );
}