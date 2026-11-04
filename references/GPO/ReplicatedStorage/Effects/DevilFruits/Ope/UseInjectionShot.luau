 

local v1 = {}
require(game.ReplicatedStorage.Modules.LightningBolt)
function v1.start(_, p2, _) --[[ Line: 5 ]]
    if not _G.checkRenderDistance(p2.PrimaryPart.Position) then
        return
    end
    local _ = script
    local _ = p2.HumanoidRootPart
    local v3 = game.Workspace.Effects:WaitForChild("aimShotOpePart" .. p2.Name, 3)
    local v4 = game.Workspace.Effects:WaitForChild("swordShotOpePart" .. p2.Name, 3)
    if v3 == nil then
        return
    end
    v3.Name = "done"
    v4.Name = "done"
    v4:Destroy()
    for _, u5 in pairs(v3:GetChildren()) do
        if u5.Name == "burstAttach" then
            ::l8::
            if u5.Name == "waveAttach1" or u5.Name == "waveAttach2" then
                local v6 = game:GetService("TweenService")
                local v7 = TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                local v8 = {}
                local v9 = u5.Position.Z
                v8.Position = Vector3.new(0, 10, v9)
                v6:Create(u5, v7, v8, true):Play()
            elseif u5.Name == "waveBeam1" or u5.Name == "waveBeam2" then
                u5.Enabled = true
                game:GetService("TweenService"):Create(u5, TweenInfo.new(0, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    ["CurveSize0"] = u5.CurveSize0 * 5,
                    ["CurveSize1"] = u5.CurveSize1 * 5,
                    ["Width0"] = 1,
                    ["Width1"] = 1
                }, true):Play()
                task.delay(0.05, function() --[[ Line: 35 ]]
                    --[[
                    Upvalues:
                        [1] = u5
                    --]]
                    game:GetService("TweenService"):Create(u5, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        ["Width0"] = 0,
                        ["Width1"] = 0
                    }, true):Play()
                end)
            elseif u5.Name == "frontAttach1" or u5.Name == "frontAttach2" then
                game:GetService("TweenService"):Create(u5, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    ["Position"] = Vector3.new(0, 30, 0)
                }, true):Play()
            elseif u5.Name == "stabBeam1" or u5.Name == "stabBeam2" then
                game:GetService("TweenService"):Create(u5, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    ["Width0"] = 0
                }, true):Play()
            elseif u5.Name ~= "burstAttach" and (u5.Name ~= "stabAttach1" and u5.Name ~= "stabAttach2") then
                u5:Destroy()
            end
        elseif u5.Name ~= "lineBurst" then
            if u5.Name ~= "forwardLightningLine" then
                goto l8
            end
        end
    end
    _G.customEmit(v3.burstAttach, true)
    v3.Anchored = true
    local _ = Random.new():NextInteger(1, 2) == 1
end
return v1