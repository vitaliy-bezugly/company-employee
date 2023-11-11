import 'Position.dart';
import 'Department.dart';
import 'Constants.dart';

class Employee {
  String _fullName;
  Position _position;
  Department _department;
  int _salary = 0;
  List<Position> _positionHistory = [];
  List<Department> _departmentHistory = [];

  Employee(this._fullName, this._position, this._department) {
    _validateFullName(_fullName);
    _setSalary();
    _positionHistory.add(_position);
    _departmentHistory.add(_department);
  }

  void _validateFullName(String fullName) {
    if (fullName.isEmpty || RegExp(r'\d').hasMatch(fullName)) {
      throw FormatException('Full name cannot be empty or contain numbers');
    }
  }

  void _setSalary() {
    switch (_position) {
      case Position.director:
        _salary = Constants.directorSalary;
        break;
      case Position.manager:
        _salary = Constants.managerSalary;
        break;
      case Position.engineer:
        _salary = Constants.engineerSalary;
        break;
      case Position.handyman:
        _salary = Constants.handymanSalary;
        break;
    }
  }

  void changePosition(Position newPosition) {
    _setSalary();
    _position = newPosition;
    _positionHistory.add(newPosition);
  }

  bool promotePosition() {
    try {
      _position = Position.values[Position.values.indexOf(_position) - 1];
      _setSalary();
      _positionHistory.add(_position);
      return true;
    } catch (e) {
      return false;
    }
  }

  bool demotePosition() {
    try {
      _position = Position.values[Position.values.indexOf(_position) + 1];
      _setSalary();
      _positionHistory.add(_position);
      return true;
    } catch (e) {
      return false;
    }
  }

  int getSalary() {
    return _salary;
  }

  Department findDepartment(Department department) {
    try {
      return _departmentHistory.firstWhere((d) => d == department);
    } catch (e) {
      throw Exception('Department not found');
    }
  }

  Position findPosition(Position position) {
    try {
      return _positionHistory.firstWhere((p) => p == position);
    } catch (e) {
      throw Exception('Position not found');
    }
  }

  void changeDepartment(Department newDepartment) {
    _department = newDepartment;
    _departmentHistory.add(newDepartment);
  }

  bool equalsByPosition(Employee other) {
    return _position == other._position;
  }

  @override
  String toString() {
    return 'Employee: $_fullName, Position: ${_position.name}, Department: ${_department.toString()}';
  }
}
