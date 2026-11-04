 

local v1 = script.RightHand:GetChildren()
local u2 = {}
local v3 = {}
for v4 = 1, #v1 do
    local v5 = v1[v4]
    table.insert(u2, v5)
end
local u6 = {
    0.25,
    Enum.EasingStyle.Quad,
    Enum.EasingDirection.Out,
    1,
    true,
    0
}
local u7 = {
    ["Brightness"] = 0
}
local function u11(p8) --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    for v9 = 1, #u2 do
        local v10 = u2[v9]:Clone()
        v10.Parent = p8
        v10:Emit(math.random(1, 4))
        _G.destroy(v10, 0.4)
    end
end
function v3.start(_, p12, p13, p14, p15) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u6
        [3] = u7
    --]]
    if p14:FindFirstChild("LowerTorso") == nil then
        return
    elseif _G.checkRenderDistance(p14.HumanoidRootPart.CFrame.Position) ~= false then
        if (string.sub(p12, 1, 4) == "Mink" or p15 == true) and p13:FindFirstChild("HumanoidRootPart") then
            local v16 = p13:GetChildren()
            for v17 = 1, #v16 do
                if v16[v17]:IsA("BasePart") then
                    u11(v16[v17])
                end
            end
            local v18 = script.minklight:Clone()
            v18.Parent = p13.HumanoidRootPart
            _G.tween(v18, u6, u7)
            _G.destroy(v18, 0.2)
            local v19 = script.elec1:Clone()
            v19.Parent = p13.Head
            v19.Pitch = math.random(90, 120) / 100
            v19:Play()
            _G.destroy(v19, 1.1)
        end
    end
end
return v3