part of 'httpManagement.dart';

_printLogs(
  Map<String, dynamic> logs,
  StackTrace? stackTrace,
) {
  var spaces = ' ' * 4;
  var encoder = JsonEncoder.withIndent(spaces);
  if (kDebugMode) {
    log(
      '''
Estos son los logs
-----------------------------------------------------------
${encoder.convert(logs).toString()}
-----------------------------------------------------------
''',
      stackTrace: stackTrace,
    );
  }
}
