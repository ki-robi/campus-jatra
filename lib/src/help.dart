/*import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('FAQ'),
            onTap: () {
              // Navigate to FAQ
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_support),
            title: Text('Contact Support'),
            onTap: () {
              // Navigate to Contact Support
            },
          ),
          ListTile(
            leading: Icon(Icons.feedback),
            title: Text('Send Feedback'),
            onTap: () {
              // Navigate to Send Feedback
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              // Navigate to About
            },
          ),
        ],
      ),
    );
  }
}*/

/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpSupportPage extends StatelessWidget {
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
          'Help & Support',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: isDark ? colorScheme.surface : Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How can we help?',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Find answers or contact our support team',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 24),

            // Help Options Cards
            Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildHelpTile(
                      context,
                      icon: Icons.help_outline,
                      title: 'FAQs',
                      subtitle: 'Find answers to common questions',
                      onTap: () {
                        // Navigate to FAQ
                      },
                    ),
                    const Divider(height: 1, indent: 16),
                    _buildHelpTile(
                      context,
                      icon: Icons.contact_support,
                      title: 'Contact Support',
                      subtitle: 'Get in touch with our team',
                      onTap: () {
                        // Navigate to Contact Support
                      },
                    ),
                    const Divider(height: 1, indent: 16),
                    _buildHelpTile(
                      context,
                      icon: Icons.feedback,
                      title: 'Send Feedback',
                      subtitle: 'Share your experience with us',
                      onTap: () {
                        // Navigate to Send Feedback
                      },
                    ),
                    const Divider(height: 1, indent: 16),
                    _buildHelpTile(
                      context,
                      icon: Icons.info,
                      title: 'About App',
                      subtitle: 'Version 1.0.0 • Privacy Policy',
                      onTap: () {
                        // Navigate to About
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Emergency Contact Section
            Text(
              'Emergency Assistance',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.errorContainer.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.warning, color: colorScheme.error),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Emergency Contact',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onErrorContainer,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Call campus security or emergency services',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: colorScheme.onErrorContainer.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.phone, color: colorScheme.error),
                      onPressed: () {
                        // Implement call functionality
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpTile(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        required VoidCallback onTap,
      }) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: colorScheme.primary.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: colorScheme.primary,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: colorScheme.onSurface.withOpacity(0.6),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: colorScheme.onSurface.withOpacity(0.4),
      ),
      onTap: onTap,
    );
  }
}*/

/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'faq_page.dart';
import 'contact_support_page.dart';
import 'feedback_page.dart';

class HelpSupportPage extends StatelessWidget {
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
          'Help & Support',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: isDark ? colorScheme.surface : Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
          'How can we help?',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Find answers or contact our support team',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 24),

        // Help Options Cards
        Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              child: Column(
                children: [
                  _buildHelpTile(
                    context,
                    icon: Icons.help_outline,
                    title: 'FAQs',
                    subtitle: 'Find answers to common questions',
                    page: FaqPage(),
                  ),
                  const Divider(height: 1, indent: 16),
                  _buildHelpTile(
                    context,
                    icon: Icons.contact_support,
                    title: 'Contact Support',
                    subtitle: 'Get in touch with our team',
                    page: ContactSupportPage(),
                  ),
                  const Divider(height: 1, indent: 16),
                  _buildHelpTile(
                    context,
                    icon: Icons.feedback,
                    title: 'Send Feedback',
                    subtitle: 'Share your experience with us',
                    page: FeedbackPage(),
                  ),
                  const Divider(height: 1, indent: 16),
                  _buildHelpTile(
                    context,
                    icon: Icons.info,
                    title: 'About App',
                    subtitle: 'Version 1.0.0 • Privacy Policy',
                    onTap: () {
                      showAboutDialog(
                        context: context,
                        applicationName: 'Campus-Jatra',
                        applicationVersion: '1.0.0',
                        applicationLegalese: '© 2023 Campus-Jatra. All rights reserved.',
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Emergency Contact Section
          _buildEmergencyContact(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpTile(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        Widget? page,
        VoidCallback? onTap,
      }) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: colorScheme.primary.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: colorScheme.primary,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: colorScheme.onSurface.withOpacity(0.6),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: colorScheme.onSurface.withOpacity(0.4),
      ),
      onTap: onTap ?? () {
        if (page != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        }
      },
    );
  }

  Widget _buildEmergencyContact(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Emergency Assistance',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.errorContainer.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.warning, color: colorScheme.error),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Emergency Contact',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onErrorContainer,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Call campus security or emergency services',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: colorScheme.onErrorContainer.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.phone, color: colorScheme.error),
                  onPressed: () async {
                    // Implement call functionality
                    const phoneNumber = 'tel:+1234567890';
                    if (await canLaunch(phoneNumber)) {
                      await launch(phoneNumber);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Could not launch phone app')),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}*/
/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'faq_page.dart';
import 'contact_support_page.dart';
import 'feedback_page.dart';

class HelpSupportPage extends StatelessWidget {
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
          'Help & Support',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: isDark ? colorScheme.surface : Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How can we help?',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Find answers or contact our support team',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 24),

            // Help Options Cards
            Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildHelpTile(
                      context,
                      icon: Icons.help_outline,
                      title: 'FAQs',
                      subtitle: 'Find answers to common questions',
                      page: FaqPage(),
                    ),
                    const Divider(height: 1, indent: 16),
                    _buildHelpTile(
                      context,
                      icon: Icons.contact_support,
                      title: 'Contact Support',
                      subtitle: 'Get in touch with our team',
                      page: ContactSupportPage(),
                    ),
                    const Divider(height: 1, indent: 16),
                    _buildHelpTile(
                      context,
                      icon: Icons.feedback,
                      title: 'Send Feedback',
                      subtitle: 'Share your experience with us',
                      page: FeedbackPage(),
                    ),
                    const Divider(height: 1, indent: 16),
                    _buildHelpTile(
                      context,
                      icon: Icons.info,
                      title: 'About App',
                      subtitle: 'Version 1.0.0 • Privacy Policy',
                      onTap: () {
                        showAboutDialog(
                          context: context,
                          applicationName: 'Campus-Jatra',
                          applicationVersion: '1.0.0',
                          applicationLegalese: '© 2023 Campus-Jatra. All rights reserved.',
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Emergency Contact Section
            _buildEmergencyContact(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpTile(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        Widget? page,
        VoidCallback? onTap,
      }) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: colorScheme.primary.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: colorScheme.primary,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: colorScheme.onSurface.withOpacity(0.6),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: colorScheme.onSurface.withOpacity(0.4),
      ),
      onTap: onTap ?? () {
        if (page != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        }
      },
    );
  }

  Widget _buildEmergencyContact(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Emergency Assistance',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.errorContainer.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.warning, color: colorScheme.error),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Emergency Contact',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onErrorContainer,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Call campus security or emergency services',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: colorScheme.onErrorContainer.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.phone, color: colorScheme.error),
                  onPressed: () async {
                    const phoneNumber = 'tel:+1234567890';
                    final Uri uri = Uri.parse(phoneNumber);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Could not launch phone app')),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'faq_page.dart';
import 'contact_support_page.dart';
import 'feedback_page.dart';

class HelpSupportPage extends StatelessWidget {
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
          'Help & Support',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: isDark ? colorScheme.surface : Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How can we help?',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Find answers or contact our support team',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 24),

            // Help Options Cards
            Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildHelpTile(
                      context,
                      icon: Icons.help_outline,
                      title: 'FAQs',
                      subtitle: 'Find answers to common questions',
                      page: FaqPage(),
                    ),
                    const Divider(height: 1, indent: 16),
                    _buildHelpTile(
                      context,
                      icon: Icons.contact_support,
                      title: 'Contact Support',
                      subtitle: 'Get in touch with our team',
                      page: ContactSupportPage(),
                    ),
                    const Divider(height: 1, indent: 16),
                    _buildHelpTile(
                      context,
                      icon: Icons.feedback,
                      title: 'Send Feedback',
                      subtitle: 'Share your experience with us',
                      page: FeedbackPage(),
                    ),
                    const Divider(height: 1, indent: 16),
                    _buildHelpTile(
                      context,
                      icon: Icons.info,
                      title: 'About App',
                      subtitle: 'Version 1.0.0 • Privacy Policy',
                      onTap: () {
                        showAboutDialog(
                          context: context,
                          applicationName: 'Campus-Jatra',
                          applicationVersion: '1.0.0',
                          applicationLegalese: '© 2023 Campus-Jatra. All rights reserved.',
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Emergency Contact Section
            _buildEmergencyContact(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpTile(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        Widget? page,
        VoidCallback? onTap,
      }) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: colorScheme.primary.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: colorScheme.primary,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: colorScheme.onSurface.withOpacity(0.6),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: colorScheme.onSurface.withOpacity(0.4),
      ),
      onTap: onTap ?? () {
        if (page != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        }
      },
    );
  }

  Widget _buildEmergencyContact(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const emergencyNumber = '+880'; // Replace with your actual emergency number

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Emergency Assistance',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Emergency Number"),
                  content: Text(
                    emergencyNumber,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[700],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("OK"),
                    ),
                  ],
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.errorContainer.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: colorScheme.error.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.warning,
                      color: colorScheme.error,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Emergency Services',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onErrorContainer,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Immediate assistance',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: colorScheme.onErrorContainer.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    emergencyNumber,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.error,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

 /* Future<void> _showEmergencyCallConfirmation(BuildContext context, String number) async {
    final shouldCall = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Call Emergency Services?'),
        content: Text('Are you sure you want to call $number?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Call Now',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (shouldCall ?? false) {
      _callEmergencyNumber(context, number);
    }
  }*/

  /*Future<void> _callEmergencyNumber(BuildContext context, String number) async {
    final phoneNumber = 'tel:$number';

    try {
      final Uri uri = Uri.parse(phoneNumber);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch phone app')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }*/
}