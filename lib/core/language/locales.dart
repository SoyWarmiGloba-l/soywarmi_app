import 'package:flutter_localization/flutter_localization.dart';

List<MapLocale> LOCALES = [
  const MapLocale('es', LocaleData.es),
  const MapLocale('ay', LocaleData.ay),
];

mixin LocaleData {
  static const String hola = 'Hola';
  static const String inicioSesion= 'Iniciar Sesión';
  static const String inicio = 'Inicio';
  static const String noticiasSoyWarmi = 'Noticias Soy Warmi';
  static const String quienesSomos = 'Quiénes Somos';
  static const String miembros = 'Miembros';
  static const String preguntasFrecuentes = 'Preguntas Frecuentes';
  static const String cerrarSesion = 'Cerrar sesión';
  static const String version = 'Versión 0.0.1';
  static const String politicasPrivacidadTerminosCondiciones =
      'Políticas de privacidad - Términos y condiciones';
  static const String edicionPerfil = 'Edición de Perfil';
  static const String comoTeLlamas = '¿Cómo te llamas?';
  static const String cuandoNaciste = '¿Cuándo naciste?';
  static const String fechaNacimiento = 'Fecha de nacimiento';
  static const String seleccionarFecha = 'Seleccionar Fecha';
  static const String generoIdentificas = '¿Con qué género te identificas?';
  static const String masculino = 'Masculino';
  static const String femenino = 'Femenino';
  static const String noBinario = 'No binario';
  static const String prefieroNoDecirlo = 'Prefiero no decirlo';
  static const String guardarCambios = 'Guardar cambios';
  static const String notificaciones = 'Notificaciones';
  static const String noTienesNotificaciones = 'No tienes notificaciones';
  static const String yaVisteEliminasteTodasNotificaciones =
      'Ya viste o eliminaste todas tus notificaciones. Cuando tengas una nueva aparecerá aquí.';
  static const String sobreElMedico = 'Sobre el médico';
  static const String especialidades = 'Especialidades';
  static const String ubicacion = 'Ubicación';
  static const String contacto = 'Contacto';
  static const String contrasena = 'Contraseña';
  static const String correoElectronico = 'Correo electrónico';
  static const String olvidasteContrasena = '¿Olvidaste tu contraseña?';
  static const String iniciaSesionGoogle = 'Inicia sesión con Google';
  static const String noTienesCuenta = '¿No tienes cuenta?';
  static const String registrate = 'Regístrate';
  static const String verTodo = 'Ver todo';
  static const String hospitales = 'Hospitales';
  static const String publicaciones = 'Posts';
  static const String restablecerContrasena = 'Restablecer contraseña';
  static const String atras = 'Atrás';
  static const String crearCuenta = 'Crear cuenta';
  static const String crearTuCuenta = 'Crear tu cuenta';
  static const String nombre = 'Nombre';
  static const String apellido = 'Apellido';
  static const String yaTienesCuenta = '¿Ya tienes cuenta?';
  static const String anonimo = 'Anónimo';
  static const String publico = 'Público';
  static const String ver = 'Ver';
  static const String cualEsTuPregunta = '¿Cuál es tu pregunta?';
  static const String publicar = 'Publicar';
  static const String denunciar = 'Denunciar';
  static const String editarPerfil = 'Editar perfil';
  static const String descripcion = 'Descripcion';


  static const Map<String, dynamic> es = {
    hola: 'Hola',
    inicioSesion: 'Iniciar Sesión',
    inicio: 'Inicio',
    noticiasSoyWarmi: 'Noticias Soy Warmi',
    quienesSomos: 'Quiénes Somos',
    miembros: 'Miembros',
    preguntasFrecuentes: 'Preguntas Frecuentes',
    cerrarSesion: 'Cerrar sesión',
    version: 'Versión 0.0.1',
    politicasPrivacidadTerminosCondiciones:
        'Políticas de privacidad - Términos y condiciones',
    edicionPerfil: 'Edición de Perfil',
    comoTeLlamas: '¿Cómo te llamas?',
    cuandoNaciste: '¿Cuándo naciste?',
    fechaNacimiento: 'Fecha de nacimiento',
    seleccionarFecha: 'Seleccionar Fecha',
    generoIdentificas: '¿Con qué género te identificas?',
    masculino: 'Masculino',
    femenino: 'Femenino',
    noBinario: 'No binario',
    prefieroNoDecirlo: 'Prefiero no decirlo',
    guardarCambios: 'Guardar cambios',
    notificaciones: 'Notificaciones',
    noTienesNotificaciones: 'No tienes notificaciones',
    yaVisteEliminasteTodasNotificaciones:
        'Ya viste o eliminaste todas tus notificaciones. Cuando tengas una nueva aparecerá aquí.',
    sobreElMedico: 'Sobre el médico',
    especialidades: 'Especialidades',
    ubicacion: 'Ubicación',
    contacto: 'Contacto',
    contrasena: 'Contraseña',
    correoElectronico: 'Correo electrónico',
    olvidasteContrasena: '¿Olvidaste tu contraseña?',
    iniciaSesionGoogle: 'Inicia sesión con Google',
    noTienesCuenta: '¿No tienes cuenta?',
    registrate: 'Regístrate',
    verTodo: 'Ver todo',
    hospitales: 'Hospitales',
    publicaciones: 'Posts',
    restablecerContrasena: 'Restablecer contraseña',
    atras: 'Atrás',
    crearCuenta: 'Crear cuenta',
    crearTuCuenta: 'Crear tu cuenta',
    nombre: 'Nombre',
    apellido: 'Apellido',
    yaTienesCuenta: '¿Ya tienes cuenta?',
    anonimo: 'Anónimo',
    publico: 'Público',
    ver: 'Ver',
    cualEsTuPregunta: 'Cuál es tu pregunta?',
    publicar: 'Publicar',
    denunciar: 'Denunciar',
    editarPerfil: 'Editar perfil',
  };

  static const Map<String, dynamic> ay = {
    hola: 'Kamisaki',
    inicioSesion: 'Qalltaña',
    inicio: 'Qalltaña',
    noticiasSoyWarmi: 'Kurmi Yatiyäwinak',
    quienesSomos: 'Khitinakas jiwasaxa',
    miembros: 'Miembronaka',
    preguntasFrecuentes: 'jiskt’awinaka',
    cerrarSesion: 'Ukhamatwa qillqt’asiñama',
    version: 'Mä cuenta luraña',
    politicasPrivacidadTerminosCondiciones: 'Sutim uñt’ayañamawa',
    edicionPerfil: 'Qhipa sutim uñt’ayañamawa',
    comoTeLlamas: 'Ukatsti ukax mä contraseña uchatawa',
    cuandoNaciste: 'Uka contraseñajj mayamp sañamawa',
    fechaNacimiento: 'Cuenta luraña',
    seleccionarFecha: '¿Jumaxa mä cuenta utjktamti?, ukar mantañamawa',
    generoIdentificas: 'Kutiyaña',
    masculino: '¿Jumax contraseña armasxtati?',
    femenino:
        'Correo electrónico ukar qillqt’am ukat mä link ukar apayanipxäma contraseña ukar kutt’ayañataki',
    noBinario: 'correo electrónico ukar uñt’ayaña',
    prefieroNoDecirlo: 'Contraseña ukar kutt’ayaña',
    guardarCambios: 'Kamisaki……(nombre)',
    notificaciones: 'yatiyawinak uñt’ayaña',
    noTienesNotificaciones: 'Janiwa yatiyawinakaxa utjkiti',
    yaVisteEliminasteTodasNotificaciones: 'Yanapt’añ Utanaka',
    sobreElMedico: 'jaqinakax yanapt’apxi',
    especialidades: 'jaqinakax yanapt’apxi',
    ubicacion: 'Yatiyawinaka',
    contacto: 'Correo electrónico tuqi',
    contrasena: 'chimpu',
    correoElectronico: 'Correo electrónico tuqi',
    olvidasteContrasena: '¿Jumax contraseña armasxtati?',
    iniciaSesionGoogle: 'Google ukamp mantam',
    noTienesCuenta: '¿Jumax contraseña armasxtati?',
    registrate: 'Hapiy',
    verTodo: 'Taqi kun uñjaña',
    hospitales: 'Yanapt’añ Utanaka',
    publicaciones: 'Qillqatanaka',
    restablecerContrasena: 'Contraseña ukar kutt’ayaña',
    atras: 'Kutiyaña',
    crearCuenta: 'Cuenta luraña',
    crearTuCuenta: 'Mä cuenta luraña',
    nombre: 'phuqhat sutipa',
    apellido: 'apilliru',
    yaTienesCuenta: '¿Jumaxa mä cuenta utjktamti?,',
    anonimo: 'Taqitaki',
    publico: 'Priwaru',
    ver: 'ullaña ',
    cualEsTuPregunta: 'jiskt’awinaka utjiti?',
    publicar: "Uñt'ayaña'",
    denunciar: 'Arsusïwi',
    editarPerfil: 'Perfil ukar chiqañchaña',
  };
}
