class Assets {
  static String bgMosque = 'assets/images/bg_mosque.png';
  static String thumbnailSudais = 'assets/images/img_sudais.png';
  static String Function(String id) quranSvg = (id) => 'assets/quran/al-mulk/${id.padLeft(4, '0')}.svg';
}