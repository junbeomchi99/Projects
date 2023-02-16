import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:snapbody/constant/calendar_constant.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../util/calendar_utils.dart';
import '../constant/constant.dart';
import '../screen/home/controller/home_controller.dart';
import 'calendar_dowbuilder.dart';

class HomeCalendarTable extends StatefulWidget {
  const HomeCalendarTable({Key? key}) : super(key: key);

  @override
  _HomeCalendarTableState createState() => _HomeCalendarTableState();
}

class _HomeCalendarTableState extends State<HomeCalendarTable> {
  final getController = Get.put(EventController());

  double? _height;

  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {});

    _selectedDay = _focusedDay;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setCalendarHeight(bool isMonth) {
    //TODO: 기기 사이즈별 캘린더 사이즈 값 설정
    setState(() {
      if (isMonth) {
        _height = 410.h;
      } else {
        _height = 170.h;
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setCalendarHeight(false);
  }

  List<Event> _getEventsForDay(DateTime day) {
    //TODO: 캘린더의 datetime과 Event의 datetime 통일 (9시간 차이남)
    return getController
            .selectedEvents[day.toLocal().subtract(const Duration(hours: 9))] ??
        [];
  }

  List<DateTime> getDaysInRange(DateTime first, DateTime last) {
    final dayCount = last.difference(first).inDays + 1;
    return List.generate(
      dayCount,
      (index) => DateTime.utc(first.year, first.month, first.day + index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: MediaQuery.of(context).size.width,
      height: _height,
      padding: EdgeInsets.only(top: 50.r),
      duration: _calendarFormat == CalendarFormat.month
          ? MONTH_DURATION
          : WEEK_DURATION,
      curve: Curves.fastOutSlowIn,
      decoration: BoxDecoration(
        color: BACKGROUND_COLOR,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(14.r),
          bottomRight: Radius.circular(14.r),
        ),
        boxShadow: [
          BoxShadow(
            color: BOXSHADOW_COLOR,
            offset: BOXSHADOW_OFFSET,
            blurRadius: 10.0.r,
            spreadRadius: 0.0.r,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 42.h,
            height: 16.h,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20).r,
              child: DaysOfWeek(
                visibleDays: getDaysInRange(
                  DateTime.utc(2022, 5, 2),
                  DateTime.utc(2022, 5, 8),
                ),
                dowBuilder: (context, day) {
                  return Center(
                    //TODO: 폰트 설정하기
                    child: Text(DateFormat('E').format(day),
                        style: TextStyle(fontSize: 12.sp)),
                  );
                },
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: 320.w,
              child: TableCalendar<Event>(
                daysOfWeekVisible: false,
                firstDay: DateTime(2022, 1, 1),
                lastDay: DateTime(2099, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: _calendarFormat,
                availableCalendarFormats: const {
                  CalendarFormat.month: '   ',
                  CalendarFormat.week: '   ',
                },
                formatAnimationCurve: Curves.fastOutSlowIn,
                formatAnimationDuration: _calendarFormat == CalendarFormat.month
                    ? FORMAT_MONTH_DURATION
                    : FORMAT_WEEK_DURATION,
                eventLoader: _getEventsForDay,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: CalendarStyle(
                  defaultTextStyle: TextStyle(fontSize: DATE_FONTSIZE),
                  weekendTextStyle: TextStyle(fontSize: DATE_FONTSIZE),
                  //holidayTextStyle: TextStyle(fontSize: DATE_FONTSIZE),
                  outsideTextStyle: TextStyle(fontSize: DATE_FONTSIZE),
                  markersAlignment: Alignment.center,
                  // todayDecoration: const BoxDecoration(
                  //   color: PRIMARY_COLOR,
                  //   shape: BoxShape.circle,
                  // ),
                  // todayTextStyle: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: DATE_FONTSIZE,
                  //     fontWeight: FontWeight.bold),
                  // selectedDecoration: BoxDecoration(
                  //     color: _selectedDayColor, shape: BoxShape.circle),
                  // selectedTextStyle: TextStyle(
                  //     color: _selectedTextColor,
                  //     fontSize: _selectedDayFontSize,
                  //     fontWeight: _selectedDayFontWeight),
                  outsideDaysVisible: false,
                ),
                headerStyle: HeaderStyle(
                  //decoration: BoxDecoration(color: Colors.green[100]),
                  formatButtonDecoration: BoxDecoration(
                    image: DecorationImage(
                        alignment: Alignment.centerRight,
                        image: _calendarFormat == CalendarFormat.week
                            ? const AssetImage(
                                'assets/images/icon_calendar.png')
                            : const AssetImage('assets/images/icon_unfold.png'),
                        //fit: BoxFit.fill,
                        scale: 0.6),
                  ),
                  formatButtonTextStyle: TextStyle(fontSize: 16.sp),
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  //TODO: 기기 사이즈별 headerPadding 조절
                  headerPadding: EdgeInsets.fromLTRB(5.w, 0, 7.w, 33.h),
                  titleTextFormatter: (date, locale) =>
                      DateFormat('yyyy.MM').format(date),
                  //TODO: 폰트 설정하기
                  titleTextStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    //TODO: 캘린더의 datetime과 Event의 datetime 통일 (9시간 차이남)
                    getController.selectedDate(
                      selectedDay.toLocal().subtract(
                            const Duration(hours: 9),
                          ),
                    );
                  }
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      if (format == CalendarFormat.month) {
                        setCalendarHeight(true);
                        _calendarFormat = format;
                      } else {
                        setCalendarHeight(false);
                        _calendarFormat = format;
                      }
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                //TODO: 기기 사이즈별 margin 조절
                calendarBuilders: CalendarBuilders(
                  todayBuilder: (context, day, focusedDay) {
                    return AnimatedContainer(
                      margin: const EdgeInsets.all(3).r,
                      padding: const EdgeInsets.all(0),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: PRIMARY_COLOR, shape: BoxShape.circle),
                      duration: const Duration(milliseconds: 250),
                      child: Text(
                        '${day.day}',
                        style: TextStyle(
                            color: const Color(0xFFFAFAFA),
                            fontSize: DATE_FONTSIZE,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                  selectedBuilder: (context, day, focusedDay) {
                    if (isSameDay(day, DateTime.now())) {
                      return AnimatedContainer(
                        margin: const EdgeInsets.all(3).r,
                        padding: const EdgeInsets.all(0),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: PRIMARY_COLOR, shape: BoxShape.circle),
                        duration: const Duration(milliseconds: 250),
                        child: Text(
                          '${day.day}',
                          style: TextStyle(
                              color: BACKGROUND_COLOR,
                              fontSize: DATE_FONTSIZE,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        decoration:
                            const BoxDecoration(color: TRANSPARENT_COLOR),
                        child: Text(
                          '${day.day}',
                          style: TextStyle(
                              color: SELECTED_DATE_COLOR,
                              fontSize: DATE_FONTSIZE,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                  },
                  markerBuilder: (context, datetime, events) {
                    String date = DateFormat('yMd').format(datetime.toLocal());
                    String today = DateFormat('yMd').format(DateTime.now());
                    if (events.isEmpty || date == today) {
                      return const SizedBox();
                    }
                    return Container(
                      margin: const EdgeInsets.all(3).r,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: SECONDARY_COLOR, width: 1.0.w),
                          color: TRANSPARENT_COLOR,
                          shape: BoxShape.circle),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
