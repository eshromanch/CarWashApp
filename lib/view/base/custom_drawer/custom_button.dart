import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String ?text;
  final VoidCallback ? onClicked;

  const ButtonWidget({
    Key? key,
    @required this.text,
    @required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: 58.0,right: 58),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(50),
      ),
      child: Text("Print", style: TextStyle(fontSize: 20)),
      onPressed: onClicked,
    ),
  );
}
