import 'package:flutter/material.dart';
import 'dart:async';

class VerifyOtpScreenView extends StatefulWidget {
  const VerifyOtpScreenView({super.key});

  @override
  State<VerifyOtpScreenView> createState() => _VerifyOtpScreenViewState();
}

class _VerifyOtpScreenViewState extends State<VerifyOtpScreenView> {
  final int _otpLength = 6;
  final List<TextEditingController> _otpControllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
  List.generate(6, (_) => FocusNode());
  bool _isResendEnabled = false;
  late Timer _timer;
  int _remainingSeconds = 600;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    setState(() => _isResendEnabled = false);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        timer.cancel();
        setState(() => _isResendEnabled = true);
      }
    });
  }

  void _resendOtp() {
    if (_isResendEnabled) {
      setState(() => _remainingSeconds = 600);
      _startTimer();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP Resent Successfully!'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  String _getOtpValue() {
    return _otpControllers.map((controller) => controller.text).join();
  }

  bool _areAllFieldsFilled() {
    return _otpControllers.every((controller) => controller.text.isNotEmpty);
  }

  void _onOtpChanged(String value, int index) {
    // Move focus to the next field if current one is filled
    if (value.isNotEmpty && index < _otpLength - 1) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    }
    // Move focus to the previous field if backspace is pressed and current field is empty
    else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF9B6763);
    final Color secondaryColor = const Color(0xFFB8978C);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black54,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo
                Center(
                  child: Icon(
                    Icons.lock,
                    size: 100,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 24),

                // Header Text
                Center(
                  child: Text(
                    'Enter One-Time Password (OTP)',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // OTP Input Fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(_otpLength, (index) {
                    return SizedBox(
                      width: 50,
                      child: TextField(
                        controller: _otpControllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          counterText: '',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onChanged: (value) {
                          _onOtpChanged(value, index);
                          setState(() {}); // Trigger state update when OTP is entered
                        },
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 24),

                // Resend OTP Button
                TextButton(
                  onPressed: _isResendEnabled ? _resendOtp : null,
                  child: Text(
                    _isResendEnabled
                        ? 'Resend OTP'
                        : 'Resend OTP in ${(_remainingSeconds ~/ 60).toString().padLeft(2, '0')}:${(_remainingSeconds % 60).toString().padLeft(2, '0')}',
                    style: TextStyle(
                      color: _isResendEnabled ? primaryColor : Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Verify Button
                ElevatedButton(
                  onPressed: _areAllFieldsFilled()
                      ? () {
                    final otp = _getOtpValue();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('OTP Verified: $otp'),
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    Navigator.pushNamed(context, '/reset-password');
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: const Text(
                    'Verify',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Gilroy',
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
