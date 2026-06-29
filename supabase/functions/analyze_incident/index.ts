
/// <reference types="https://esm.sh/@supabase/functions-js/src/edge-runtime.d.ts" />

import { GoogleGenAI } from "npm:@google/genai";
import { Buffer } from "node:buffer";

const ai = new GoogleGenAI({
  apiKey: Deno.env.get("GEMINI_API_KEY")!,
});

Deno.serve(async (req) => {
  try {

    const { imageUrl } = await req.json();

    const response = await fetch(imageUrl);

    const buffer = await response.arrayBuffer();

    const base64 = Buffer
        .from(buffer)
        .toString("base64");

    const result = await ai.models.generateContent({
      model: "gemini-2.5-flash",

      config: {
        responseMimeType: "application/json",
      },

      contents: [
        {
          inlineData: {
            mimeType: "image/jpeg",
            data: base64,
          },
        },
        {
          text: `
            Analiza esta incidencia urbana.

            Devuelve exclusivamente:

            {
              "categoria":"",
              "riesgo": 1,
              "descripcion":"",
              "entidad":"",
              "is_incident": true
            }

            Reglas:

            * para el Riesgo solo hay 3 tipos:
              1 = Bajo
              2 = Medio
              3 = Alto
              
            * para entidades escoge solo de esta lista: 
              [
                {
                  "name": "Aguas de Cartagena"
                },
                {
                  "name": "Veolia"
                },
                {
                  "name": "Pacaribe"
                },
                {
                  "name": "Surtigas"
                },
                {
                  "name": "Movilidad Cartagena"
                },
                {
                  "name": "Policía Nacional"
                },
                {
                  "name": "Bomberos Cartagena"
                },
                {
                  "name": "DADIS"
                },
                {
                  "name": "EPA Cartagena"
                },
                {
                  "name": "Alcaldía de Cartagena"
                },
                {
                  "name": "Espacio Público"
                },
                {
                  "name": "Protección Animal"
                },
                {
                  "name": "Defensa Civil"
                },
                {
                  "name": "Secretaría de Educación"
                },
                {
                  "name": "Cruz Roja Colombiana"
                },
                {
                  "name": "Secretaría de Infraestructura"
                },
                {
                  "name": "Guardacostas"
                },
                {
                  "name": "Ministerio de Ambiente"
                },
                {
                  "name": "Gestión del Riesgo"
                },
                {
                  "name": "Afinia"
                }
              ];

            * para las clasificaciones escoge solo de esta lista:
              [
                {
                  "name": "Infraestructura"
                },
                {
                  "name": "Seguridad"
                },
                {
                  "name": "Movilidad"
                },
                {
                  "name": "Servicios públicos"
                },
                {
                  "name": "Medio ambiente"
                },
                {
                  "name": "Comunidad"
                },
                {
                  "name": "Emergencias"
                },
                {
                  "name": "Espacio urbano"
                },
                {
                  "name": "Otros reportes"
                },
                {
                  "name": "Mascotas y animales"
                }
              ];

            * para la propiedad is_incident siempre retorna true, siempre y cuando la imagen analizada sea de verdad un incidente,
              si no lo es retorna false, Ejemplo: Si el usuario envia una foto de una mesa y objetos eso no es incidente y retornas false asi con todos los que no apliquen.

            * Para la descripción devuelve un resumen claro y resumido de lo que vez en la imagen de unas 3 a 4 lineas.

            * No agregues texto adicional solo la estructura del json que te deje arriba..
          `,
        },
      ],
    });

    const text = result.text ?? "";

    return new Response(
      JSON.stringify({
        response: text,
      }),
      {
        headers: {
          "Content-Type": "application/json",
        },
      },
    );

  } catch (e) {

    return new Response(
      JSON.stringify({
        error: e.toString(),
      }),
      {
        status: 500,
      },
    );
  }
});