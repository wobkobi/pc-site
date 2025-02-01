import {FlatCompat} from "@eslint/eslintrc";
import js from "@eslint/js";
import typescriptEslint from "@typescript-eslint/eslint-plugin";
import tsParser from "@typescript-eslint/parser";
import prettier from "eslint-plugin-prettier";
import path from "node:path";
import {fileURLToPath} from "node:url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const compat = new FlatCompat({
  baseDirectory: __dirname,
  recommendedConfig: js.configs.recommended,
  allConfig: js.configs.all,
});

const eslintConfig = [
  ...compat.extends("eslint:recommended", "plugin:@typescript-eslint/recommended", "plugin:@next/next/recommended", "next/core-web-vitals", "eslint:recommended", "next", "prettier"),
  {
    plugins: {
      "@typescript-eslint": typescriptEslint,
      prettier,
    },

    languageOptions: {
      parser: tsParser,
    },

    settings: {
      "import/resolver": {
        node: {
          extensions: [".js", ".jsx", ".ts", ".tsx"],
        },
      },
    },

    rules: {
      "@typescript-eslint/no-unused-vars": "error",

      "prettier/prettier": [
        "error",
        {
          endOfLine: "auto",
        },
      ],

      "@typescript-eslint/consistent-type-definitions": ["error", "type"],
    },
  },
];

export default eslintConfig;
