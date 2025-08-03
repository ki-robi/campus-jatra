import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello/src/Notification_alert.dart';
import 'package:provider/provider.dart';
import 'bus_provider.dart';
import 'bus_details_page.dart';
import 'base_page.dart';
import 'package:google_fonts/google_fonts.dart';


class WelcomePage extends StatefulWidget {
  final String userName;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  WelcomePage({required this.userName, super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _trackerNotifications = [
    'Bus 101 is delayed',
    'Bus 202 has arrived at your stop',
    'Bus 303 is on time'
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BusProvider>(context, listen: false).loadBuses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final busProvider = Provider.of<BusProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return BasePage(
      currentIndex: 0,
      child: Scaffold(
        backgroundColor: colorScheme.surfaceVariant.withOpacity(0.3),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              expandedHeight: 170,
              collapsedHeight: 70,
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
                        'Welcome back,',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: colorScheme.onPrimary.withOpacity(0.8),
                        ),
                      ),
                      Text(
                        widget.userName,
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Campus-Jatra',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  IconButton(
                    icon: Badge(
                      smallSize: 8,
                      backgroundColor: colorScheme.error,
                      child: Icon(
                        Icons.notifications,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Notification_alert(notifications: _trackerNotifications),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
          body: Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Search Bar with floating effect
                Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(12),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by location or bus name',
                      prefixIcon: Icon(Icons.search, color: colorScheme.onSurface.withOpacity(0.6)),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: colorScheme.surface,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    ),
                    onChanged: (query) => busProvider.filterBuses(query),
                  ),
                ),

                //const SizedBox(height: 29),

                // Bus List with modern cards
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Material(
                      color: Colors.transparent,
                      child: busProvider.isLoading
                          ? Center(child: CircularProgressIndicator())
                          : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: busProvider.filteredBuses.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final bus = busProvider.filteredBuses[index];
                          return Ink(
                            decoration: BoxDecoration(
                              color: colorScheme.surface,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BusDetailsPage(bus: bus, showMap: false),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: colorScheme.primaryContainer,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.directions_bus,
                                        color: colorScheme.primary,
                                        size: 28,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            bus.name,
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            bus.route,
                                            style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: colorScheme.onSurface.withOpacity(0.6),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    FilledButton.tonal(
                                      style: FilledButton.styleFrom(
                                        backgroundColor: colorScheme.primaryContainer,
                                        foregroundColor: colorScheme.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BusDetailsPage(bus: bus, showMap: true),
                                          ),
                                        );
                                      },
                                      child: const Text('Track'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}