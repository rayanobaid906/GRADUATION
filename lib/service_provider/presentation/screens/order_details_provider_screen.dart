import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/order_details/order_details_bloc.dart';
import '../../business_logic/order_details/order_details_event.dart';
import '../../business_logic/order_details/order_details_state.dart';
import 'qr_scanner_screen.dart';
import 'package:graduation/app_colors.dart';

class OrderDetailsProviderScreen extends StatelessWidget {
  final String orderId;
  const OrderDetailsProviderScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderDetailsBloc()..add(LoadOrderDetails(orderId)),
      child: Scaffold(
        appBar: AppBar(title: Text('تفاصيل الطلب #$orderId', style: const TextStyle(color: AppColors.textPrimary)), iconTheme: const IconThemeData(color: AppColors.textPrimary), backgroundColor: AppColors.surface),
        body: BlocConsumer<OrderDetailsBloc, OrderDetailsState>(
          listener: (context, state) {
            if (state is QRSubmitting) {
              showDialog(context: context, barrierDismissible: false, builder: (_) => const Center(child: CircularProgressIndicator()));
            }
            if (state is QRSubmitSuccess) {
              Navigator.pop(context); 
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إنهاء الطلب وتأكيد العملية بنجاح!'), backgroundColor: Colors.green));
              Navigator.pop(context); 
            }
            if (state is QRSubmitFailure) {
              Navigator.pop(context); 
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: Colors.red));
            }
          },
          builder: (context, state) {
            if (state is OrderDetailsLoading) return const Center(child: CircularProgressIndicator());
            if (state is OrderDetailsError) return Center(child: Text(state.message));

            if (state is OrderDetailsLoaded || state is QRSubmitting || state is QRSubmitFailure) {
              final order = (state is OrderDetailsLoaded) ? state.order : (context.read<OrderDetailsBloc>().state as dynamic).order;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.purple.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.red)),
                      child: const Text('حالة الطلب: معلق بانتظار مسح كود الإغلاق (CompletionPending)', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 24),
                    const Text('تفاصيل المشكلة المطلوبة:', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                    const SizedBox(height: 8),
                    Text(order.description, style: const TextStyle(fontSize: 14, height: 1.4, color: AppColors.textPrimary)),
                    const Divider(height: 32),
                    Text('العميل: ${order.customerName}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: AppColors.textPrimary)),
                    Text('الهاتف: ${order.customerPhone}', style: const TextStyle(fontSize: 14, color: AppColors.textPrimary)),
                    const Spacer(),
                    if (order.status == 'CompletionPending')
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 16)),
                          icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
                          label: const Text('مسح كود الـ QR لإنهاء الطلب', style: TextStyle(color: Colors.white, fontSize: 16)),
                          onPressed: () async {
                            final code = await Navigator.push<String>(context, MaterialPageRoute(builder: (context) => const QrScannerScreen()));
                            if (code != null && context.mounted) {
                              context.read<OrderDetailsBloc>().add(CompleteOrderWithQR(orderId: orderId, qrHash: code));
                            }
                          },
                        ),
                      ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}