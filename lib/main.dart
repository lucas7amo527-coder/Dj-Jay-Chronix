import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const DJChronixApp());

class DJChronixApp extends StatelessWidget {
  const DJChronixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DJ JAY E CHRONIX',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D0D0F),
      ),
      home: const ActivationScreen(),
    );
  }
}

class ActivationScreen extends StatefulWidget {
  const ActivationScreen({super.key});

  @override
  State<ActivationScreen> createState() => _ActivationScreenState();
}

class _ActivationScreenState extends State<ActivationScreen> {
  final TextEditingController _codeController = TextEditingController();
  String _statusMessage = '';
  bool _isError = false;

  final Set<String> _validCodes = {
    'JAYE-7B3N-4W9Q',
    'JAYE-8K4P-92MX',
    'JAYE-5R9T-2V6C',
  };

  void _verifyAndUnlock() {
    final code = _codeController.text.trim().toUpperCase();
    if (_validCodes.contains(code)) {
      setState(() {
        _isError = false;
        _statusMessage = 'Unlocked! Welcome to DJ JAY E CHRONIX Studio.';
      });
    } else {
      setState(() {
        _isError = true;
        _statusMessage = 'Invalid code. Tap WhatsApp below to get yours.';
      });
    }
  }

  Future<void> _openWhatsApp() async {
    final url = Uri.parse(
      'https://wa.me.',
    );
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    const gold = Color(0xFFD4AF37);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'DJ JAY E\nCHRONIX',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: gold,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: gold, width: 2),
                  ),
                  child: const Icon(Icons.lock_outline, color: gold, size: 42),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Enter Activation Code',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _codeController,
                  textAlign: TextAlign.center,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    hintText: 'JAYE-XXXX-XXXX',
                    filled: true,
                    fillColor: const Color(0xFF1A1A1E),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _verifyAndUnlock,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: gold,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text(
                      'UNLOCK',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
