import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supdup/core/utils/constants.dart';



class CommonTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String lableText;
  final bool obscureText;
  final suffixIcon;
  final FormFieldValidator? validate;
  final Function(String)? onValueChanged;
  final TextInputType? inputType;
  final Color textFilledColor;
  final int? maxLimit;
  final Color borderColor;
  final Color textColor;
  bool readOnly;
  bool enabled;

  /*final TextInputAction textInputAction;
  final TextInputType textInputType;*/
  final FocusNode? focusNode;

  CommonTextField({
    Key? key,
    this.hintText = '',
    this.obscureText = false,
    required this.controller,
    this.suffixIcon,
    this.validate,
    this.onValueChanged,
    this.maxLimit,
    this.inputType,
    this.textColor=AppColors.whiteShade,
    this.textFilledColor= AppColors.textFiledColor,
    this.borderColor=AppColors.textFiledColor,
    /* required this.textInputAction,
    required this.textInputType,*/
    this.lableText='',
    this.focusNode,
    this.enabled=true,
    this.readOnly=false
  }) : super(key: key);

  @override
  _CommonTextFieldState createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      //height: 46,
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        maxLength: widget.maxLimit,
        textAlign: TextAlign.left,
        cursorColor: AppColors.white,
         readOnly: widget.readOnly,
        obscureText: widget.obscureText,
        keyboardType: widget.inputType,
        controller: widget.controller,
        //style: AppFonts.headlineRegularStyle(fontSize: 14,fontColor: widget.textColor),

        validator:widget.validate,
        decoration: InputDecoration(
          filled: true,
            contentPadding: EdgeInsets.only(left: 20.0),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: widget.borderColor),
            borderRadius: BorderRadius.circular(5.0),
          ),
          fillColor: widget.textFilledColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: widget.borderColor),
          ) ,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: widget.borderColor),
          ),
          hintText: widget.hintText,
          // hintStyle: AppFonts.headlineRegularStyle(
          //   fontSize: 14,
          //   fontColor: widget.textColor
          // ),
          suffixIcon: widget.suffixIcon,
        ),
      ),
    );
  }
}
