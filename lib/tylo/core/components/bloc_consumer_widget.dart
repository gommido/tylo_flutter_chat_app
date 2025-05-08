import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BlocConsumerWidget<C extends Cubit<S>, S> extends StatelessWidget {
  const BlocConsumerWidget({super.key, required this.listener, required this.builder});
  final Function(BuildContext, S) listener;
  final Widget Function(BuildContext, S) builder;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<C, S>(
      listener: listener,
      builder: builder,
    );
  }
}
