import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/subscription/subscription_bloc.dart';
import '../../business_logic/subscription/subscription_event.dart';
import 'package:graduation/app_colors.dart';

import '../../business_logic/subscription/subscription_state.dart';

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
      appBar: AppBar(title: const Text('تفعيل الاشتراك السنوي', style: TextStyle(color: AppColors.textPrimary)), backgroundColor: AppColors.surface,iconTheme: const IconThemeData(color: AppColors.textPrimary)),
      body: BlocConsumer<SubscriptionBloc, SubscriptionState>(
        listener: (context, state) {
          if (state is SubscriptionSubmitting) {
            showDialog(context: context, barrierDismissible: false, builder: (_) => const Center(child: CircularProgressIndicator()));
          }
          if (state is SubscriptionSubmitSuccess) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إرسال رقم المعاملة للإدارة للتفعيل اليدوي!'), backgroundColor: Colors.green));
          }
        },
        builder: (context, state) {
          bool isActive = false;
          String? pendingId;
          String infoText = "الحساب غير نشط - يرجى دفع الاشتراك لتفعيل تقديم العروض.";

          if (state is SubscriptionStatusLoaded) {
            isActive = state.isActive;
            pendingId = state.pendingTransactionId;
            if (isActive) infoText = "اشتراكك نشط وصالح لتقديم العروض.";
            if (pendingId != null) infoText = "يوجد معاملة معلقة برقم ($pendingId) بانتظار موافقة المسؤول.";
          }

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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<SubscriptionBloc>().add(SubmitSubscriptionPayment(transactionId: _txController.text.trim()));
                        }
                      },
                      child: const Text('إرسال المعاملة للمدير', style: TextStyle(color: AppColors.textPrimary) ),
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