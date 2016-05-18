cheerio = require 'cheerio'
request = require 'request'
fs      = require 'fs'

url = 'https://countrycode.org/'

codes = []

request url, ( error, response, html ) ->
  
  if !error
    $ = cheerio.load html
    $table = $( '.table.table-hover.table-striped.main-table' )
    $table.find( 'tbody tr' ).each ( index, element ) ->
      $elem = $ element
      codes.push
        country : $( $elem.children()[0] ).text()
        code    : $( $elem.children()[1] ).text()

    fs.writeFile __dirname + '/../countryCodes.json', JSON.stringify( codes ), ( err ) ->
      if !err
        console.log 'File Saved...'
      else
        console.log err

    return