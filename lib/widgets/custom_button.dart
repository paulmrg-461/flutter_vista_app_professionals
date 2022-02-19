import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final double? fontSize;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final double? width;
  final double? borderRadius;
  const CustomButton(
      {Key? key,
      this.icon,
      @required this.text,
      @required this.onPressed,
      this.width,
      this.fontSize = 16,
      this.fontColor = Colors.white,
      this.fontWeight = FontWeight.normal,
      this.backgroundColor = Colors.blue,
      this.borderRadius = 26})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 6),
      width: width,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(backgroundColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius!),
                // side: BorderSide(color: Colors.red)
              ))),
          onPressed: onPressed,
          child: (icon == null)
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(text!,
                      style: TextStyle(
                          fontSize: fontSize!,
                          color: fontColor!,
                          fontWeight: fontWeight!)),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      text!,
                      style: TextStyle(
                          fontSize: fontSize!,
                          color: fontColor!,
                          fontWeight: fontWeight!),
                    ),
                  ],
                )),
    );
  }
}
