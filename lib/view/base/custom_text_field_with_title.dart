

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:car_wash_app/util/dimensions.dart';

class CustomTextFieldWithTitle extends StatefulWidget {

  final String hintText;
  final String titleText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode ?nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  final Function? onChanged;
  final Function? onSubmit;
  final bool isEnabled;
  final int maxLines;
  final int minLines;
  final TextCapitalization capitalization;
   String ?prefixIcon;
  final bool divider;

  CustomTextFieldWithTitle(

      {
        this.hintText = 'Write something...',
        required this.titleText,
      required this.controller,
      required this.focusNode,
      this.nextFocus,
      this.isEnabled = true,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.next,
      this.maxLines = 1,
       this.onSubmit,
        this.onChanged,
       this.prefixIcon,
      this.capitalization = TextCapitalization.none,
      this.isPassword = false,
      this.divider = false, this.minLines=1, }
  );

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextFieldWithTitle> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.only(top: 10,bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(widget.titleText,style: TextStyle(
            fontSize: 16,color: Color(0xff8C98A9)
          ),),
          SizedBox(height: 5,),
          TextField(

            maxLines: widget.maxLines,
            controller: widget.controller,
            focusNode: widget.focusNode,
            style: TextStyle(fontSize: Dimensions.fontSizeLarge,fontWeight: FontWeight.bold,color: Colors.black),
            textInputAction: widget.inputAction,
            keyboardType: widget.inputType,
            cursorColor: Theme.of(context).primaryColor,
            textCapitalization: widget.capitalization,
            enabled: widget.isEnabled,
            autofocus: false,
            minLines: widget.minLines,
            obscureText: widget.isPassword ? _obscureText : false,
            inputFormatters: widget.inputType == TextInputType.phone ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9]'))] : null,
            decoration: InputDecoration(

              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(style: BorderStyle.solid,color: Color(0xff2E5BFF), width: 1.0),
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                borderSide: BorderSide(style: BorderStyle.solid,color: Color(0xffE0E7FF), width: 1),
              ),
              isDense: true,

              hintText: widget.hintText,
              fillColor: Color(0xffF9FAFF),
              hintStyle: TextStyle(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).hintColor),
              filled: true,
              prefixIcon: widget.prefixIcon!= null ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Image.asset(widget.prefixIcon!, height: 10, width: 10,color: Colors.black,),
              ) : null,
              suffixIcon: widget.isPassword ? IconButton(
                icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: Colors.black.withOpacity(0.6)),
                onPressed: _toggle,
              ) : null,
            ),
            onSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus)
                : widget.onSubmit != null ? widget.onSubmit!(text) : null,
            onChanged:(text)=> widget.onChanged,
          ),

          widget.divider ? Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE), child: Divider()) : SizedBox(),
        ],
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
