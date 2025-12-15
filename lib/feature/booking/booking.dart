import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  static const Color primaryBlue = Color(0xFF004AAD);
  static const Color primaryOrange = Color(0xFFFF751E);

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? _selectedTimeSlot;
  String? _selectedService;

  final List<String> _timeSlots = [
    '09:00 ص',
    '10:00 ص',
    '11:00 ص',
    '12:00 م',
    '02:00 م',
    '03:00 م',
    '04:00 م',
    '05:00 م',
  ];

  final List<ServiceType> _services = [
    ServiceType(
      name: 'صيانة دورية',
      icon: Iconsax.setting_2,
      duration: '2 ساعة',
      price: '300 ج.م',
    ),
    ServiceType(
      name: 'تغيير زيت',
      icon: Iconsax.drop,
      duration: '1 ساعة',
      price: '150 ج.م',
    ),
    ServiceType(
      name: 'فحص شامل',
      icon: Iconsax.search_status,
      duration: '3 ساعات',
      price: '500 ج.م',
    ),
    ServiceType(
      name: 'إصلاح عطل',
      icon: Iconsax.close_circle,
      duration: '4 ساعات',
      price: '800 ج.م',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: primaryBlue,
          elevation: 0,
          title: const Text(
            'حجز موعد',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCalendarSection(),
              _buildServiceTypeSection(),
              _buildTimeSlotSection(),
              _buildSelectedInfoCard(),
              _buildBookButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TableCalendar(
        firstDay: DateTime.now(),
        lastDay: DateTime.now().add(const Duration(days: 90)),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        calendarFormat: CalendarFormat.month,
        startingDayOfWeek: StartingDayOfWeek.saturday,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryBlue,
          ),
          leftChevronIcon: const Icon(
            Iconsax.arrow_left_2,
            color: primaryBlue,
          ),
          rightChevronIcon: const Icon(
            Iconsax.arrow_right_3,
            color: primaryBlue,
          ),
        ),
        calendarStyle: CalendarStyle(
          selectedDecoration: const BoxDecoration(
            color: primaryOrange,
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: primaryBlue.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          outsideDaysVisible: false,
          weekendTextStyle: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget _buildServiceTypeSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'نوع الخدمة',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryBlue,
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
            ),
            itemCount: _services.length,
            itemBuilder: (context, index) {
              final service = _services[index];
              final isSelected = _selectedService == service.name;
              return _ServiceCard(
                service: service,
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    _selectedService = service.name;
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlotSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'اختر الوقت',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryBlue,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _timeSlots.map((time) {
              final isSelected = _selectedTimeSlot == time;
              return _TimeSlotChip(
                time: time,
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    _selectedTimeSlot = time;
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedInfoCard() {
    if (_selectedDay == null ||
        _selectedService == null ||
        _selectedTimeSlot == null) {
      return const SizedBox.shrink();
    }

    final selectedServiceData =
        _services.firstWhere((s) => s.name == _selectedService);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primaryBlue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primaryBlue, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ملخص الحجز',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryBlue,
            ),
          ),
          const SizedBox(height: 12),
          _InfoRow(
            icon: Iconsax.calendar_1,
            label: 'التاريخ',
            value: '${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}',
          ),
          const SizedBox(height: 8),
          _InfoRow(
            icon: Iconsax.clock,
            label: 'الوقت',
            value: _selectedTimeSlot!,
          ),
          const SizedBox(height: 8),
          _InfoRow(
            icon: Iconsax.setting_2,
            label: 'الخدمة',
            value: _selectedService!,
          ),
          const SizedBox(height: 8),
          _InfoRow(
            icon: Iconsax.timer_1,
            label: 'المدة',
            value: selectedServiceData.duration,
          ),
          const SizedBox(height: 8),
          _InfoRow(
            icon: Iconsax.wallet,
            label: 'السعر',
            value: selectedServiceData.price,
          ),
        ],
      ),
    );
  }

  Widget _buildBookButton() {
    final isEnabled = _selectedDay != null &&
        _selectedService != null &&
        _selectedTimeSlot != null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: isEnabled
              ? () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تم تأكيد الحجز بنجاح!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryOrange,
            disabledBackgroundColor: Colors.grey[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: isEnabled ? 3 : 0,
          ),
          child: Text(
            'تأكيد الحجز',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isEnabled ? Colors.white : Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }
}

class ServiceType {
  final String name;
  final IconData icon;
  final String duration;
  final String price;

  ServiceType({
    required this.name,
    required this.icon,
    required this.duration,
    required this.price,
  });
}

class _ServiceCard extends StatelessWidget {
  final ServiceType service;
  final bool isSelected;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.service,
    required this.isSelected,
    required this.onTap,
  });

  static const Color primaryBlue = Color(0xFF004AAD);
  static const Color primaryOrange = Color(0xFFFF751E);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? primaryOrange.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? primaryOrange : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              service.icon,
              size: 32,
              color: isSelected ? primaryOrange : primaryBlue,
            ),
            const SizedBox(height: 8),
            Text(
              service.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isSelected ? primaryOrange : primaryBlue,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              service.price,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeSlotChip extends StatelessWidget {
  final String time;
  final bool isSelected;
  final VoidCallback onTap;

  const _TimeSlotChip({
    required this.time,
    required this.isSelected,
    required this.onTap,
  });

  static const Color primaryBlue = Color(0xFF004AAD);
  static const Color primaryOrange = Color(0xFFFF751E);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? primaryOrange : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? primaryOrange : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          time,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : primaryBlue,
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF004AAD)),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF004AAD),
          ),
        ),
      ],
    );
  }
}
