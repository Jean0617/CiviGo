
enum Environment { dev, prod }

class Env {
  //ACA SE VALIDA EL ENTONO SI ES PROD O DEV
  static Environment current = Environment.dev;
}

class Api {
  
  static String get baseUrl => 
    Env.current == Environment.prod? 
      'https://api-academy.smagronet.net'
    : 
      'https://api-academy.smagronet.net';

  static const connectTimeout = Duration(hours: 1);
}


