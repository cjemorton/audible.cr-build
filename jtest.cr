require "json"

json_text = %([1, 2, 3])
puts Array(Int32).from_json(json_text) # => [1, 2, 3]

json_text = %({"x": 1, "y": 2})
puts Hash(String, Int32).from_json(json_text) # => {"x" => 1, "y" => 2}
