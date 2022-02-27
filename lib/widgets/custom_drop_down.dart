import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final String? hintText;
  final List<DropdownMenuItem<String>>? listItems;
  final Color? textColor;
  final Color? backgroundColor;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback? callback;

  CustomDropDown(
      {Key? key,
      @required this.hintText,
      @required this.listItems,
      this.textColor = Colors.white,
      this.backgroundColor = Colors.black54,
      this.icon = Icons.business_center_outlined,
      this.iconColor = const Color(0xffD6BA5E),
      @required this.callback})
      : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String value = 'Abogados';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: widget.backgroundColor, //background color of dropdown button
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            width: double.infinity,
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  color: widget.iconColor,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: DropdownButton<String>(
                      hint: Text(
                        widget.hintText!,
                        style: TextStyle(color: widget.textColor, fontSize: 16),
                      ),
                      borderRadius: BorderRadius.circular(8),
                      isExpanded: true,
                      dropdownColor: Colors.black87,
                      style: TextStyle(color: widget.textColor, fontSize: 15),
                      underline: Container(),
                      value: value,
                      items: widget.listItems!.map<DropdownMenuItem<String>>(
                          (DropdownMenuItem<String> item) {
                        return DropdownMenuItem<String>(
                          value: item.value,
                          child: Text(item.value!,
                              style: TextStyle(
                                  inherit: false,
                                  color: widget.textColor,
                                  fontSize: 15)),
                        );
                      }).toList(),
                      onChanged: (item) => setState(() {
                            value = item!;
                            widget.callback;
                          })),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
