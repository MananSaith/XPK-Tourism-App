import 'package:flutter/material.dart';

class ServicesGrid extends StatelessWidget {
  final String placeId;

  const ServicesGrid({
    Key? key,
    required this.placeId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // Define services to show
    final services = [
      {'icon': Icons.hotel, 'name': 'Hotels'},
      {'icon': Icons.restaurant, 'name': 'Restaurants'},
      {'icon': Icons.local_cafe, 'name': 'Cafes'},
      {'icon': Icons.shopping_bag, 'name': 'Shopping'},
      {'icon': Icons.local_hospital, 'name': 'Hospitals'},
      {'icon': Icons.local_gas_station, 'name': 'Gas Stations'},
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nearby Services",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.1,
            ),
            itemCount: services.length,
            itemBuilder: (context, index) {
              return _buildServiceItem(
                context,
                services[index]['icon'] as IconData,
                services[index]['name'] as String,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(BuildContext context, IconData icon, String name) {
    return InkWell(
      onTap: () {
        // Handle service tap - could navigate to a list of nearby services
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Searching for nearby $name...')),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
