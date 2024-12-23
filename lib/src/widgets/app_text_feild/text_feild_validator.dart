class TextFeildValidator {
  static String? nameValidator(String? username) {
    if (username!.isEmpty) {
      return 'Please enter first name';
    } else if (username.length < 3) {
      return 'Please enter first name';
    }
    return null;
  }
  static String? lastnameValidator(String? username) {
    if (username!.isEmpty) {
      return 'Please enter last name';
    } else if (username.length < 3) {
      return 'Please enter last name';
    }
    return null;
  }

  static String? fullnameValidator(String? username) {
    if (username!.isEmpty) {
      return 'Please enter full name';
    } else if (username.length < 6) {
      return 'Please enter full name';
    }
    return null;
  }

  static String? registerDropDownValidator(String? selectedTitle) {
    if (selectedTitle!.trim().length < 2) {
      return 'Please select title.';
    }
    return null;
  }

  static String? emailValidator(String? email) {
    if (email!.isEmpty) {
      return 'Please enter email address';
    } else if (email.trim().length < 3) {
      return 'Please enter valid email address';
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email.trim())) {
      return 'Please enter valid email address';
    }
    return null;
  }

  static String? passwordValidator(String? password) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (password!.trim().isEmpty) {
      return 'Please enter password';
    } else if(password.trim().length<8 || password.length>20){
      return "Password must be between 8 and 20 charcters";
    }/*else if (!regex.hasMatch(password)) {
      return 'Password must be 8 characters including 1 uppercase and lower letter, 1 special character and alphanumeric characters';
    }*/
    return null;
  }

  static String? reasonValidator(String? selectedTitle) {
    if (selectedTitle!.trim().length < 10) {
      return 'Note must be between 10 and 500 charcters.';
    }
    return null;
  }
}
