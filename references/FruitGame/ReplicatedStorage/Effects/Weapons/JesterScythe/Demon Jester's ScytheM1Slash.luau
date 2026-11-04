 

local u1 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local u2 = {
    "rbxassetid://7631047144",
    "rbxassetid://7630565717",
    "rbxassetid://7630565282",
    "rbxassetid://7630564894",
    "rbxassetid://7630564228",
    "rbxassetid://7630557972",
    "rbxassetid://7630557430",
    "rbxassetid://7630556948",
    "rbxassetid://7630556431",
    "rbxassetid://7630541633",
    "rbxassetid://7630541008",
    "rbxassetid://7630540358",
    "rbxassetid://7630526842",
    "rbxassetid://7630526405",
    "rbxassetid://7630525946",
    "rbxassetid://7630525539",
    "rbxassetid://7630525008",
    "rbxassetid://7630524480",
    "rbxassetid://7630523910"
}
local v3 = game:GetService("ContentProvider")
local v4 = {}
for v5 = 1, #u2 do
    local v6 = Instance.new("Decal")
    v6.Texture = u2[v5]
    v6.Parent = script.Folder
end
v3:PreloadAsync((script.Folder:GetChildren()))
script.Folder.Parent = workspace.Effects
local u7 = require(game.ReplicatedStorage.Modules.sBeat)
function v4.start(_, p8, p9, p10) --[[ Line: 35 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u7
    --]]
    if _G.checkRenderDistance(p9.Position) then
        local u11 = script.Slash:Clone()
        u1.apply(u11, p9.Parent)
        if p10 then
            local v12 = u11:GetChildren()
            for v13 = 1, #v12 do
                if v12[v13]:IsA("Decal") then
                    v12[v13].Color3 = Color3.fromRGB(0, 0, 0)
                end
            end
        end
        u11.Parent = workspace.Effects
        if p8 == "1" then
            u11.CFrame = p9.CFrame * CFrame.new(0, 0.5, 0) * CFrame.Angles(0, 0, -0.6108652381980153) * CFrame.new(0, 0.5, 0) * CFrame.Angles(0, 0, -3.141592653589793)
            _G.tween(u11, {
                0.4,
                "Quint",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u11.CFrame * CFrame.Angles(0, -1.0471975511965976, 0)
            })
        end
        if p8 == "2" then
            u11.CFrame = p9.CFrame * CFrame.new(0, 0.5, 0) * CFrame.Angles(0, 1.0471975511965976, 0)
            _G.tween(u11, {
                0.4,
                "Quart",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u11.CFrame * CFrame.Angles(0, -2.6179938779914944, 0)
            })
        end
        if p8 == "3" then
            u11.CFrame = p9.CFrame * CFrame.new(0, 0.5, -1) * CFrame.Angles(0, 0, 0.3490658503988659) * CFrame.Angles(-0.08726646259971647, 0.8726646259971648, 0) * CFrame.Angles(0, 2.792526803190927, -3.141592653589793)
            _G.tween(u11, {
                0.3,
                "Quart",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u11.CFrame * CFrame.Angles(0, -2.6179938779914944, 0)
            })
        end
        if p8 == "4" then
            u11.CFrame = p9.CFrame * CFrame.new(0, 0.5, 0) * CFrame.Angles(0, 0, 3.141592653589793) * CFrame.Angles(0.04363323129985824, 0.8726646259971648, 0)
            _G.tween(u11, {
                0.4,
                "Quart",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u11.CFrame * CFrame.Angles(0, -1.4835298641951802, 0)
            })
        end
        if p8 == "5" then
            u11.CFrame = p9.CFrame * CFrame.new(0, 0.5, 0) * CFrame.Angles(0, 0, 3.4033920413889427) * CFrame.Angles(0.04363323129985824, 0.6981317007977318, 0)
            _G.tween(u11, {
                0.4,
                "Quart",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u11.CFrame * CFrame.Angles(0, -0.8726646259971648, 0)
            })
        end
        if p8 == "Air-4" then
            u11.CFrame = p9.CFrame * CFrame.new(0, 0.5, 0) * CFrame.Angles(0, 0, -0.5235987755982988) * CFrame.new(0, 1, 0) * CFrame.Angles(0, -3.141592653589793, 0)
            _G.tween(u11, {
                0,
                "Quint",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u11.CFrame * CFrame.Angles(0, 2.443460952792061, 0)
            })
        end
        if p8 == "Air-5" then
            u11.CFrame = p9.CFrame * CFrame.new(0, 0.5, 0) * CFrame.Angles(0, 0, 1.5707963267948966) * CFrame.Angles(0, -3.839724354387525, -3.141592653589793)
            _G.tween(u11, {
                0,
                "Quint",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u11.CFrame * CFrame.Angles(0, 2.443460952792061, 0)
            })
        end
        task.spawn(function() --[[ Line: 83 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u11
                [3] = u7
            --]]
            for v14 = 1, #u2 do
                u11.Decal.Texture = u2[v14]
                u7()
            end
            u11:Destroy()
        end)
        return u11
    end
end
return v4