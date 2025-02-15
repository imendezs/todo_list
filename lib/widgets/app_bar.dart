import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/screens/login/login_screen.dart';
import 'package:todo_list/widgets/responsive_helper.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final responsive = ResponsiveHelper(context);

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: responsive.paddingMedium),
          child: Row(
            children: [
              CircleAvatar(
                radius: responsive.iconMedium,
                backgroundColor: const Color(0xFF00BF6D).withOpacity(0.1),
                child: Icon(
                  Icons.person,
                  color: const Color(0xFF00BF6D),
                  size: responsive.iconMedium,
                ),
              ),
              SizedBox(width: responsive.spacingSmall),
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: responsive.textSmall,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    const TextSpan(text: "Usuario\n"),
                    TextSpan(
                      text: user?.email ?? "Sin sesión",
                      style: TextStyle(fontSize: responsive.textSmall, color: Colors.black26),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: responsive.paddingMedium),
          child: CircleAvatar(
            radius: responsive.iconSmall,
            backgroundColor: Colors.white,
            child: IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.redAccent,
                size: responsive.iconMedium,
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
