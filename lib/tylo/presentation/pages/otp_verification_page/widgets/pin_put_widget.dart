import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinPutWidget extends StatelessWidget {
  const PinPutWidget({super.key, this.onTapOutside, this.onChanged});
  final Function(PointerDownEvent)? onTapOutside;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      onTapOutside: onTapOutside,
      length: 6,
      showCursor: true,
      onChanged: onChanged,
    );
  }
}
