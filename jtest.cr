require "json"

library = Path["library.json"].expand(home: true)


json = File.open("#{library}") do |file|
  JSON.parse(file)
end
