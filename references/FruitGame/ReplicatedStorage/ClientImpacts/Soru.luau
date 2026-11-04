 

local v1 = {}
_G.getEffect("Shockwave2")
_G.getEffect("Beam")
game:GetService("PhysicsService")
local u2 = {}
function v1.start(_, p3) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local u4 = p3.char
    local v5 = p3.ti
    local u6 = p3.noSound
    local u7 = v5 == nil and 0.5 or v5
    if u4 == nil then
        return
    elseif u4.PrimaryPart == nil then
        return
    elseif _G.checkRenderDistance(u4.HumanoidRootPart.CFrame.p) ~= false then
        local _ = u4.UpperTorso.Position
        task.spawn(function() --[[ Line: 35 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u7
                [3] = u2
                [4] = u6
            --]]
            local _ = {}
            local v8 = script.sorun:Clone()
            v8.CFrame = CFrame.new(u4.UpperTorso.Position)
            v8.Parent = workspace.Effects
            _G.customEmit(v8)
            local v9 = u4.HumanoidRootPart
            local u10 = Instance.new("Attachment", v9)
            local v11 = v9.Size.X / 2
            u10.Position = Vector3.new(v11, 0, 0)
            _G.tween(u10, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Position"] = Vector3.new(0, 0, 0)
            })
            local u12 = Instance.new("Attachment", v9)
            local v13 = -v9.Size.X / 2
            u12.Position = Vector3.new(v13, 0, 0)
            _G.tween(u12, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Position"] = Vector3.new(0, 0, 0)
            })
            local u14 = script.GepoTrail:Clone()
            u14.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0))
            u14.Attachment0 = u10
            u14.Attachment1 = u12
            u14.Transparency = NumberSequence.new(0.8, 1)
            u14.WidthScale = NumberSequence.new(1)
            u14.Parent = workspace.Effects
            if u6 == nil then
                local v15 = script["SoruNew" .. math.random(1, 2)]:Clone()
                v15.Parent = u4.Head
                v15:Play()
                _G.destroy(v15, 2)
            end
            if game.Players.LocalPlayer.PlayerGui:FindFirstChild("HealthBars") and game.Players.LocalPlayer.PlayerGui.HealthBars:FindFirstChild(u4.Name) then
                game.Players.LocalPlayer.PlayerGui.HealthBars:FindFirstChild(u4.Name).Enabled = false
            end
            task.spawn(function() --[[ Line: 120 ]]
                --[[
                Upvalues:
                    [1] = u7
                    [2] = u14
                    [3] = u10
                    [4] = u12
                --]]
                task.wait(u7)
                u14.Enabled = false
                if u10 then
                    _G.destroy(u10, u14.Lifetime)
                    _G.destroy(u12, u14.Lifetime)
                end
                _G.destroy(u14, u14.Lifetime)
            end)
            _G.destroy(v8, 3)
            _G.transparentCharacter(u4)
            if u7 ~= 0 then
                task.wait(u7)
                _G.transparentCharacter(u4, true)
                local v16 = script.sorun:Clone()
                v16.CFrame = CFrame.new(u4.UpperTorso.Position)
                v16.Parent = workspace.Effects
                _G.customEmit(v16)
                _G.destroy(v16, 3)
            end
            if game.Players.LocalPlayer.PlayerGui.HealthBars:FindFirstChild(u4.Name) then
                game.Players.LocalPlayer.PlayerGui.HealthBars:FindFirstChild(u4.Name).Enabled = true
            end
        end)
    end
end
return v1