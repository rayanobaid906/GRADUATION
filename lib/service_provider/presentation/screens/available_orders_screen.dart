import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../business_logic/available_orders/available_orders_provider.dart';
import 'order_details_provider_screen.dart';
import 'package:graduation/app_colors.dart';

class AvailableOrdersScreen extends StatelessWidget {
  const AvailableOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الطلبات المتاحة لتخصصك', style: TextStyle(color: AppColors.textPrimary)),iconTheme: const IconThemeData(color: AppColors.textPrimary), 
        backgroundColor: AppColors.surface,
      ),
      body: const AvailableOrdersView(),
    );
  }
}

class AvailableOrdersView extends StatelessWidget {
  const AvailableOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AvailableOrdersProvider>(
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

        final orders = provider.orders;
        if (orders.isEmpty) {
          return const Center(child: Text('لا توجد طلبات مفتوحة حالياً.'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              color: AppColors.surface,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('طلب رقم #${order.id}', style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(order.description, style: const TextStyle(fontSize: 14, color: AppColors.textPrimary)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16, color: Colors.red),
                        const SizedBox(width: 4),
                        Expanded(child: Text(order.addressText, style: const TextStyle(fontSize: 12, color: AppColors.textPrimary))),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), backgroundColor: AppColors.background),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => OrderDetailsProviderScreen(orderId: order.id)),
                              );
                            },
                            child: const Text('التفاصيل والمتابعة', style: TextStyle(color: AppColors.textPrimary)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), backgroundColor: AppColors.background),
                            onPressed: () => _showOfferSheet(context, order.id),
                            child: const Text('تقديم عرض سعر', style: TextStyle(color: AppColors.textPrimary)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showOfferSheet(BuildContext context, String orderId) {
    final priceController = TextEditingController();
    final noteController = TextEditingController();
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(sheetContext).viewInsets.bottom, top: 20, left: 16, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('تقديم عرض للطلب #$orderId', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: AppColors.textPrimary)),
            const SizedBox(height: 16),
            TextField(
              controller: priceController,
              style: const TextStyle(color: AppColors.textPrimary,backgroundColor: AppColors.surface),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'سعر الفحص المتوقع (PriceToCheck)', labelStyle: TextStyle(color: AppColors.textPrimary), border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: noteController,
              style: const TextStyle(color: AppColors.textPrimary,backgroundColor: AppColors.surface),
              decoration: const InputDecoration(labelText: 'ملاحظات إضافية (اختياري)', labelStyle: TextStyle(color: AppColors.textPrimary), border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), backgroundColor: AppColors.background),
                onPressed: () {
                  final price = double.tryParse(priceController.text);
                  if (price != null) {
                    context.read<AvailableOrdersProvider>().submitOffer(
                          orderId: orderId,
                          priceToCheck: price,
                          note: noteController.text,
                        );
                    Navigator.pop(sheetContext);
                  }
                },
                child: const Text('تأكيد وإرسال العرض', style: TextStyle(color: AppColors.textPrimary)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
