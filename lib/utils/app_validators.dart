class AppValidators {
  static String? date(String? value, {bool required = true}) {
    if (_isEmptyOrNull(value, required)) {
      return 'Por favor, ingrese una fecha';
    } else if (value != null && value.isNotEmpty) {
      try {
        DateTime.parse(value);
      } catch (e) {
        return 'Por favor, ingrese una fecha válida (AAAA-MM-DD)';
      }
    }
    return null;
  }

  static bool _isEmptyOrNull(String? value, bool required) {
    return required && (value == null || value.isEmpty);
  }
}
