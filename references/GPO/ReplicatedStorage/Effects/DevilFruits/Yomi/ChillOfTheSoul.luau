 

local v1 = {}
local u2 = game:GetService("TweenService")
game:GetService("RunService")
function v1.start(_, u3) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(u3.PrimaryPart.Position) ~= false then
        local v4 = script:WaitForChild("FreezeHolder"):Clone()
        v4.CFrame = u3:GetPrimaryPartCFrame() * CFrame.new(0, -1.5, -2)
        v4.Parent = workspace.Effects
        _G.customEmit(v4)
        _G.destroy(v4, 2)
        local u5 = Random.new()
        task.spawn(function() --[[ Line: 17 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u3
                [3] = u2
            --]]
            for _ = 1, 2 do
                local v6 = u5:NextNumber(-3.141592653589793, 3.141592653589793) / 6
                local v7 = u5:NextNumber(-3.141592653589793, 3.141592653589793)
                local v8 = u5:NextNumber(-3.141592653589793, 3.141592653589793) / 6
                local v9 = script:WaitForChild("Wind"):Clone()
                v9.CFrame = u3:GetPrimaryPartCFrame() * CFrame.Angles(0, Random.new():NextNumber(-3.141592653589793, 3.141592653589793), 0)
                v9.Parent = workspace.Effects
                v9.Decal.Color3 = Color3.fromRGB(255, 1000, 500)
                v9.Decal.Texture = "rbxassetid://9572542664"
                _G.tween(v9.Decal, { 0.35, "Linear", Enum.EasingDirection.Out }, {
                    ["Transparency"] = 1
                })
                u2:Create(v9.Decal, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    ["Color3"] = Color3.fromRGB(255, 500, 1000)
                }):Play()
                _G.tween(v9, { 0.8, "EntranceExpressive", Enum.EasingDirection.Out }, {
                    ["CFrame"] = u3:GetPrimaryPartCFrame() * CFrame.Angles(v6, v7, v8) * CFrame.new(0, -5, 0)
                })
                _G.tween(v9.Mesh, { 0.75, "EntranceExpressive", Enum.EasingDirection.Out }, {
                    ["Scale"] = Vector3.new(12, 25, 12)
                })
                _G.destroy(v9, 1)
            end
        end)
        for _ = 1, 2 do
            local v10 = script:WaitForChild("Wind"):Clone()
            v10.CFrame = u3:GetPrimaryPartCFrame() * CFrame.Angles(0, u5:NextNumber(-3.141592653589793, 3.141592653589793), 0)
            v10.Parent = workspace.Effects
            v10.Decal.Transparency = 0.75
            _G.tween(v10.Decal, { 0.75, "Cubic", Enum.EasingDirection.Out }, {
                ["Transparency"] = 1
            })
            _G.tween(v10, { 0.75, "EntranceExpressive", Enum.EasingDirection.Out }, {
                ["CFrame"] = u3:GetPrimaryPartCFrame() * CFrame.Angles(0, u5:NextNumber(-3.141592653589793, 3.141592653589793), 0) * CFrame.new(0, -5, 0)
            })
            _G.tween(v10.Mesh, { 0.5, "EntranceExpressive", Enum.EasingDirection.Out }, {
                ["Scale"] = Vector3.new(15, 25, 15)
            })
            _G.destroy(v10, 1)
        end
    end
end
return v1