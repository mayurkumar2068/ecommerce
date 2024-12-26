import 'dart:io';

bool? validateFullName(String? value) {
  if(value == null || value.isEmpty){
    print("Empty");
    return false;
  }

  if(!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
    return false;
  }
  return true;
}


bool? validateMobileNumber(String? value) {
  if(value == null || value.isEmpty) {
    print("Empty");
    return false;
  }

  if (!RegExp(r'^\d{10}$').hasMatch(value)) {
    print("Empty");
   return false;
  }
  return true;
}

bool validateEmail(String? value) {
  if(value == null || value.isEmpty) {
    return false;
  }
  if(!RegExp(r'^[^@]+@[^@]+\.[^@]').hasMatch(value)) {
    return false;
  }
  return true;
}

String? validatePassword(String? value) {
  if(value == null || value.isEmpty) {
    return "Empty password";
  }

  if(value.length  < 8) {
    return "Length of password must be less than eight character";
  }
  if(!RegExp(r'[0-9]').hasMatch(value)) {
    return "One number needed";
  }
  if(!RegExp(r'[!@#$\$%]').hasMatch(value)) {
    return "One Special Character needed";
  }
  return null;
}