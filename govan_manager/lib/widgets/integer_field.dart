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
        alignLabelWithHint: true,
        filled: true,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        errorMaxLines: null,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        labelText: widget.fieldName,
      ),
    );
  }
}
