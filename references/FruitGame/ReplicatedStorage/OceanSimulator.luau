 

local u1 = game:GetService("RunService")
local v2 = require(script.PartToSettingConverter)
local u3 = require(script.SimulationManager)
local u4 = require(script.ChunkManager)
require(script.WavePlane)
local u5 = require(script.TextureSync)
local u6 = require(script.WaveSettings)
local u7 = require(script.GerstnerCalculation)
local u8 = u1:IsClient()
local u9 = nil
local u10 = nil
local u11 = nil
v2.Setup()
local function v15(p12, p13, p14) --[[ Line: 33 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u4
        [3] = u11
    --]]
    if u10 then
        u10:Destroy()
        u10 = nil
    end
    u10 = u4.new(p12, p13, u11 or 0, p14)
end
local function u19(p16) --[[ Line: 41 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u10
        [3] = u9
        [4] = u1
    --]]
    local v17 = u8
    assert(v17, "Cannot run client-side function on the server.")
    local v18 = u10
    assert(v18, "You must initialize the chunk manager before using this.")
    if p16 then
        if not u9 then
            u9 = u1.Heartbeat:Connect(function() --[[ Line: 46 ]]
                --[[
                Upvalues:
                    [1] = u10
                --]]
                u10:Update()
            end)
            return
        end
    elseif u9 then
        u9:Disconnect()
    end
end
local function v22(p20) --[[ Line: 57 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u5
        [3] = u10
    --]]
    local v21 = u8
    assert(v21, "Cannot run client-side function on the server.")
    u5.SetEnabled(p20)
    if u10 then
        u10:enableTexturePreload(p20)
    end
end
local function v25(p23) --[[ Line: 71 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u7
        [3] = u11
    --]]
    local v24 = u6.GetWaveSettings(p23.X, p23.Z)
    return u7.GetWaveHeightAtPosition(p23, v24, workspace:GetServerTimeNow()) + (u11 or 0)
end
local function v27(p26) --[[ Line: 81 ]]
    --[[
    Upvalues:
        [1] = u11
    --]]
    u11 = p26
end
local v35 = {
    ["EnableSimulation"] = function(p28) --[[ Name: EnableSimulation, Line 27 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u3
        --]]
        local v29 = u8
        assert(v29, "Cannot run client-side function on the server.")
        u3.SetEnabled(p28)
    end,
    ["InitializeChunkManager"] = v15,
    ["EnableChunkManager"] = u19,
    ["EnableTextureSync"] = v22,
    ["SetEnabled"] = function(p30) --[[ Name: SetEnabled, Line 65 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u19
            [3] = u3
        --]]
        local v31 = u8
        assert(v31, "Cannot run client-side function on the server.")
        u19(p30)
        local v32 = u8
        assert(v32, "Cannot run client-side function on the server.")
        u3.SetEnabled(p30)
    end,
    ["GetWaveHeightAtPosition"] = v25,
    ["GetWaveNormalAtPosition"] = function(p33) --[[ Name: GetWaveNormalAtPosition, Line 76 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u7
        --]]
        local v34 = u6.GetWaveSettings(p33.X, p33.Z)
        return u7.GetWaveNormalAtPosition(p33, v34, workspace:GetServerTimeNow())
    end,
    ["WaveSettings"] = u6,
    ["SetOceanHeight"] = v27,
    ["LowWaveResolution"] = {
        ["type"] = "WaveSimulationLowWaveResolution"
    },
    ["MediumWaveResolution"] = {
        ["type"] = "WaveSimulationMediumWaveResolution"
    },
    ["HighWaveResolution"] = {
        ["type"] = "WaveSimulationHighWaveResolution"
    },
    ["UltraHighWaveResolution"] = {
        ["type"] = "WaveSimulationUltraHighWaveResolution"
    }
}
return table.freeze(v35)