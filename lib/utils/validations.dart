
class Validations {
static String? isEmailValid(String email) {
    String pattern = r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$";
    RegExp regExp = RegExp(pattern);
    if (email.isEmpty) {
      return "Enter username or email";
    } else if (!regExp.hasMatch(email)) {
      return "username or email is not valid";
    }
    return null;
  }

static String? isPasswordValid(String password) {
    String pattern = r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$";
    RegExp regExp = RegExp(pattern);
    if (password.isEmpty) {
      return "Password is empty";
    } else if (!regExp.hasMatch(password)) {
      return "Password is not valid";
    }
    return null;
  }


}
