 

local v1 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local function u2() --[[ Line: 4 ]] end
local v3 = {}
local function u8(p4, u5, u6) --[[ Line: 7 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local u7 = {
        ["Direction"] = u6:GetAttribute("Direction"),
        ["Steepness"] = u6:GetAttribute("Steepness"),
        ["Length"] = u6:GetAttribute("Length"),
        ["WaveUpdated"] = u2
    }
    u6:GetAttributeChangedSignal("Direction"):Connect(function() --[[ Line: 15 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u6
            [3] = u5
        --]]
        u7.Direction = u6:GetAttribute("Direction")
        u5.WaveUpdated(u7)
    end)
    u6:GetAttributeChangedSignal("Steepness"):Connect(function() --[[ Line: 19 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u6
            [3] = u5
        --]]
        u7.Steepness = u6:GetAttribute("Steepness")
        u5.WaveUpdated(u7)
    end)
    u6:GetAttributeChangedSignal("Length"):Connect(function() --[[ Line: 23 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u6
            [3] = u5
        --]]
        u7.Length = u6:GetAttribute("Length")
        u5.WaveUpdated(u7)
    end)
    table.insert(p4, u7)
end
local function u16(p9, p10) --[[ Line: 30 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    local v11 = next
    local v12, v13 = p9:GetChildren()
    local v14 = {}
    for _, v15 in v11, v12, v13 do
        if v15:IsA("Configuration") then
            u8(v14, p10, v15)
        end
    end
    return v14
end
local function v19(p17) --[[ Line: 40 ]]
    --[[
    Upvalues:
        [1] = u16
    --]]
    local v18 = {
        ["Name"] = p17.Name,
        ["P0"] = {
            ["Position"] = p17.P0.Position
        },
        ["P1"] = {
            ["Position"] = p17.P1.Position
        }
    }
    v18.Waves = u16(p17, v18)
    return v18
end
if v1.Assets.StreamingObjects.OceanRegions:GetAttribute("ready") == nil then
    repeat
        task.wait()
    until v1.Assets.StreamingObjects.OceanRegions:GetAttribute("ready") ~= nil
end
local v20 = next
local v21, v22 = v1.Assets.StreamingObjects.OceanRegions:GetChildren()
for _, v23 in v20, v21, v22 do
    v3[v23.Name] = v19(v23)
end
v3.DefaultRegionData = v19(v1.Assets.StreamingObjects.DefaultOceanRegion)
return v3