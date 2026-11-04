 

local v1 = {}
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage"):WaitForChild("Refrences"):WaitForChild("Phoenix")
local u3 = require(game:GetService("ReplicatedStorage"):WaitForChild("Util").Misc)
local u4 = require(game:GetService("ReplicatedStorage").Util.ShakeCamera)
local u5 = workspace.CurrentCamera
require(u2.Effects.Flare)
function v1.start(_, p6, p7, p8, p9) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u5
        [4] = u4
    --]]
    local v10 = p6 or CFrame.new()
    if _G.checkRenderDistance(v10.Position) ~= false then
        local v11 = math.min(15, p7 or 10)
        local v12 = p8 or 1
        if p9 then
            u3.PlaySound(v10, u2.Sounds["Audio/PhoUltFinalHit"], {
                ["PlaybackSpeed"] = 1 / v12
            })
        else
            u3.PlaySound(v10, u2.Sounds["Audio/PhoUltHit1"], {
                ["PlaybackSpeed"] = 1.25
            })
        end
        local v13 = (u5.CFrame.Position - v10.Position).Magnitude / (v11 * 2.75 + 25)
        if v13 < 1 then
            local v14 = 1 - v13
            u4({
                ["RotationInfluence"] = Vector3.new(0, 0, 1),
                ["Roughness"] = 8 * v14,
                ["Magnitude"] = 6 * v14,
                ["FadeIn"] = v12 * 2,
                ["FadeOut"] = v12 * 0.75
            })
        end
        local v15 = Instance.new("Attachment")
        v15.CFrame = v10
        v15.Parent = workspace.Terrain
        local v16 = script.Part.Attachment:Clone()
        v16.Parent = workspace.Terrain
        v16.CFrame = v10
        local v17 = v16:GetChildren()
        for v18 = 1, #v17 do
            v17[v18]:Emit(1)
        end
        _G.PlayEffect("Spheres", nil, {
            ["cf"] = v10,
            ["ti"] = 0.25,
            ["ti2"] = 0.2,
            ["range"] = 20,
            ["minThick"] = 15,
            ["maxThick"] = 30,
            ["part"] = nil,
            ["color"] = Color3.fromRGB(255, 170, 0),
            ["am"] = 10
        })
        _G.PlayEffect("Spheres", nil, {
            ["cf"] = v10,
            ["ti"] = 0.25,
            ["ti2"] = 0.2,
            ["range"] = 10,
            ["minThick"] = 15,
            ["maxThick"] = 30,
            ["part"] = nil,
            ["color"] = Color3.fromRGB(0, 255, 255),
            ["am"] = 5
        })
        task.wait(v12 + 1)
        v16:Destroy()
        v15:Destroy()
    end
end
return v1