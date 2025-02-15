import 'package:flutter/material.dart';
import 'package:todo_list/widgets/responsive_helper.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const LoginButton({Key? key, required this.text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    return SizedBox(
      width: double.infinity,
      height: responsive.buttonHeightMedium,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00BF6D),
          foregroundColor: Colors.white,
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(horizontal: responsive.paddingMedium),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: responsive.textMedium,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
