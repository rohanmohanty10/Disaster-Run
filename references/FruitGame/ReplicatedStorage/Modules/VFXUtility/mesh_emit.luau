 

local u1 = {}
u1.__index = u1
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService")
local u4 = game:GetService("Debris")
require(script.Types)
local function u11(u5, u6, p7) --[[ Line: 33 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local u10 = u3.Heartbeat:Connect(function(_) --[[ Line: 36 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u6
        --]]
        local v8 = u5
        local v9 = u6
        v8.CFrame = v8.CFrame * CFrame.Angles(0, math.rad(v9), 0)
    end)
    task.delay(p7, function() --[[ Line: 39 ]]
        --[[
        Upvalues:
            [1] = u10
        --]]
        u10:Disconnect()
    end)
end
local function u15(p12) --[[ Line: 52 ]]
    local v13 = {}
    if (p12:IsA("Part") and p12:FindFirstChildOfClass("SpecialMesh") and "SpecialMesh" or "Mesh") == "SpecialMesh" then
        local v14 = p12:FindFirstChildOfClass("SpecialMesh")
        if not v14 then
            return {}
        end
        v13.Scale = v14.Scale
    else
        v13.Size = p12.Size
    end
    v13.Position = p12.CFrame.Position
    return v13
end
function u1.new(p16) --[[ Line: 67 ]]
    --[[
    Upvalues:
        [1] = u15
        [2] = u1
    --]]
    local v17 = {
        ["Model"] = p16,
        ["Type"] = p16.Start:IsA("Part") and p16.Start:FindFirstChildOfClass("SpecialMesh") and "SpecialMesh" or "Mesh",
        ["Properities"] = u15(p16.Start),
        ["EndProperities"] = u15(p16.End),
        ["Settings"] = p16:GetAttributes()
    }
    local v18 = u1
    return setmetatable(v17, v18)
end
function u1.SetFlipbook(p19, p20) --[[ Line: 78 ]]
    p19.__Flipbook = require(p20)
end
function u1.RandomizeSize(p21, p22, p23) --[[ Line: 82 ]]
    if p21.Type == "SpecialMesh" then
        local v24 = p21.EndProperities
        local v25 = math.random(p22.X, p23.X)
        local v26 = math.random(p22.Y, p23.Y)
        local v27 = math.random
        local v28 = p22.Z
        local v29 = p23.Z
        v24.Scale = Vector3.new(v25, v26, v27(v28, v29))
    else
        local v30 = p21.EndProperities
        local v31 = math.random(p22.X, p23.X)
        local v32 = math.random(p22.Y, p23.Y)
        local v33 = math.random
        local v34 = p22.Z
        local v35 = p23.Z
        v30.Size = Vector3.new(v31, v32, v33(v34, v35))
    end
end
function u1.PlayFlipbook(u36, u37) --[[ Line: 90 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local u38 = u36.__Flipbook
    if u38 then
        local u39 = 1
        local u40 = 0
        local u41 = nil
        u41 = u3.Heartbeat:Connect(function(p42) --[[ Line: 96 ]]
            --[[
            Upvalues:
                [1] = u40
                [2] = u36
                [3] = u39
                [4] = u38
                [5] = u41
                [6] = u37
            --]]
            u40 = u40 + p42
            if u40 >= (1 / u36.Settings.FlipbookRate or 0.016666666666666666) then
                u39 = u39 + 1
                if u39 > #u38 then
                    u41:Disconnect()
                    return
                end
                if u36.Type == "SpecialMesh" then
                    local v43 = u37:FindFirstChildOfClass("Decal")
                    if not v43 then
                        return
                    end
                    v43.Texture = u38[u39]
                else
                    u37.TextureId = u38[u39]
                end
                u40 = 0
            end
        end)
    end
end
function u1.Emit(u44, p45) --[[ Line: 115 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u11
        [3] = u2
    --]]
    local v46 = u44.Settings.Lifetime
    local v47 = Enum.EasingStyle[u44.Settings.EasingStyle]
    local v48 = Enum.EasingDirection[u44.Settings.EasingDirection]
    local v49 = u44.Settings.Transparency or 1
    local v50 = u44.Settings.StartTransparency or 1
    local v51 = u44.Settings.RotationX
    local v52 = not v51 and 0 or math.random(v51.Min, v51.Max)
    local v53 = u44.Settings.RotationY
    local v54 = not v53 and 0 or math.random(v53.Min, v53.Max)
    local v55 = u44.Settings.RotationZ
    local v56 = not v55 and 0 or math.random(v55.Min, v55.Max)
    local v57 = TweenInfo.new(v46, v47, v48)
    local u58 = u44.Model.Start:Clone()
    u44:PlayFlipbook(u58)
    u58.CFrame = (typeof(p45) == "CFrame" and p45 and p45 or p45.CFrame) * CFrame.Angles(math.rad(v52), math.rad(v54), (math.rad(v56)))
    u58.Parent = workspace.Effects
    u4:AddItem(u58, v46)
    local v59 = u44.Model.Start.CFrame:ToObjectSpace(u44.Model.End.CFrame)
    u44.EndProperities.Position = nil
    if u44.Settings.RotationSpeed then
        u11(u58, u44.Settings.RotationSpeed, v46)
    end
    if u44.Type == "SpecialMesh" then
        local u60 = u58:FindFirstChildOfClass("SpecialMesh")
        local v61 = u58:FindFirstChildOfClass("Decal")
        if u60 then
            local v62 = u2:Create(u60, v57, u44.EndProperities)
            local v63 = u2:Create(u58, v57, {
                ["CFrame"] = u58.CFrame * v59
            })
            v62:Play()
            v63:Play()
            v62.Completed:Once(function() --[[ Line: 154 ]]
                --[[
                Upvalues:
                    [1] = u60
                    [2] = u44
                    [3] = u58
                --]]
                u60.Scale = u44.Properities.Scale or Vector3.new(1, 1, 1)
                u58.Transparency = 1
            end)
        end
        if v61 then
            v61.Transparency = v50
            u2:Create(v61, TweenInfo.new(v46, Enum.EasingStyle[u44.Settings.TransparencyEasingStyle], Enum.EasingDirection[u44.Settings.TransparencyEasingDirection]), {
                ["Transparency"] = v49,
                ["Color3"] = u44.Model.End:FindFirstChildOfClass("Decal").Color3
            }):Play()
            return
        end
    else
        u58.Transparency = v50
        TweenInfo.new(v46, Enum.EasingStyle[u44.Settings.TransparencyEasingStyle], Enum.EasingDirection[u44.Settings.TransparencyEasingDirection])
        if u44.Settings.Movement then
            u44.EndProperities.CFrame = u58.CFrame * v59
        end
        u44.EndProperities.Transparency = v49
        local v64 = u2:Create(u58, v57, u44.EndProperities)
        v64:Play()
        v64.Completed:Once(function() --[[ Line: 177 ]]
            --[[
            Upvalues:
                [1] = u58
                [2] = u44
            --]]
            u58.Size = u44.Properities.Size or Vector3.new(1, 1, 1)
            u58.Transparency = 1
        end)
    end
end
function u1.EmitRate(u65, u66, p67, u68) --[[ Line: 184 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local u69 = 0
    local u71 = u3.Heartbeat:Connect(function(p70) --[[ Line: 186 ]]
        --[[
        Upvalues:
            [1] = u69
            [2] = u66
            [3] = u65
            [4] = u68
        --]]
        u69 = u69 + p70
        if u69 > u66 / 60 then
            u69 = 0
            u65:Emit(u68)
        end
    end)
    task.delay(p67, function() --[[ Line: 193 ]]
        --[[
        Upvalues:
            [1] = u71
        --]]
        u71:Disconnect()
    end)
end
function u1.EmitAt(p72, p73) --[[ Line: 200 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1.new(p73):Emit(computeSpawnCFrame(p72, p73))
end
function u1.EnableAt(p74, p75, p76, p77) --[[ Line: 205 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1.new(p76):EmitRate(p74, p75, computeSpawnCFrame(p77, p76))
end
return u1