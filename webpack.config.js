const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const VueLoaderPlugin = require('vue-loader/lib/plugin');
const path = require('path');
const webpack = require('webpack');
const devMode = process.env.NODE_ENV !== 'production';

function sassRules() {
    return [{
        test: /\.(sa|sc|c)ss$/,
        use: [
            MiniCssExtractPlugin.loader,
            { loader: 'css-loader', options: { url: false, sourceMap: true } },
            { loader: 'sass-loader', options: { sourceMap: true } }
        ]
    }];
}

function scriptRules () {
    return [{
        test: /\.js$/,
        exclude: [/node_modules/],
        loader: 'babel-loader',
        options: { presets: ['@babel/preset-env'] }
    }];
}

function vueRules () {
    return [{
        test: /\.vue$/,
        loader: 'vue-loader'
    }];
}

module.exports = {
    mode: devMode ? 'development' : 'production',
    // stats: 'errors-only',
    context: __dirname,
    entry: [
        './app/frontend/sass/app.scss',
        './app/frontend/javascripts/entry.js'
    ],
    output: {
        // filename: '../public/app.js',
        // path: __dirname + '/public'
        path: path.join(__dirname, 'app', 'assets', 'javascripts'),
        filename: 'app.js',
        publicPath: '/assets',
    },
    resolve: {
        alias: { 'vue$': 'vue/dist/vue.esm.js' },
        extensions: ['*', '.js', '.vue', '.json']
    },
    module: { rules: sassRules().concat(scriptRules()).concat(vueRules()) },
    plugins: [
        new webpack.ProgressPlugin(),
        new MiniCssExtractPlugin({ filename: '../stylesheets/app.css' }),
        new VueLoaderPlugin({ filename: '../javascripts/vue.js' })
    ]
}
