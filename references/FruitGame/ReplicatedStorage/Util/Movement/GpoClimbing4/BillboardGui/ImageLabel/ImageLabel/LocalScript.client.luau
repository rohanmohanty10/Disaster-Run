 

local v1 = require(script.ConfigReader)
local v2 = {
    ["diameter"] = 120,
    ["padding"] = 4,
    ["count"] = 64,
    ["size"] = 1024
}
local v3 = Vector2.new
script.Parent.ImageRectSize = v3(v1.GetSize(v2))
local v4 = 0
while task.wait(0.1) do
    script.Parent.ImageRectOffset = v3(v1.GetOffset(v2, v4))
    v4 = v4 + 1
end