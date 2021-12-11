import 'package:flutter/foundation.dart';

enum HelpState {
  GOOD,
  FREE,
  ACCEPTABLE,
  ARCHIVE,
  DELETED,
  RATING,
  RATINGHELPER,
  RATINGNEEDER,
}

extension HelpStateExtension on HelpState {
  String get name => describeEnum(this);

  String get getDescribeNeeder {
    switch (this) {
      case HelpState.GOOD:
        return 'Zaakceptowany';
      case HelpState.FREE:
        return 'Oczekuje na pomocnika';
      case HelpState.ACCEPTABLE:
        return 'Wysłany do zaakceptowania';
      case HelpState.DELETED:
        return 'Usunięty';
      case HelpState.ARCHIVE:
        return 'Archiwalny';
      case HelpState.RATING:
      case HelpState.RATINGHELPER:
      case HelpState.RATINGNEEDER:
      return 'Do oceny';
    }
  }
  String get getDescribeHelper {
    switch (this) {
      case HelpState.GOOD:
        return 'Zaakceptowany';
      case HelpState.FREE:
        return 'Błąd';
      case HelpState.ACCEPTABLE:
        return 'Wysłany do zaakceptowania';
      case HelpState.DELETED:
        return 'Usunięty';
      case HelpState.ARCHIVE:
        return 'Archiwalny';
      case HelpState.RATING:
      case HelpState.RATINGHELPER:
      case HelpState.RATINGNEEDER:
      return 'Do oceny';
    }
  }
}
