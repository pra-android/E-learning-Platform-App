import 'package:flutter/material.dart';

class FormValidations {
  //controllers for signup
  static TextEditingController fullNameController = TextEditingController();
  static TextEditingController signUpEmailController = TextEditingController();
  static TextEditingController signUpPasswordController =
      TextEditingController();

  //controllers for login
  static TextEditingController loginEmailController = TextEditingController();
  static TextEditingController loginPasswordController =
      TextEditingController();

  //controllers for forgotpassword screen
  static TextEditingController forgotPasswordController =
      TextEditingController();

  //controllers for Adding new Courses
  static final adminFormKey = GlobalKey<FormState>();

  static final TextEditingController categoryController =
      TextEditingController();
  static final TextEditingController titleController = TextEditingController();
  static final TextEditingController descriptionController =
      TextEditingController();
  static final TextEditingController priceController = TextEditingController();

  //controller for Comment
  static final TextEditingController courseComment = TextEditingController();
}
