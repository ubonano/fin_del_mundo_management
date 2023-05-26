import '../modules/branch/branch.dart';

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

  static String? text(String? value, {bool required = true}) {
    if (_isEmptyOrNull(value, required)) {
      return 'Por favor, complete el campo';
    }
    return null;
  }

  static String? number(String? value, {bool required = true}) {
    if (_isEmptyOrNull(value, required)) {
      return 'Por favor, complete el campo';
    } else if (value == null || value.isEmpty) {
      value = '0';
    }

    if (double.tryParse(value) == null) {
      return 'Por favor, ingresa un número válido';
    }
    return null;
  }

  static String? branch(Branch? value, {bool required = true}) {
    if (required && (value == null)) {
      return 'Por favor, complete el campo';
    }
    return null;
  }

  static bool _isEmptyOrNull(String? value, bool required) {
    return required && (value == null || value.isEmpty);
  }
}
