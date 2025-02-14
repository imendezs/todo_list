/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

const functions = require('firebase-functions');
const admin = require('firebase-admin');
const { Translate } = require('@flutter pub add http').v2;

admin.initializeApp();

// Inicializa el cliente de Google Translate
const translate = new Translate();

// Firestore Trigger que se activa cuando se crea una nueva tarea
exports.translateTask = functions.firestore
    .document('tasks/{taskId}')
    .onCreate(async (snap, context) => {
        const newValue = snap.data();
        const title = newValue.title;
        const description = newValue.description;

        try {
            // Traducción del título y la descripción
            const [translatedTitle] = await translate.translate(title, 'en');
            const [translatedDescription] = await translate.translate(description, 'en');

            // Actualiza la tarea con la traducción
            await snap.ref.update({
                translatedTitle: translatedTitle,
                translatedDescription: translatedDescription,
            });

            console.log('Tarea traducida y actualizada exitosamente');
        } catch (error) {
            console.error('Error al traducir la tarea:', error);
        }
    });

