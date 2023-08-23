import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stafflink/view/home_page/home_page.dart';

class AppMainController extends GetxController {
  bool initialDataLoading = true;
  DateTime selectedDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  bool buttonTodaySelected = true;
  bool mondaySelected = false;
  bool tuesdaySelected = false;
  bool weekSelected = false;

  bool endDateSelection = false;
  bool noDateSelected = false;
  bool noDateButtonStatus = false;

  String calenderType = '';

  bool editMode = false;

  String employeeName = '';
  String employeeRole = '';
  String employeeStartDate = '';
  String employeeEndDate = '';

  void selectButton(index) {
    switch (index) {
      case 0:
        selectedDate = DateTime.now();
        buttonTodaySelected = true;
        mondaySelected = false;
        tuesdaySelected = false;
        weekSelected = false;
        noDateSelected = false; // no date selection status
        update();
        break;
      case 1:
        DateTime currentDate = DateTime.now();
        num daysUntilNextMonday = (8 - currentDate.weekday) % 7;
        DateTime nextMonday =
            currentDate.add(Duration(days: daysUntilNextMonday.toInt()));
        selectedDate = nextMonday;
        buttonTodaySelected = false;
        mondaySelected = true;
        tuesdaySelected = false;
        weekSelected = false;
        update();

        break;
      case 2:
        DateTime currentDate = DateTime.now();
        num daysUntilNextMonday = (9 - currentDate.weekday) % 7;
        DateTime nextTuesday =
            currentDate.add(Duration(days: daysUntilNextMonday.toInt()));
        selectedDate = nextTuesday;

        buttonTodaySelected = false;
        mondaySelected = false;
        tuesdaySelected = true;
        weekSelected = false;
        update();

        break;
      case 3:
        DateTime currentDate = DateTime.now();
        DateTime dateAfterOneWeek = currentDate.add(const Duration(days: 7));
        selectedDate = dateAfterOneWeek;
        buttonTodaySelected = false;
        mondaySelected = false;
        tuesdaySelected = false;
        weekSelected = true;
        update();

        break;
      case 4:
        noDateSelected = true;
        buttonTodaySelected = false;
        update();

        break;
      default:
    }
    update();
  }

  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> previousData = [];

  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'employeeDb');
    var database =
        await openDatabase(path, version: 1, onCreate: onCreatingDatabase);
    return database;
  }

  ///Create Database
  onCreatingDatabase(Database database, int version) async {
    await database.execute("CREATE TABLE employees(empName TEXT, "
        "role TEXT, startDate TEXT, endDate TEXT)");

    await database.execute("CREATE TABLE previous_employees(empName TEXT, "
        "role TEXT, startDate TEXT, endDate TEXT)");
  }

  ///Insert data into the database
  insertDatabase(
      String empName, String role, String startDate, String endDate) async {
    Database db = await setDatabase();
    db.rawInsert('INSERT INTO employees(empName, role, startDate, endDate)'
        ' VALUES("$empName", "$role", "$startDate", "$endDate")');
    getData();
    Get.offAll(() => const HomePage(), transition: Transition.cupertino);
  }

  insertIntoPreviousEmployees(
      String empName, String role, String startDate, String endDate) async {
    Database db = await setDatabase();
    db.rawInsert(
        'INSERT INTO previous_employees(empName, role, startDate, endDate)'
        ' VALUES("$empName", "$role", "$startDate", "$endDate")');
    getData();
  }

  deleteEmployee(String employeeName) async {
    Database db = await setDatabase();
    await db.rawDelete('DELETE FROM employees WHERE empName = "$employeeName"');
    getPreviousData();
  }

  deletePreviousEmployee(String employeeName) async {
    Database db = await setDatabase();
    await db.rawDelete(
        'DELETE FROM previous_employees WHERE empName = "$employeeName"');
    getPreviousData();
  }

  ///Select Data from table
  Future<List<Map<String, dynamic>>?> getData() async {
    Database db = await setDatabase();
    data = await db.query("employees");

    return data;
  }

  ///Select Data from table
  Future<List<Map<String, dynamic>>?> getPreviousData() async {
    Database db = await setDatabase();
    previousData = await db.query("previous_employees");
    return previousData;
  }

  updateEmployee(
      String empName, String role, String startDate, String endDate) async {
    Database db = await setDatabase();
    await db.rawUpdate(
        'UPDATE employees SET empName = "$empName", role = "$role", startDate = "$startDate", endDate = "$endDate" WHERE empName = "$employeeName"');

    getData();
    Get.offAll(const HomePage(), transition: Transition.cupertino);
  }

  Future<void> clearEmployeesTable() async {
    Database db = await setDatabase();
    await db.rawDelete('DELETE FROM employees');
    await db.rawDelete('DELETE FROM previous_employees');
  }
}
