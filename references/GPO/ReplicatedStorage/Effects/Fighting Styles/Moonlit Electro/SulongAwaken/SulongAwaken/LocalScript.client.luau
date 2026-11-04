 

local v1 = {
    "rbxassetid://16318134160",
    "rbxassetid://16318133890",
    "rbxassetid://16318133600",
    "rbxassetid://16318133334",
    "rbxassetid://16318133049",
    "rbxassetid://16318132536",
    "rbxassetid://16318132092",
    "rbxassetid://16318131649",
    "rbxassetid://16318131300"
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