import 'package:flutter/material.dart';
import '../../domain/entities/emergency_contact_entity.dart';

class EmergencyContactCard extends StatelessWidget {
  final EmergencyContactEntity contact;

  const EmergencyContactCard({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    final String emoji = contact.nome.characters.first;
    final String nomeSemEmoji = contact.nome.substring(2).trim();
    
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFCDFB6),
        borderRadius: BorderRadius.circular(isSmallScreen ? 20 : 25),
        border: Border.all(color: const Color(0xFF715848), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF715848),
            offset: Offset(0, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 16 : 20,
          vertical: isSmallScreen ? 12 : 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  emoji,
                  style: TextStyle(fontSize: isSmallScreen ? 18 : 20),
                ),
                SizedBox(width: isSmallScreen ? 6 : 8),
                Flexible(
                  child: Text(
                    nomeSemEmoji,
                    style: TextStyle(
                      fontFamily: 'DINNext',
                      fontWeight: FontWeight.w700,
                      fontSize: isSmallScreen ? 16 : 18,
                      color: const Color(0xFF444444),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: isSmallScreen ? 6 : 8),
            Text(
              contact.tipo,
              style: TextStyle(
                fontFamily: 'DINNext',
                fontWeight: FontWeight.w400,
                fontSize: isSmallScreen ? 14 : 16,
                color: const Color(0xFF444444),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
} 