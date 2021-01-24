const path = require('path');
const webpack = require('webpack');




const HtmlWebpackPlugin = require('html-webpack-plugin')
const ScriptExtHtmlWebpackPlugin = require('script-ext-html-webpack-plugin')




/*
 * We've enabled HtmlWebpackPlugin for you! This generates a html
 * page for you when you compile webpack, which will make you start
 * developing and prototyping faster.
 *
 * https://github.com/jantimon/html-webpack-plugin
 *
 */

module.exports = {
  mode: 'production',
  entry: './srcjs/index.js',

  output: {
    path: path.resolve(__dirname, 'inst')
  },

  plugins: [new webpack.ProgressPlugin(), new HtmlWebpackPlugin({
    template: './srcjs/index.html'
  }), new ScriptExtHtmlWebpackPlugin({
    inline: [/\.js$/]
  })],

  module: {
    rules: [{
      test: /\.(js|jsx)$/,
      include: [path.resolve(__dirname, 'srcjs')],
      loader: 'babel-loader'
    }]
  },

  devServer: {
    open: true,
    host: 'localhost'
  }
}
