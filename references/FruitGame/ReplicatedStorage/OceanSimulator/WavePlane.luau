 

local v1 = game:GetService("RunService")
local u2 = require(script.Parent.FrustumCulling)
local u3 = require(script.Parent.SimulationManager)
local u4 = require(script.Parent.TextureSync)
local u5 = require(script.Parent.WaveSettings)
local u6 = workspace:FindFirstChild("WavesStorage")
if not u6 and v1:IsClient() then
    u6 = Instance.new("Folder")
    u6.Name = "WavesStorage"
    u6.Parent = workspace
end
local u7 = script.Parent:GetAttribute("PlaneSize") or 100
local u8 = script.Parent:GetAttribute("MaxRenderDistance") or 512
local u9 = script.Parent:GetAttribute("ActorsAmount") or 1
local u10 = script.Simulation
local u11 = {}
u11.__index = u11
function u11.new(p12) --[[ Line: 85 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u9
        [3] = u10
        [4] = u7
        [5] = u6
    --]]
    local v13
    if p12.type == "WaveSimulationUltraHighWaveResolution" then
        v13 = script.Wave4:Clone()
    elseif p12.type == "WaveSimulationHighWaveResolution" then
        v13 = script.Wave3:Clone()
    elseif p12.type == "WaveSimulationMediumWaveResolution" then
        v13 = script.Wave2:Clone()
    elseif p12.type == "WaveSimulationNoBoneResolution" then
        v13 = script.NoBone:Clone()
    else
        v13 = script.Wave1:Clone()
    end
    local v14 = {
        ["wavePlane"] = v13,
        ["bonesList"] = {},
        ["actorsList"] = {},
        ["isReset"] = true,
        ["isInFrustum"] = false,
        ["isActive"] = false,
        ["treeVersion"] = 0
    }
    local v15 = u11
    local v16 = setmetatable(v14, v15)
    if p12.type ~= "WaveSimulationNoBoneResolution" then
        for _, v17 in v13:GetChildren() do
            if v17:IsA("Bone") then
                local v18 = v14.bonesList
                table.insert(v18, v17)
            end
        end
        for _ = 1, u9 do
            local v19 = Instance.new("Actor")
            u10:Clone().Parent = v19
            local v20 = v16.actorsList
            table.insert(v20, v19)
        end
        for _, v21 in v16.actorsList do
            v21.Parent = v16.wavePlane
            local v22 = v21:FindFirstChild(u10.Name)
            if v22 and v22:IsA("Script") then
                v22.Enabled = true
            end
        end
    end
    local v23 = u7
    local v24 = u7
    v16:UpdateMeshSize((Vector3.new(v23, 0.001, v24)))
    v13.Parent = u6
    v13.Transparency = 0
    return v16
end
function u11.Destroy(p25) --[[ Line: 142 ]]
    p25:Deactivate()
    p25.wavePlane:Destroy()
    table.clear(p25.bonesList)
end
function u11.UpdateMeshSize(p26, p27) --[[ Line: 151 ]]
    local v28 = p26.wavePlane.Size
    p26.wavePlane.Size = p27
    for _, v29 in ipairs(p26.bonesList) do
        local v30 = v29.Position
        local v31 = (v30.X + v28.X / 2) / v28.X
        local v32 = (v30.Y + v28.Y / 2) / v28.Y
        local v33 = (v30.Z + v28.Z / 2) / v28.Z
        local v34 = Vector3.new(v31, v32, v33)
        local v35 = v34.X * p27.X - p27.X / 2
        local v36 = v34.Y * p27.Y - p27.Y / 2
        local v37 = v34.Z * p27.Z - p27.Z / 2
        v29.Position = Vector3.new(v35, v36, v37)
    end
end
function u11.PivotTo(p38, p39) --[[ Line: 178 ]]
    p38.wavePlane:PivotTo(p39)
end
function u11.MoveTo(p40, p41) --[[ Line: 186 ]]
    p40.wavePlane.Position = p41
end
function u11.UpdateSimulation(p42, p43, p44, p45) --[[ Line: 194 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u7
        [3] = u5
    --]]
    local v46 = u2.findInFrustum(p44, p42.wavePlane.Position, u7)
    p42.isInFrustum = v46
    if v46 then
        p42.isReset = false
        local v47
        if p42.treeVersion == u5.GetVersion() then
            v47 = nil
        else
            p42.treeVersion = u5.GetVersion()
            v47 = u5.GetSerializedTree()
        end
        for _, v48 in p42.actorsList do
            v48:SendMessage("Simulate", p43, p45, v47)
        end
    elseif not p42.isReset then
        p42:Reset()
    end
end
function u11.Activate(u49) --[[ Line: 215 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
        [3] = u8
    --]]
    if u49.isActive then
        return false
    end
    u49.isActive = true
    u3.AddWavePlane(u49)
    u4.AddWavePlane(u49)
    local u50 = #u49.actorsList
    local u51 = #u49.bonesList
    if u50 <= 0 or u51 <= 0 then
        return false
    end
    task.defer(function() --[[ Line: 225 ]]
        --[[
        Upvalues:
            [1] = u49
            [2] = u51
            [3] = u50
            [4] = u8
        --]]
        for v52, v53 in u49.actorsList do
            local v54 = u51 / u50
            local v55 = (v52 - 1) * v54
            local v56 = math.floor(v55) + 1
            local v57 = v54 * v52
            local v58 = math.floor(v57)
            v53:SendMessage("PrepareSimulation", u49.bonesList, v56, v58, u8)
        end
    end)
    return true
end
function u11.Deactivate(p59) --[[ Line: 241 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
    --]]
    if not p59.isActive then
        return false
    end
    p59.isActive = false
    u3.RemoveWavePlane(p59)
    u4.RemoveWavePlane(p59)
    return true
end
function u11.Reset(p60) --[[ Line: 252 ]]
    p60.isReset = true
    for _, v61 in ipairs(p60.bonesList) do
        v61.Transform = CFrame.new()
    end
end
u11.LowWaveResolution = {
    ["type"] = "WaveSimulationLowWaveResolution"
}
u11.MediumWaveResolution = {
    ["type"] = "WaveSimulationMediumWaveResolution"
}
u11.HighWaveResolution = {
    ["type"] = "WaveSimulationHighWaveResolution"
}
u11.UltraHighWaveResolution = {
    ["type"] = "WaveSimulationUltraHighWaveResolution"
}
u11.NoBoneResolution = {
    ["type"] = "WaveSimulationNoBoneResolution"
}
return table.freeze(u11)