abstract class LanguageEvent {}

class SelectLanguage extends LanguageEvent {
  final String languageCode;
  SelectLanguage(this.languageCode);
}
