class Utils {

  static bool isValidEmail(String email){
    final RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    return emailRegex.hasMatch(email);
  }
}