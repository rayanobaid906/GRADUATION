import 'package:flutter/material.dart';
import 'package:graduation/app_colors.dart';

class ToBeProvider extends StatefulWidget {
  const ToBeProvider({super.key});

  @override
  State<ToBeProvider> createState() => _ToBeProvider();
}

class _ToBeProvider extends State<ToBeProvider> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedSpecialization;
  final TextEditingController _bioController = TextEditingController();

  final List<String> _specializations = [
    'كهربائي',
    'سباك',
    'نجار',
    'حداد',
  ];

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'التسجيل كمقدم خدمة',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppColors.textPrimary,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.textPrimary,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(200.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'التخصص*',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),

              DropdownButtonFormField<String>(
                value: _selectedSpecialization,
                hint: const Text(
                  'اختر تخصصك من القائمة',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                dropdownColor: AppColors.surface,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.primary,
                ),
                decoration: InputDecoration(
                  fillColor: AppColors.surface,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: AppColors.primary.withOpacity(0.05),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 1.5,
                    ),
                  ),
                ),
                items: _specializations.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedSpecialization = newValue;
                  });
                },
                validator: (value) => value == null
                    ? 'يرجى اختيار تخصص قبل المتابعة'
                    : null,
              ),

              const SizedBox(height: 24),

              const Text(
                'نبذة عنك (اختياري)',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 8),

              TextFormField(
                controller: _bioController,
                maxLines: 4,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText:
                      'اكتب نبذة قصيرة عن خبرتك وخدماتك حتى يعرفك العملاء بشكل أفضل.',
                  hintStyle: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                  fillColor: AppColors.surface,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: AppColors.primary.withOpacity(0.05),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.primary,
                        Color(0xFFC69214),
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('التخصص المختار: $_selectedSpecialization');
                        print('النص: ${_bioController.text}');

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'تم إرسال طلبك بنجاح وسنراجع بياناتك قريبًا.',
                              style: TextStyle(fontFamily: 'Cairo'),
                            ),
                            backgroundColor: AppColors.primary,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'إرسال الطلب',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

