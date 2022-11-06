import 'dart:math';

import 'package:expev/components/chart.dart';
import 'package:expev/components/transaction_form.dart';
import 'package:expev/components/transaction_list.dart';
import 'package:expev/models/transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExpenvApp());
}

class ExpenvApp extends StatelessWidget {
  const ExpenvApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    return MaterialApp(
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        textTheme: tema.textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: const TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> _transactions = [];
  // [
  //   Transaction(
  //     id: '1',
  //     title: 'Tenis de corrida',
  //     value: 310.50,
  //     date: DateTime.now(),
  //   ),
  //   Transaction(
  //     id: '4',
  //     title: 'carro',
  //     value: 10000.500,
  //     date: DateTime.now(),
  //   ),
  //   Transaction(
  //     id: '2',
  //     title: 'Conta de Luz',
  //     value: 202.30,
  //     date: DateTime.now().subtract(Duration(days: 3)),
  //   ),
  //   Transaction(
  //     id: '3',
  //     title: 'hotrl',
  //     value: 150,
  //     date: DateTime.now().subtract(Duration(days: 5)),
  //   ),
  // ];
  _addTransaction(String title, double value, DateTime selectedDate) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: selectedDate,
    );
    setState(() {
      if (newTransaction.title.isNotEmpty &&
          newTransaction.value.toString().isNotEmpty) {
        _transactions.add(newTransaction);
      }
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  _openTrasnsationFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return TransationForm(
          onSubmit: _addTransaction,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Despesas Pessoais"),
        actions: [
          IconButton(
              onPressed: () => _openTrasnsationFormModal(context),
              icon: Icon(
                Icons.add,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(recentTransaction: _recentTransactions),
            TransactionList(
                transactions: _transactions, onDelete: _deleteTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTrasnsationFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
