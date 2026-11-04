 

local v1 = {}
local u2 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules").swoopz)
function v1.start(_, p3, p4) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p3.Position) ~= false then
        local v5 = script.SwooshB:Clone()
        v5.Mesh.Scale = Vector3.new(p4, 2.7, p4)
        v5.Decal.Transparency = 1
        v5.CFrame = p3
        v5.Parent = workspace.Effects
        local v6
        if p4 == 4 then
            v5.Decal.Color3 = Color3.new(2500, 0, 0)
            v6 = "slice_slow"
        else
            v6 = "slice_quick"
        end
        u2.Do(v6, v5)
        _G.tween(v5.Decal, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 0
        })
        _G.destroy(v5, 1)
    end
end
return v1