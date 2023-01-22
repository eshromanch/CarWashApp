

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:car_wash_app/util/dimensions.dart';

class CustomTextFieldForSearch extends StatefulWidget {

  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode ?nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  final Function(String text)? onChanged;
  final Function()? suffunc;
  final Function(String text)? onSubmit;
  final bool isEnabled;
  final int maxLines;
  final TextCapitalization capitalization;
   IconData ?prefixIcon;
  final bool divider;

  CustomTextFieldForSearch(
      {this.hintText = 'Write something...',
      required this.controller,
      required this.focusNode,
      this.nextFocus,
      this.isEnabled = true,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.next,
      this.maxLines = 1,
       this.onSubmit,
        this.onChanged,
        this.suffunc,
       this.prefixIcon,
      this.capitalization = TextCapitalization.none,
      this.isPassword = false,
      this.divider = false, }
  );

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextFieldForSearch> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [


        TextField(
          maxLines: widget.maxLines,
          controller: widget.controller,
          focusNode: widget.focusNode,

          style: TextStyle(fontSize: Dimensions.fontSizeLarge),
          textInputAction: widget.inputAction,
          keyboardType: widget.inputType,
          cursorColor: Theme.of(context).primaryColor,
          textCapitalization: widget.capitalization,
          enabled: widget.isEnabled,
          autofocus: false,
          obscureText: widget.isPassword ? _obscureText : false,
          inputFormatters: widget.inputType == TextInputType.phone ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9]'))] : null,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              borderSide: BorderSide(style: BorderStyle.none, width: 0),
            ),
            isDense: true,
            hintText: widget.hintText,
            fillColor: Theme.of(context).cardColor,
            hintStyle: TextStyle(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).hintColor),
            filled: true,
            prefixIcon: widget.prefixIcon!= null ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(widget.prefixIcon!, size:20,color: Colors.black,),
            ) : null,
            suffixIcon:IconButton(
              icon: Icon(Icons.cancel_rounded,size: 20, color: Colors.black.withOpacity(0.6)),
              onPressed: widget.suffunc,
            ) ,
          ),
          onSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus)
              : widget.onSubmit != null ? widget.onSubmit!(text) : null,
          onChanged:(text)=> widget.onChanged!(text),
        ),

        widget.divider ? Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE), child: Divider()) : SizedBox(),
      ],
    );
  }

  /*void _toggle() {
    setState(() {
     widget.controller.text='';
    });
  }*/
}
