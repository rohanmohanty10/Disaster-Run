 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.LightningBolt)
function v1.start(_, p3, _) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if p3 == nil then
        return
    elseif _G.checkRenderDistance(p3.PrimaryPart.Position) then
        local v4 = Instance.new("Model")
        v4.Parent = workspace.Effects
        _G.destroy(v4, 4)
        local v5 = Instance.new("Highlight")
        v5.Name = "shamblesHighlight"
        v5.OutlineTransparency = 0.8
        v5.DepthMode = Enum.HighlightDepthMode.Occluded
        v5.FillTransparency = 0.05
        v5.OutlineColor = Color3.fromRGB(0, 0, 0)
        v5.FillColor = Color3.fromRGB(255, 255, 255)
        v5.Parent = v4
        for _ = 1, 25 do
            local _ = p3.PrimaryPart
            local u6 = Instance.new("NumberValue")
            u6.Value = Random.new():NextNumber(0.75, 1.3)
            game:GetService("TweenService"):Create(u6, TweenInfo.new(Random.new():NextNumber(0.15, 0.2), Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ["Value"] = 0
            }, true):Play()
            _G.destroy(u6, 4)
            local v7 = Instance.new("Attachment")
            v7.Parent = p3.RightHand
            local v8 = Instance.new("Attachment")
            v8.Parent = p3.LeftHand
            _G.destroy(v7, 0.3)
            _G.destroy(v8, 0.3)
            local u9 = u2.new(v7, v8, 12)
            u9.MaxRadius = 1
            u9.PulseSpeed = 20
            u9.AnimationSpeed = 20
            u9.Thickness = u6.Value
            u9.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(88, 135, 197)), ColorSequenceKeypoint.new(1, Color3.fromRGB(88, 135, 197)) })
            u9.GivenParent = v4
            local u10 = tick()
            local u11 = nil
            u11 = game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 66 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u6
                    [3] = u9
                    [4] = u11
                --]]
                if tick() - u10 > 0.0125 then
                    if u6.Value > 0.01 then
                        u9.Thickness = u6.Value
                    else
                        u9:Destroy()
                        u11:Disconnect()
                    end
                    u10 = tick()
                end
            end)
            task.wait()
        end
    end
end
return v1