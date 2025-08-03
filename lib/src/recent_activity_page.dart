// recent_activity_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bus_provider.dart';
import 'bus_details_page.dart';

class RecentActivityPage extends StatelessWidget {
  const RecentActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final busProvider = Provider.of<BusProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Recent Activity'),
      ),
      body: busProvider.recentSearches.isEmpty
          ? Center(child: Text('No recent searches'))
          : ListView.builder(
        itemCount: busProvider.recentSearches.length,
        itemBuilder: (context, index) {
          final bus = busProvider.recentSearches[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 6),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(
                Icons.directions_bus,
                color: Colors.red,
                size: 30,
              ),
              title: Text(
                bus.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                bus.route,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BusDetailsPage(bus: bus, showMap: false),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}