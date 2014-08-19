platform = RUBY_PLATFORM
if platform.include?("darwin") # OS X machine
  binary_path = '/Users/nielsonrolim/.rvm/gems/ruby-2.1.2@utineonatal/bin/wkhtmltopdf'
elsif platform.include?("64-linux") # 64-bit linux machine
  binary_path = '/home/garimpo/.rvm/gems/ruby-2.1.2@utineonatal/bin/wkhtmltopdf'
end

WickedPdf.config = {
  #:wkhtmltopdf => '/usr/local/bin/wkhtmltopdf',
  :layout => "pdf.pdf.erb",

  #:exe_path => '/usr/local/bin/wkhtmltopdf'
  :exe_path => binary_path
}
