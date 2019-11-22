// rollup.config.js
import resolve from 'rollup-plugin-node-resolve';
import commonjs from "rollup-plugin-commonjs";


export default {
  input: 'javascript/main.js',
  output: {
    file: 'javascript/bundle.js',
    format: 'iife'
  },
  plugins: [ resolve(), commonjs() ]
};