import 'package:flutter/material.dart';
import 'package:graduation/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:graduation/providers/auth_provider.dart';

class OtpPage extends StatefulWidget {
  final String email;
  const OtpPage({super.key, required this.email});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose(); // ╪¬╪ú┘â╪» ┘à┘å ╪¬╪¡╪▒┘è╪▒ ╪º┘ä┘à┘ê╪º╪▒╪» ╪╣┘å╪» ╪º┘ä╪¬╪«┘ä╪╡ ┘à┘å ╪º┘ä╪╡┘ü╪¡╪⌐
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
              const Icon(
                Icons.shield_outlined,
                size: 80,
                color: AppColors.primary,
              ),
              const SizedBox(height: 24),
              const Text(
                "Verification Code",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Enter the 6-digit code sent to your phone",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  fontFamily: 'Cairo',
                ),
              ),
              const SizedBox(height: 40),

              // ╪º┘ä┘â╪º╪▒╪» ╪º┘ä┘à╪╢┘è╪í ╪º┘ä╪░┘è ┘è╪¡╪¬┘ê┘è ╪╣┘ä┘ë ╪¡┘é┘ê┘ä ╪º┘ä┘Ç OTP
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.3),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.12),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) => _buildOtpBox(index)),
                ),
              ),
              const SizedBox(height: 30),

              // ╪▓╪▒ ╪º┘ä╪¬╪ú┘â┘è╪»
              ElevatedButton(
                onPressed: () async {
                  final authProvider = Provider.of<AuthProvider>(
                    context,
                    listen: false,
                  );

                  String code = _controllers
                      .map((controller) => controller.text)
                      .join();

                  bool success = await authProvider.verifyEmail(
                    widget.email,
                    code,
                  );

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("تم التحقق بنجاح")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("رمز التحقق غير صحيح"),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Verify",
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
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
      width: 45,
      child: TextFormField(
        controller: _controllers[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          counterText: "", // ╪Ñ╪«┘ü╪º╪í ╪╣╪»╪º╪» ╪º┘ä╪¡╪▒┘ê┘ü ╪¿╪º┘ä╪ú╪│┘ü┘ä
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
            FocusScope.of(
              context,
            ).nextFocus(); // ╪º┘ä╪º┘å╪¬┘é╪º┘ä ╪º┘ä╪¬┘ä┘é╪º╪ª┘è ┘ä┘ä┘à╪▒╪¿╪╣ ╪º┘ä╪¬╪º┘ä┘è ╪╣┘å╪» ╪º┘ä┘â╪¬╪º╪¿╪⌐
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(
              context,
            ).previousFocus(); // ╪º┘ä╪▒╪¼┘ê╪╣ ┘ä┘ä┘à╪▒╪¿╪╣ ╪º┘ä╪│╪º╪¿┘é ╪╣┘å╪» ╪º┘ä┘à╪│╪¡
          }
        },
      ),
    );
  }
}

