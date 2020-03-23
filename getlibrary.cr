require "audible"
require "json"
# Purpose: Get every book in library.
# Reference Examples : https://nts.strzibny.name/building-and-consuming-json-api-with-crystal/

# TODO: Parse eacy page returned from from library, when array returns empty, stop incrementing page number.

# Config.
session = Path["~/.audible.json"].expand(home: true)
locale = "ca"


client = Audible::Client.from_json(File.read("#{session}"))
res = client.get("/1.0/library?page=1").body
parsed = JSON.parse("#{res}")

p parsed["items"][0]["asin"]
