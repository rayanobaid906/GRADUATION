import 'package:flutter/material.dart';
import 'package:graduation/app_colors.dart';
// import 'package:graduation/main_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/main_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'service_provider/business_logic/available_orders/available_orders_bloc.dart';
// import 'service_provider/business_logic/available_orders/available_orders_event.dart';
// import 'service_provider/business_logic/subscription/subscription_bloc.dart';
// import 'service_provider/business_logic/subscription/subscription_event.dart';

import 'presentation/screens/available_orders_screen.dart';
import 'presentation/screens/subscription_payment_screen.dart';

class ProviderDashboardLaunchScreen extends StatelessWidget {
  const ProviderDashboardLaunchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('لوحة تحكم مقدم الخدمة', style: TextStyle(color: AppColors.textPrimary)), backgroundColor: AppColors.surface,),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.engineering, size: 80, color: AppColors.primary),
            const SizedBox(height: 32,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), backgroundColor: AppColors.surface),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AvailableOrdersScreen())),
              child: const Text('استعراض طلبات الصيانة المتاحة',style: TextStyle(color: AppColors.textPrimary)),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), backgroundColor: AppColors.surface),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SubscriptionPaymentScreen())),
              child: const Text('إدارة الاشتراك والدفع اليدوي',style: TextStyle(color: AppColors.textPrimary)),
            ),
          ],
        ),
      ),
    );
  }
}
