 

local v1 = {}
local u2 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules").swoopz)
function v1.start(_, p3, p4, p5, p6) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p3.Position) ~= false then
        local v7 = p6:FindFirstChild("BusoMelee") and "Buso" or ""
        local v8 = script["Model" .. v7]:Clone()
        v8:PivotTo(p3)
        require(script.Parent.BusoColor):applyColors(p6, v8)
        v8.Parent = workspace.Effects
        local v9 = v8:GetChildren()
        for v10 = 1, #v9 do
            if v9[v10]:FindFirstChild("Decal") then
                if v9[v10].Name:match("Swoosh") == nil then
                    u2.Do("slice_slow", v9[v10])
                else
                    u2.Do("slice_quick", v9[v10])
                end
            end
        end
        _G.destroy(v8, 2)
        _G.PlayEffect("Spheres", nil, {
            ["xrange"] = 0,
            ["yrange"] = 28,
            ["zrange"] = 0,
            ["cf"] = p5 * CFrame.new(0, -15, -3),
            ["ti"] = 0.2,
            ["ti2"] = 0.2,
            ["range"] = 0,
            ["minThick"] = 0.1,
            ["maxThick"] = 2,
            ["part"] = nil,
            ["color"] = Color3.fromRGB(255, 89, 89),
            ["am"] = 10
        })
        local v11 = script.Part:Clone()
        v11.Parent = workspace.Effects
        v11.CFrame = p4
        if v7 == "Buso" then
            v11.new3.LightEmission = 0
            v11.new3.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0), require(script.Parent.BusoColor):getColor(p6))
        end
        _G.tween(v11, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = p5
        })
        _G.destroy(v11, 0.5)
        task.wait(0.25)
        v11.new3.Enabled = false
    end
end
return v1