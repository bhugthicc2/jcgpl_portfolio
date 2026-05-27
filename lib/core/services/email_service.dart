import 'dart:js_interop';

// JS interop — calls EmailJS from Flutter Web
@JS('emailjs.send')
external JSPromise _emailjsSend(
  JSString serviceId,
  JSString templateId,
  JSObject templateParams,
);

class EmailService {
  static const _serviceId = 'YOUR_SERVICE_ID'; // 👈 replace
  static const _templateId = 'YOUR_TEMPLATE_ID'; // 👈 replace

  static Future<void> send({
    required String fromName,
    required String fromEmail,
    required String message,
  }) async {
    final params =
        {
              'from_name': fromName,
              'from_email': fromEmail,
              'message': message,
            }.jsify()
            as JSObject;

    await _emailjsSend(_serviceId.toJS, _templateId.toJS, params).toDart;
  }
}
