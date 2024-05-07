import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:schedule_app/models/role/role.dart';
import 'package:schedule_app/screens/appointment/appointment_screen.dart';
import 'package:schedule_app/screens/loader_hub.dart';
import 'package:schedule_app/store/session_context.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SessionContext>(builder: (_, sessionContext, __) {
      sessionContext.retrieveAppointment();
      return Observer(
        builder: (_) => LoaderHud(
          inAsyncCall: sessionContext.isloginLoading,
          loading: const CircularProgressIndicator(),
          child: Scaffold(
            body: SfCalendar(
              view: CalendarView.week,
              monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              ),
              firstDayOfWeek: 6,
              dataSource: MettingDataSource(
                sessionContext.appointments,
              ),
              onTap: (CalendarTapDetails details) {
                dynamic appointment = details.appointments;
                debugPrint(appointment.toString());
              },
              onSelectionChanged: (calendarSelectionDetails) async {
                sessionContext
                    .setSelectedDateTime(calendarSelectionDetails.date!);
                debugPrint('${calendarSelectionDetails.date}');

                Role? role;

                for (var rolev in sessionContext.staff!.roles!) {
                  if (rolev.name == 'ROLE_ADMIN') {
                    role = rolev;
                  }
                }

                if (role != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AppointmentScreen(),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      );
    });
  }
}

class MettingDataSource extends CalendarDataSource {
  MettingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
