require "audible"
require "option_parser"

shout = false
asin = ""
codec = "LC_128_44100_Stereo"
config = Path["~/.audible.json"].expand(home: true)

option_parser = OptionParser.parse do |parser|

  parser.on "-v", "--version", "Show version" do
    puts "version 1.0"
    exit
  end
  parser.on "-h", "--help", "Show help" do
    puts parser
    exit
  end
  parser.on "-a ASIN", "--asin=ASIN", "Enter ASIN" do |myasin|
    asin = myasin
  end
  parser.on "-c CODEC", "--codec=CODEC", "Enter CODEC" do |mycodec|
    codec = mycodec
  end
  parser.on "-j CONFIG", "--json=audible.json", "Enter a audible.json file" do |json|
    config = json
  end
  parser.missing_option do |option_flag|
    STDERR.puts "ERROR: #{option_flag} is missing something."
    STDERR.puts ""
    STDERR.puts parser
    exit(1)
  end
  parser.invalid_option do |option_flag|
    STDERR.puts "ERROR: #{option_flag} is not a valid option."
    STDERR.puts parser
    exit(1)
  end
end

unless asin.empty?
  get_url(asin, codec, config)
else
  puts "Please supply an asin: -- -a ASIN"
end

def get_url(asin, codec, config)

  client = Audible::Client.from_json(File.read("#{config}"))

  request = HTTP::Request.new("GET", "/FionaCDEServiceEngine/FSDownloadContent?type=AUDI&currentTransportMethod=WIFI&key=#{asin}&codec=#{codec}")
  request = client.sign_request(request)

  tld = Audible::LOCALES[client.locale]["AUDIBLE_API"].to_s.split("api.audible.")[1]
  content_url = HTTP::Client.new(URI.parse("https://cde-ta-g7g.amazon.com")).exec(request)
    .headers["Location"].gsub("https://cds.audible.com", "https://cds.audible.#{tld}")
  print content_url
end
