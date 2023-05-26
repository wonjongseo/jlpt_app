// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/repository/my_word_repository.dart';
import 'package:table_calendar/table_calendar.dart';

import 'common/widget/kangi_text.dart';

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = {
  for (var item in List.generate(100, (index) => index))
    DateTime.utc(kFirstDay.year, kFirstDay.month, item * 1): List.generate(
      item % 4 + 1,
      (index) => Event('Event $item | ${index + 1}'),
    )
};

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

class TableMultiExample extends StatefulWidget {
  @override
  _TableMultiExampleState createState() => _TableMultiExampleState();
}

class _TableMultiExampleState extends State<TableMultiExample> {
  final ValueNotifier<List<Event>> _selectedEvents = ValueNotifier([]);
  List<MyWord> myWords = [];
  bool isWordFlip = false;

  // Using a `LinkedHashSet` is recommended due to equality comparison override
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  @override
  void initState() {
    super.initState();
    getLoad();
  }

  Map<DateTime, List<Event>> kEvents2 = {};

  getLoad() async {
    myWords = await myWordReposotiry.getAllMyWord();
    DateTime now = DateTime.now();
    for (int i = 0; i < myWords.length; i++) {
      if (myWords[i].createdAt == null) {
        DateTime savedDate = DateTime.utc(now.year, now.month, now.day);
        kEvents2.addAll({
          savedDate: [...kEvents2[savedDate] ?? [], Event(myWords[i].word)]
        });
      } else {
        DateTime savedDate = DateTime.utc(myWords[i].createdAt!.year,
            myWords[i].createdAt!.month, myWords[i].createdAt!.day);
        kEvents2.addAll(
          {
            savedDate: [...kEvents2[savedDate] ?? [], Event(myWords[i].word)]
          },
        );
      }
    }
  }

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  MyWordRepository myWordReposotiry = MyWordRepository();

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents2[day] ?? [];
  }

  List<Event> _getEventsForDays(Set<DateTime> days) {
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.add(selectedDay);
      }
    });

    _selectedEvents.value = _getEventsForDays(_selectedDays);
  }

  void updateWord(int index) {
    myWordReposotiry.updateKnownMyVoca(myWords[index]);
  }

  void deleteWord(int index) {
    myWordReposotiry.deleteMyWord(myWords[index]);
    myWords.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double responsiveWordBoxHeight = size.width > 700 ? 130 : 55;
    double responsiveTextFontSize = size.width > 700 ? 25 : 18;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: AppColors.whiteGrey,
              child: TableCalendar<Event>(
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                eventLoader: _getEventsForDay,
                startingDayOfWeek: StartingDayOfWeek.monday,
                selectedDayPredicate: (day) {
                  return _selectedDays.contains(day);
                },
                onDaySelected: _onDaySelected,
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
            ),
            // ElevatedButton(
            //   child: Text('Clear selection'),
            //   onPressed: () {
            //     setState(() {
            //       _selectedDays.clear();
            //       _selectedEvents.value = [];
            //     });
            //   },
            // ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        value.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Slidable(
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    updateWord(myWords.length - index - 1);
                                    setState(() {});
                                  },
                                  backgroundColor: Colors.blueAccent,
                                  foregroundColor: Colors.white,
                                  icon: Icons.check,
                                  label: myWords[myWords.length - 1 - index]
                                              .isKnown ==
                                          true
                                      ? '미암기'
                                      : '암기',
                                ),
                              ],
                            ),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    deleteWord(myWords.length - index - 1);
                                    setState(() {});
                                  },
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: '삭제',
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    myWords[myWords.length - 1 - index].isKnown
                                        ? AppColors.correctColor
                                        : AppColors.whiteGrey,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: KangiText(
                                        fontSize: 40,
                                        color: Colors.black,
                                        japanese:
                                            myWords[myWords.length - 1 - index]
                                                .word,
                                        clickTwice: false,
                                      ),
                                      content: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            '의미 : ${myWords[myWords.length - 1 - index].mean}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            '읽는 법 : ${myWords[myWords.length - 1 - index].yomikata}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: responsiveWordBoxHeight,
                                    child: Center(
                                        child: Text(
                                      isWordFlip
                                          ? myWords[myWords.length - 1 - index]
                                              .mean
                                          : myWords[myWords.length - 1 - index]
                                              .word,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: responsiveTextFontSize,
                                      ),
                                    )),
                                  ),
                                  if (myWords[myWords.length - 1 - index]
                                          .createdAt !=
                                      null)
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        '${myWords[myWords.length - 1 - index].createdAt!}에 저장됨',
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
