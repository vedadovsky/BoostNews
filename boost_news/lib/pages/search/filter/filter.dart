import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../search_result.dart';

class Filter extends StatefulWidget {
  String search, sort;
  Filter(this.search, this.sort);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  DateTimeRange dateRange;
  String getFrom() {
    if (dateRange == null) {
      return 'From';
    } else {
      return DateFormat('yyyy-MM-dd').format(dateRange.start);
    }
  }

  String getUntil() {
    if (dateRange == null) {
      return 'Until';
    } else {
      return DateFormat('yyyy-MM-dd').format(dateRange.end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (result) {
        if (result == 0) {
          pickDateRange(context);
        } else if (result == 1) {
          pickDateRange(context);
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text(getFrom()),
              ),
              Icon(
                Icons.access_time_filled,
                color: Colors.blue[900],
              ),
            ],
          ),
          value: 0,
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text(getUntil()),
              ),
              Icon(
                Icons.access_time,
                color: Colors.blue[900],
              ),
            ],
          ),
          value: 1,
        ),
      ],
      child: const Icon(
        Icons.filter_alt,
        color: Colors.white,
        size: 24,
      ),
    );
  }

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(
        Duration(hours: 24 * 3),
      ),
    );

    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().month - 1),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateRange ?? initialDateRange,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
              primaryColor: const Color(0xFF01579B),
              colorScheme: ColorScheme.light(primary: const Color(0xFF01579B)),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              dialogBackgroundColor: Colors.white,
              textTheme: Theme.of(context).textTheme.apply(fontSizeDelta: 2)),
          child: child,
        );
      },
    );

    if (newDateRange == null) return;
    setState(() => dateRange = newDateRange);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResult(
          widget.search,
          widget.sort,
          getFrom(),
          getUntil(),
        ),
      ),
    );
  }
}
