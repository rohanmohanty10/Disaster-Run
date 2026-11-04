 

local v1 = {
    "rbxassetid://16629070999",
    "rbxassetid://16629070638",
    "rbxassetid://16629070308",
    "rbxassetid://16629070163",
    "rbxassetid://16629070022",
    "rbxassetid://16629069891",
    "rbxassetid://16629069731",
    "rbxassetid://16629069531",
    "rbxassetid://16629069290",
    "rbxassetid://16629069064",
    "rbxassetid://16629068937",
    "rbxassetid://16629068806",
    "rbxassetid://16629068611",
    "rbxassetid://16629068409"
}
local v2 = {}
for v3 = 1, #v1 do
    local v4 = script.ImageLabel:Clone()
    v4.Image = v1[v3]
    v4.Size = UDim2.new(0, 1, 0, 1)
    v4.Position = UDim2.new(0.05, 0, 0.9, 0)
    v4.Parent = script.Parent
    table.insert(v2, v4)
end
for v5 = 1, #v2 do
    v2[v5].Size = UDim2.new(1, 0, 1, 0)
    v2[v5].Position = UDim2.new(0.5, 0, 0.5, 0)
    task.wait(0.02)
    v2[v5]:Destroy()
end
script.Parent:Destroy()