local function str_split(str)
	local t = {}
	for i=1, str:len() do
		t[#t+1] = str:sub(i, i)
	end
	return t
end

local function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else 
        copy = orig
    end
    return copy
end


local lsystem = function( axiom, rules )
	local stringt = ''
	for i,v in ipairs(axiom) do
		stringt = stringt..v[1]
	end
	--sprint(stringt)
	local state_rules = {}

	for k, rule in pairs(rules) do
		if type(rule) == 'string' then
			state_rules[k] = str_split(rule)
		else
			state_rules[k] = rule
		end

	end

	local state_axiom = {}

	for i,v in ipairs(axiom) do
		local char = v[1]
		local args = deepcopy(v[2])
		local rule = state_rules[char]
		if type(rule) == 'table' then
			for ii,vv in ipairs(rule) do
				table.insert( state_axiom, {vv,args} )
			end
		elseif type(rule) == 'function' then
			local t = rule(args)
			for ii,vv in ipairs(t) do
				table.insert( state_axiom, vv )
			end
		else
			table.insert(state_axiom, {char,args})
		end
	end

	return state_axiom

end

return lsystem

