import 'package:flutter/material.dart';

class TransationForm extends StatefulWidget {
  TransationForm({
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  final void Function(String, double) onSubmit;

  @override
  State<TransationForm> createState() => _TransationFormState();
}

class _TransationFormState extends State<TransationForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;
    if (title.isNotEmpty && value.toString().isNotEmpty) {
      widget.onSubmit(title, value);
    }
    return;
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
              controller: titleController,
              onChanged: ((nvalue) {}),
              decoration: InputDecoration(
                labelText: 'Título',
              ),
            ),
            TextField(
              controller: valueController,
              onChanged: (nvalue) {},
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (cal) {
                _submitForm();
              },
              decoration: InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _submitForm,
                  child: Text(
                    'Nova transação',
                    style: TextStyle(
                      color: Colors.purple,
                    ),
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
