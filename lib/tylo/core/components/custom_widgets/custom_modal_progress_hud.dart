import 'package:flutter/material.dart';
import '../loading_widget.dart';
import 'custom_builder.dart';
import 'custom_container.dart';
import 'custom_scaffold.dart';
import 'custom_sized_box.dart';
import 'custom_stack.dart';

class CustomModalProgressHUD extends StatelessWidget {
  const CustomModalProgressHUD({super.key, required this.child, required this.inAsyncCall});
  final Widget child;
  final bool inAsyncCall;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomScaffold(
      body: CustomStack(
        alignment: Alignment.center,
        children: [
          child,
          CustomBuilder(
            builder: (context){
              if(inAsyncCall){
                return CustomContainer(
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                  ),
                );
              }
              return CustomSizedBox();
            },
          ),
          CustomBuilder(
            builder: (context){
              if(inAsyncCall){
                return const LoadingWidget(color: Colors.white);
              }
              return CustomSizedBox();
            },
          ),

        ],
      ),
    );

  }
}
