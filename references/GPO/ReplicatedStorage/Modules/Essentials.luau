 

game:GetService("RunService")
local u1 = game:GetService("TweenService")
local u2 = RaycastParams.new()
u2.FilterType = Enum.RaycastFilterType.Include
u2.FilterDescendantsInstances = { workspace.Islands, workspace.Env }
u2.IgnoreWater = true
local v32 = {
    ["RaycastParams"] = u2,
    ["Mouse"] = require(script.Mouse),
    ["DrawRay"] = function(p3, p4, p5) --[[ Name: DrawRay, Line 33 ]]
        local v6 = typeof(p3) == "Vector3"
        local v7 = typeof(p4) == "Vector3"
        local v8 = v6 and p3 and p3 or p3.Position
        local v9 = v7 and p4 and p4 or p4.Position
        local v10 = (v9 - v8).Magnitude
        local v11 = Instance.new("Part")
        v11.Anchored = true
        v11.Color = p5 or Color3.fromRGB(255, 255, 255)
        v11.Locked = true
        v11.CanCollide = false
        v11.Size = Vector3.new(0.5, 0.5, v10)
        v11.CFrame = CFrame.new(v8, v9) * CFrame.new(0, 0, -v10 / 2)
        v11.Parent = workspace.Effects
    end,
    ["BeamToggle"] = function(p12) --[[ Name: BeamToggle, Line 51 ]]
        for _, v13 in pairs(typeof(p12) == "table" and p12 and p12 or p12:GetChildren()) do
            if v13:IsA("Beam") then
                v13.Enabled = not v13.Enabled
            end
        end
    end,
    ["Tween"] = function(p14, p15, p16) --[[ Name: Tween, Line 59 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local u17 = u1:Create(p14, p15, p16)
        u17:Play()
        task.delay(p15.Time * 1.05, function() --[[ Line: 64 ]]
            --[[
            Upvalues:
                [1] = u17
            --]]
            if u17 then
                u17:Destroy()
            end
        end)
        return u17, p15
    end,
    ["Destroy"] = function(p18, p19) --[[ Name: Destroy, Line 73 ]]
        local v20 = typeof(p18) == "table" and p18 and p18 or { p18 }
        for _, u21 in pairs(v20) do
            task.delay(p19, function() --[[ Line: 77 ]]
                --[[
                Upvalues:
                    [1] = u21
                --]]
                local v22 = u21
                if typeof(v22) == "Instance" then
                    u21:Destroy()
                else
                    local v23 = u21
                    if typeof(v23) == "RBXScriptConnection" then
                        u21:Disconnect()
                    end
                end
            end)
        end
    end,
    ["GetTime"] = function(p24, p25) --[[ Name: GetTime, Line 87 ]]
        local v26 = p24 / p25
        return math.abs(v26)
    end,
    ["Emit"] = function(p27, p28, p29, _) --[[ Name: Emit, Line 91 ]]
        if p28 then
            for _, v30 in pairs(p27:GetChildren()) do
                if v30:IsA("ParticleEmitter") then
                    v30:Emit(v30:GetAttribute("EmitCount"))
                end
            end
        else
            for _, u31 in pairs(p27:GetChildren()) do
                if u31:IsA("ParticleEmitter") then
                    if u31.Enabled then
                        local _ = u31.Enabled
                    else
                        u31:Emit(u31:GetAttribute("EmitCount"))
                    end
                    u31.Enabled = not u31.Enabled
                    if p29 then
                        task.delay(p29, function() --[[ Line: 112 ]]
                            --[[
                            Upvalues:
                                [1] = u31
                            --]]
                            u31.Enabled = not u31.Enabled
                        end)
                    end
                end
            end
        end
    end
}
local u33 = require(game.ReplicatedStorage.Modules.RotatedRegion3)
function v32.CreateHitbox(p34, p35, p36) --[[ Line: 123 ]]
    --[[
    Upvalues:
        [1] = u33
    --]]
    local v37 = OverlapParams.new()
    v37.FilterType = Enum.RaycastFilterType.Include
    v37.FilterDescendantsInstances = p36
    local v38 = {}
    for _, v39 in u33.new(p34, p35):FindPartsInRegion3WithWhiteList(p36, 5000) do
        if not table.find(v38, v39.Parent) then
            local v40 = v39.Parent
            table.insert(v38, v40)
        end
    end
    if v38[1] then
        return v38
    else
        return nil
    end
end
function v32.Raycast(p41, p42) --[[ Line: 147 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    return workspace:Raycast(p41, p42, u2)
end
v32.Visualize = v32.DrawRay
return v32