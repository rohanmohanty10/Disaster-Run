 

local u1 = {
    ["islands"] = {
        ["Town of Beginnings"] = 0,
        ["Shell\'s Town"] = 1000,
        ["Island Of Zou"] = 1750,
        ["Orange Town"] = 2000,
        ["Kori Island"] = 4000,
        ["Restaurant Baratie"] = 1250,
        ["Roca Island"] = 2000,
        ["Marine Fort F-1"] = 500,
        ["Colosseum"] = 500,
        ["Sandora"] = 500,
        ["Shark Park"] = 1000,
        ["Sphinx Island"] = 1200,
        ["Land of the Sky"] = 2000,
        ["Gravito\'s Fort"] = 2200,
        ["Traders Lounge"] = 1000,
        ["Fishman Cave"] = 3000,
        ["Valentine Island"] = 2000,
        ["Coco Island"] = 2000,
        ["Marine Base G-1"] = 3000,
        ["Elo\'s Island"] = 3000,
        ["Reverse Mountain"] = 3000,
        ["Desert Kingdom"] = 5000,
        ["Colosseum of Arc"] = 3000,
        ["Transylvania"] = 3000,
        ["Winter Wonderland"] = 3000,
        ["Thriller Bark"] = 5000,
        ["Foro Island"] = 5000,
        ["Dokkan Island"] = 5000,
        ["Rose Kingdom"] = 5000,
        ["Impel Base"] = 5000,
        ["Sett\'s Arena"] = 5000,
        ["Logue Town"] = 2000,
        ["Spooksville"] = 0,
        ["Sakura Stronghold"] = 2000,
        ["Umi Island"] = 2000,
        ["Turtleback Cave"] = 2000,
        ["Blo\'s Island"] = 2000,
        ["Whole Cake Island"] = 2000
    }
}
local function u6(p2) --[[ Line: 45 ]]
    local v3 = workspace.Islands:GetChildren()
    local v4 = nil
    for v5 = 1, #v3 do
        if p2:IsDescendantOf(v3[v5]) then
            return v3[v5]
        end
    end
    return v4
end
local function u9(p7) --[[ Line: 57 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    local v8 = Ray.new(p7.HumanoidRootPart.Position, p7.HumanoidRootPart.CFrame.upVector * -1000)
    return u6((_G.raycastWhitelist(v8, { workspace.Islands })))
end
function u1.check(_, p10) --[[ Line: 64 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u1
    --]]
    local v11 = game.Players.LocalPlayer
    local _ = v11.Character
    local v12 = game.ReplicatedStorage:FindFirstChild("Stats" .. v11.Name)
    local v13 = u9(p10)
    local v14 = u1.islands[v13.Name]
    if v14 ~= nil then
        return v12.Stats.Peli.Value < v14 and _G.HasItem(v11, v13.Name .. " Eternal Pose") == false and {
            {
                ["talkname"] = "nomoney",
                ["talknumber"] = 2,
                ["talkend"] = 2
            }
        } or (_G.HasItem(v11, v13.Name .. " Eternal Pose") == true and {
            {
                ["talkname"] = "haveitem",
                ["talknumber"] = 2,
                ["talkend"] = 2
            }
        } or nil)
    end
end
function u1.adjust(_, p15) --[[ Line: 83 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u1
    --]]
    local v16 = u9(p15)
    return {
        {
            ["talkname"] = "Talk1",
            ["new"] = "I travel form island to island selling <Color=Blue>Eternal Poses<Color=/>.Would you like to buy one for this island for <Color=Yellow>" .. u1.islands[v16.Name] .. " <Color=/>Peli?"
        }
    }
end
return u1