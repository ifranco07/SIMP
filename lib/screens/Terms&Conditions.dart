import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  _TermsAndConditionsScreenState createState() => _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  final String _termsAndConditionsText = '''

Bienvenido al Sistema Integral de Monitorización de Piscinas (SIMP). Antes de utilizar nuestros servicios, por favor, asegúrate de leer y comprender nuestros términos y condiciones detallados a continuación. Al utilizar nuestro sistema, aceptas estar legalmente obligado por estos términos y condiciones.
1. Uso del Sistema: El Sistema Integral de Monitorización de Piscinas (SIMP) proporciona servicios de monitoreo y gestión de piscinas a través de una plataforma en línea. Estos servicios están diseñados para ayudar a los propietarios y administradores de piscinas a mantener un entorno seguro y saludable para los usuarios.
2. Acceso y Seguridad: Los usuarios deben crear una cuenta para acceder al sistema. Es responsabilidad del usuario mantener la seguridad de su cuenta y contraseña. Cualquier actividad realizada desde la cuenta del usuario será su responsabilidad.
3. Datos Personales: Recopilamos cierta información personal de los usuarios para proporcionar nuestros servicios. Esta información se maneja de acuerdo con nuestra política de privacidad, que se puede encontrar en [enlace a la política de privacidad].
4. Uso Aceptable: Los usuarios se comprometen a utilizar el sistema de manera responsable y ética. No se permite el uso del sistema para actividades ilegales, fraudulentas o dañinas.
5. Propiedad Intelectual: Todo el contenido y la propiedad intelectual asociada con el Sistema Integral de Monitorización de Piscinas son propiedad exclusiva de [Nombre de la Empresa]. Los usuarios no tienen derecho a utilizar, copiar o distribuir este contenido sin permiso.
6. Limitación de Responsabilidad: [Nombre de la Empresa] no se hace responsable de ningún daño directo, indirecto, incidental, especial o consecuente que surja del uso o la imposibilidad de utilizar el Sistema Integral de Monitorización de Piscinas.
7. Modificaciones de Términos y Condiciones: Nos reservamos el derecho de actualizar y modificar estos términos y condiciones en cualquier momento. Se notificará a los usuarios sobre cualquier cambio importante en los términos y condiciones.
8. Terminación del Servicio: Nos reservamos el derecho de suspender o cancelar el acceso de un usuario al Sistema Integral de Monitorización de Piscinas si viola estos términos y condiciones.
9. Ley Aplicable: Estos términos y condiciones se rigen e interpretan de acuerdo con las leyes del [país o estado donde opera la empresa].
Al utilizar el Sistema Integral de Monitorización de Piscinas, aceptas cumplir con estos términos y condiciones. Si no estás de acuerdo con alguno de estos términos, no utilices nuestro sistema.
Fecha de entrada en vigencia:  DD/MM/AA


''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POLITICA DE TERMINOS Y CONDICIONES'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
      ),
    );
  }
}
