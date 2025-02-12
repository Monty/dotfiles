import globals from 'globals';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import js from '@eslint/js';
import {FlatCompat} from '@eslint/eslintrc';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const compat = new FlatCompat({
  baseDirectory: __dirname,
  recommendedConfig: js.configs.recommended,
  allConfig: js.configs.all,
});

export default [...compat.extends('eslint:recommended'), {
  languageOptions: {
    globals: {
      ...globals.browser,
      ...globals.node,
    },
  },

  rules: {
    'guard-for-in': 2,
    'no-caller': 2,
    'no-extend-native': 2,
    'no-extra-bind': 2,
    'no-invalid-this': 2,
    'no-multi-spaces': 2,
    'no-multi-str': 2,
    'no-new-wrappers': 2,
    'no-with': 2,
    'array-bracket-spacing': ['error', 'never'],
    'block-spacing': ['error', 'never'],
    'brace-style': 2,
    'comma-dangle': ['error', 'always-multiline'],
    'comma-spacing': 2,
    'comma-style': 2,
    'computed-property-spacing': 2,
    'eol-last': 2,
    'func-call-spacing': 2,
    'key-spacing': 2,
    'keyword-spacing': 2,
    'linebreak-style': 2,

    'max-len': ['error', {
      code: 80,
      tabWidth: 2,
      ignoreUrls: true,
    }],

    'new-cap': 2,
    'no-array-constructor': 2,

    'no-multiple-empty-lines': ['error', {
      max: 2,
    }],

    'no-new-object': 2,
    'no-tabs': 2,
    'no-trailing-spaces': 2,
    'object-curly-spacing': 2,

    'one-var': ['error', {
      var: 'never',
      let: 'never',
      const: 'never',
    }],

    'padded-blocks': ['error', 'never'],
    'quote-props': ['error', 'consistent'],

    'quotes': ['error', 'single', {
      allowTemplateLiterals: true,
    }],

    'semi': 2,
    'semi-spacing': 2,
    'space-before-blocks': 2,

    'space-before-function-paren': ['error', {
      asyncArrow: 'always',
      anonymous: 'never',
      named: 'never',
    }],

    'spaced-comment': ['error', 'always'],
    'switch-colon-spacing': 2,
    'curly': ['error'],
    'default-case': ['error'],
    'dot-notation': ['error'],
    'eqeqeq': ['error', 'smart'],
    'no-magic-numbers': ['error'],
    'no-sequences': ['warn'],
    'no-useless-concat': ['warn'],
    'no-useless-escape': ['warn'],
    'no-var': ['error'],
    'prefer-const': ['error'],
    'vars-on-top': ['warn'],
    'yoda': ['warn'],

    'capitalized-comments': ['warn', 'always', {
      ignoreConsecutiveComments: true,
    }],

  },
}];
