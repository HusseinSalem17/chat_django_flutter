import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Text titleWidget() {
  return Text(
    'Chat App',
    style: GoogleFonts.lato(
      fontSize: 40,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  );
}
