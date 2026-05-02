import 'package:flutter/widgets.dart';

/// Validator function signature used by [WlmFormField]. Returns an
/// error string when invalid, or `null` when the value passes.
typedef WlmValidator<T> = String? Function(T? value);

/// Built-in validator factory.
class WlmValidators {
  WlmValidators._();

  static WlmValidator<String> required([String message = 'Required']) =>
      (value) =>
          (value == null || value.trim().isEmpty) ? message : null;

  static WlmValidator<String> minLength(int n,
          {String? message,}) =>
      (value) => (value == null || value.length < n)
          ? (message ?? 'Must be at least $n characters')
          : null;

  static WlmValidator<String> maxLength(int n,
          {String? message,}) =>
      (value) => (value != null && value.length > n)
          ? (message ?? 'Must be at most $n characters')
          : null;

  static WlmValidator<String> email(
          [String message = 'Enter a valid email',]) =>
      (value) {
        if (value == null || value.isEmpty) return null;
        final ok = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$').hasMatch(value);
        return ok ? null : message;
      };

  static WlmValidator<String> pattern(RegExp re,
          {String message = 'Invalid format',}) =>
      (value) {
        if (value == null || value.isEmpty) return null;
        return re.hasMatch(value) ? null : message;
      };

  static WlmValidator<T> compose<T>(List<WlmValidator<T>> validators) =>
      (value) {
        for (final v in validators) {
          final err = v(value);
          if (err != null) return err;
        }
        return null;
      };
}

/// Tiny form orchestrator. Hold a [WlmFormController] in your
/// `StatefulWidget`, register fields, then call [WlmFormController.validate]
/// before submission.
class WlmFormController extends ChangeNotifier {
  final Map<String, _FieldState> _fields = {};

  /// @nodoc — internal hook used by [WlmFormField] during mount.
  void register(String name, Object field) {
    _fields[name] = field as _FieldState;
  }

  void unregister(String name) => _fields.remove(name);

  /// Returns true when all registered fields pass their validators.
  bool validate() {
    var ok = true;
    for (final field in _fields.values) {
      final err = field.validate();
      if (err != null) ok = false;
    }
    notifyListeners();
    return ok;
  }

  /// Snapshot of all current field values.
  Map<String, dynamic> get values =>
      {for (final e in _fields.entries) e.key: e.value.value};

  /// Map of `field name -> error message` for fields that currently fail.
  Map<String, String> get errors => {
        for (final e in _fields.entries)
          if (e.value.error != null) e.key: e.value.error!,
      };

  /// Reset every registered field to its initial value and clear errors.
  void reset() {
    for (final f in _fields.values) {
      f.reset();
    }
    notifyListeners();
  }
}

class _FieldState {
  _FieldState({
    required this.initialValue,
    required this.validator,
    required this.onChanged,
  }) : value = initialValue;

  final dynamic initialValue;
  final WlmValidator<dynamic>? validator;
  final ValueChanged<dynamic>? onChanged;
  dynamic value;
  String? error;

  String? validate() {
    error = validator?.call(value);
    return error;
  }

  void set(dynamic v) {
    value = v;
    error = validator?.call(v);
    onChanged?.call(v);
  }

  void reset() {
    value = initialValue;
    error = null;
  }
}

/// Generic form-bound field. Wraps any builder receiving the current
/// value/error and a setter.
class WlmFormField<T> extends StatefulWidget {
  const WlmFormField({
    super.key,
    required this.controller,
    required this.name,
    required this.builder,
    this.initialValue,
    this.validator,
    this.onChanged,
  });

  final WlmFormController controller;
  final String name;
  final T? initialValue;
  final WlmValidator<T>? validator;
  final ValueChanged<T>? onChanged;
  final Widget Function(BuildContext context, T? value, String? error,
      ValueChanged<T> setValue,) builder;

  @override
  State<WlmFormField<T>> createState() => _WlmFormFieldState<T>();
}

class _WlmFormFieldState<T> extends State<WlmFormField<T>> {
  late _FieldState _state;

  @override
  void initState() {
    super.initState();
    _state = _FieldState(
      initialValue: widget.initialValue,
      validator: widget.validator == null
          ? null
          : (v) => widget.validator!(v as T?),
      onChanged: (v) {
        widget.onChanged?.call(v as T);
        setState(() {});
      },
    );
    widget.controller.register(widget.name, _state);
    widget.controller.addListener(_onControllerTick);
  }

  void _onControllerTick() => setState(() {});

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerTick);
    widget.controller.unregister(widget.name);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      _state.value as T?,
      _state.error,
      (v) => setState(() => _state.set(v)),
    );
  }
}
