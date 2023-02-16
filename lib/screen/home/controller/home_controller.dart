import 'package:get/get.dart';
import '../../../util/calendar_utils.dart';

class EventController extends GetxController {
  final RxMap<DateTime, List<Event>> selectedEvents =
      {DateTime.now(): <Event>[]}.obs;
  Rx<DateTime> selectedDay = DateTime.now().obs;

  void addEvents(DateTime day, List<String> eventSource) {
    if (selectedEvents[day]?.isEmpty ?? true) {
      selectedEvents[day] = <Event>[];
      selectedEvents[day]?.add(Event(
          eventSource[0], eventSource[1], eventSource[2], eventSource[3]));
    } else {
      selectedEvents[day]?.add(Event(
          eventSource[0], eventSource[1], eventSource[2], eventSource[3]));
    }
  }

  void selectedDate(DateTime day) {
    selectedDay.value = day;
  }
}
