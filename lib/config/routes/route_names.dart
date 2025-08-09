part of 'route.dart';

class RouteNames {
  static String home = '/home';
  static String search = '/search';
  static String favorites = '/favorites';
  static String downloads = '/downloads';
  static String Function({int? id}) reciterDetail =({id}) => "reciter/${id ?? ":id"}";
  static String Function({int? reciterId, int? surah}) quranScreen = ({reciterId, surah}) => "reciter/${reciterId ?? ":reciterId"}/${surah ?? ":surah"}";
}