import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/appointment_provider.dart';
import '../utils/colors.dart';
import '../widgets/drawer.dart';
import '../widgets/appointment_item.dart';

class DoctorHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appointmentProvider = Provider.of<AppointmentProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        title: Text('SAPDOS'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage('assets/profile1.png'),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Hello!',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    Text('Dr. Amol', style: TextStyle(fontSize: 20)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Center(
              child:
                  Text('Today\'s Appointments', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatusCard('Pending Appointments', '19/40'),
                _buildStatusCard('Completed Appointments', '21/40'),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    DateFormat('EEEE, MMM d')
                        .format(appointmentProvider.selectedDate),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context, appointmentProvider),
                  child: Icon(Icons.calendar_today),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: appointmentProvider.patients.length,
                itemBuilder: (context, index) {
                  final patient = appointmentProvider.patients[index];
                  return AppointmentItem(
                    time: '10:00 AM',
                    patientName: patient.name,
                    patientAge: patient.age,
                    status: index % 2 == 0 ? 'pending' : 'completed',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, AppointmentProvider appointmentProvider) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: appointmentProvider.selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != appointmentProvider.selectedDate) {
      appointmentProvider.selectDate(picked);
    }
  }

  Widget _buildStatusCard(String title, String count) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(count, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
