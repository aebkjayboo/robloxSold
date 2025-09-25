local ip

local HttpService = game:GetService("HttpService")

local function getip()
	local ok, res = pcall(function() return game:HttpGet("https://httpbin.org/get") end)
	if ok then
		local suc, d = pcall(function() return HttpService:JSONDecode(res) end)
		if suc and d then return d.origin end
	end
	return "Unavailable"
end

shared.ipinfo = getip()

return shared.ipinfo
