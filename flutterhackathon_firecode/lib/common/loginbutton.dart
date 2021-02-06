import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final double radius;
  final double yukseklik;
  final Widget buttonIcon;
  final VoidCallback onPressed;

  const SocialLoginButton(
      {Key key,
      @required this.buttonText,
      this.buttonColor: Colors.purple,
      this.textColor: Colors.white,
      this.radius: 16,
      this.yukseklik: 40,
      this.buttonIcon,
      this.onPressed})
      : assert(buttonText != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: SizedBox(
        height: yukseklik,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius)),
              ),),
          
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buttonIcon != null ? buttonIcon : Container(),
              Text(
                buttonText,
                style: TextStyle(color: textColor),
              ),
              buttonIcon != null
                  ? Opacity(opacity: 0, child: buttonIcon)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
