const { environment } = require('@rails/webpacker')
const webpack = require('webpack');

// environment.plugins.set(
//     'Provide',
//     new webpack.ProvidePlugin({
//       $: 'jquery',
//       jQuery: 'jquery',
//       Popper: ['popper.js', 'default']
//     })
// )
environment.plugins.prepend(
    'Provide',
    new webpack.ProvidePlugin({
      $: 'jquery/dist/jquery',
      jQuery: 'jquery/dist/jquery',
      Popper: 'popper.js/dist/popper',
      DateTimePicker: 'tempusdominus-bootstrap-4/src/js/tempusdominus-bootstrap-4'
    })
)
module.exports = environment
