 

local v1 = {}
local u2 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules").swoopz)
function v1.start(_, p3, p4, p5) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v6 = _G.awaitObject(p3)
    local v7 = _G.awaitObject(p4)
    if _G.checkRenderDistance(v6.Position) == false then
        return
    end
    if v7 == nil then
        v7 = v6
    end
    while true do
        local v8 = p5:FindFirstChild("BusoMelee") and "Buso" or ""
        local v9 = math.random(200, 280) / 100
        local v10 = script["SwooshB" .. v8]:Clone()
        local v11 = CFrame.Angles
        local v12 = 90 + math.random(-90, 90)
        local v13 = math.rad(v12)
        local v14 = math.random(-25, 25)
        local v15 = v11(v13, math.rad(v14), -1.5707963267948966)
        v10.Mesh.Scale = Vector3.new(v9, 2.7, v9)
        v10.Decal.Transparency = 1
        if v8 == "Buso" and math.random(1, 2) == 1 then
            v10.Decal.Color3 = Color3.fromRGB(0, 0, 0)
        end
        require(script.Parent.BusoColor):applyColors(p5, v10)
        v10.Parent = workspace.Effects
        u2.Do("thswir", v10)
        _G.tween(v10.Decal, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 0
        })
        local v16 = Instance.new("Weld")
        v16.Part0 = v6
        v16.Part1 = v10
        v16.C0 = v15
        v16.Parent = v10
        _G.destroy(v10, 0.5)
        game["Run Service"].Heartbeat:Wait()
        if v7:IsDescendantOf(game) == false then
            return
        end
    end
end
return v1