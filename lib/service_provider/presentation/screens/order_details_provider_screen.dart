import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../business_logic/order_details/order_details_provider.dart';
import 'qr_scanner_screen.dart';
import 'package:graduation/app_colors.dart';

class OrderDetailsProviderScreen extends StatelessWidget {
  final String orderId;
  const OrderDetailsProviderScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrderDetailsProvider(orderId),
      child: Scaffold(
        appBar: AppBar(
          title: Text('تفاصيل الطلب #$orderId', style: const TextStyle(color: AppColors.textPrimary)),
          iconTheme: const IconThemeData(color: AppColors.textPrimary),
          backgroundColor: AppColors.surface,
        ),
        body: Consumer<OrderDetailsProvider>(
          builder: (context, provider, child) {
            if (provider.successMessage != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(provider.successMessage!), backgroundColor: Colors.green),
                );
                provider.clearMessages();
                Navigator.pop(context);
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

            final order = provider.order;
            if (order == null) {
              return const Center(child: Text('فشل تحميل بيانات الطلب'));
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red),
                    ),
                    child: const Text(
                      'حالة الطلب: معلق بانتظار مسح كود الإغلاق (CompletionPending)',
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    ),
                    const SizedBox(height: 24),
                  const Text(
                    'تفاصيل المشكلة المطلوبة:',
                    style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                    const SizedBox(height: 8),
                    Text(order.description, style: const TextStyle(fontSize: 14, height: 1.4, color: AppColors.textPrimary)),
                    const Divider(height: 32),
                  Text('العميل: ${order.customerName}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                    Text('الهاتف: ${order.customerPhone}', style: const TextStyle(fontSize: 14, color: AppColors.textPrimary)),
                    const Spacer(),
                    if (order.status == 'CompletionPending')
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 16)),
                          icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
                          label: provider.isCompleting
                              ? const SizedBox(
                                  height: 20,
                                  child: Center(child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
                                )
                              : const Text('مسح كود الـ QR لإنهاء الطلب', style: TextStyle(color: Colors.white, fontSize: 16)),
                          onPressed: provider.isCompleting
                              ? null
                              : () async {
                                final code = await Navigator.push<String>(
                                  context,
                                  MaterialPageRoute(builder: (context) => const QrScannerScreen()),
                                );
                                  if (code != null && context.mounted) {
                                    provider.completeOrderWithQR(code);
                                  }
                                },
                        ),
                      ),
                  ],
                ),
              );
          },
        ),
      ),
    );
  }
}
