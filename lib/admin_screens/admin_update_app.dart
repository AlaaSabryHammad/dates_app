import 'package:booking_calendar/booking_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dates_app/admin_screens/success/admin_update_app_success.dart';
import 'package:flutter/material.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class AdminUpdateApp extends StatefulWidget {
  const AdminUpdateApp({super.key, required this.item});
  final QueryDocumentSnapshot item;

  @override
  State<AdminUpdateApp> createState() => _AdminUpdateAppState();
}

class _AdminUpdateAppState extends State<AdminUpdateApp> {
  late BookingService mockBookingService;
  final now = DateTime.now();
  List<DateTimeRange> converted = [];

  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    await firebaseFirestore.collection('bookings').doc(widget.item.id).update({
      'startTime': DateTime.parse(newBooking.toJson()['bookingStart']),
      'endTime': DateTime.parse(newBooking.toJson()['bookingEnd'])
    });
    await firebaseFirestore
        .collection('doctors')
        .doc(widget.item.get('doctorID'))
        .collection('appointments')
        .where('startTime', isEqualTo: widget.item.get('startTime'))
        .get()
        .then((value) async {
      for (var doc in value.docs) {
        await firebaseFirestore
            .collection('doctors')
            .doc(widget.item.get('doctorID'))
            .collection('appointments')
            .doc(doc.id)
            .update({
          'startTime': DateTime.parse(newBooking.toJson()['bookingStart']),
          'endTime': DateTime.parse(newBooking.toJson()['bookingEnd']),
        });
      }
    });
    // ignore: use_build_context_synchronously
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AdminUpdateAppSuccess()));
  }

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    firebaseFirestore
        .collection('doctors')
        .doc(widget.item.get('doctorID'))
        .collection('appointments')
        .snapshots()
        .listen((event) {
      for (var item in event.docs) {
        DateTime start = item.get('startTime').toDate();
        DateTime end = item.get('endTime').toDate();
        setState(() {
          converted.add(DateTimeRange(start: start, end: end));
        });
      }
    });
    return converted;
  }

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }

  List<DateTime> xDates = [];
  getCancelledDates() {
    firebaseFirestore
        .collection('cancelledDates')
        .where('doctorId', isEqualTo: widget.item.get('doctorID'))
        .get()
        .then((value) {
      for (var doc in value.docs) {
        DateTime xx = doc.data()['date'].toDate();
        setState(() {
          xDates.add(DateTime(xx.year, xx.month, xx.day));
        });
      }
    });
    return xDates;
  }

  @override
  void initState() {
    super.initState();
    getCancelledDates();
    mockBookingService = BookingService(
        bookingStart: DateTime(now.year, now.month, now.day, 8, 0),
        bookingEnd: DateTime(now.year, now.month, now.day, 18, 0),
        serviceName: 'Mock Service',
        serviceDuration: 30);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BookingCalendar(
          bookingService: mockBookingService,
          convertStreamResultToDateTimeRanges: convertStreamResultMock,
          getBookingStream: getBookingStreamMock,
          uploadBooking: uploadBookingMock,
          // pauseSlots: generatePauseSlots(),
          // pauseSlotText: 'LUNCH',
          hideBreakTime: false,
          loadingWidget: const Text('Fetching data...'),
          uploadingWidget: const CircularProgressIndicator(),
          locale: 'en',
          startingDayOfWeek: StartingDayOfWeek.saturday,
          wholeDayIsBookedWidget:
              const Text('Sorry, for this day everything is booked'),
          disabledDates: xDates,
          // disabledDates: [DateTime(2023, 5, 15)],
          // disabledDays: const [16, 19],
        ),
      ),
    );
  }
}
