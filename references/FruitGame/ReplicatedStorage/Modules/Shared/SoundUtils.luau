 

game:GetService("SoundService")
local v1 = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Shared")
local u2 = require(v1:WaitForChild("DebrisService"))
local u3 = script:WaitForChild("Sounds")
local u11 = {
    ["Disabled"] = false,
    ["Debug"] = false,
    ["SetSoundsFolder"] = function(_, p4) --[[ Name: SetSoundsFolder, Line 20 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        u3 = p4
    end,
    ["Disable"] = function(_, p5) --[[ Name: Disable, Line 24 ]]
        --[[
        Upvalues:
            [1] = u11
        --]]
        u11.Disabled = p5
        warn(("SoundService has been %s"):format(p5 and "Disabled!" or "Enabled!"))
    end,
    ["EnableDebug"] = function(_, p6) --[[ Name: EnableDebug, Line 29 ]]
        --[[
        Upvalues:
            [1] = u11
        --]]
        u11.Debug = p6
    end,
    ["AdjustInstanceProperties"] = function(_, p7, p8) --[[ Name: AdjustInstanceProperties, Line 33 ]]
        for v9, v10 in pairs(p8) do
            p7[v9] = v10
        end
    end
}
local u12 = {
    ["Chrous"] = {
        ["ClassName"] = "ChorusSoundEffect"
    },
    ["Compressor"] = {
        ["ClassName"] = "CompressorSoundEffect"
    },
    ["Distortion"] = {
        ["ClassName"] = "DistortionSoundEffect"
    },
    ["Echo"] = {
        ["ClassName"] = "EchoSoundEffect"
    },
    ["Equalizer"] = {
        ["ClassName"] = "EqualizerSoundEffect"
    },
    ["Flange"] = {
        ["ClassName"] = "FlangeSoundEffect"
    },
    ["PitchShift"] = {
        ["ClassName"] = "PitchShiftSoundEffect"
    },
    ["Reverb"] = {
        ["ClassName"] = "ReverbSoundEffect"
    },
    ["Tremolo"] = {
        ["ClassName"] = "TremoloSoundEffect"
    }
}
function u11.AdjustSoundEffects(_, p13, p14) --[[ Line: 51 ]]
    --[[
    Upvalues:
        [1] = u12
        [2] = u11
    --]]
    for v15, v16 in pairs(p14) do
        local v17 = u12[v15]
        local v18 = Instance.new(v17.ClassName)
        v18.Parent = p13
        u11:AdjustInstanceProperties(v18, v16)
    end
end
function u11.GetSoundCategory(_, p19) --[[ Line: 62 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v20 = u3:FindFirstChild(p19)
    if v20 then
        return v20
    end
    warn(("[SoundService]: Failed to find category with the name of (%s)!"):format(p19))
    return nil
end
function u11.GetSound(_, p21, p22) --[[ Line: 73 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v23 = type(p21) == "string"
    assert(v23, "Requested sound must be a string!")
    local v24 = p22.SoundCategory or nil
    local v25 = p22.SubCategory or nil
    local v26 = v25 ~= nil and (v24 ~= nil and (u3[v24] ~= nil and u3[v24][v25] ~= nil)) and u3[v24][v25]:FindFirstChild(p21) or (v24 ~= nil and u3[v24] ~= nil and u3[v24]:FindFirstChild(p21) or u3:FindFirstChild(p21, true))
    if v26 then
        return v26
    end
    warn(("[SoundService]: Failed to find sound with the name of (%s)!"):format(p21))
    return nil
end
function u11.PlaySound(p27, p28) --[[ Line: 96 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u2
        [3] = u3
    --]]
    local v29 = type(p27) == "string"
    assert(v29, "Requested sound must be a string!")
    if u11.Disabled == false then
        local _ = p28.SoundCategory or nil
        local v30 = p28.InObject or nil
        local v31 = p28.Location or nil
        if p28.RandomPitch then
            if p28.Properties == nil then
                p28.Properties = {}
            end
            p28.Properties.Pitch = math.random(90, 110) / 100
        end
        local v32 = p28.Properties or nil
        local v33 = p28.SoundEffects or nil
        local v34 = u11:GetSound(p27, p28)
        if v34 then
            local v35 = v34:Clone()
            v35.PlayOnRemove = false
            u2:AddItem(v35, v34.TimeLength + 1)
            if v32 ~= nil then
                u11:AdjustInstanceProperties(v35, v32)
            end
            if v33 ~= nil then
                u11:AdjustSoundEffects(v35, v33)
            end
            if v31 then
                v30 = Instance.new("Part")
                v30.Anchored = true
                v30.CanCollide = false
                v30.CanQuery = false
                v30.CanTouch = false
                v30.Transparency = 1
                v30.Size = Vector3.new(1, 1, 1)
                v30.Name = "SFX"
                v30.CFrame = v31
                v30.Parent = workspace.Effects
            end
            v35.Parent = v30 or u3.Debris
            v35:Play()
            return v35
        end
    end
    if u11.Debug then
        warn(p27, p28)
    end
end
return u11