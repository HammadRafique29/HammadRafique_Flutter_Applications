import 'package:ibm_table_gen_app/constantFile.dart';
import 'package:flutter/material.dart';


class RepeatTextandICONeWidget extends StatelessWidget {
  RepeatTextandICONeWidget({required this.icondata,required this.label});
  final IconData icondata;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icondata,
          size: 85.0,
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          label,
          style: kLabelStyle,
        ),
      ],
    );
  }
}
