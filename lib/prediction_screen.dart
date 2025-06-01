import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final List<TextInputFormatter> numberInputFormatters = [
    FilteringTextInputFormatter.digitsOnly,
  ];

  final List<int> roomOptions = List.generate(5, (index) => index + 1);
  int? selectedBedrooms;
  int? selectedBathrooms;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D47A1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Prediksi Harga',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D47A1), Color(0xFF64B5F6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: const [
                          Icon(Icons.home_work, size: 48, color: Color(0xFF3E64FF)),
                          SizedBox(height: 8),
                          Text(
                            'Prediksi Harga Properti',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3E64FF),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildInputField("Luas Bangunan (m²)"),
                    const SizedBox(height: 16),
                    _buildInputField("Luas Tanah (m²)"),
                    const SizedBox(height: 16),
                    _buildDropdownField("Kamar Tidur", selectedBedrooms, (value) {
                      setState(() {
                        selectedBedrooms = value;
                      });
                    }),
                    const SizedBox(height: 16),
                    _buildDropdownField("Kamar Mandi", selectedBathrooms, (value) {
                      setState(() {
                        selectedBathrooms = value;
                      });
                    }),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text("Hasil Prediksi"),
                              content: const Text("Perkiraan harga properti: Rp 950 Juta"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Tutup"),
                                )
                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3E64FF),
                          elevation: 0, // Hapus stroke (shadow halus, biar lebih flat)
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Prediksi Sekarang',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: numberInputFormatters,
    );
  }

  Widget _buildDropdownField(String label, int? value, void Function(int?) onChanged) {
    return DropdownButtonFormField<int>(
      value: value,
      items: roomOptions
          .map((val) => DropdownMenuItem(
                value: val,
                child: Text(val.toString()),
              ))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
    );
  }
}
