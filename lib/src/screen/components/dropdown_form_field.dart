import 'package:flutter/material.dart';

typedef LabelBuilder<T> = String Function(T value);

class DropdownFormField<T> extends FormField<T> {
  final String? hintLabel;
  final Color backgroundColor;
  final Color? borderColor;
  final Color textColor;
  final bool hintLabelFitted;
  final FocusNode? focusNode;
  final List<T> items;
  final LabelBuilder<T?>? labelBuilder;
  final ValueChanged<T?>? onChanged;
  final bool enable;

  DropdownFormField(
      {Key? key,
      T? initialValue,
      this.hintLabel,
      this.backgroundColor = Colors.white,
      this.borderColor,
      this.textColor = Colors.black,
      this.hintLabelFitted = false,
      this.focusNode,
      required this.items,
      this.enable = true,
      this.labelBuilder,
      this.onChanged,
      FormFieldValidator<T>? validator,
      FormFieldSetter<T>? onSaved})
      : super(
            key: key,
            initialValue: initialValue,
            validator: validator,
            onSaved: onSaved,
            builder: (FormFieldState<T> field) {
              return Column(children: [
                DropdownButtonFormField<T>(
                  focusNode: focusNode,
                  value: initialValue,
                  isExpanded: true,
                  hint: hintLabel != null
                      ? (hintLabelFitted)
                          ? FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                hintLabel,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          : Text(
                              hintLabel,
                              overflow: TextOverflow.ellipsis,
                            )
                      : null,
                  icon: enable
                      ? Icon(
                          Icons.keyboard_arrow_down,
                          color: textColor,
                        )
                      : SizedBox(),
                  dropdownColor: backgroundColor,
                  onChanged: enable ? onChanged ?? (value) => field.didChange(value) : null,
                  onSaved: onSaved,
                  items: items.map<DropdownMenuItem<T>>((T value) {
                    var label;
                    if (labelBuilder != null) {
                      label = labelBuilder(value);
                    } else {
                      label = value != null ? '$value' : hintLabel ?? '';
                    }
                    return DropdownMenuItem<T>(
                      value: value,
                      child: Text(label),
                    );
                  }).toList(),
                  validator: (value) => null,
                ),
              ]);
            });
}
