import 'package:flutter/material.dart';
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
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: AppColors.textPrimary),
              ),
              const SizedBox(height: 20),

              // 2. لوحة تحكم مقدم الخدمة (Dashboard Card)
              _buildProviderDashboardCard(context),
              const SizedBox(height: 30),

              // 3. قسم طلب خدمة جديدة (كعميل)
              const Text(
                '🛒 اطلب خدمة جديدة (كعميل):',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: AppColors.textPrimary),
              ),
              const SizedBox(height: 12),
              _buildCustomerServicesGrid(),
              const SizedBox(height: 30),

              // 4. أحدث الطلبات المطابقة للتخصص
              const Text(
                '📌 أحدث الطلبات في منطقتك المطابقة لتخصصك:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: AppColors.textPrimary),
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
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'طلباتي',),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }

  // --- دوال بناء أجزاء الواجهة (Widgets) ---

  // تم تغيير اسم هذه الدالة قليلاً لتجنب التعارض مع اسم الكلاس الجديد
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
            // عنوان اللوحة وحالة الاشتراك
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
            
            // شبكة الأزرار السريعة
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 2.5, // للتحكم بعرض وارتفاع الزر
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
                _buildActionButton('📊 عروضي الحالية', Colors.purple.shade700, () {}),
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

  Widget _buildCustomerServicesGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4, // 4 عناصر في نفس السطر
      childAspectRatio: 0.8,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        _buildServiceCategory('⚡\nكهرباء', Colors.orange),
        _buildServiceCategory('🚰\nسباكة', Colors.blue),
        _buildServiceCategory('❄️\nتكييف', Colors.cyan),
        _buildServiceCategory('📺\nأجهزة', Colors.purple),
      ],
    );
  }

  Widget _buildServiceCategory(String title, Color color) {
    return InkWell(
      onTap: () {},
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













// import 'package:flutter/material.dart';
// import 'package:graduation/app_colors.dart';
// import 'presentation/screens/available_orders_screen.dart';
// import 'presentation/screens/subscription_payment_screen.dart';

// class ProviderDashboardLaunchScreen extends StatefulWidget {
//   const ProviderDashboardLaunchScreen({Key? key}) : super(key: key);

//   @override
//   State<ProviderDashboardLaunchScreen> createState() => _ProviderDashboardLaunchScreenState();
// }

// class _ProviderDashboardLaunchScreenState extends State<ProviderDashboardLaunchScreen> {
//   int _selectedIndex = 0;

//   Widget _buildProviderBody(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(24.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           const Icon(Icons.engineering, size: 80, color: AppColors.primary),
//           const SizedBox(height: 32,),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), backgroundColor: AppColors.surface),
//             onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AvailableOrdersScreen())),
//             child: const Text('استعراض طلبات الصيانة المتاحة',style: TextStyle(color: AppColors.textPrimary)),
//           ),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), backgroundColor: AppColors.surface),
//             onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SubscriptionPaymentScreen())),
//             child: const Text('إدارة الاشتراك والدفع اليدوي',style: TextStyle(color: AppColors.textPrimary)),
//           ),
//         ],
//       ),
//     );
//   }

//   List<Widget> get _pages => [
//     Builder(builder: (context) => _buildProviderBody(context)),
//     const SizedBox.shrink(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(
//         backgroundColor: AppColors.background,
//         elevation: 0,
//         centerTitle: true,
//         title: const Text('لوحة تحكم مقدم الخدمة', style: TextStyle(color: AppColors.textPrimary)),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 20.0),
//             child: IconButton(
//               icon: const Icon(Icons.notifications_none_rounded, color: AppColors.textPrimary, size: 26),
//               onPressed: () {},
//             ),
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         backgroundColor: AppColors.surface,
//         child: Container(
//           decoration: BoxDecoration(
//             color: AppColors.textPrimary,
//             border: Border(
//               left: BorderSide(
//                 color: AppColors.primary.withValues(alpha: 0.4),
//                 width: 1.5,
//               ),
//             ),
//           ),
//           child: Column(
//             children: [
//               const Padding(
//                 padding: EdgeInsets.only(top: 60.0, bottom: 20.0),
//                 child: Text(
//                   "القائمة الرئيسية",
//                   style: TextStyle(
//                     fontFamily: 'Cairo',
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
//                 child: Card(
//                   color: const Color(0xFF222539),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                   child: ListTile(
//                     leading: const Icon(Icons.person_rounded, color: AppColors.primary),
//                     title: const Text("الملف الشخصي", style: TextStyle(fontFamily: 'Cairo', color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
//                     trailing: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textSecondary, size: 14),
//                     onTap: () => Navigator.pop(context),
//                   ),
//                 ),
//               ),
//               const Spacer(),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 20.0),
//                 child: Card(
//                   color: const Color(0xFF2A1B24),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.redAccent.withValues(alpha: 0.2), width: 1)),
//                   child: ListTile(
//                     leading: const Icon(Icons.logout_rounded, color: Colors.redAccent),
//                     title: const Text("تسجيل الخروج", style: TextStyle(fontFamily: 'Cairo', color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 15)),
//                     onTap: () { Navigator.pop(context); },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.only(bottom: 3, top: 3),
//         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
//         decoration: BoxDecoration(
//           color: AppColors.surface,
//           borderRadius: BorderRadius.circular(24),
//           boxShadow: [
//             BoxShadow(color: AppColors.primary.withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(0, 0)),
//             BoxShadow(color: AppColors.primary.withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 4)),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(24),
//           child: Theme(
//             data: Theme.of(context).copyWith(splashColor: const Color.fromARGB(0, 245, 208, 208), highlightColor: Colors.transparent),
//             child: BottomNavigationBar(
//               currentIndex: _selectedIndex,
//               onTap: (index) => setState(() { _selectedIndex = index; }),
//               backgroundColor: Colors.transparent,
//               selectedItemColor: AppColors.primary,
//               unselectedIconTheme: const IconThemeData(size: 24),
//               selectedIconTheme: const IconThemeData(size: 28),
//               unselectedItemColor: AppColors.textSecondary,
//               selectedLabelStyle: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
//               unselectedLabelStyle: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.normal),
//               elevation: 0,
//               items: const [
//                 BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "الرئيسية"),
//                 BottomNavigationBarItem(icon: Icon(Icons.list_alt_rounded), label: "طلباتي"),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
