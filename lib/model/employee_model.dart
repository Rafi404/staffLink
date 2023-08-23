// To parse this JSON data, do
//
//     final employeeListDataModel = employeeListDataModelFromJson(jsonString);

import 'dart:convert';

List<EmployeeListDataModel> employeeListDataModelFromJson(String str) =>
    List<EmployeeListDataModel>.from(
        json.decode(str).map((x) => EmployeeListDataModel.fromJson(x)));

String employeeListDataModelToJson(List<EmployeeListDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeListDataModel {
  final String? empName;
  final String? role;
  final String? startDate;
  final String? endDate;

  EmployeeListDataModel({
    this.empName,
    this.role,
    this.startDate,
    this.endDate,
  });

  factory EmployeeListDataModel.fromJson(Map<String, dynamic> json) =>
      EmployeeListDataModel(
        empName: json["empName"],
        role: json["role"],
        startDate: json["startDate"],
        endDate: json["endDate"],
      );

  Map<String, dynamic> toJson() => {
        "empName": empName,
        "role": role,
        "startDate": startDate,
        "endDate": endDate,
      };
}
