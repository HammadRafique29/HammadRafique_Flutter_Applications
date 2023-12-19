import 'package:flutter/material.dart';

TextStyle cstmTextStyle(Color clr) {
  return TextStyle(color: clr);
}

Text cstmTextBox(String txt, Color clr, double fnt) {
  return Text(txt, style: TextStyle(color: clr, fontSize: fnt));
}

Text cstmCenteredTextBox(String txt, Color clr, double fnt) {
  return Text(txt,
      style: TextStyle(
        color: clr,
        fontSize: fnt,
      ),
      textAlign: TextAlign.center);
}

Icon cstmIcon(IconData icn, Color clr) {
  return Icon(icn, color: clr);
}

double cstmWidth(BuildContext context, double wdth) {
  return MediaQuery.sizeOf(context).width * wdth;
}

double cstmHeight(BuildContext context, double hght) {
  return MediaQuery.sizeOf(context).height * hght;
}

EdgeInsetsGeometry cstmPad(double tp, double rt, double bt, double lt) {
  return EdgeInsets.only(top: tp, right: rt, bottom: bt, left: lt);
}

EdgeInsetsGeometry cstmPadAll(double pad) {
  return EdgeInsets.all(pad);
}

GestureDetector cstmGstDect(Function fnc, Widget chld, BuildContext context) {
  return GestureDetector(onTap: fnc(context), child: chld);
}

BoxDecoration cstmBoxDec(
    Color clr, double brd, Color brdClr, double bdr, double bsd, Color bsdClr) {
  return BoxDecoration(
      color: clr,
      border: Border.all(width: brd, color: brdClr),
      borderRadius: BorderRadius.circular(bdr),
      boxShadow: [BoxShadow(blurRadius: bsd, color: bsdClr)]);
}

// Predefined Functions
