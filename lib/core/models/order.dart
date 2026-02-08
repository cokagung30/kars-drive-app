import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class Order extends Equatable {
  const Order({
    required this.id,
    required this.orderDate,
    required this.guestFirstName,
    required this.guestLastName,
    required this.guestPhoneNumber,
    required this.guestEmail,
    required this.flightNumber,
    required this.pickUpLocation,
    required this.dropLocation,
    required this.guestAdultCount,
    required this.guestPetCount,
    required this.guestBabyCount,
    required this.guestLuggage,
    required this.amount,
    required this.distance,
    required this.estimation,
    required this.estimationIncome,
    required this.platformIncome,
    required this.pickUpNote,
    required this.status,
    required this.car,
    required this.pickupCoordinate,
    required this.dropoffCoordinate,
    this.estimatePickupDay = 1,
    this.expiredPickupDay = 1,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    final date = json['date'] as String;
    final time = json['time'] as String;

    return Order(
      id: json['uuid'] as String,
      orderDate: DateTime.parse('$date $time'),
      guestFirstName: json['guest_first_name'] as String,
      guestLastName: json['guest_last_name'] as String,
      guestPhoneNumber: json.containsKey('phone_number')
          ? json['phone_number'] as String?
          : null,
      guestEmail: json.containsKey('email') ? json['email'] as String? : null,
      flightNumber: json['flight_number'] as String?,
      pickUpLocation: json['pickup_location'] as String,
      dropLocation: json['dropoff_location'] as String,
      guestAdultCount: json.containsKey('guest_adult_count')
          ? json['guest_adult_count'] as num
          : 0,
      guestPetCount: json.containsKey('guest_pet_count')
          ? json['guest_pet_count'] as num
          : 0,
      guestBabyCount: json.containsKey('guest_baby_count')
          ? json['guest_baby_count'] as num
          : 0,
      guestLuggage: json.containsKey('guest_tools')
          ? (json['guest_tools'] as List<dynamic>)
                .map((dynamic e) => e as String)
                .toList()
          : [],
      amount: num.parse(json['amount'] as String),
      distance: num.parse(json['distance'] as String),
      estimation: json.containsKey('estimated_duration')
          ? json['estimated_duration'] as String
          : null,
      estimationIncome: json.containsKey('estimate_income')
          ? json['estimate_income'] as num
          : 0,
      platformIncome: json.containsKey('platform_income')
          ? json['platform_income'] as num
          : 0,
      pickUpNote: json.containsKey('pickup_note')
          ? json['pickup_note'] as String?
          : null,
      status: json.containsKey('status')
          ? json['status'] as String
          : 'COMPLETED',
      car: json.containsKey('car_class')
          ? (json['car_class'] != null)
                ? CarClass.fromJson(json['car_class'] as Map<String, dynamic>)
                : null
          : null,
      pickupCoordinate: json.containsKey('pickup_coordinate')
          ? Coordinate.fromJson(
              json['pickup_coordinate'] as Map<String, dynamic>,
            )
          : null,
      dropoffCoordinate: json.containsKey('dropoff_coordinate')
          ? Coordinate.fromJson(
              json['dropoff_coordinate'] as Map<String, dynamic>,
            )
          : null,
      expiredPickupDay: json.containsKey('expired_pickup_day')
          ? json['expired_pickup_day'] as num
          : 1,
      estimatePickupDay: json.containsKey('estimate_pickup_date')
          ? json['estimate_pickup_date'] as num
          : 1,
    );
  }

  final String id;

  final DateTime orderDate;

  final String guestFirstName;

  final String guestLastName;

  final String? guestPhoneNumber;

  final String? guestEmail;

  final String? flightNumber;

  final String pickUpLocation;

  final String dropLocation;

  final num guestAdultCount;

  final num guestPetCount;

  final num guestBabyCount;

  final num amount;

  final num distance;

  final String? estimation;

  final num estimatePickupDay;

  final num expiredPickupDay;

  final List<String> guestLuggage;

  final num estimationIncome;

  final num platformIncome;

  final String? pickUpNote;

  final CarClass? car;

  final String status;

  final Coordinate? pickupCoordinate;

  final Coordinate? dropoffCoordinate;

  @override
  List<Object?> get props => [
    id,
    orderDate,
    guestFirstName,
    guestLastName,
    guestPhoneNumber,
    flightNumber,
    pickUpLocation,
    dropLocation,
    guestAdultCount,
    guestPetCount,
    guestBabyCount,
    amount,
    distance,
    estimation,
    guestLuggage,
    estimationIncome,
    pickUpNote,
    status,
    car,
    pickupCoordinate,
    dropoffCoordinate,
    estimatePickupDay,
    expiredPickupDay,
  ];
}

extension OrderX on Order {
  bool get hasActionButtons => [
    'PAID_CUSTOMER',
    'CONFIRM_BID',
    'PICKUP',
    'ONDELIVER',
  ].where((e) => e == status).isNotEmpty;

  Color get orderStatusColor {
    return switch (status) {
      'PAID_CUSTOMER' => ColorName.colorPaidCustomer,
      'UNPAID' => ColorName.colorUnpaid,
      'CONFIRM_BID' => ColorName.colorConfirmBid,
      'PICKUP' => ColorName.colorPickup,
      'ONDELIVER' => ColorName.colorOndeliver,
      'ONSITE' => ColorName.colorOnSite,
      'WAIT_PAYMENT' => ColorName.colorWaitPayment,
      'PAID' => ColorName.colorPaid,
      'COMPLETED' => ColorName.colorCompleted,
      'CANCELED' ||
      'WAIT_REFUND' ||
      'REFUNDED' ||
      'REFUND_REJECTED' => ColorName.candyRed,
      _ => ColorName.colorOpen,
    };
  }

  String get statusName {
    return switch (status) {
      'PAID_CUSTOMER' => 'Pembayaran Awal',
      'UNPAID' => 'Belum Dibayar',
      'CONFIRM_BID' => 'Konfirmasi Pesanan',
      'PICKUP' => 'Siap Dijemput',
      'ONDELIVER' => 'Sedang Diantar',
      'ONSITE' => 'Sampai Tujuan',
      'WAIT_PAYMENT' => 'Menunggu Pembayaran',
      'PAID' => 'Lunas',
      'COMPLETED' => 'Selesai',
      'CANCELED' ||
      'WAIT_REFUND' ||
      'REFUNDED' ||
      'REFUND_REJECTED' => 'Dibatalkan',
      _ => 'Diajukan',
    };
  }

  String get duration {
    if (estimation == null) return '-';
    return estimation!
        .replaceAll('j', ' Jam')
        .replaceAll('h', ' Jam')
        .replaceAll('minutes', ' Menit')
        .replaceAll('m', ' Menit');
  }

  bool get canPickup {
    final today = DateTime.now();

    final estimatePickUpDate = orderDate.subtract(
      Duration(days: estimatePickupDay.toInt()),
    );

    final expiredPickUpDate = orderDate.add(
      Duration(days: expiredPickupDay.toInt()),
    );

    return today.isAtSameMomentAs(estimatePickUpDate) ||
        (today.isAtSameMomentAs(expiredPickUpDate) ||
            today.isBefore(expiredPickUpDate));
  }
}
