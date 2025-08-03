import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FaqPage extends StatelessWidget {
  final List<FaqItem> faqs = [
    FaqItem(
      question: 'How do I track my bus in real-time?',
      answer: 'Go to the Dashboard and tap on the "Track" button next to your bus. '
          'This will show the bus location on a map with real-time updates.',
    ),
    FaqItem(
      question: 'What should I do if my bus is delayed?',
      answer: 'The app will automatically notify you about delays. You can also '
          'check the "Ride History" section for updates on your scheduled rides.',
    ),
    FaqItem(
      question: 'How do I save my frequent locations?',
      answer: 'Navigate to "Saved Locations" from the Dashboard and tap the "+" '
          'button to add new frequently visited locations.',
    ),
    FaqItem(
      question: 'Is my payment information secure?',
      answer: 'Yes, we use industry-standard encryption for all payment '
          'transactions and never store your full card details on our servers.',
    ),
    FaqItem(
      question: 'How do I change my notification preferences?',
      answer: 'Go to "Preferences" in your Dashboard and toggle the notification '
          'settings according to your preferences.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? colorScheme.surfaceVariant.withOpacity(0.1)
          : Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'FAQs',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        backgroundColor: isDark ? colorScheme.surface : Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(
              faqs[index].question,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurface,
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 16, 16),
                child: Text(
                  faqs[index].answer,
                  style: GoogleFonts.poppins(
                    color: colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class FaqItem {
  final String question;
  final String answer;

  FaqItem({required this.question, required this.answer});
}