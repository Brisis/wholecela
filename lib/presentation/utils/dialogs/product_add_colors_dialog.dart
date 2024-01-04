import 'package:flutter/material.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/core/extensions/to_hex_color.dart';
import 'package:wholecela/data/models/color.dart';

class ProductColorsMultiSelectFormDialog extends StatefulWidget {
  final List<ColorModel> colors;
  const ProductColorsMultiSelectFormDialog({
    super.key,
    required this.colors,
  });

  @override
  State<ProductColorsMultiSelectFormDialog> createState() =>
      _ProductColorsMultiSelectFormDialogState();
}

class _ProductColorsMultiSelectFormDialogState
    extends State<ProductColorsMultiSelectFormDialog> {
  final List<ColorModel> _selectedItems = [];

  void _colorChange(ColorModel itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AlertDialog(
          title: const Text("Pick colors"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            child: SingleChildScrollView(
              child: ListBody(
                children: widget.colors
                    .map(
                      (color) => CheckboxListTile(
                        activeColor: kPrimaryColor,
                        checkColor: Colors.white,
                        value: _selectedItems.contains(color),
                        title: Row(
                          children: [
                            Text(color.name),
                            horizontalSpace(),
                            SizedBox(
                              child: CircleAvatar(
                                backgroundColor: HexColor.fromHex(
                                  color.hexCode,
                                ),
                                radius: 8,
                              ),
                            ),
                          ],
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (isChecked) =>
                            _colorChange(color, isChecked!),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          actions: [
            TextButton(
              onPressed: _cancel,
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.all(10.0),
                ),
                backgroundColor: MaterialStateProperty.all(kWarningColor),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: kWhiteColor,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _submit,
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.all(10.0),
                ),
                //backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              child: const Text("Submit"),
            ),
          ],
        ),
      ],
    );
  }
}
