import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'setup/firebase_options.dart';
import 'setup/get_it_setup.dart';
import 'setup/logger_setup.dart';
import 'setup/router.dart';
import 'setup/setup_emulator.dart';
import 'modules/branch/utils/branch_generator.dart';

const bool useEmulator = true;

Future<void> main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setupLogger();
  setupServiceLocator();

  setupEmulator(useEmulator: useEmulator);

  // branchDefaultGenerate();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fin del Mundo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: useEmulator ? Colors.amber : Colors.purple,
        scaffoldBackgroundColor: const Color(0xffF2EFFA),
      ),
      routerConfig: _appRouter.config(),
    );
  }
}

/**
 Responde como un experto en Flutter, firebase, firestore, getIt, logging, rxdart, clean code, principios SOLID, auto_route. Tu tarea es escribir codigo de promgramacion segun el requisito que te hago. 
 */

/**
 implementa la funcionalidad para crear nuevos ingresos diarios. Esto incluye la validación de los datos ingresados por el usuario y la actualización de la pantalla para mostrar los nuevos ingresos diarios.
Se debe poder crear nuevas mesas. La informacion necesaria es:
{
  "createdAt": timestamp,      // Fecha en la que se almacena el ingreso diario, este dato se debe cargar automaticamente. No se modifica. No se muestra al usuario.
  "modifiedAt": timestamp,     // Fecha en la que se modificó el ingreso, este dato se modifica unicamente de forma automatica al actualizar el ingreso diario. No se muestra al usuario.
  "createdBy": string,         // Usuario que creó el ingreso, este dato se debe cargar automaticamente por el usuario que crea el ingreso diario. No se debe poder modificar y no se muestra al usuario.
  "modifiedBy": string,        // Usuario que modificó el ingreso, este dato se modifica unicamente y de forma automatica al actualizar un ingreso diario.
  "date": timestamp,           // Fecha que corresponde al ingreso
  "branch": string,            // Sucursal del ingreso
  "total": number,             // Total de ingresos del día. Este dato se calcula automaticamente sumando los metodos de pago, el sobrante y restando el faltante. No se puede modificar manualmente.
  "paymentMethods": {          // Métodos de pago
    "cash": number,            // Dinero que ingresó en efectivo
    "cards": number,           // Dinero que ingresó mediante tarjetas
    "mercadoPago": number      // Dinero que ingresó mediante MercadoPago
  },
  "surplus": number,           // Sobrante
  "shortage": number           // Faltante
}

Se debe poder eliminar ingresos diarios, se debe confirmar si el usuario desea eliminar.
Se debe poder modificar la informacion de los ingresos diarios.
Para la base de dato usa Firestore.
Para manejar las instancias utiliza la dependencia GetIt, la configuracion debe estar en un archivo aparte.
Para integrar el controller y la interfaz grafica usa BehaviorSubject.
Utiliza auto_route las rutas.
Agrega logs en la pantalla, en el controller y el repositorio, antes y despues de cada accion que permitan una buena depuracion utilizando loggin.
El codigo de progrmaacion debe seguir los principios Clean Code y Solid. 
El codigo debe reutilizable y debe ser facil de modificar en futuras actualizaciones.
Crea un repositorio y un controller para las mesas.
Para una mejor mantencion crea una interfaz del repositorio para facilitar el interacmbio de repositorios.
Escribe todo el codigo, no des solamente la estructura. Implementa todo el codigo necesario para cumplir con todo lo indicado
 */