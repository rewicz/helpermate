import 'package:flutter/foundation.dart';

enum HelpType {
  cleaning,
  compan,
  computer,
  grass_cut,
  rubbish,
  shopping,
  walk,
  walk_dog,
  another,
}

extension HelpTypeExtension on HelpType {

  List<String> get allNames {
    List<String> list = [];
    HelpType.values.forEach((element) {list.add(element.name);});
    return list;
  }

  String get name => describeEnum(this);

  String get getDescribe {
    switch (this) {
      case HelpType.cleaning:
        return 'Sprzątanie';
      case HelpType.compan:
        return 'Towarzystwo';
      case HelpType.computer:
        return 'Komputer';
      case HelpType.grass_cut:
        return 'Ścięcie trawy';
      case HelpType.rubbish:
        return 'Śmieci';
      case HelpType.shopping:
        return 'Zakupy';
      case HelpType.walk:
        return 'Spacer';
      case HelpType.walk_dog:
        return 'Spacer z psem';
      case HelpType.another:
        return 'Inne';
    }
  }

  String get getPath {
    switch (this) {
      case HelpType.cleaning:
        return 'assets/helpTypes/cleaning.jpg';
      case HelpType.compan:
        return 'assets/helpTypes/compan.jpg';
      case HelpType.computer:
        return 'assets/helpTypes/computer.jpg';
      case HelpType.grass_cut:
        return 'assets/helpTypes/grass_cut.jpg';
      case HelpType.rubbish:
        return 'assets/helpTypes/rubbish.jpg';
      case HelpType.shopping:
        return 'assets/helpTypes/shopping.jpg';
      case HelpType.walk:
        return 'assets/helpTypes/walk.jpg';
      case HelpType.walk_dog:
        return 'assets/helpTypes/walk_dog.jpg';
      case HelpType.another:
        return 'assets/helpTypes/question_mark.jpg';
    }
  }
}
