import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/presentation/controllers/chat_controller/chat_cubit.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_contacts_list_widget.dart';
import '../../../controllers/home_controller/home_cubit.dart';

class SearchedContactsWidget extends StatelessWidget {
  const SearchedContactsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<ChatCubit, ChatState>(
      listener: (context, state){},
      builder: (context, state){
        return CustomContactsListWidget(
          contacts: context.watch<HomeCubit>().searchedList,
        );
      },
    );
  }
}
