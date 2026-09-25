// These must be unique across the entire app.
abstract class TypeIds {
  // System information (use range 0 - 999)
  static const int system = 0;
  static const int member = 1;
  static const int standardFront = 2;
  static const int frontEntry = 3;
  static const int standardFrontArchive = 4;
  static const int singleFrontArchive = 5;
  static const int singleFront = 6;
  static const int feeling = 7;
  static const int feelings = 8;
  static const int feelingEntry = 9;

  // General Settings (use range 1000 - 1999)
  static const int settings = 1000;
  static const int cursor = 1001;

  // Medication (use range 2000 - 2999)
  static const int medication = 2000;
  static const int regiment = 2001;
  static const int regimentArchive = 2002;
  static const int takenEntry = 2003;
}
