import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../theme/app_theme.dart';
import '../providers/providers.dart';

class BookingScreen extends ConsumerWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final bookings = ref.watch(bookingsProvider);

    final dayBookings = bookings.where((b) =>
        b.dateTime.year == selectedDate.year &&
        b.dateTime.month == selectedDate.month &&
        b.dateTime.day == selectedDate.day).toList();

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Book a Session', style: Theme.of(context).textTheme.headlineSmall),
            ),
          ),
          TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime.now().add(const Duration(days: 60)),
            focusedDay: selectedDate,
            selectedDayPredicate: (day) => isSameDay(day, selectedDate),
            onDaySelected: (selected, focused) => ref.read(selectedDateProvider.notifier).state = selected,
            calendarFormat: CalendarFormat.twoWeeks,
            headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(color: AppColors.coral.withValues(alpha: 0.15), shape: BoxShape.circle),
              selectedDecoration: const BoxDecoration(color: AppColors.coral, shape: BoxShape.circle),
              todayTextStyle: const TextStyle(color: AppColors.coral, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: dayBookings.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.event_available, size: 48, color: AppColors.muted.withValues(alpha: 0.5)),
                        const SizedBox(height: 12),
                        const Text('No sessions available', style: TextStyle(color: AppColors.muted)),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: dayBookings.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (_, i) {
                      final b = dayBookings[i];
                      final isFull = b.booked >= b.capacity;
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(b.className, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: (isFull ? AppColors.error : AppColors.mint).withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      isFull ? 'Full' : '${b.capacity - b.booked} spots left',
                                      style: TextStyle(color: isFull ? AppColors.error : AppColors.mint, fontSize: 11, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.access_time, size: 14, color: AppColors.muted),
                                  const SizedBox(width: 4),
                                  Text(b.timeSlot, style: const TextStyle(color: AppColors.muted, fontSize: 13)),
                                  const SizedBox(width: 16),
                                  const Icon(Icons.person, size: 14, color: AppColors.muted),
                                  const SizedBox(width: 4),
                                  Text(b.ageGroup, style: const TextStyle(color: AppColors.muted, fontSize: 13)),
                                ],
                              ),
                              const SizedBox(height: 12),
                              // Capacity bar
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: b.capacityPercent,
                                  backgroundColor: AppColors.muted.withValues(alpha: 0.15),
                                  color: isFull ? AppColors.error : AppColors.coral,
                                  minHeight: 6,
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: b.isBooked
                                    ? OutlinedButton.icon(
                                        onPressed: isFull ? null : () => ref.read(bookingsProvider.notifier).toggleBooking(b.id),
                                        icon: const Icon(Icons.check),
                                        label: const Text('Booked — Tap to Cancel'),
                                      )
                                    : ElevatedButton(
                                        onPressed: isFull ? null : () => ref.read(bookingsProvider.notifier).toggleBooking(b.id),
                                        child: Text(isFull ? 'Join Waitlist' : 'Book Now'),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
