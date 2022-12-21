import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String title, double value, DateTime date) onSubmit;
  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  DateTime? _selectDate = DateTime.now();
  final valueController = TextEditingController();
  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0;

    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.onSubmit(title, value, _selectDate!);
  }

  _showDataPiker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) =>
        pickedDate != null ? setState(() => _selectDate = pickedDate) : null);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(labelText: 'Título'),
              controller: titleController,
            ),
            TextField(
              onSubmitted: (_) => _submitForm(),
              keyboardType: const TextInputType.numberWithOptions(),
              decoration: const InputDecoration(labelText: 'Valor R\$'),
              controller: valueController,
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  const Text('Nenhuma data selecionada!'),
                  Expanded(
                    child: TextButton(
                      child: Text(
                        _selectDate == null
                            ? 'Selecionar Data'
                            : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectDate!)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () => _showDataPiker(),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: _submitForm,
                  child: const Text(
                    'Nova Transação',
                    style: TextStyle(color: Colors.purple),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
