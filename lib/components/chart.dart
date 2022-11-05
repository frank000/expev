import 'package:expev/components/chart_bar.dart';
import 'package:expev/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({required this.recentTransaction, Key? key}) : super(key: key);

  final List<Transaction> recentTransaction;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMonth = recentTransaction[i].date.month == weekDay.month;
        bool sameYer = recentTransaction[i].date.year == weekDay.year;
        if (sameDay && sameMonth && sameYer) {
          totalSum += recentTransaction[i].value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0].toString(),
        'value': totalSum,
      };
    });
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (acc, item) {
      return acc + (item['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(5),
      child: SingleChildScrollView(
        child: Container(
          width: 321,
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactions.map((tr) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: tr['day'].toString(),
                    value: double.parse(tr['value'].toString()),
                    percent: (tr['value'] as double) / _weekTotalValue,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
