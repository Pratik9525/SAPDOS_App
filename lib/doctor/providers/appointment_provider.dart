import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../models/patient.dart';

class AppointmentProvider with ChangeNotifier {
  DateTime _selectedDate = DateTime.now();
  List<Patient> _patients = [];

  DateTime get selectedDate => _selectedDate;
  List<Patient> get patients => _patients;

  AppointmentProvider() {
    _loadPatientData();
  }

  void _loadPatientData() async {
    final String jsonString =
        await rootBundle.loadString('assets/patients.json');
    final List<dynamic> jsonResponse = jsonDecode(jsonString);
    _patients = jsonResponse.map((e) => Patient.fromJson(e)).toList();
    notifyListeners();
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
}
