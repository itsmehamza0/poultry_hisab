import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poultry_hisab/applications/color.dart';
import 'package:poultry_hisab/screens/eggproduction.dart';
import 'package:poultry_hisab/screens/farmmanagement.dart';
import 'package:poultry_hisab/screens/feedmanagement.dart';
import 'package:poultry_hisab/screens/poultrystock.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Function to fetch stats from Firestore
  Future<Map<String, dynamic>> getFarmStats() async {
    try {
      var farmRef = FirebaseFirestore.instance
          .collection('farms')
          .doc('farmId'); // Replace 'farmId' dynamically
      var farmData = await farmRef.get();

      // Check if document exists
      if (farmData.exists) {
        int totalBirds = farmData['totalBirds'] ?? 0; // Default 0 if no data
        int eggsProducedToday =
            farmData['eggsProducedToday'] ?? 0; // Default 0 if no data
        String farmName = farmData['farmName'] ?? 'My Farm';
        return {
          'totalBirds': totalBirds,
          'eggsProducedToday': eggsProducedToday,
          'farmName': farmName,
        };
      } else {
        return {
          'totalBirds': 0,
          'eggsProducedToday': 0,
          'farmName': 'My Farm',
        }; // Default data if document doesn't exist
      }
    } catch (e) {
      // Return default values if error occurs
      return {'totalBirds': 0, 'eggsProducedToday': 0, 'farmName': 'My Farm'};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("পোল্ট্রি হিসাব",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.appMainColor,
        centerTitle: true,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        // Make the entire body scrollable
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Map<String, dynamic>>(
          future: getFarmStats(),
          builder: (context, snapshot) {
            // Default content while loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildContent(context, 0, 0, 'My Farm');
            } else {
              var stats = snapshot.hasData
                  ? snapshot.data!
                  : {
                      'totalBirds': 0,
                      'eggsProducedToday': 0,
                      'farmName': 'My Farm'
                    };
              return _buildContent(context, stats['totalBirds'],
                  stats['eggsProducedToday'], stats['farmName']);
            }
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, int totalBirds,
      int eggsProducedToday, String farmName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        _buildCombinedStatsCard(totalBirds, eggsProducedToday),
        SizedBox(height: 10),
        // Navigation Buttons
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics:
              NeverScrollableScrollPhysics(), // Prevent GridView from scrolling
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildNavButton(
                context, "পোল্ট্রি স্টক", Icons.pets, PoultryStockScreen()),
            _buildNavButton(
                context, "ডিম উৎপাদন", Icons.egg, EggProductionScreen()),
            _buildNavButton(context, "ফিড ম্যানেজমেন্ট", Icons.food_bank,
                FeedManagementScreen()),
            _buildNavButton(context, "ফার্ম ম্যানেজমেন্ট", Icons.home,
                FarmManagementScreen()),
          ],
        ),
      ],
    );
  }

  Widget _buildCombinedStatsCard(int totalBirds, int eggsProducedToday) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4), // Reduced vertical margin
      padding: EdgeInsets.all(12), // Reduced padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("ফার্ম পরিসংখ্যান",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Divider(color: Colors.grey),
          _buildStatRow("মোট মুরগি", totalBirds),
          _buildStatRow("আজকে ডিম পেরেছে", eggsProducedToday),
        ],
      ),
    );
  }

  Widget _buildStatRow(String title, int value) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 4.0), // Reduced vertical padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 18)),
          Text("$value",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildNavButton(
      BuildContext context, String label, IconData icon, Widget screen) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 10),
        backgroundColor: AppColors.appMainColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 5,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: Colors.white),
          SizedBox(height: 8),
          Text(label, style: TextStyle(color: Colors.white, fontSize: 10)),
        ],
      ),
    );
  }
}
