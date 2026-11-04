 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.sBeat)
local u6 = {
    ["Mes"] = function() --[[ Line: 5 ]]
        task.spawn(function() --[[ Line: 6 ]]
            task.wait(0.4)
            local v3 = script.Mes.ColorCorrection:Clone()
            v3.Parent = workspace.CurrentCamera
            v3.TintColor = Color3.fromRGB(255, 255, 255)
            v3.Saturation = 0
            _G.tween(v3, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["TintColor"] = script.Mes.ColorCorrection.TintColor,
                ["Saturation"] = script.Mes.ColorCorrection.Saturation
            })
            _G.destroy(v3, 0.5)
        end)
    end,
    ["Rokuogan"] = function() --[[ Line: 18 ]]
        task.spawn(function() --[[ Line: 19 ]]
            task.wait(0.85)
            local v4 = script.Rokuogan.ColorCorrection:Clone()
            v4.Parent = workspace.CurrentCamera
            v4.TintColor = Color3.fromRGB(255, 255, 255)
            v4.Saturation = 0
            local v5 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true, 0)
            game:GetService("TweenService"):Create(v4, v5, {
                ["Saturation"] = -1
            }):Play()
            _G.destroy(v4, 0.5)
        end)
    end
}
function v1.start(_, u7, u8, p9) --[[ Line: 37 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u6
    --]]
    local u10 = game.Players.LocalPlayer
    local u11 = p9 or u10.Character
    task.spawn(function() --[[ Line: 43 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u10
            [3] = u11
            [4] = u8
            [5] = u2
            [6] = u6
        --]]
        if script:FindFirstChild(u7) then
            workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
            local v12 = u10.PlayerGui:GetChildren()
            local v13 = {}
            for v14 = 1, #v12 do
                if v12[v14]:IsA("ScreenGui") and v12[v14].Enabled == true then
                    v12[v14].Enabled = false
                    local v15 = v12[v14]
                    table.insert(v13, v15)
                end
            end
            u11.Humanoid.AutoRotate = false
            local v16 = u8
            local v17 = script:FindFirstChild(u7):GetChildren()
            local _ = v17[1]
            local v18 = tick()
            local v19 = 0
            while true do
                local v20 = (tick() - v18) * 60 + 0.5
                v19 = v19 + math.floor(v20)
                if not v17[v19] then
                    break
                end
                workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(u11.HumanoidRootPart.CFrame:ToWorldSpace(v17[v19].Value) * CFrame.new(0, 0, v16), 60 / _G.FPS)
                if #v17 - 1 <= v19 then
                    break
                end
                v18 = tick()
                u2()
            end
            if u6[u7] then
                u6[u7]()
            end
            u11.Humanoid.AutoRotate = true
            workspace.CurrentCamera.CameraType = game.Players.LocalPlayer and Enum.CameraType.Custom or Enum.CameraType.Fixed
            for v21 = 1, #v13 do
                if v13[v21] then
                    v13[v21].Enabled = true
                end
            end
        end
    end)
end
return v1