class Validator {
  static bool emailFormat(value) {
    Pattern pattern = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static String requiredField(value, [String customErrorText]) {
    if (value.isEmpty) {
      return customErrorText ?? 'This field is required';
    }
  }

  static String emailField(value, [String customErrorText]) {
    if(!emailFormat(value)){
      return customErrorText ?? 'Please enter valid email';
    }
  }


}