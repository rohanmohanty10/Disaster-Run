 

game:GetService("RunService")
local u1 = game:GetService("TweenService")
game:GetService("UserInputService")
local v2 = game:GetService("ReplicatedStorage")
require(v2.Modules.LightningBolt)
local v3 = {
    ["Radius"] = 45,
    ["TornadoSpeed"] = 200,
    ["RotSpeed"] = 300
}
local u4 = Random.new()
local v5 = RaycastParams.new()
local v6 = { workspace.Islands, workspace.Env, workspace.Ships }
local v7 = Enum.RaycastFilterType.Include
v5.FilterDescendantsInstances = v6
v5.FilterType = v7
function v3.start(_, p8, u9, p10, p11) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u1
    --]]
    local function v29(p12, p13) --[[ Line: 20 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u9
            [3] = u1
        --]]
        local u14 = script["DashWind" .. u4:NextInteger(1, 2)]:Clone()
        local v15 = CFrame.Angles
        local v16 = math.random(-360, 360)
        u14.CFrame = p12 * v15(3.141592653589793, math.rad(v16), 0)
        u14.Decal.Color3 = p13 and Color3.fromRGB(255, 86, 34) or u9.DragonHead.Color
        local v17 = u14.Mesh
        v17.Scale = v17.Scale * 2
        u14.Parent = workspace.Effects
        local v18 = u14.Mesh.Scale
        local u19 = u1:Create(u14.Decal, TweenInfo.new(u4:NextNumber(0.25, 0.425)), {
            ["Transparency"] = 1
        })
        local v20 = u1
        local v21 = TweenInfo.new(u4:NextNumber(0.375, 0.475))
        local v22 = {}
        local v23 = u14.CFrame
        local v24 = CFrame.Angles
        local v25 = math.random(0, 360)
        v22.CFrame = v23 * v24(0, -math.rad(v25), 0)
        local u26 = v20:Create(u14, v21, v22)
        local v27 = u14.Mesh
        v27.Scale = v27.Scale * u4:NextNumber(0.25, 0.3)
        local u28 = u1:Create(u14.Mesh, TweenInfo.new(u4:NextNumber(0.425, 0.525), Enum.EasingStyle.Quint), {
            ["Scale"] = v18 * u4:NextNumber(0.8, 1.5)
        })
        u26:Play()
        u19:Play()
        u28:Play()
        u19.Completed:Once(function() --[[ Line: 45 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u28
                [3] = u26
                [4] = u14
            --]]
            u19:Destroy()
            u28:Destroy()
            u26:Destroy()
            _G.destroy(u14, 1.5)
        end)
    end
    repeat
        v29(p8, p10)
        task.wait(0.05)
    until p11:IsDescendantOf(game) == false
end
return v3