import '../../domain/entities/wine.dart';

class CountryUtils {
  static final List<String> countries = [
    'Todas',
    'França',
    'Itália',
    'Portugal',
    'Espanha',
    'EUA',
    'Australia',
    'Chile',
    'Brasil',
    'Canadá',
    'Argentina',
    'Alemanha'
  ];

  static bool isValidCountry(String country) {
    return countries.contains(country);
  }

  static String getCountryFlagEmoji(Wine wine) {
    switch (
        wine.origin.toLowerCase().split(',').map((term) => term.trim()).last) {
      case 'frança':
        return '🇫🇷';
      case 'itália':
        return '🇮🇹';
      case 'espanha':
        return '🇪🇸';
      case 'portugal':
        return '🇵🇹';
      case 'eua':
        return '🇺🇸';
      case 'austrália':
        return '🇦🇺';
      case 'chile':
        return '🇨🇱';
      case 'brasil':
        return '🇧🇷';
      case 'canadá':
        return '🇨🇦';
      case 'argentina':
        return '🇦🇷';
      case 'alemanha':
        return '🇩🇪';
      default:
        return '';
    }
  }
}
