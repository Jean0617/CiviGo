sealed class AppFailure {
  const AppFailure();
}

/// ----------------------
/// HTTP ERRORS
/// ----------------------

// 400
class BadRequestFailure extends AppFailure {
  const BadRequestFailure();
}

// 401
class Unauthorized extends AppFailure {
  const Unauthorized();
}

// 403
class Forbidden extends AppFailure {
  const Forbidden();
}

// 404
class NotFound extends AppFailure {
  const NotFound();
}

// 409
class ConflictFailure extends AppFailure {
  const ConflictFailure();
}

// 422
class ValidationFailure extends AppFailure {
  const ValidationFailure();
}

// 429
class TooManyRequestsFailure extends AppFailure {
  const TooManyRequestsFailure();
}

// 500
class InternalServerFailure extends AppFailure {
  const InternalServerFailure();
}

// 502
class BadGatewayFailure extends AppFailure {
  const BadGatewayFailure();
}

// 503
class ServiceUnavailableFailure extends AppFailure {
  const ServiceUnavailableFailure();
}

// 504
class GatewayTimeoutFailure extends AppFailure {
  const GatewayTimeoutFailure();
}

/// ----------------------
/// NETWORK / DIO ERRORS
/// ----------------------

// Sin internet / conexión fallida
class NetworkError extends AppFailure {
  const NetworkError();
}

// Timeout al conectar
class ConnectionTimeoutFailure extends AppFailure {
  const ConnectionTimeoutFailure();
}

// Timeout enviando datos
class SendTimeoutFailure extends AppFailure {
  const SendTimeoutFailure();
}

// Timeout recibiendo datos
class ReceiveTimeoutFailure extends AppFailure {
  const ReceiveTimeoutFailure();
}

// Request cancelada manualmente
class RequestCancelledFailure extends AppFailure {
  const RequestCancelledFailure();
}

// Certificado SSL inválido
class BadCertificateFailure extends AppFailure {
  const BadCertificateFailure();
}

// Respuesta inválida
class BadResponseFailure extends AppFailure {
  const BadResponseFailure();
}

/// ----------------------
/// UNKNOWN
/// ----------------------

class UnknownError extends AppFailure {
  const UnknownError();
}