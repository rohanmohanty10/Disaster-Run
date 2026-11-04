 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = require(script.Parent.SlashMesh)
local u4 = _G.customEmit
function PlayAnim(p5, p6)
    local v7 = (p5:FindFirstChild("Humanoid") or p5:FindFirstChild("AnimationController")).Animator:LoadAnimation(script[p6])
    v7:Play(0.45, 1, 1)
    return v7
end
function v1.start(_, u8) --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
        [3] = u3
    --]]
    Random.new()
    local u9 = u8:GetPivot() * CFrame.new(0, -0.2, 0)
    local u10 = script.SusanooModel:Clone()
    u10:PivotTo(u9 * CFrame.new(0, 30.844, 32))
    u10.Parent = workspace.Effects
    for _, v11 in u10:GetChildren() do
        if v11:IsA("MeshPart") then
            v11.Transparency = 1
            u2:Create(v11, TweenInfo.new(0.45), {
                ["Transparency"] = 0
            }):Play()
        end
    end
    _G.PlaySound(u10.PrimaryPart, script["Audio/SusanooGrip"])
    u4(u10["Plane.006"])
    local u12 = PlayAnim(u10, "grip")
    task.delay(1.6, function() --[[ Line: 35 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u8
            [3] = u4
            [4] = u9
            [5] = u2
        --]]
        u3(1, 0.45, u8:GetPivot() * CFrame.new(-4, 18, 15) * CFrame.Angles(-0.7853981633974483, 3.141592653589793, 0), { 0.25 })
        u3(1, 0.55, u8:GetPivot() * CFrame.new(4, 18, 15) * CFrame.Angles(2.6179938779914944, 0, 0), { 0.25 })
        task.wait(0.1)
        local v13 = script.Particles:Clone()
        v13.CFrame = u8:GetPivot() * CFrame.new(0, -3, 0)
        v13.Parent = workspace.Effects
        u4(v13)
        _G.destroy(v13, 3)
        local u14 = script.Slashes:Clone()
        u14:PivotTo(u9)
        u14.Parent = workspace.Effects
        _G.destroy(u14, 4)
        task.delay(1, function() --[[ Line: 57 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u2
            --]]
            for _, u15 in u14:GetDescendants() do
                if u15:IsA("ParticleEmitter") then
                    task.delay(0.5, function() --[[ Line: 60 ]]
                        --[[
                        Upvalues:
                            [1] = u15
                        --]]
                        u15.Enabled = false
                    end)
                elseif u15:IsA("Decal") then
                    task.delay(u15.Parent.Name == "Slash" and 0 or 1.25, function() --[[ Line: 68 ]]
                        --[[
                        Upvalues:
                            [1] = u2
                            [2] = u15
                        --]]
                        u2:Create(u15, TweenInfo.new(0.5), {
                            ["Transparency"] = 1
                        }):Play()
                    end)
                end
            end
        end)
    end)
    task.delay(3.1, function() --[[ Line: 77 ]]
        --[[
        Upvalues:
            [1] = u12
            [2] = u4
            [3] = u10
            [4] = u2
        --]]
        u12:AdjustSpeed(0.5)
        u12.TimePosition = 3.2
        u4(u10["Plane.006"])
        u4(u10.RootPart)
        for _, v16 in u10:GetChildren() do
            if v16:IsA("MeshPart") then
                u2:Create(v16, TweenInfo.new(0.45), {
                    ["Transparency"] = 1
                }):Play()
            end
        end
        _G.destroy(u10, 2)
    end)
end
return v1