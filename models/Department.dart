class Department {
  String _name;

  Department(this._name) {
    _validateDepartmentName(_name);
  }

  void _validateDepartmentName(String name) {
    if (!RegExp(r'[A-Za-z]').hasMatch(name) || !RegExp(r'\d').hasMatch(name)) {
      throw FormatException(
          'Department name must contain at least one letter and one number');
    }
  }

  @override
  String toString() {
    return _name;
  }

  @override
  bool operator ==(Object other) {
    if(identical(this, other)) return true;

    return other is Department &&
      other._name == _name;
  }

  @override
  int get hashCode => _name.hashCode;
}
