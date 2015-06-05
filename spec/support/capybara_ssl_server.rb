require 'webrick/https'
require 'rack/handler/webrick'
 
def run_ssl_server(app, port)
 
  opts = {
    :Port => port,
    :SSLEnable => true,
    :SSLVerifyClient => OpenSSL::SSL::VERIFY_NONE,
    :SSLPrivateKey => OpenSSL::PKey::RSA.new("./spec/support/server.key"),
    :SSLCertificate => OpenSSL::X509::Certificate.new(File.read "./spec/support/server.crt"),
    :SSLCertName => [["US", 'localhost']],
    :AccessLog => [], 
    :Logger => WEBrick::Log::new(Rails.root.join("./log/capybara_test.log").to_s)
  }
 
  Rack::Handler::WEBrick.run(app, opts)
end