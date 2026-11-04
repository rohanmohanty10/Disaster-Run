 

local v1 = script.Parent.Parent
local v2 = v1:FindFirstChild("Packages")
return {
    ["Directory"] = v2 or v1.Parent,
    ["IsPlugin"] = v2 ~= nil
}