require "audible"
require "option_parser"
require "json"

session = Path["~/.audible.json"].expand(home: true)
asin = ""
locale = "ca"

option_parser = OptionParser.parse do |parser|

  parser.on "-v", "--version", "Show version" do
    puts "version 1.0"
    exit
  end
  parser.on "-h", "--help", "Show help" do
    puts parser
    exit
  end
  parser.on "-a ASIN", "--a=ASIN", "Enter ASIN." do |asinopt|
    asin = asinopt
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
  get_json(asin,session)
else
 puts "Missing -a asin"
end

def get_json(asin,session)
  puts "Getting ASIN: #{asin}"
  client = Audible::Client.from_json(File.read("#{session}"))
  res = client.get("/1.0/library/#{asin}?response_groups=product_attrs").body
  parsed = JSON.parse("#{res}")

#p parsed["desc"]["someKey"]
  #p parsed["item"]["available_codecs"][0]["enhanced_codec"]

  over = parsed["item"]["available_codecs"]

  #p over[1]["enhanced_codec"]
  if (over[0].to_s.blank?) {
    p "Blank"
  } else {
    p over[0]["enhanced_codec"]
  }
  end

  if (over[1].to_s.blank?) {
    p "Blank"
  } else {
    p over[1]["enhanced_codec"]
  }
  end

  if (over[2].to_s.blank?) {
    p "Blank"
  } else {
    p over[2]["enhanced_codec"]
  }
  end

  if (over[3].to_s.blank?) {
    p "Blank"
  } else {
    p over[3]["enhanced_codec"]
  }
  end

  if (over[4].to_s.blank?) {
    p "Blank"
  } else {
    p over[4]["enhanced_codec"]
  }
  end


end

# crystal auget.cr --progress --error-trace -- -a B07WZVDD1B
