import 'package:flutter_bloc/flutter_bloc.dart';
import 'order_details_event.dart';
import 'order_details_state.dart';
import '../../data/models/order_model.dart';

class OrderDetailsBloc extends Bloc<OrderDetailsEvent, OrderDetailsState> {
  OrderDetailsBloc() : super(OrderDetailsInitial()) {

    on<LoadOrderDetails>((event, emit) async {
      emit(OrderDetailsLoading());
      try {
        await Future.delayed(const Duration(milliseconds: 500));
        OrderModel mockOrder = OrderModel(
          id: event.orderId,
          description: "يوجد تسريب مياه أسفل حوض المطبخ الرئيسي بحاجة لإصلاح سريع وتبديل الأنابيب التالفة.",
          status: "CompletionPending", 
          addressText: "دمشق - مشروع دمر - الجزيرة الثالثة",
          customerName: "أحمد العلي",
          customerPhone: "+963912345678",
          createdAt: "منذ ساعتين",
        );
        emit(OrderDetailsLoaded(mockOrder));
      } catch (e) {
        emit(OrderDetailsError("فشل في تحميل تفاصيل الطلب"));
      }
    });

    on<CompleteOrderWithQR>((event, emit) async {
      emit(QRSubmitting());
      try {
        await Future.delayed(const Duration(seconds: 1));
        emit(QRSubmitSuccess());
      } catch (e) {
        emit(QRSubmitFailure("رمز الـ QR غير صالح أو ممسوح مسبقاً"));
      }
    });
  }
}