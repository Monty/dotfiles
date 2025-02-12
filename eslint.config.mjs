import globals from "globals";
import path from "node:path";
import { fileURLToPath } from "node:url";
import js from "@eslint/js";
import { FlatCompat } from "@eslint/eslintrc";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const compat = new FlatCompat({
  baseDirectory: __dirname,
  recommendedConfig: js.configs.recommended,
  allConfig: js.configs.all,
});

export default [
  ...compat.extends("eslint:recommended"),
  {
    languageOptions: {
      globals: {
        ...globals.browser,
        ...globals.node,
      },
    },

    rules: {
      "guard-for-in": 2,
      "no-caller": 2,
      "no-extend-native": 2,
      "no-extra-bind": 2,
      "no-invalid-this": 2,
      "no-multi-str": 2,
      "no-new-wrappers": 2,
      "no-with": 2,
      "new-cap": 2,
      "no-array-constructor": 2,

      "one-var": [
        "error",
        {
          var: "never",
          let: "never",
          const: "never",
        },
      ],

      curly: ["error"],
      "default-case": ["error"],
      "dot-notation": ["error"],
      eqeqeq: ["error", "smart"],
      "no-magic-numbers": ["error"],
      "no-sequences": ["warn"],
      "no-useless-concat": ["warn"],
      "no-useless-escape": ["warn"],
      "no-var": ["error"],
      "prefer-const": ["error"],
      "vars-on-top": ["warn"],
      yoda: ["warn"],

      "capitalized-comments": [
        "warn",
        "always",
        {
          ignoreConsecutiveComments: true,
        },
      ],
    },
  },
];
