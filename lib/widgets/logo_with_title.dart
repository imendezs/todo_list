import 'package:flutter/material.dart';
import 'package:todo_list/widgets/responsive_helper.dart';

class LogoWithTitle extends StatelessWidget {
  final String title, subText;
  final List<Widget> children;

  const LogoWithTitle({
    Key? key,
    required this.title,
    this.subText = '',
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    return SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: responsive.paddingLarge),
          child: Column(
            children: [
              SizedBox(height: constraints.maxHeight * 0.1),
              Icon(
                Icons.library_add_check_outlined,
                color: const Color(0xFF00BF6D),
                size: responsive.iconLogo,
              ),
              SizedBox(height: constraints.maxHeight * 0.05),
              Text(
                title,
                style: TextStyle(
                  fontSize: responsive.textExtraLarge,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: responsive.paddingSmall),
                child: Text(
                  subText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: responsive.textMedium,
                    height: 1.5,
                    color: Colors.black54.withOpacity(0.64),
                  ),
                ),
              ),
              ...children,
            ],
          ),
        );
      }),
    );
  }
}
