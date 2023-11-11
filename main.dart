import 'models/Employee.dart';
import 'models/Position.dart';
import 'models/Department.dart';

void main() {
  try {
    var department = Department('Tech2');
    var employee = Employee('John Smith', Position.manager, department);
    print(employee); // Employee: John Smith, Position: manager, Department: Tech2
    employee.changeDepartment(Department('Dev1'));
    print(employee); // Employee: John Smith, Position: manager, Department: Dev1
  } catch (e) {
    print('Error: $e');
  }
}
