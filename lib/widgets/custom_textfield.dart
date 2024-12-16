import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metatube/utils/app_styles.dart';
import 'package:metatube/utils/snackbar_utils.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.maxLength,
    this.maxLines,
    required this.hintText,
    required this.controller,
  });
  final int maxLength;
  final int? maxLines;
  final String hintText;
  final TextEditingController controller;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final _focusNode = FocusNode();
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    SnackBarUtils.showSnackbar(context, Icons.content_copy, 'Copied text');
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      onEditingComplete: () => FocusScope.of(context).nextFocus,
      controller: widget.controller,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      keyboardType: TextInputType.multiline,
      cursorColor: AppTheme.accent,
      style: AppTheme.inputStyle,
      decoration: InputDecoration(
          hintStyle: AppTheme.hintStyle,
          hintText: widget.hintText,
          suffixIcon: _copyButton(context),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.accent,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.medium,
            ),
          ),
          counterStyle: AppTheme.counterStyle),
    );
  }

  // IconButton _copyButton(BuildContext context) {
  //   return IconButton(
  //     onPressed: () {},
  //     icon: const Icon(
  //       splashColor: AppTheme.accent,
  //splashRadius:20,
  //       Icons.content_copy_rounded,
  //       color: AppTheme.accent,
  //     ),
  //   );
  // }
  Widget _copyButton(BuildContext context) {
    final isInputEmpty = widget.controller.text.isEmpty;
    return Material(
      color: Colors.transparent, // Ensures no background color interference
      child: InkWell(
        borderRadius: BorderRadius.circular(20), // Custom splash radius
        splashColor: AppTheme.accent,
        onTap: isInputEmpty
            ? null
            : () => copyToClipboard(context, widget.controller.text),
        child: Padding(
          padding: const EdgeInsets.all(8.0), // Adjust padding for button size
          child: Icon(
            Icons.content_copy_rounded,
            color: isInputEmpty ? AppTheme.medium : AppTheme.accent,
          ),
        ),
      ),
    );
  }
}
