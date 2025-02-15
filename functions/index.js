const functions = require('firebase-functions');
const admin = require('firebase-admin');
const { Translate } = require('@google-cloud/translate').v2;

admin.initializeApp();

// Inicializa el cliente de Google Cloud Translation
const translate = new Translate();

exports.translateText = functions.https.onCall(async (data, context) => {
  const text = data.text;
  const sourceLang = data.source || 'es';
  const targetLang = data.target || 'en';

  if (!text) {
    throw new functions.https.HttpsError("invalid-argument", "No se proporcionó texto para traducir.");
  }

  try {
    // Realiza la traducción
    const [translation] = await translate.translate(text, { from: sourceLang, to: targetLang });
    return { translatedText: translation };
  } catch (error) {
    throw new functions.https.HttpsError("internal", "Error en la traducción", error);
  }
});
