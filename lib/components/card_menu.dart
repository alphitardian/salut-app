import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardMenu extends StatelessWidget {
  final String cardTitle;
  final IconData icon;

  const CardMenu({
    Key? key,
    required this.cardTitle,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 5,
      margin: EdgeInsets.all(8),
      child: Container(
        width: 125,
        height: 140,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              size: 65.0,
            ),
            Spacer(),
            Text(
              cardTitle,
              style: GoogleFonts.poppins(
                fontSize: kIsWeb ? 12 : 14,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
