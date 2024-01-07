import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/core/config/exception_handlers.dart';
import 'package:wholecela/data/models/order.dart';
import 'package:wholecela/data/models/order_item_dto.dart';
import 'package:wholecela/data/repositories/order/order_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;
  OrderBloc({
    required this.orderRepository,
  }) : super(OrderStateInitial()) {
    on<AddOrder>((event, emit) async {
      emit(OrderStateLoading());
      try {
        final order = await orderRepository.addOrder(
          status: event.status,
          totalPrice: event.totalPrice,
          userId: event.userId,
          locationId: event.locationId,
        );

        emit(OrderStateAdded(orderId: order.id));
      } on AppException catch (e) {
        emit(
          OrderStateError(
            message: e,
          ),
        );
      }
    });

    on<AddOrderItems>((event, emit) async {
      emit(OrderStateLoading());
      try {
        final orderItems = event.orderItems;
        for (var i = 0; i < orderItems.length; i++) {
          await orderRepository.addOrderItem(
            orderId: orderItems[i].orderId,
            quantity: orderItems[i].quantity,
            productId: orderItems[i].productId,
          );
        }

        emit(OrderStateCreated());
      } on AppException catch (e) {
        emit(
          OrderStateError(
            message: e,
          ),
        );
      }
    });

    on<LoadOrder>((event, emit) async {
      emit(OrderStateLoading());
      try {
        final order = await orderRepository.getOrder(id: event.id);

        emit(LoadedOrder(order: order));
      } on AppException catch (e) {
        emit(
          OrderStateError(
            message: e,
          ),
        );
      }
    });

    on<LoadOrders>((event, emit) async {
      emit(OrderStateLoading());
      try {
        final orders = await orderRepository.getOrders(userId: event.userId);

        emit(LoadedOrders(orders: orders));
      } on AppException catch (e) {
        emit(
          OrderStateError(
            message: e,
          ),
        );
      }
    });

    // on<OrderUpdateDetails>((event, emit) async {
    //   emit(
    //     OrderStateLoading(),
    //   );

    //   try {
    //     final productResponse = await productRepository.updateProductDetails(
    //       product: event.product,
    //     );

    //     emit(LoadedOrder(product: productResponse));
    //   } on AppException catch (e) {
    //     emit(
    //       OrderStateError(
    //         message: e,
    //       ),
    //     );
    //   }
    // });

    // on<OrderUpdateImage>((event, emit) async {
    //   emit(
    //     OrderStateLoading(),
    //   );

    //   try {
    //     final productResponse = await productRepository.updateProductImage(
    //       productId: event.product.id,
    //       image: File(event.product.imageUrl!),
    //     );

    //     emit(LoadedOrder(product: productResponse));
    //   } on AppException catch (e) {
    //     emit(
    //       OrderStateError(
    //         message: e,
    //       ),
    //     );
    //   }
    // });
  }
}
