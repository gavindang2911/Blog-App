import 'package:flutter/material.dart';

class InputFormCommon extends StatelessWidget {
  final Function validator;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final bool isPassword;
  final Function onTapHiddenPassword;

  const InputFormCommon(
      {Key key,
      this.validator,
      this.controller,
      this.keyboardType,
      this.hintText,
      this.isPassword,
      this.onTapHiddenPassword})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        suffixIcon: isPassword != null
            ? IconButton(
                icon:
                    Icon(isPassword ? Icons.visibility_off : Icons.visibility),
                onPressed: onTapHiddenPassword)
            : null,
        fillColor: Colors.white,
        hintText: hintText,
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(16.0, 18.0, 37.0, 18.0),
        enabledBorder: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(3),
          ),
          borderSide: new BorderSide(
            color: Color(0xFFDCDCDC),
            width: 0.5,
          ),
        ),
      ),
      controller: controller,
      keyboardType: keyboardType != null ? keyboardType : TextInputType.text,
      autocorrect: false,
      validator: validator,
      autofocus: false,
      obscureText: isPassword != null ? isPassword : false,
    );
  }
}
