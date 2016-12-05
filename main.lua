local LSystem = require("lsystem")

local axiom = {{"a"}}
local rules = {}
rules["a"] = "ab"
rules["b"] = "ac"
rules["c"] = "c"

for i=1,3 do
	axiom = LSystem(axiom,rules)
end

local str = ""
for i,v in ipairs(axiom) do
	str = str.. v[1]
end
print(str)
