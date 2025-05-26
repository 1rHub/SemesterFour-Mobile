import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PropertyDetailScreen extends StatelessWidget {
  final String image;
  final String title;
  final String location;
  final String price;

  const PropertyDetailScreen({
    super.key,
    required this.image,
    required this.title,
    required this.location,
    required this.price,
  });

  final String phoneNumber = '081357097383';
  final String whatsappUrl = 'https:/wa.me/6281357097383';

  void _launchPhone() async {
    final uri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchWhatsapp() async {
    final uri = Uri.parse(whatsappUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Properti')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image, width: double.infinity, height: 200, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(price, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(location, style: TextStyle(fontSize: 14, color: Colors.grey)),
                  SizedBox(height: 16),
                  Text("Spesifikasi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      children: [
                      _buildSpecRow("Luas Tanah", "57 m2"),
                      _buildSpecRow("Luas Bangunan", "100 m2"),
                      _buildSpecRow("Kamar Tidur", "2"),
                      _buildSpecRow("Kamar Mandi", "1"),
                      _buildSpecRow("Garasi", "1"),
                      ],
                    )
                  ),
                  
                  SizedBox(height: 16),
                  Text("Kontak", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Expanded(child: Text("Muhammad Irsyadul Ibad")),
                        IconButton(
                          icon: Icon(Icons.phone),
                          onPressed: _launchPhone,
                        ),
                        ElevatedButton.icon(
                          icon: Icon(Icons.phone),
                          label: Text("Whatsapp"),
                          onPressed: _launchWhatsapp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecRow(String title, String value) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          width: 1,
          color: Colors.grey
        )
      ),
      // color: Colors.white,
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    margin: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
        Text(value, style: TextStyle(fontWeight: FontWeight.w600)),
      ],
    ),
  );
}

}
