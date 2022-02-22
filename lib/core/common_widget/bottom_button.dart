import 'package:flutter/material.dart';
import 'package:supdup/core/config/localization.dart';
import 'package:supdup/core/utils/constants.dart';
class BottomButton extends StatefulWidget {
  final String buttonName;
  final VoidCallback onClick;
  final Color color1;
  final Color fontColor;
  const BottomButton({
    Key? key,
    required this.buttonName,
    required this.onClick,
    this.color1= AppColors.greenTwo,
    this.fontColor=AppColors.whiteShade
  }) : super(key: key);

  @override
  _BottomButtonState createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.onClick();
      },
      child:  Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            color: widget.color1
        ),
        child:  Text(MyLocalizations.of(context).getString(widget.buttonName),
          style: TextStyle(
              fontSize: 16.0, color: widget.fontColor),),
      ),
    );
  }
}
