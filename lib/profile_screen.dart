import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Tambahkan ini
import 'loginpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Map<String, bool> _expanded = {
    'pengaturan': false,
    'tentangKami': false,
    'hubungiKami': false,
  };
  String idUser = '';
  String nama = '';
  String email = '';
  String telepon = '';

  @override
  void initState() {
    super.initState();
    _getDataUser();
  }

  Future<void> _getDataUser() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        idUser = prefs.getString('id_user')!;
        nama = prefs.getString('nama')!;
        email = prefs.getString('email')!;
        telepon = prefs.getString('telepon')!;
      });
    }catch(e){
      print(e);
    }
  }

  void _toggle(String key) {
    setState(() {
      _expanded[key] = !_expanded[key]!;
    });
  }

  Future<void> _launchWhatsApp(BuildContext context) async {
  final phone = '6281357097383';
  final message = Uri.encodeComponent("Halo, saya ingin bertanya tentang aplikasi Anda.");
  final url = "https://wa.me/$phone?text=$message";

  final uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tidak dapat membuka WhatsApp.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 30),
          _buildAnimatedTile(
            keyName: 'pengaturan',
            icon: Icons.settings,
            title: 'Pengaturan',
            color: Colors.black87,
            child: Column(
              children: [
                _buildAnimatedTile(
                  keyName: 'tentangKami',
                  icon: Icons.info_outline,
                  title: 'Tentang Kami',
                  color: Colors.black87,
                  child: ListTile(
                    title: const Text('Ini adalah aplikasi UHome.'),
                    onTap: () {},
                  ),
                ),
                _buildAnimatedTile(
                  keyName: 'hubungiKami',
                  icon: Icons.phone,
                  title: 'Hubungi Kami',
                  color: Colors.black87,
                  child: ListTile(
                    title: const Text('Hubungi kami via WhatsApp'),
                    onTap: () => _launchWhatsApp(context),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
            child: GestureDetector(
              onTap: () => _showLogoutDialog(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: const [
                    Icon(Icons.logout, size: 24, color: Colors.redAccent),
                    SizedBox(width: 12),
                    Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.redAccent,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF3E64FF), Color(0xFF5EDFFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'SELAMAT DATANG',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 6),
          Text(
            nama,
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedTile({
    required String keyName,
    required IconData icon,
    required String title,
    required Widget child,
    Color color = Colors.black87,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => _toggle(keyName),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(icon, size: 24, color: color),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                  const Spacer(),
                  RotationTransition(
                    turns: AlwaysStoppedAnimation(
                        _expanded[keyName]! ? 0.5 : 0.0),
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      size: 24,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: Container(),
            secondChild: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: child,
            ),
            crossFadeState: _expanded[keyName]!
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Apakah Anda yakin ingin logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Anda sudah logout'),
                    duration: Duration(seconds: 2),
                  ),
                );
                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                });
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }
}
