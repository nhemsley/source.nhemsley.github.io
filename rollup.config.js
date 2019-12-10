// rollup.config.js
import resolve from 'rollup-plugin-node-resolve';
import commonjs from "rollup-plugin-commonjs";
import { terser } from "rollup-plugin-terser";
import multiInput from 'rollup-plugin-multi-input';


export default {
  input: 'javascript/*.js',
  output: {
    dir: 'javascript/build',
    format: 'esm'
  },
  plugins: [ 
    resolve()
    , commonjs() 
    // , terser()
    , multiInput()
  ]
};