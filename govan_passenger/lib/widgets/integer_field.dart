import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IntegerFieldWidget extends StatefulWidget {
  const IntegerFieldWidget({
    required this.controller,
    required this.fieldName,
    required this.validator,
    this.isObscure = false,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final String fieldName;
  final FormFieldValidator<String>? validator;
  final bool isObscure;

  @override
  _IntegerFieldWidgetState createState() => _IntegerFieldWidgetState();
}

class _IntegerFieldWidgetState extends State<IntegerFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      maxLines: 1,
      obscureText: widget.isObscure,
      controller: widget.controller,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(
          RegExp('[0-9]'),
        ),
      ],
      validator: widget.validator,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        labelText: widget.fieldName,
      ),
    );
  }
}
