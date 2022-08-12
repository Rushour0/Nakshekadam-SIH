class Language {
  // Internal model for language
  Language._internal();

  // Private static Language variable
  static final Language _language = Language._internal();

  // Currently chosen language - Defaults to English
  static String _chosenLanguage = "English";

  // Options for languages
  static final List<String> _languages = ["English", "Marathi"];

  // Get the chosen language
  String get language => _chosenLanguage;

  // Get the allowed languages
  List<String> get languages => _languages;

  // Set language
  set setLanguage(selectLanguage) {
    _chosenLanguage = selectLanguage;
  }

  // Making the class Singleton
  factory Language() => _language;
}
