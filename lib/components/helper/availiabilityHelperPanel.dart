import 'package:flutter/material.dart';
import 'package:helpermate/components/componentsUI.dart';
import 'package:range_slider_dialog/range_slider_dialog.dart';
import 'package:table_calendar/table_calendar.dart';


class AvailiabilityHelperPanel extends StatefulWidget {
  @override
  _AvailiabilityHelperPanelState createState() => _AvailiabilityHelperPanelState();
}

class _AvailiabilityHelperPanelState extends State<AvailiabilityHelperPanel> {
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  var _rangeValues = RangeValues(9.00 , 15.00); // zakres slidera do dodania dostępności

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          TableCalendar(
            availableCalendarFormats: const {
              CalendarFormat.month: 'Miesiąc',
              CalendarFormat.twoWeeks: '2 tygodnie',
              CalendarFormat.week: '1 tydzien',
            },
            focusedDay: selectedDay,
            firstDay: DateTime(1990),
            lastDay: DateTime(2050),
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,

            //Day Changed
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
              });
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },

            eventLoader: _getEventsfromDay,

            //To style the Calendar
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Colors.purpleAccent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5.0),
              ),
              formatButtonTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ..._getEventsfromDay(selectedDay).map((Event event) => Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      event.toString(),
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    RoitButton(text: 'Modyfikuj', onPressedCallback: () {}),
                    RoitButton(text: 'Usuń', onPressedCallback: () {}),
                  ],
                ),
              ),
            )

        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => (showRangeSliderDialog(context, this._rangeValues, (currentValue) {
          bool isGood = true;
          if (currentValue != null) {
              if (selectedEvents[selectedDay] != null) {
                selectedEvents[selectedDay]!.asMap().forEach((key, savedValues) {
                  //sprytne sprwadzenie czy data co wpisaliśmy jest dobra
                  if (savedValues.end <= currentValue.start.toInt()) {
                    print("now start");
                  } else if (savedValues.start >= currentValue.end.toInt()) {
                    print("now end");
                  } else {
                    isGood = false;
                  }
                });
                if(isGood) {
                  selectedEvents[selectedDay]!.add(
                    Event(start: currentValue.start.toInt(), end: currentValue.end.toInt()),
                  );
                  Navigator.pop(context);
                  setState(() {});
                } else {
                  showDialog(context: context, builder: (BuildContext context) {
                    return AlertDialog(
                        title: Text(
                            'Wybrane przez ciebie godziny pokrywają się z poprzednim wyborem. Popraw godziny dostępnosci'),
                        content: SingleChildScrollView(
                            child: RoitButton(text: 'OK',
                              onPressedCallback: () => Navigator.pop(context),)
                        )
                    );
                  });
                }
              } else {
                selectedEvents[selectedDay] = [
                  Event(start: currentValue.start.toInt(), end: currentValue.end.toInt())
                ];
                Navigator.pop(context);
                setState(() {});
              }
            }
        })),
        label: Text("Dodaj godziny"),
        icon: Icon(Icons.add),
      ),
    );
  }

  void showRangeSliderDialog(BuildContext context,
      RangeValues? defaultValue, Function(RangeValues?) callback) async {
    await RangeSliderDialog.display<double>(context,
        minValue: 0,
        maxValue: 24,
        acceptButtonText: 'Akceptuj',
        cancelButtonText: 'Anuluj',
        headerText: 'Podaj godziny swojej dostępności',
        selectedRangeValues: defaultValue, onApplyButtonClick: (value) {
          callback(value);
        });
  }
}

class Event {
   int start;
   int end;
  
  Event({
    required this.start,
    required this.end,
  });

   @override
  String toString() {
    return 'Godziny od $start do $end';
  }
}