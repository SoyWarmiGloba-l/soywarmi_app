import 'package:flutter_localization/flutter_localization.dart';

List<MapLocale> LOCALES = [
  const MapLocale('es', LocaleData.es),
  const MapLocale('ay', LocaleData.ay),
  const MapLocale('quechua', LocaleData.quechua),
  const MapLocale('guarani', LocaleData.guarani),

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
  static const String detalle = 'Detalle';
  static const String cambiarCiudad="Cambiar ciudad";
  static const String hospitalesCercanos="Hospitales cercanos";
  static const String buscarDoctor="Buscar doctor";
  static const String buscarPublicacion="Buscar publicacion";
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
    detalle:"Detalle",
    cambiarCiudad:"Cambiar Ciudad",
    hospitalesCercanos:"Hospitales cercanos",
    buscarDoctor:"Buscar doctor",
    buscarPublicacion:"Buscar publicacion"
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
    masculino: 'Masculino',
    femenino: 'Femenino',
    noBinario: 'No binario',
    prefieroNoDecirlo: 'Jan Lurapxamti',
    guardarCambios: 'Imaña',
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
    detalle:"Ukhama",
    cambiarCiudad:"Markanaka",
    hospitalesCercanos:"uka jak'ankir qullañuta",
    buscarDoctor:"qulliri taqhaña",
    buscarPublicacion:"post taqhaña"
  };
  static const Map<String, dynamic> quechua = {
    hola: 'Allinllachu',
    inicioSesion: 'Yaykuy',
    inicio: 'Qallariy',
    noticiasSoyWarmi: 'Willaykuna',
    quienesSomos: 'Ñuqanchikmanta',
    miembros: 'Miembrokuna',
    preguntasFrecuentes: 'Tupukuykuna',
    cerrarSesion: 'Lluqsiy',
    version: 'Ima niraq',
    politicasPrivacidadTerminosCondiciones: 'Términos de uso nisqamanta',
    edicionPerfil: 'Datosniyunata tikray',
    comoTeLlamas: 'Imataq Sutiyki',
    cuandoNaciste: 'Nacesqaykipi',
    fechaNacimiento: 'Paqarisqn punchaw',
    seleccionarFecha: 'Punchayta akllay',
    generoIdentificas: 'Ima kay',
    masculino: 'Masculino',
    femenino: 'Femenino',
    noBinario: 'No binario',
    prefieroNoDecirlo: 'Manam nisaqchu',
    guardarCambios: 'Waqaychay',
    notificaciones: 'Willakuykunata',
    noTienesNotificaciones: 'Mana willakuykuna kanchu',
    yaVisteEliminasteTodasNotificaciones: 'Mana willakuykuna kanchu',
    sobreElMedico: 'Hampimanta willakuy',
    especialidades: 'Especialidades nisqakuna',
    ubicacion: 'Tarikuynin',
    contacto: 'Tupaqmasi',
    contrasena: 'Kichana',
    correoElectronico: 'Correo electrónico',
    olvidasteContrasena: '¿Qurqarqanki kinchana?',
    iniciaSesionGoogle: 'Google niqawan yaykuy',
    noTienesCuenta: '¿Ñawpaqtaqa manam yaykurqankichu?',
    registrate: 'Inscribikuy',
    verTodo: 'Tukuy imata rikuy',
    hospitales: 'Hampina wasikunapi',
    publicaciones: 'Qillqakuna',
    restablecerContrasena: 'Contraseña nisqatikray',
    atras: 'Kutichiy',
    crearCuenta: 'Cuenta ruway',
    crearTuCuenta: 'Cuenta ruway',
    nombre: 'Suti',
    apellido: 'Taytamam suti',
    yaTienesCuenta: '¿Ñawpaqtaraqmi yaykurunkiña?,',
    anonimo: 'Mana riqsisqas',
    publico: 'Runapaq',
    ver: 'Qaway',
    cualEsTuPregunta: 'Ima tapukuyniyuqtaq kanki?',
    publicar: "Apachiy",
    denunciar: 'Willakuy',
    editarPerfil: 'Datosniykunata tikray',
    detalle:"Kaqnin",
    cambiarCiudad:"Huk llaqtata akllay",
    hospitalesCercanos:"Qayllanpi kaq hampina wasikuna",
    buscarDoctor:"Doctorta maskay",
    buscarPublicacion:"Maskay qillqa"
  };
  static const Map<String, dynamic> guarani = {
    hola: 'Maitei',
    inicioSesion: 'Ike',
    inicio: 'Ñepyrü',
    noticiasSoyWarmi: 'Marandu',
    quienesSomos: 'Quienes somos',
    miembros: 'Miembros',
    preguntasFrecuentes: 'Porandu',
    cerrarSesion: 'Piä',
    version: 'Version',
    politicasPrivacidadTerminosCondiciones: 'Condiciones de uso',
    edicionPerfil: 'Editar perfil',
    comoTeLlamas: 'Téra',
    cuandoNaciste: 'Teñói',
    fechaNacimiento: 'Teñói',
    seleccionarFecha: 'Poravo arange',
    generoIdentificas: 'Genero',
    masculino: 'Masculino',
    femenino: 'Femenino',
    noBinario: 'No binario',
    prefieroNoDecirlo: "Kuaa'ÿ",
    guardarCambios: 'Ñongatu',
    notificaciones: 'Marandu',
    noTienesNotificaciones: 'No tienes notificaciones',
    yaVisteEliminasteTodasNotificaciones: 'Ya eliminaste notificaciones',
    sobreElMedico: 'Sobre el medico',
    especialidades: 'Especialidades',
    ubicacion: 'Ubicacion',
    contacto: 'Contacto',
    contrasena: 'Contraseña',
    correoElectronico: 'Correo electrónico',
    olvidasteContrasena: '¿Olvidaste contraseña?',
    iniciaSesionGoogle: 'Ke google',
    noTienesCuenta: '¿No tienes cuenta?',
    registrate: 'Registrate',
    verTodo: 'Hecha',
    hospitales: 'Hospitales',
    publicaciones: 'Marandu',
    restablecerContrasena: 'Cambiar constraseña',
    atras: 'Jere',
    crearCuenta: 'Pyaha cuenta',
    crearTuCuenta: 'Pyaha cuenta',
    nombre: 'Téra',
    apellido: 'Terajuapy',
    yaTienesCuenta: '¿Ya tienes cuenta?,',
    anonimo: 'Anonimo',
    publico: 'Publico',
    ver: 'Hecha',
    cualEsTuPregunta: 'Porandu?',
    publicar: "Moherakuä",
    denunciar: "Mombe'u",
    editarPerfil: 'Rova perfil',
    detalle:"Detalle",
    cambiarCiudad:"Rova ciudad",
    hospitalesCercanos:"Hospital aguïgua",
    buscarDoctor:"Heka doctor",
    buscarPublicacion:"Heka publicacion"
  };
}
