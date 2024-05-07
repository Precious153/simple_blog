import 'package:flutter/material.dart';
import 'package:simple_blog/app/utils/size_config.dart';

import 'constants.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
        required this.text,
        required this.color,
        required this.size,
        required this.font,
        this.weight,
        this.textAlign,
        this.overflow,
        this.maxLines,
        this.textDecoration,
        this.letterSpacing,
        this.height});

  final String text;
  final Color color;
  final double size;
  final String font;
  final FontWeight? weight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final TextDecoration? textDecoration;
  final double? letterSpacing, height;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      softWrap: true,
      overflow: overflow,
      style: TextStyle(
          color: color,
          fontSize: getScreenWidth(size),
          fontWeight: weight,
          fontFamily: font,
          decoration: textDecoration,
          letterSpacing: letterSpacing,
          height: height,
          overflow: overflow),
      textAlign: textAlign,
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
        required this.onPressed,
        this.color = Palette.kPrimary,
        required this.text,
        this.isLoading = false,
        this.textColor = Colors.white});

  final VoidCallback onPressed;
  final Color? color;
  final String text;
  final Color? textColor;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getScreenHeight(55),
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: color,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          child: isLoading!
              ? SizedBox(
              height: getScreenHeight(24),
              width: getScreenWidth(24),
              child: const CircularProgressIndicator(color: Colors.white))
              : CustomText(
            text: text,
            color: textColor!,
            size: 15,
            weight: FontWeight.w700,
            font: FontFamily.kBold,
          )),
    );
  }
}

class CustomInputField extends StatefulWidget {
  CustomInputField(
      {super.key, required this.inputController,
        required this.inputHintText,
        required this.header,
        required this.keyboardType,
        this.onChanged,
        this.maxLength,
        this.maxLine,
        this.enabled,
        this.suffix,
        this.onTap,
        this.readOnly = false,
        bool? isObscured,
        Function()? onPressed});

  TextEditingController inputController;
  String inputHintText;
  String header;
  TextInputType keyboardType;
  int? maxLength;
  int? maxLine;
  bool? enabled;
  void Function(String)? onChanged;
  void Function()? onTap;
  Widget? suffix;
  final bool readOnly;

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}
class _CustomInputFieldState extends State<CustomInputField> {
  bool showHint = false;

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(getScreenHeight(8)),
      borderSide: BorderSide(
        color: Palette.k1E,
        width: getScreenHeight(0.5),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
            text: widget.header,
            color: Colors.black,
            size: 14,
            font: FontFamily.kRegular,
            textAlign: TextAlign.center,
            weight: FontWeight.w400),
        SizedBox(height: getScreenHeight(8),),
        TextFormField(
          readOnly: widget.readOnly,
          autofocus: false,
          controller: widget.inputController,
          keyboardType: widget.keyboardType,
          cursorColor: Colors.black,
          maxLength: widget.maxLength,
          maxLines: widget.maxLine,
          enabled: widget.enabled,
          style: TextStyle(
              fontFamily: FontFamily.kRegular,
              fontSize: getScreenWidth(14),
              fontWeight: FontWeight.w400,
              color: Palette.k1E),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 13,
                left:10,bottom: 13),
            counterText: '',
            filled: true,
            fillColor: Colors.transparent,
            suffix: Padding(
              padding:
              EdgeInsets.only(right:
              getScreenWidth(25.67)),
              child: widget.suffix,
            ),
            enabledBorder: outlineInputBorder,
            border: outlineInputBorder,
            disabledBorder: outlineInputBorder,
            errorBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            focusedErrorBorder: outlineInputBorder,
            hintText: widget.inputHintText,
            hintStyle: TextStyle(
                fontFamily: FontFamily.kRegular,
                fontSize: getScreenWidth(14),
                fontWeight: FontWeight.w400,
                color: Palette.k1E),
          ),
          validator: (value) =>
          value!.isEmpty ? 'Enter ${widget.header}' : null,
          onChanged: (value) {
            setState(() {
              if (value.isEmpty) {
                showHint = false;
              } else {
                showHint = true;
              }
            });
          },
          onTap: widget.onTap,
        ),
      ],
    );
  }
}


kToastMsgPopUp(BuildContext context,
    {required String message, bool? success}) {
  success ?? (success = false);
  final color = success ? Palette.kGreen : Palette.kRed;
  return
    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
          backgroundColor: color,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 120,
            right: 20,
            left: 20),          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          content:CustomText(
            text: message,
            color: Colors.white,
            size: 12,
            font: FontFamily.kRegular,
            textAlign: TextAlign.center,),
      ));
}

