 

local v1 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local v2 = game:GetService("Players")
game:GetService("TweenService")
require(game:GetService("ReplicatedStorage").Modules.CameraShaker)
require(v1.Modules.CraterHandler)
local _ = v2.LocalPlayer
local u3 = workspace.Effects
local function u14(p4, p5, p6) --[[ Line: 17 ]]
    local function v12(u7, p8, p9) --[[ Line: 18 ]]
        for _, v10 in ipairs(u7:GetDescendants()) do
            if v10:IsA("ParticleEmitter") or v10:IsA("Trail") then
                v10.Enabled = p8
            end
        end
        if p9 then
            task.delay(p9, function() --[[ Line: 26 ]]
                --[[
                Upvalues:
                    [1] = u7
                --]]
                for _, v11 in ipairs(u7:GetDescendants()) do
                    if v11:IsA("ParticleEmitter") or v11:IsA("Trail") then
                        v11.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p4) == "table" then
        for _, v13 in p4 do
            v12(v13, p5, p6)
        end
    else
        v12(p4, p5, p6)
    end
end
local v15 = RaycastParams.new()
v15.FilterType = Enum.RaycastFilterType.Include
v15.FilterDescendantsInstances = { workspace.Terrain, workspace.Islands, workspace.Env }
return {
    ["start"] = function(_, p16, p17, p18) --[[ Name: start, Line 61 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u14
        --]]
        if _G.checkRenderDistance(p17.PrimaryPart.Position) ~= false then
            if p16 == "Start" then
                local u19 = script.Wave:Clone()
                u19.CFrame = p17.PrimaryPart.CFrame * CFrame.new(0, 0, -2)
                u19.Parent = u3
                _G.PlaySound(u19, script["Audio/Mero2LoveBeamStart"])
                local u20 = script["Audio/Mero2LoveBeamLoop"]:Clone()
                u20.Parent = u19
                u20:Play()
                u14(u19, true)
                task.delay(p18, function() --[[ Line: 77 ]]
                    --[[
                    Upvalues:
                        [1] = u20
                        [2] = u14
                        [3] = u19
                    --]]
                    _G.tween(u20, {
                        0.5,
                        "Quad",
                        Enum.EasingDirection.In,
                        0,
                        false,
                        0
                    }, {
                        ["Volume"] = 0
                    })
                    u14(u19, false)
                    _G.destroy(u19, 3)
                end)
            end
        end
    end
}