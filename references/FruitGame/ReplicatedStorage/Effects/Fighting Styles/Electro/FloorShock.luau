 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
function v1.start(_, p3) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local u4 = p3.cf
    local v5 = p3.part
    local v6 = p3.char
    if not u4 or _G.checkRenderDistance(u4.Position) ~= false then
        if v5 then
            local v7 = script.dust:Clone()
            v7.CFrame = u4 * CFrame.Angles(-1.5707963267948966, 0, 0)
            v7.Attachment.sm2.Color = ColorSequence.new(v5.Color)
            v7.Attachment.Rocks.Color = ColorSequence.new(v5.Color)
            v7.Attachment.sm2.Size = NumberSequence.new(5, 25)
            v7.Parent = workspace.Effects
            _G.customEmit(v7)
            _G.destroy(v7, 2)
            local v8 = script.Part:Clone()
            u2.apply(v8, v6)
            v8.CFrame = u4 * CFrame.Angles(-1.5707963267948966, 0, 0)
            v8.Parent = workspace.Effects
            _G.tween(v8.PointLight, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                true,
                0
            }, {
                ["Range"] = 35,
                ["Brightness"] = 25
            })
            _G.destroy(v8, 0.5)
            _G.PlaySound(v6.Head, script.grab2)
            _G.PlaySound(v6.Head, script.gauss_electro2, {
                ["TimePosition"] = 0.2
            })
            local u9 = script:FindFirstChild("LightningColor")
            if u9 then
                u9 = script.LightningColor:GetAttribute("UniqueID")
            end
            if u9 then
                u9 = u2.getColor(v6, u9)
            end
            for _ = 1, 25 do
                task.spawn(function() --[[ Line: 36 ]]
                    --[[
                    Upvalues:
                        [1] = u9
                        [2] = u4
                    --]]
                    local v10 = BrickColor.new("Cyan").Color
                    if math.random(1, 2) == 1 then
                        v10 = BrickColor.new("Medium blue").Color
                    end
                    if u9 then
                        v10 = u9
                    end
                    local v11 = {
                        ["color"] = v10,
                        ["color2"] = u9 or BrickColor.new("Baby blue").Color,
                        ["ti"] = math.random(100, 200) / 1000,
                        ["decay"] = math.random(100, 200) / 1000,
                        ["bends"] = math.random(1, 3),
                        ["fork_bends"] = math.random(1, 10),
                        ["fork_chance"] = 1,
                        ["transparency"] = 0.5,
                        ["thickness"] = math.random(10, 25) / 200,
                        ["max_depth"] = 100
                    }
                    local v12 = (u4 * CFrame.new(math.random(-5, 5), math.random(1, 10), -25)).Position
                    _G.PlayEffect("Lightning", nil, u4.Position, v12, v11)
                end)
                game["Run Service"].Heartbeat:Wait()
            end
        end
    end
end
return v1