import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../business_logic/subscription/subscription_provider.dart';
import 'package:graduation/app_colors.dart';

class SubscriptionPaymentScreen extends StatefulWidget {
  const SubscriptionPaymentScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionPaymentScreen> createState() => _SubscriptionPaymentScreenState();
}

class _SubscriptionPaymentScreenState extends State<SubscriptionPaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _txController = TextEditingController();

  @override
  void dispose() {
    _txController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تفعيل الاشتراك السنوي', style: TextStyle(color: AppColors.textPrimary)), backgroundColor: AppColors.surface, iconTheme: const IconThemeData(color: AppColors.textPrimary)),
      body: Consumer<SubscriptionProvider>(
        builder: (context, provider, child) {
          if (provider.successMessage != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(provider.successMessage!), backgroundColor: Colors.green),
              );
              provider.clearMessages();
            });
          }

          if (provider.errorMessage != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(provider.errorMessage!), backgroundColor: Colors.red),
              );
              provider.clearMessages();
            });
          }

          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          bool isActive = provider.isActive;
          String? pendingId = provider.pendingTransactionId;
          String infoText = "الحساب غير نشط - يرجى دفع الاشتراك لتفعيل تقديم العروض.";

          if (isActive) infoText = "اشتراكك نشط وصالح لتقديم العروض.";
          if (pendingId != null) infoText = "يوجد معاملة معلقة برقم ($pendingId) بانتظار موافقة المسؤول.";

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Card(
                    color: isActive ? Colors.green.shade50 : Colors.amber.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(infoText, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('طريقة الدفع والتفعيل (Sham Cash):', style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.textPrimary)),
                  const Text('1. حول قيمة الاشتراك السنوي إلى حساب التطبيق عبر كاش شام.\n2. أدخل رقم العملية (Transaction ID) أدناه للمراجعة.',style: TextStyle(color: AppColors.textPrimary)),
                  const Divider(height: 40),
                  if (pendingId == null && !isActive) ...[
                    TextFormField(
                      controller: _txController,
                      decoration: const InputDecoration(labelText: 'رقم العملية الفريد (Transaction ID)', border: OutlineInputBorder()),
                      validator: (v) => (v == null || v.isEmpty) ? 'الحقل مطلوب' : null,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), backgroundColor: AppColors.surface),
                      onPressed: provider.isSubmitting
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                provider.submitSubscriptionPayment(_txController.text.trim());
                              }
                            },
                      child: provider.isSubmitting
                          ? const SizedBox(
                              height: 20,
                              child: Center(child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
                            )
                          : const Text('إرسال المعاملة للمدير', style: TextStyle(color: AppColors.textPrimary)),
                    ),
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}