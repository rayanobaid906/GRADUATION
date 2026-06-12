import 'package:flutter/material.dart';
import 'package:graduation/app_colors.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose(); // تأكد من تحرير الموارد عند التخلص من الصفحة
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 80),
              const Icon(Icons.shield_outlined, size: 80, color: AppColors.primary),
              const SizedBox(height: 24),
              const Text(
                "Verification Code",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textPrimary, fontSize: 26, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
              ),
              const SizedBox(height: 8),
              const Text(
                "Enter the 4-digit code sent to your phone",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary, fontFamily: 'Cairo'),
              ),
              const SizedBox(height: 40),

              // الكارد المضيء الذي يحتوي على حقول الـ OTP
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 1.5),
                  boxShadow: [
                    BoxShadow(color: AppColors.primary.withValues(alpha: 0.12), blurRadius: 20, spreadRadius: 5),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) => _buildOtpBox(index)),
                ),
              ),
              const SizedBox(height: 30),

              // زر التأكيد
              ElevatedButton(
                onPressed: () {
                  print("تم تأكيد رمز الـ OTP");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text("Verify", style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
// these is for otp text field
  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 50,
      child: TextFormField(
        controller: _controllers[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(color: AppColors.textPrimary, fontSize: 22, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: "", // إخفاء عداد الحروف بالأسفل
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF2C304D)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 3) {
            FocusScope.of(context).nextFocus(); // الانتقال التلقائي للمربع التالي عند الكتابة
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus(); // الرجوع للمربع السابق عند المسح
          }
        },
      ),
    );
  }
}