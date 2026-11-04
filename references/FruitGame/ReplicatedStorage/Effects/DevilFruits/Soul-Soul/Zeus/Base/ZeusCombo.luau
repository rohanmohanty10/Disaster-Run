 

game:GetService("TweenService")
game:GetService("Debris")
Random.new()
require(script.Parent.Shared)
local u1 = script.VFX
return {
    ["start"] = function(_, p2, p3, p4) --[[ Name: start, Line 11 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v5 = game.Players.LocalPlayer.Character
        local v6 = p2 == v5
        if v6 == true then
            workspace.CurrentCamera.CameraSubject = v5.UpperTorso
        end
        local v7 = workspace:GetServerTimeNow() - p4
        _G.PlaySound(p2.UpperTorso, script.SoulZeusComboHit).Parent = p2.UpperTorso
        local v8 = u1.SkeletonOutfit:Clone()
        local u9 = Instance.new("Highlight")
        u9.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        u9.FillColor = Color3.new(1, 1, 1)
        u9.OutlineTransparency = 1
        u9.FillTransparency = 0
        u9.Parent = v8
        for _, v10 in v8:GetChildren() do
            if v10:IsA("BasePart") then
                local v11 = p2:FindFirstChild(v10.Name)
                if v11 then
                    local v12 = Instance.new("Weld")
                    v12.Part0 = v11
                    v12.Part1 = v10
                    v12.Parent = v10
                end
            end
        end
        v8.Parent = workspace.Effects
        for v13 = 1, #p3 do
            task.wait(p3[v13] - v7)
            _G.PlaySound(p2.PrimaryPart, script.HitSFX["ZeusComboHit" .. v13])
            if v13 ~= #p3 then
                _G.PlayEffect("Zeus Zap", nil, p2)
            end
            v8.Parent = workspace.Effects
            task.spawn(function() --[[ Line: 46 ]]
                --[[
                Upvalues:
                    [1] = u9
                --]]
                for _ = 1, 2 do
                    u9.Enabled = true
                    u9.FillColor = Color3.new(0, 0, 0)
                    task.wait(0.05)
                    u9.FillColor = Color3.fromRGB(255, 255, 255)
                    u9.Enabled = false
                end
            end)
        end
        _G.destroy(v8, 0.1)
        if v6 == true then
            task.wait(0.15)
            workspace.CurrentCamera.CameraSubject = v5.Humanoid
        end
    end
}