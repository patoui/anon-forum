const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const OptimizeCssAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const path = require('path');
const webpack = require('webpack');
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');
const isProduction = process.argv.includes('-p');

function stylesheetRules() {
  return [{
    test: /\.(sa|sc|c)ss$/,
    use: [
      MiniCssExtractPlugin.loader,
      { loader: 'css-loader', options: { sourceMap: true } },
      { loader: 'sass-loader', options: { sourceMap: true } }
    ]
  }];
}

function scriptRules() {
  return [{
    test: /\.js$/,
    exclude: [/node_modules/],
    loader: 'babel-loader',
    options: { presets: ['@babel/preset-env'] }
  }];
}

function fontRules() {
  return [{
    test: /\.(svg|eot|ttf|woff|woff2)$/i,
    use: {
      loader: 'file-loader',
      options: {
        name: '../fonts/[name].[ext]'
      }
    }
  }];
}

function imageRules() {
  return [{
    test: /\.(jpe?g|png|gif)$/i,
    use: [
      'url-loader?limit=8192',
      {
        loader: 'file-loader',
        options: {
          name: '../images/[name].[ext]'
        }
      },
      {
        loader: 'img-loader',
        options: {
          plugins: [
            require('imagemin-gifsicle')({ interlaced: false }),
            require('imagemin-mozjpeg')({ progressive: true, arithmetic: false }),
            require('imagemin-pngquant')({ floyd: 0.5, speed: 2 })
          ]
        }
      }
    ]
  }];
}

module.exports = {
  mode: isProduction ? 'production' : 'development',
  context: __dirname,
  entry: { app: './app/frontend/entry.js' },
  output: {
    path: path.join(__dirname, 'app', 'assets', 'javascripts'),
    filename: 'app.js',
    publicPath: '/assets',
  },
  resolve: { extensions: ['*', '.js'] },
  module: {
    rules: stylesheetRules()
      .concat(scriptRules())
      .concat(imageRules())
      .concat(fontRules())
  },
  plugins: [
    new webpack.ProgressPlugin(),
    new MiniCssExtractPlugin({ filename: '../stylesheets/[name].css' })
  ],
  optimization: {
    minimizer: [
      new UglifyJsPlugin({
        cache: true,
        parallel: true,
        sourceMap: true // set to true if you want JS source maps
      }),
      new OptimizeCssAssetsPlugin({})
    ]
  },
}
