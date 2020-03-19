require "audible"
require "option_parser"

filename = Path["~/.audible.json"].expand(home: true)
username = ""
password = ""
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
  parser.on "-u USER", "--user=USERNAME", "Enter username email." do |email|
    username = email
  end
  parser.on "-p PASSWORD", "--codec=PASSWORD", "Enter password" do |pass|
    password = pass
  end
  parser.on "-l LOCALE", "--locale=LOCALE", "Enter Locale. ex. ca, us, uk" do |loc|
   locale = loc
  end
  parser.on "-f FILENAME", "--file=FILENAME", "Enter Filename: ~/.'filename'.json default ~/.audible.json" do |file|
    filename = Path["~/.#{file}.json"].expand(home: true)
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

unless username.empty? && password.empty?
  get_json(username, password, filename, locale)
else
 puts "Missing -u username -p password"
end

def get_json(username, password, filename, locale)
  client = Audible::Client.new("#{username}", "#{password}", locale: "#{locale}")
  File.write("#{filename}", client.to_json)
end
