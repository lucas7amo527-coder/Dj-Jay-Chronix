import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const DJChronixApp());
}

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
  bool _isLoading = false;

  final Set<String> _validCodes = {
    'JAYE-7B3N-4W9Q',
    'JAYE-8K4P-92MX',
    'JAYE-5R9T-2V6C',
  };

  Future<void> _verifyAndUnlock() async {
    final enteredCode = _codeController.text.trim().toUpperCase();

    if (enteredCode.length < 14) {
      setState(() {
        _isError = true;
        _statusMessage = 'Please enter a complete 12-character JAYE code.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _statusMessage = '';
    });

    await Future.delayed(const Duration(milliseconds: 600));

    if (_validCodes.contains(enteredCode)) {
      setState(() {
        _isLoading = false;
        _isError = false;
        _statusMessage = 'Unlocked! Loading 4-Deck Studio...';
      });
    } else {
      setState(() {
        _isLoading = false;
        _isError = true;
        _statusMessage = 'Invalid or already used code. Request one via WhatsApp.';
      });
    }
  }

  Future<void> _requestCodeOnWhatsApp() async {
    const phone = '254790191263';
    final message = Uri.encodeComponent(
      'Hello DJ Jay E Chronix, I would like to request an activation code for the DJ App.',
    );
    final whatsappUrl = Uri.parse('https://wa.me');

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      setState(() {
        _isError = true;
        _statusMessage = 'Could not open WhatsApp. Message +254 790 191 263 directly.';
      });
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const goldColor = Color(0xFFD4AF37);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'DJ JAY E\nCHRONIX',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: goldColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 28),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: goldColor, width: 2),
                  ),
                  child: const Icon(Icons.lock_outline, color: goldColor, size: 42),
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
                  textCapitalization: TextCapitali
