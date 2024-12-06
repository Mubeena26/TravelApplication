import 'package:flutter/material.dart';

class FormContainer extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldKey;
  final bool isPasswordField;
  final String hintText;
  final String labelText;

  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;
  final bool obscureText; // This will be used for password visibility
  final Function()? onTapSuffixIcon; // This will handle the icon tap

  const FormContainer({
    Key? key,
    this.controller,
    this.fieldKey,
    this.isPasswordField = false,
    required this.hintText,
    required this.labelText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    required this.obscureText, // Pass the obscureText state
    this.onTapSuffixIcon, // Pass the function to handle tap
    this.inputType = TextInputType.text,
  }) : super(key: key);

  @override
  State<FormContainer> createState() => _FormContainerState();
}

class _FormContainerState extends State<FormContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        key: widget.fieldKey,
        controller: widget.controller,
        obscureText: widget.isPasswordField
            ? widget.obscureText
            : false, // Use the passed obscureText
        decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.labelText,
          filled: true,
          fillColor: Colors.white,
          suffixIcon: widget.isPasswordField
              ? GestureDetector(
                  onTap: widget
                      .onTapSuffixIcon, // Call the passed function when tapped
                  child: Icon(
                    widget.obscureText
                        ? Icons.visibility_off
                        : Icons.visibility, // Toggle icon based on visibility
                  ),
                )
              : null,
        ),
        onSaved: widget.onSaved,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        keyboardType: widget.inputType,
      ),
    );
  }
}
