import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';

final currentUserProvider = StateProvider<User>((ref) {
  return User(name: 'Sarah Johnson', email: 'sarah@example.com', phone: '(555) 123-4567', hasActiveWaiver: true, membershipType: 'Monthly Unlimited');
});

final childrenProvider = StateNotifierProvider<ChildrenNotifier, List<Child>>((ref) => ChildrenNotifier());

class ChildrenNotifier extends StateNotifier<List<Child>> {
  ChildrenNotifier() : super([
    Child(name: 'Emma Johnson', dateOfBirth: DateTime(2020, 5, 15), allergies: 'Peanuts'),
    Child(name: 'Liam Johnson', dateOfBirth: DateTime(2022, 8, 22)),
  ]);

  void addChild(Child child) => state = [...state, child];
  void removeChild(String id) => state = state.where((c) => c.id != id).toList();
  void updateChild(Child updated) => state = [for (final c in state) if (c.id == updated.id) updated else c];
}

final bookingsProvider = StateNotifierProvider<BookingsNotifier, List<Booking>>((ref) => BookingsNotifier());

class BookingsNotifier extends StateNotifier<List<Booking>> {
  BookingsNotifier() : super(_mock);

  void toggleBooking(String id) {
    state = state.map((b) {
      if (b.id == id) {
        return Booking(
          id: b.id, className: b.className, dateTime: b.dateTime, timeSlot: b.timeSlot,
          capacity: b.capacity, booked: b.isBooked ? b.booked - 1 : b.booked + 1,
          ageGroup: b.ageGroup, isBooked: !b.isBooked,
        );
      }
      return b;
    }).toList();
  }
}

final _mock = [
  Booking(className: 'Tiny Tumblers', dateTime: DateTime.now().add(const Duration(days: 1)), timeSlot: '9:00 AM - 10:00 AM', capacity: 12, booked: 8, ageGroup: '2-4 years'),
  Booking(className: 'Open Play', dateTime: DateTime.now().add(const Duration(days: 1)), timeSlot: '10:30 AM - 12:00 PM', capacity: 20, booked: 15, ageGroup: 'All Ages'),
  Booking(className: 'Gym Stars', dateTime: DateTime.now().add(const Duration(days: 2)), timeSlot: '1:00 PM - 2:00 PM', capacity: 15, booked: 10, ageGroup: '5-8 years'),
  Booking(className: 'Open Play', dateTime: DateTime.now().add(const Duration(days: 2)), timeSlot: '3:00 PM - 4:30 PM', capacity: 20, booked: 20, ageGroup: 'All Ages'),
  Booking(className: 'Baby Bounce', dateTime: DateTime.now().add(const Duration(days: 3)), timeSlot: '9:30 AM - 10:15 AM', capacity: 10, booked: 4, ageGroup: '0-2 years'),
  Booking(className: 'Ninja Warriors', dateTime: DateTime.now().add(const Duration(days: 3)), timeSlot: '2:00 PM - 3:00 PM', capacity: 15, booked: 12, ageGroup: '6-10 years'),
];

final membershipPlansProvider = Provider<List<MembershipPlan>>((ref) => [
  MembershipPlan(name: 'Drop-In Pass', price: '\$25', period: 'per visit', description: 'Single day access to open play area'),
  MembershipPlan(name: 'Monthly Unlimited', price: '\$89', period: 'per month', description: 'Unlimited open play + 4 classes/month', isPopular: true),
  MembershipPlan(name: 'Family Plan', price: '\$149', period: 'per month', description: 'Up to 3 siblings, unlimited everything'),
]);

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
final isAuthenticatedProvider = StateProvider<bool>((ref) => false);

final pushNotificationsProvider = StateProvider<bool>((ref) => true);
final emailNotificationsProvider = StateProvider<bool>((ref) => true);
final darkModeProvider = StateProvider<bool>((ref) => false);
