 

local v1 = {}
local u2 = game:GetService("TweenService")
function v1.start(_, p3, _) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p3.PrimaryPart.Position) ~= false then
        local v4 = {
            14399492802,
            14399492596,
            14399492365,
            14399492055,
            14399491725,
            14399491447,
            14399491149,
            14399490913,
            14399490678,
            14399490439,
            14399490165,
            14399489881,
            14399489682,
            14399489443,
            14399489049
        }
        local v5 = script.AxeSwingRight:Clone()
        local v6 = v5.Slash
        v5.Parent = workspace.Effects
        task.wait(0.316)
        v6.CFrame = p3.RootPart.CFrame * CFrame.new(1.206, 10.25, -9.737) * CFrame.Angles(0.08726646259971647, 4.363323129985824, -0.08726646259971647)
        v6.SlashDecal.Transparency = 0
        u2:Create(v6, TweenInfo.new(0.225, Enum.EasingStyle.Quart), {
            ["CFrame"] = v6.CFrame * CFrame.Angles(0, -3.0543261909900767, 0)
        }):Play()
        for v7 = 1, #v4 do
            v6.SlashDecal.Texture = "rbxassetid://" .. v4[v7]
            task.wait(0.225 / #v4)
        end
        _G.destroy(v5, 1)
    end
end
return v1