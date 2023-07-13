import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin AppFormValidators {
  static String? validateEmpty(dynamic data, BuildContext context) {
    if (data == null) return "Field can't be blank";
    if (data is String) {
      if (data.toString().trim().isEmpty) return "Field can't be blank";
    }
    if (data is Iterable || data is Map) {
      if (data.isEmpty) return "Field can't be blank";
    }
  }

  static String? validateAmount(String? data, BuildContext context) {
    if (data == null) return "Field can't be blank";
    if (data.isNotEmpty) {
      double amount = double.parse(data);
      if (amount <= 0)
        return "Invalid amount";
      else
        return null;
    } else {
      return "*required";
    }
  }

  static String? validateMail(String? email, BuildContext context) {
    if (email == null) return "Field can't be blank";
    if (email.isEmpty) {
      return "Field can't be blank";
    } else if (!GetUtils.isEmail(email)) {
      return "Invalid email id";
    }
  }

  static String? validatePassword(String? password, BuildContext context) {
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (password == null) return "Field can't be blank";
    if (password.isEmpty) {
      return "Field can't be blank";
    } else if (!regExp.hasMatch(password)) {
      return "Must have uppercase, lowercase, numbers and symbols";
    }
  }

  static String? validatePhone(String? phone, BuildContext context) {
    if (phone == null) return "Field can't be blank";
    if (phone.isEmpty) {
      return "Field can't be blank";
    } else if (!GetUtils.isPhoneNumber(phone)) {
      return "Invalid phone no.";
    }
  }
}
