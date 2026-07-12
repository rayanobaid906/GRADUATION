import 'package:flutter/material.dart';
import 'package:graduation/create_order.dart';
import 'package:provider/provider.dart';
import 'package:graduation/app_colors.dart';
import 'package:graduation/service_provider/business_logic/provider_dashboard/provider_dashboard_provider.dart';
import 'package:graduation/service_provider/presentation/screens/available_orders_screen.dart';
import 'package:graduation/service_provider/presentation/screens/qr_scanner_screen.dart';
import 'package:graduation/service_provider/presentation/screens/subscription_payment_screen.dart';

class ProviderDashboard extends StatelessWidget {
  const ProviderDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProviderDashboardProvider(),
      child: const _ProviderDashboardContent(),
    );
  }
}

class _ProviderDashboardContent extends StatelessWidget {
  const _ProviderDashboardContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProviderDashboardProvider>();

    Widget bodyContent;
    switch (provider.selectedIndex) {
      case 1:
        bodyContent = const AvailableOrdersView();
        break;
      default:
        bodyContent = SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. رسالة الترحيب
              const Text(
                'مرحباً بك، أحمد 👋',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 20),

              // 2. لوحة تحكم مقدم الخدمة (Dashboard Card)
              _buildProviderDashboardCard(context),
              const SizedBox(height: 30),

              // 3. قسم طلب خدمة جديدة (كعميل)
              const Text(
                '🛒 اطلب خدمة جديدة (كعميل):',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 12),
              _buildCustomerServicesGrid(context), // 🛠️ قمنا بتمرير الـ context هنا
              const SizedBox(height: 30),

              // 4. أحدث الطلبات المطابقة للتخصص
              const Text(
                '📌 أحدث الطلبات في منطقتك المطابقة لتخصصك:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 12),
              _buildLatestOrdersList(),
            ],
          ),
        );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('🛠️ خدمات الصيانة المنزلية'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.surface,
        foregroundColor: Colors.white,
      ),
      body: bodyContent,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.selectedIndex,
        onTap: provider.onBottomNavTap,
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'طلباتي'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }

  // --- دوال بناء أجزاء الواجهة (Widgets) ---

  Widget _buildProviderDashboardCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '💼 لوحة تحكم مقدم الخدمة (تخصص: كهرباء)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'حالة الاشتراك: فعال ✅ (ينتهي بعد 12 يوم)',
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'الإجراءات السريعة:',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                _buildActionButton('🔍 تصفح الطلبات', Colors.blue.shade700, () {}),
                _buildActionButton('📸 مسح كود QR', Colors.teal.shade700, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QrScannerScreen()),
                  );
                }),
                _buildActionButton('💳 تمديد الاشتراك', Colors.orange.shade700, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SubscriptionPaymentScreen()),
                  );
                }),
                _buildActionButton('📊 عروضي الحالية', Colors.purple.shade700, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AvailableOrdersScreen()),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String title, Color color, VoidCallback onTap) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
      onPressed: onTap,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  // 🛠️ قمنا بإضافة BuildContext كمعامل هنا
  Widget _buildCustomerServicesGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 1, 
      childAspectRatio: 5,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        _buildServiceCategory(context, 'طلب خدمة', Colors.blue), // 🛠️ تم تمريره هنا أيضاً
      ],
    );
  }

  // 🛠️ قمنا بإضافة BuildContext كمعامل هنا لتتعرف دالة الـ Navigator عليه
  Widget _buildServiceCategory(BuildContext context, String title, Color color) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CreateOrder(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ),
    );
  }

  Widget _buildLatestOrdersList() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 1.5),
      ),
      child: ListTile(
        leading: const Icon(Icons.build_circle, color: Colors.orange, size: 35),
        title: const Text('طلب صيانة لوحة قواطع رئيسية', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary)),
        subtitle: const Text('على بعد 2 كم • منذ 15 دقيقة', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}