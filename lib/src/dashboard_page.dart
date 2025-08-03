import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_profile_page.dart';
import 'notification.dart';
import 'package:flutter/material.dart';
import 'theme.dart';
import 'history.dart';
import 'saved_location.dart';
import 'setting.dart';
import 'help.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}
class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }
}

class _DashboardPageState extends State<DashboardPage> {
  String? _imageUrl;
  String? _name;
  String? _email;
  bool _notificationsEnabled = true;

  @override
  // Replace your _fetchUserData with this real-time listener:
  StreamSubscription<DocumentSnapshot>? _userSubscription;

  @override
  void initState() {
    super.initState();
    _setupUserListener();
  }

  void _setupUserListener() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _userSubscription = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots()
          .listen((doc) {
        if (mounted) {
          setState(() {
            _name = doc['name'];
            _email = doc['email'];
            _imageUrl = doc['profilePicture'] ?? user.photoURL;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }

// Remove the old _fetchUserData method
  void _navigateToEditProfile() async {
    final updatedData = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfilePage()),
    );

    if (updatedData != null) {
      setState(() {
        _name = updatedData['name'] ?? _name;
        _email = updatedData['email'] ?? _email;
        _imageUrl = updatedData['profilePicture'] ?? _imageUrl;
      });
    }
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: colorScheme.surfaceVariant.withOpacity(0.2),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160,
            collapsedHeight: 80,
            floating: true,
            pinned: true,
            backgroundColor: colorScheme.surface,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      colorScheme.primary.withOpacity(0.8),
                      colorScheme.primaryContainer,
                    ],
                  ),
                ),
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profile',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(_imageUrl ?? 'https://via.placeholder.com/150'),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _name ?? 'New User',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onPrimary,
                              ),
                            ),
                            Text(
                              _email ?? 'No email available',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: colorScheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.edit, color: colorScheme.onSurface),
                onPressed: _navigateToEditProfile,
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSectionHeader('Account', colorScheme),
                _buildListCard(
                  context,
                  [
                    _buildListTile(
                      context,
                      icon: Icons.history,
                      title: 'Ride History',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RideHistoryPage())),
                    ),
                    _buildListTile(
                      context,
                      icon: Icons.bookmark,
                      title: 'Saved Locations',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SavedLocationsPage())),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildSectionHeader('Preferences', colorScheme),
                _buildListCard(
                  context,
                  [
                    _buildListTile(
                      context,
                      icon: Icons.notifications_active,
                      title: 'Push Notifications',
                      trailing: Transform.scale(
                        scale: 0.75,
                        child: Switch(
                          value: _notificationsEnabled,
                          onChanged: (value) => setState(() => _notificationsEnabled = value),
                          activeColor: colorScheme.primary,
                        ),
                      ),
                    ),
                    _buildListTile(
                      context,
                      icon: Icons.color_lens,
                      title: 'Change Theme',
                      trailing: Transform.scale(
                        scale: 0.75,
                        child: Switch(
                          value: themeProvider.isDarkMode,
                          onChanged: (value) => themeProvider.toggleTheme(value),
                          activeColor: colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildSectionHeader('Support', colorScheme),
                _buildListCard(
                  context,
                  [
                    _buildListTile(
                      context,
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HelpSupportPage())),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Center(
                  child: FilledButton.tonal(
                    style: FilledButton.styleFrom(
                      backgroundColor: colorScheme.errorContainer,
                      foregroundColor: colorScheme.onErrorContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    onPressed: _logout,
                    child: Text(
                      'Logout',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface.withOpacity(0.8),
        ),
      ),
    );
  }

  Widget _buildListCard(BuildContext context, List<Widget> children) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Widget _buildListTile(
      BuildContext context, {
        required IconData icon,
        required String title,
        Widget? trailing,
        VoidCallback? onTap,
      }) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}



/*import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_profile_page.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String? _imageUrl;
  String _name = 'User'; // Default name
  String? _email;
  bool _notificationsEnabled = true;
  StreamSubscription<DocumentSnapshot>? _userSubscription;

  @override
  void initState() {
    super.initState();
    _setupUserListener();
  }

  void _setupUserListener() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _userSubscription = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots()
          .listen((doc) {
        if (mounted) {
          setState(() {
            // Only update if the fields exist in Firestore
            if (doc.data()?['name'] != null) {
              _name = doc['name'];
            }
            _email = doc.data()?['email'];
            _imageUrl = doc.data()?['profilePicture'];
          });
        }
      });
    }
  }

  void _navigateToEditProfile() async {
    final updatedData = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfilePage()),
    );

    if (updatedData != null) {
      setState(() {
        _name = updatedData['name'] ?? _name;
        _email = updatedData['email'];
        _imageUrl = updatedData['profilePicture'];
      });
    }
  }

  // ... [Keep all other existing methods unchanged] ...

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: colorScheme.surfaceVariant.withOpacity(0.2),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160,
            collapsedHeight: 80,
            floating: true,
            pinned: true,
            backgroundColor: colorScheme.surface,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      colorScheme.primary.withOpacity(0.8),
                      colorScheme.primaryContainer,
                    ],
                  ),
                ),
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profile',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: colorScheme.primaryContainer,
                          backgroundImage: _imageUrl != null
                              ? NetworkImage(_imageUrl!)
                              : null,
                          child: _imageUrl == null
                              ? Icon(Icons.person, size: 30, color: colorScheme.primary)
                              : null,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _name,
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onPrimary,
                              ),
                            ),
                            if (_email != null)
                              Text(
                                _email!,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: colorScheme.onPrimary.withOpacity(0.8),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.edit, color: colorScheme.onSurface),
                onPressed: _navigateToEditProfile,
              ),
            ],
          ),
          // ... [Rest of the existing build method remains unchanged] ...
        ],
      ),
    );
  }

// ... [Keep all other existing helper methods] ...
}
*/

