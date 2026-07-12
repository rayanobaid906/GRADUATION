import 'package:flutter/material.dart';
import 'package:graduation/app_colors.dart';
// import 'package:graduation/app_colors.dart';
import 'package:latlong2/latlong.dart';
import 'package:graduation/location_picker_page.dart';
import 'package:provider/provider.dart';
import 'package:graduation/providers/order_provider.dart';

class CreateOrder extends StatefulWidget {
  const CreateOrder({super.key});

  @override
  State<CreateOrder> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrder> {
  final _formKey = GlobalKey<FormState>();
  LatLng? _selectedLocation;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  int? _selectedSpecializationId;

  @override
  void initState() {
    super.initState();

    print('INIT STATE');

    Future.microtask(() {
      print('CALLING PROVIDER');
      context.read<OrderProvider>().getSpecializations();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
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
          'إنشاء طلب جديد',
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
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.info_outline_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'يرجى إدخال معلومات واضحة ودقيقة عن الطلب حتى نتمكن من معالجته بسرعة وبدقة.',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'التخصص',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),

              Consumer<OrderProvider>(
                builder: (context, orderProvider, child) {
                  if (orderProvider.isLoadingSpecializations) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (orderProvider.errorMessage != null) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderProvider.errorMessage!,
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            color: Colors.red,
                          ),
                        ),

                        TextButton(
                          onPressed: () {
                            context.read<OrderProvider>().getSpecializations();
                          },
                          child: const Text('إعادة المحاولة'),
                        ),
                      ],
                    );
                  }
                  if (orderProvider.specializations.isEmpty) {
                    return const Text(
                      'لا توجد تخصصات متاحة حالياً',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: AppColors.textSecondary,
                      ),
                    );
                  }

                  return DropdownButtonFormField<int>(
                    value: _selectedSpecializationId,
                    hint: const Text(
                      'اختر التخصص من القائمة',
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
                      errorStyle: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 12,
                        color: Color.fromARGB(255, 185, 54, 54),
                      ),
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
                    items: orderProvider.specializations.map((specialization) {
                      return DropdownMenuItem<int>(
                        value: specialization.id,
                        child: Text(
                          specialization.name,
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 14,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedSpecializationId = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'يرجى اختيار تخصص قبل المتابعة';
                      }

                      return null;
                    },
                  );
                },
              ),
              const SizedBox(height: 20),

              const Text(
                'عنوان الطلب',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  errorStyle: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 12,
                    color: Color.fromARGB(255, 185, 54, 54),
                  ),
                  hintText: 'اكتب عنوانًا واضحًا يصف ما تحتاجه',
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
                validator: (value) =>
                    value == null || value.trim().isEmpty
                        ? 'يرجى إدخال عنوان الطلب'
                        : null,
              ),

              const SizedBox(height: 20),

              const Text(
                'وصف الطلب',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  errorStyle: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 12,
                    color: Color.fromARGB(255, 185, 54, 54),
                  ),
                  hintText:
                      'اكتب تفاصيل الطلب بشكل واضح حتى يتمكن العامل من فهم المطلوب بدقة وتقديم أفضل خدمة.',
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
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'يرجى إدخال وصف الطلب'
                    : null,
              ),
              const SizedBox(height: 20),

              const Text(
                'الموقع',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 8),

              InkWell(
                onTap: () async {
                  final result = await Navigator.push<LatLng>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LocationPickerPage(),
                    ),
                  );

                  if (result != null) {
                    setState(() {
                      _selectedLocation = result;
                    });
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.08),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _selectedLocation == null
                              ? 'اختر موقع الطلب من الخريطة'
                              : 'تم اختيار الموقع: ${_selectedLocation!.latitude.toStringAsFixed(5)}, ${_selectedLocation!.longitude.toStringAsFixed(5)}',
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 13,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
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
                      colors: [AppColors.primary, Color(0xFFC69214)],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      if (_selectedLocation == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'يرجى اختيار موقع الطلب',
                              style: TextStyle(fontFamily: 'Cairo'),
                            ),
                          ),
                        );
                        return;
                      }

                      final orderProvider = context.read<OrderProvider>();

                      final success = await orderProvider.createOrder(
                        specializationId: _selectedSpecializationId!,
                        description:
                            '${_titleController.text.trim()}\n${_descriptionController.text.trim()}',
                        latitude: _selectedLocation!.latitude,
                        longitude: _selectedLocation!.longitude,
                        addressText: 'الموقع غير متاح',
                      );

                      if (!mounted) return;

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'تم إنشاء الطلب بنجاح',
                              style: TextStyle(fontFamily: 'Cairo'),
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              orderProvider.createOrderError ??
                                  'فشل إنشاء الطلب',
                              style: const TextStyle(fontFamily: 'Cairo'),
                            ),
                            backgroundColor: Colors.red,
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
                    child: Consumer<OrderProvider>(
                      builder: (context, orderProvider, child) {
                        if (orderProvider.isCreatingOrder) {
                          return const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          );
                        }

                        return const Text(
                          'إنشاء الطلب',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      },
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

