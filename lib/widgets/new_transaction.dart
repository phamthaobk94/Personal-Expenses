import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransation extends StatefulWidget {
  final Function addTx;

  NewTransation(this.addTx) {
    print('Constructor NewTransation Widget');
  }

  @override
  _NewTransationState createState() {
    print('createState NewTransation Widget');
    return _NewTransationState();
  }
}

class _NewTransationState extends State<NewTransation> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  _NewTransationState() {
    print('Constructor NewTransation State');
  }

  @override
  void initState() {
    print('initState()');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NewTransation oldWidget) {
    print('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose()');
    super.dispose();
  }

  void _submitData() {
    String titleInput = _titleController.text;
    double amountInput = double.parse(_amountController.text);

    if (titleInput.isEmpty || amountInput <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(titleInput, amountInput, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          margin: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                onSubmitted: (_) => _submitData,
                keyboardType: TextInputType.number,
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Text(_selectedDate == null
                        ? 'No Date Choosen!'
                        : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}'),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: _presentDatePicker,
                    )
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
