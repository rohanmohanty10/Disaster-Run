 
  
local t = {}
function Lerp(p1, p2, p3) --[[ Lerp | Line: 3 ]]
	return p1 + (p2 - p1) * p3
end
function t.Quad(p1, p2, p3, p4) --[[ Quad | Line: 7 ]]
	local v1 = Lerp(p1, p2, p4)
	return Lerp(v1, Lerp(p2, p3, p4), p4)
end
return t