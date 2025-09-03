import 'package:flutter/material.dart';

import 'signup_form.dart';
import 'signup_header.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [SignUpHeader(), SignUpPage()],
          ),
        ),
      ),
    );
  }
}
