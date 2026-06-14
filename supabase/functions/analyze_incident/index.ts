
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
              "riesgo":1,
              "descripcion":"",
              "entidad":""
            }

            Reglas:

            * para el Riesgo solo hay 3 tipos:
              1 = Bajo
              2 = Medio
              3 = Alto
            * Para la descripción devuelve un resumen claro y resumido de lo que vez en la imagen de unas 3 a 4 lineas.
            * No agregues texto adicional.
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