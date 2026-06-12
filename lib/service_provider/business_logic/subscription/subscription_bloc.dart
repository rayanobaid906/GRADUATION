import 'package:flutter_bloc/flutter_bloc.dart';
import 'subscription_event.dart';
import 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  SubscriptionBloc() : super(SubscriptionInitial()) {

    on<CheckSubscriptionStatus>((event, emit) async {
      emit(SubscriptionLoading());
      try {
        await Future.delayed(const Duration(milliseconds: 600));
        emit(SubscriptionStatusLoaded(
          isActive: false, 
          expiryDate: "2026-06-01", 
          pendingTransactionId: null,
        ));
      } catch (e) {
        emit(SubscriptionSubmitFailure("خطأ في جلب بيانات الاشتراك"));
      }
    });

    on<SubmitSubscriptionPayment>((event, emit) async {
      emit(SubscriptionSubmitting());
      try {
        await Future.delayed(const Duration(seconds: 1));
        emit(SubscriptionSubmitSuccess());
        emit(SubscriptionStatusLoaded(
          isActive: false,
          expiryDate: "بانتظار تفعيل المسؤول",
          pendingTransactionId: event.transactionId,
        ));
      } catch (e) {
        emit(SubscriptionSubmitFailure("فشل إرسال رقم المعاملة"));
      }
    });
  }
}