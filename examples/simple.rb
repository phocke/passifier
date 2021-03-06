#!/usr/bin/env ruby
$:.unshift File.join( File.dirname( __FILE__ ), '../lib')

require "passifier"

# This is an example that will generate a simple pass file

# 1. Pass metadata and layout
# This is used to generate the pass.json file for the archive.
# See () for more information about pass.json usage
# 
serial = "SO_SERIAL"
spec = {
  "formatVersion" => 1,
  "passTypeIdentifier" => "pass.example.example",
  "teamIdentifier" => "ATEAMID",
  "relevantDate" => "2012-07-30T14:19Z",          
  "organizationName" => "Example Inc.",
  "serialNumber" => serial,
  "description" => "this is a pass",
  "labelColor" => "rgb(122, 16, 38)",
  "backgroundColor" => "rgb(227, 227, 227)",
  "foregroundColor" => "rgb(110,110,110)",
  "generic" => {
    "headerFields" => [
      {
        "key" => "date",
        "label" => "Date",
        "value" => "October 30th"
      }
    ],
    "primaryFields" => [
      {
        "key" => "title",
        "label" => "",
        "value" => "Passifier!"
      }
    ],
    "secondaryFields" => [
      {
        "key" => "host",
        "label" => "Host",
        "value" => "dev.paperlesspost.com",
      }
    ]
  }
}

#
# 2. Image assets
# notice that you can use either paths or urls here
#
images = {
  "background.png" => "assets/background.png",
  "background@2x.png" => "assets/background@2x.png",
  "icon.png" => "assets/icon.png",
  "icon@2x.png" => "assets/icon@2x.png",
  "logo.png" => "http://i.imgur.com/WLUf6.png",
  "logo@2x.png" => "http://i.imgur.com/mOpQo.png",
  "thumbnail.png" => "assets/thumbnail.png",
  "thumbnail@2x.png" => "assets/thumbnail@2x.png"
}

#
# 3. Signing settings
# Replace with your own paths/password if you plan on running this example
# 
key_pem = "../test/assets/signing/key/key.pem"
pass_phrase = File.read("../test/assets/signing/pass_phrase.txt").strip.lstrip # you can just replace this with a string if you want
cert_pem = "../test/assets/signing/certificate/certificate.pem"

# Create a signing object
signing = Passifier::Signing.new(key_pem, pass_phrase, cert_pem)

#
#
# Now, generate the pass!
#
#

# Create the pass archive
output_file = "./simple.pkpass"
Passifier::Pass.generate(output_file, serial, spec, images, signing)

# Finished!
puts "Finished generating the pass archive: #{output_file}"
