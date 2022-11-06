import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransationForm extends StatefulWidget {
  TransationForm({
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  final void Function(String, double, DateTime) onSubmit;

  @override
  State<TransationForm> createState() => _TransationFormState();
}

class _TransationFormState extends State<TransationForm> {
  final _titleController = TextEditingController();

  final _valueController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isNotEmpty && value.toString().isNotEmpty) {
      widget.onSubmit(title, value, _selectedDate!);
    }
    return;
  }

  _showADatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }

      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              onChanged: ((nvalue) {}),
              decoration: InputDecoration(
                labelText: 'Título',
              ),
            ),
            TextField(
              controller: _valueController,
              onChanged: (nvalue) {},
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (cal) {
                _submitForm();
              },
              decoration: InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      (_selectedDate == null)
                          ? 'Nenhuma data selecionada'
                          : 'Data selecionada: ${DateFormat('dd/M/y').format(_selectedDate!)}',
                    ),
                  ),
                  TextButton(
                    onPressed: _showADatePicker,
                    child: Text(
                      'Selecionar data',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(
                    'Nova transação',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
