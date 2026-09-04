import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class Child {
  final String id;
  final String name;
  final DateTime dateOfBirth;
  final String allergies;
  final String? photoUrl;

  Child({String? id, required this.name, required this.dateOfBirth, this.allergies = '', this.photoUrl})
      : id = id ?? _uuid.v4();

  int get age {
    final now = DateTime.now();
    int a = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month || (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) a--;
    return a;
  }
}

class Booking {
  final String id;
  final String className;
  final DateTime dateTime;
  final String timeSlot;
  final int capacity;
  final int booked;
  final String ageGroup;
  final bool isBooked;

  Booking({String? id, required this.className, required this.dateTime, required this.timeSlot, this.capacity = 20, this.booked = 0, this.ageGroup = 'All Ages', this.isBooked = false})
      : id = id ?? _uuid.v4();

  double get capacityPercent => booked / capacity;
}

class MembershipPlan {
  final String id;
  final String name;
  final String price;
  final String period;
  final String description;
  final bool isPopular;

  MembershipPlan({String? id, required this.name, required this.price, required this.period, required this.description, this.isPopular = false})
      : id = id ?? _uuid.v4();
}

class User {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final bool hasActiveWaiver;
  final String membershipType;

  User({String? id, required this.name, required this.email, this.phone, this.hasActiveWaiver = false, this.membershipType = 'None'})
      : id = id ?? _uuid.v4();
}
