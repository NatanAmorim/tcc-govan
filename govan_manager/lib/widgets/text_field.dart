import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    required this.controller,
    required this.fieldName,
    required this.validator,
    this.minLines = 1,
    this.maxLines = 30,
    this.isObscure = false,
    this.textInputAction,
    this.inputFormatters,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final String fieldName;
  final FormFieldValidator<String>? validator;
  final int minLines;
  final int maxLines;
  final bool isObscure;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: widget.textInputAction ?? TextInputAction.newline,
      minLines: widget.isObscure ? 1 : widget.minLines,
      maxLines: widget.isObscure ? 1 : widget.maxLines,
      obscureText: widget.isObscure,
      controller: widget.controller,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      onChanged: (String value) {
        // FIX: Correção temporaria, retirar quando "Accents" forem implmentados no win32 flutter
        // FIX: https://github.com/flutter/engine/pull/27921

        int pos = widget.controller.selection.start;
        final String newValue = value
            // A
            .replaceAll('´´a', 'á')
            .replaceAll('``a', 'à')
            .replaceAll('^^a', 'â')
            .replaceAll('~~a', 'ã')
            .replaceAll('´´A', 'Á')
            .replaceAll('``A', 'À')
            .replaceAll('^^A', 'Â')
            .replaceAll('~~A', 'Ã')
            // E
            .replaceAll('´´e', 'é')
            .replaceAll('``e', 'è')
            .replaceAll('^^e', 'ê')
            .replaceAll('´´E', 'É')
            .replaceAll('``E', 'È')
            .replaceAll('^^E', 'Ê')
            // I
            .replaceAll('´´i', 'í')
            .replaceAll('``i', 'ì')
            .replaceAll('^^i', 'î')
            .replaceAll('´´I', 'Í')
            .replaceAll('``I', 'Ì')
            .replaceAll('^^I', 'î')
            // O
            .replaceAll('´´o', 'ó')
            .replaceAll('``o', 'ò')
            .replaceAll('^^o', 'ô')
            .replaceAll('~~o', 'õ')
            .replaceAll('´´O', 'Ó')
            .replaceAll('``O', 'Ò')
            .replaceAll('^^O', 'Ô')
            .replaceAll('~~O', 'Õ')
            // U
            .replaceAll('´´u', 'ú')
            .replaceAll('``u', 'ù')
            .replaceAll('^^u', 'û')
            .replaceAll('´´U', 'Ú')
            .replaceAll('``U', 'Ù')
            .replaceAll('^^U', 'Û');

        setState(() {
          widget.controller.text = newValue;
        });
        pos -= value.length - newValue.length;
        if (pos > newValue.length) {
          pos = newValue.length;
        }
        widget.controller.selection = TextSelection.fromPosition(
          TextPosition(offset: pos),
        );

        // FIX: remover depois que o flutter corrigir o problema do accents
      },
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
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        // hintText: "${widget.fieldName}", // FIX
        labelText: widget.fieldName,
      ),
    );
  }
}
