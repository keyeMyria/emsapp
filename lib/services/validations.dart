
class Validations{
  String validateName(String value) {
    if (value.isEmpty) return 'Name is required.';
    final RegExp nameExp = new RegExp(r'^[A-za-z ]+$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only alphabetical characters.';
    return null;
  }

    String validateEmail(String value) {
    if (value.isEmpty) return 'Email is required.';
    final RegExp nameExp = new RegExp(r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$');
    if (!nameExp.hasMatch(value)) return 'Invalid email address';
    return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) return 'Please choose a password.';
    return null;
  }

  String comparePasswords(String value, String value2) {
    if (value != value2) return 'Passwords do not match.';
    return null;
  }

  String validateNumber(String value) {
    if (int.tryParse(value) == 0) {
      return 'Enter a Number';
    }
    return null;
  }

  String validateInput(String value) {
    if (value.isEmpty) return 'Please fill forms.';
    return null;
  }

}