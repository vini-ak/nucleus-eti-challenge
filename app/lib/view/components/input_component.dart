import 'package:flutter/material.dart';

class InputComponent extends StatefulWidget {
  final String label;
  final String? initialValue;
  final TextInputType? inputType;
  final Function(String value) onChange;

  const InputComponent({
    Key? key,
    required this.label,
    required this.onChange,
    this.initialValue,
    this.inputType,
  }) : super(key: key);

  @override
  State<InputComponent> createState() => _InputComponentState();
}

class _InputComponentState extends State<InputComponent> {
  late String _label;
  TextInputType? _inputType;

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _label = widget.label;
    _controller = TextEditingController(text: widget.initialValue);
    _inputType = widget.inputType;
  }

  @override
  Widget build(BuildContext context) {
    // Verificando se é um componente de data e hora
    var isReadOnly = _inputType == TextInputType.datetime;

    return TextField(
      controller: _controller,
      keyboardType: _inputType,
      decoration: _styleField(),
      readOnly: isReadOnly,
      onTap: () {
        if (_inputType == TextInputType.datetime) {
          _handleDateTimeField();
        }
      },
      onChanged: (value) {
        widget.onChange(value);
      },
    );
  }

  _handleDateTimeField() {
    var now = DateTime.now();

    showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    ).then((value) {
      print("TEste");
      showTimePicker(context: context, initialTime: TimeOfDay.now());
    });
  }

  _styleField() => InputDecoration(
        border: const OutlineInputBorder(),
        labelText: _label,
        suffixIcon: _inputType == TextInputType.datetime
            ? const Icon(Icons.calendar_today)
            : null,
      );
}
