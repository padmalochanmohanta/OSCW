// validators.dart

String? requiredValidator(String? value) {  // Removed the underscore
  if (value == null || value.trim().isEmpty) {
    return 'This field is required';
  }
  return null;
}

String? emailValidator(String? value) {  // Removed the underscore
  if (value == null || value.isEmpty) return null;
  final regex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
  if (!regex.hasMatch(value)) return 'Invalid email format';
  return null;
}

String? mobileValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Mobile number is required';
  }
  if (!RegExp(r'^\d{10}$').hasMatch(value)) {
    return 'Mobile number must be 10 digits';
  }
  return null;
}


String? aadhaarValidator(String? value) { 
  if (value == null || value.isEmpty)   return 'Aadhar number is required';
  if (!RegExp(r'^\d{12}$').hasMatch(value)) {
    return 'Aadhaar must be 12 digits';
  }
  return null;
}


String? pinValidator(String? value) {  
  if (value == null || value.isEmpty) return 'Pin code required';
  if (!RegExp(r'^\d{6}$').hasMatch(value)) {
    return 'Invalid pin code';
  }
  return null;
}

