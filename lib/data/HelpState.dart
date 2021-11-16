import 'package:flutter/foundation.dart';

enum HelpState {
  GOOD,
  FREE,
  ACCEPTABLE,
  DELETED,
}

extension HelpStateExtension on HelpState {
  String get name => describeEnum(this);

  String get getDescribe {
    switch (this) {
      case HelpState.GOOD:
        return 'GOOD';
      case HelpState.FREE:
        return 'FREE';
      case HelpState.ACCEPTABLE:
        return 'ACCEPTABLE';
      case HelpState.DELETED:
        return 'DELETED';
    }
  }
}
