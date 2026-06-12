import 'package:flutter_bloc/flutter_bloc.dart';
import 'available_orders_event.dart';
import 'available_orders_state.dart';
import '../../data/models/order_model.dart';

class AvailableOrdersBloc extends Bloc<AvailableOrdersEvent, AvailableOrdersState> {
  AvailableOrdersBloc() : super(AvailableOrdersInitial()) {
    
    on<FetchAvailableOrders>((event, emit) async {
      emit(AvailableOrdersLoading());
      try {
        await Future.delayed(const Duration(seconds: 1));
        List<OrderModel> mockOrders = [
          OrderModel(
            id: "101",
            description: "يوجد تسريب مياه أسفل حوض المطبخ الرئيسي بحاجة لإصلاح سريع وتبديل الأنابيب التالفة.",
            status: "Open",
            addressText: "دمشق - مشروع دمر - الجزيرة الثالثة",
            createdAt: "منذ 10 دقائق",
          ),
          OrderModel(
            id: "102",
            description: "صيانة وتغيير خلاط مياه الحمام التالف بالكامل مع الفحص العام.",
            status: "Open",
            addressText: "دمشق - الميدان - بالقرب من جامع الحسن",
            createdAt: "منذ ساعة",
          )
        ];
        emit(AvailableOrdersLoaded(mockOrders));
      } catch (e) {
        emit(AvailableOrdersError("فشل تحميل الطلبات المتاحة"));
      }
    });

    on<SubmitOfferEvent>((event, emit) async {
      emit(AvailableOrdersLoading());
      try {
        await Future.delayed(const Duration(milliseconds: 800));
        emit(OfferSubmittedSuccess());
        add(FetchAvailableOrders()); 
      } catch (e) {
        emit(AvailableOrdersError("فشل إرسال عرض السعر للعميل"));
      }
    });
  }
}