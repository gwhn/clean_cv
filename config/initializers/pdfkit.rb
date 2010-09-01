PDFKit.configure do |config|
  config.default_options = {
          :wkhtmltopdf => '/usr/local/bin/wkhtmltopdf ',
          :page_size => 'A4',
          :print_media_type => true
  }
end
