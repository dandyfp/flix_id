// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Transaction _$$_TransactionFromJson(Map<String, dynamic> json) =>
    _$_Transaction(
      id: json['id'] as String?,
      uid: json['uid'] as String,
      transactionTime: json['transactionTime'] as int?,
      transactionImage: json['transactionImage'] as String?,
      title: json['title'] as String,
      seats:
          (json['seats'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      teaterName: json['teaterName'] as String?,
      watchingTime: json['watchingTime'] as int?,
      ticketAmound: json['ticketAmound'] as int?,
      ticketPrince: json['ticketPrince'] as int?,
      adminFee: json['adminFee'] as int,
      total: json['total'] as int,
    );

Map<String, dynamic> _$$_TransactionToJson(_$_Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'transactionTime': instance.transactionTime,
      'transactionImage': instance.transactionImage,
      'title': instance.title,
      'seats': instance.seats,
      'teaterName': instance.teaterName,
      'watchingTime': instance.watchingTime,
      'ticketAmound': instance.ticketAmound,
      'ticketPrince': instance.ticketPrince,
      'adminFee': instance.adminFee,
      'total': instance.total,
    };
