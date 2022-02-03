import resolve from '@rollup/plugin-node-resolve'
import babel from '@rollup/plugin-babel'
import commonjs from '@rollup/plugin-commonjs';

export default {
  input: 'javascript/main.js',
  output: {
    file: 'assets/javascript/main.js',
    format: 'umd'
  },
  plugins: [
    // commonjs(),
    resolve(),
    babel({
      exclude: 'node_modules/**' // only transpile our source code
    })
  ]
};
