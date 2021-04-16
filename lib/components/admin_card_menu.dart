import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminCardMenu extends StatelessWidget {
  const AdminCardMenu({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 120,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            text,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
