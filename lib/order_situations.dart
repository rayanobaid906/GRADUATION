import 'package:flutter/material.dart';
import 'package:graduation/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:graduation/providers/order_provider.dart';
import 'package:graduation/order_details_page.dart';
class OrderSituations extends StatefulWidget {
  const OrderSituations({super.key});

  @override
  State<OrderSituations> createState() => _OrderSituationsState();
}

class _OrderSituationsState extends State<OrderSituations> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<OrderProvider>().getMyOrders();
    });
  }

  Widget _ordersList(List<dynamic> orders, String emptyMessage) {
    if (orders.isEmpty) {
      return Center(
        child: Text(
          emptyMessage,
          style: const TextStyle(
            fontFamily: 'Cairo',
            color: AppColors.textSecondary,
            fontSize: 16,
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: context.read<OrderProvider>().getMyOrders,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final order = orders[index];

          return InkWell(
  borderRadius: BorderRadius.circular(16),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderDetailsPage(
          orderId: order.id,
        ),
      ),
    );
  },
  child: Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(16),),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.specializationName,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  order.description,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  order.addressText ?? '┘ä╪º ┘è┘ê╪¼╪» ╪╣┘å┘ê╪º┘å',
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '╪▒┘é┘à ╪º┘ä╪╖┘ä╪¿: ${order.id}',
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ));
  
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor:
            AppColors.background, // ╪º┘ä╪¡┘ü╪º╪╕ ╪╣┘ä┘ë ╪º┘ä╪«┘ä┘ü┘è╪⌐ ╪º┘ä╪»╪º┘â┘å╪⌐ ┘ä┘ä╪¬╪╖╪¿┘è┘é
        // 2. ╪Ñ┘å╪┤╪º╪í ╪º┘ä┘Ç TabBar ┘ü┘è ╪º┘ä╪¼╪▓╪í ╪º┘ä╪╣┘ä┘ê┘è
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(
            50,
          ), // ╪¬╪¡╪»┘è╪» ╪º╪▒╪¬┘ü╪º╪╣ ┘à┘å╪º╪│╪¿ ┘ä┘ä┘Ç TabBar
          child: Container(
            color: AppColors.background,
            child: TabBar(
              // ╪¬╪«╪╡┘è╪╡ ╪º┘ä╪¬╪╡┘à┘è┘à ┘ä┘è╪¬┘å╪º╪│╪¿ ┘à╪╣ ╪º┘ä┘ç┘ê┘è╪⌐ ╪º┘ä╪¿╪╡╪▒┘è╪⌐ ╪º┘ä┘ü╪«┘à╪⌐ ┘ä┘Ç FIXIT
              indicatorColor:
                  AppColors.primary, // ┘ä┘ê┘å ╪º┘ä╪«╪╖ ╪º┘ä╪│┘ü┘ä┘è ╪º┘ä┘à╪╢┘è╪í ┘ä┘ä╪¬╪¿┘ê┘è╪¿ ╪º┘ä┘å╪┤╪╖
              indicatorWeight: 3, // ╪│┘à┘â ╪º┘ä╪«╪╖ ╪º┘ä╪│┘ü┘ä┘è
              labelColor: AppColors.primary, // ┘ä┘ê┘å ┘å╪╡ ╪º┘ä╪¬╪¿┘ê┘è╪¿ ╪º┘ä┘å╪┤╪╖
              unselectedLabelColor:
                  AppColors.textSecondary, //! ┘ä┘ê┘å ┘å╪╡ ╪º┘ä╪¬╪¿┘ê┘è╪¿ ╪║┘è╪▒ ╪º┘ä┘å╪┤╪╖
              labelStyle: const TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              unselectedLabelStyle: const TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
              tabs: const [
                Tab(text: "╪╖┘ä╪¿╪º╪¬ ╪¼╪º╪▒┘è╪⌐"),
                Tab(text: "╪╖┘ä╪¿╪º╪¬ ┘à┘å╪¬┘ç┘è╪⌐"),
              ],
            ),
          ),
        ),

        // 3. ┘à╪¡╪¬┘ê┘ë ┘â┘ä ╪¬╪¿┘ê┘è╪¿ (╪º┘ä┘Ç Pages ╪º┘ä╪»╪º╪«┘ä┘è╪⌐ ╪º┘ä╪¬┘è ╪¬╪¬╪¿╪»┘ä ╪╣┘å╪» ╪º┘ä╪╢╪║╪╖ ╪ú┘ê ╪º┘ä╪│╪¡╪¿)
        body: Consumer<OrderProvider>(
          builder: (context, orderProvider, child) {
            if (orderProvider.isLoadingMyOrders) {
              return const Center(child: CircularProgressIndicator());
            }

            if (orderProvider.myOrdersError != null) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      orderProvider.myOrdersError!,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        color: Colors.red,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<OrderProvider>().getMyOrders();
                      },
                      child: const Text('╪Ñ╪╣╪º╪»╪⌐ ╪º┘ä┘à╪¡╪º┘ê┘ä╪⌐'),
                    ),
                  ],
                ),
              );
            }

            final activeOrders = orderProvider.myOrders
                .where((order) => order.status != 4 && order.status != 5)
                .toList();

            final completedOrders = orderProvider.myOrders
                .where((order) => order.status == 4)
                .toList();

            return TabBarView(
              children: [
                _ordersList(activeOrders, '┘ä╪º ╪¬┘ê╪¼╪» ╪╖┘ä╪¿╪º╪¬ ╪¼╪º╪▒┘è╪⌐ ╪¡╪º┘ä┘è╪º┘ï ≡ƒ¢á∩╕Å'),
                _ordersList(completedOrders, '╪│╪¼┘ä ╪º┘ä╪╖┘ä╪¿╪º╪¬ ╪º┘ä┘à┘â╪¬┘à┘ä╪⌐ ┘ü╪º╪▒╪║ ≡ƒôü'),
              ],
            );
          },
        ),
      ),
    );
  }
}
