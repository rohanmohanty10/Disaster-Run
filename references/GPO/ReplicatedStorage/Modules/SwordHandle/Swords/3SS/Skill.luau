 

local v1 = {}
local u2, _, u3, _, _ = require(game.ReplicatedStorage.Modules.ScriptSet).get()
local u4 = nil
require(game.ReplicatedStorage.Modules.RotatedRegion3)
require(game.ReplicatedStorage.Modules.Skills)
require(game.ReplicatedStorage.Modules.sBeat)
local u5 = require(game.ReplicatedStorage.Modules.SwordHandle.SwordInfo)
local function u9() --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v6 = u2.Backpack:GetChildren()
    local v7 = nil
    for v8 = 1, #v6 do
        if v6[v8]:IsA("Tool") and (v6[v8]:FindFirstChild("SwordEquip") and v6[v8].Name ~= "3SS") then
            return v6[v8].Name
        end
    end
    return v7
end
function v1.setup(_, u10, u11) --[[ Line: 25 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
        [3] = u5
        [4] = u3
        [5] = u9
    --]]
    if u4 then
        u4:Disconnect()
        u4 = nil
    end
    local u12 = game.ReplicatedStorage:FindFirstChild("Stats" .. u2.Name)
    local u13 = require(u2.Backpack:WaitForChild("SkillCallbacks"))
    local v14 = { "1SS", "2SS", "3SS" }
    local u15 = {}
    for v16 = 1, #v14 do
        local v17
        if u5[v14[v16]] then
            v17 = u5[v14[v16]]
        else
            v17 = u5.Katana
        end
        u15[v14[v16]] = u13:GetSkillCallback(v14[v16], u11)
        _G.keysetup:setup(v14[v16], v17.keys)
        _G.keysetup:Destroy()
    end
    local u18 = "3SS"
    u4 = u3.InputBegan:Connect(function(p19, p20) --[[ Line: 51 ]]
        --[[
        Upvalues:
            [1] = u11
            [2] = u10
            [3] = u12
            [4] = u9
            [5] = u18
            [6] = u15
            [7] = u13
        --]]
        if u11.Parent == u10 and (_G.canuse ~= false and p20 ~= true) then
            if u12.Stats.FightingStyle.Value == "3SS" then
                if u9() == nil then
                    local v21 = u10:GetAttribute("currentSwordStyle")
                    if v21 then
                        u18 = v21 .. "SS"
                    end
                    local v22 = u15[u18]
                    if #v22 == 0 then
                        u15[u18] = u13:GetSkillCallback(u18, u11)
                        v22 = u15[u18]
                    end
                    if u18 == "3SS" then
                        if p19.KeyCode == Enum.KeyCode.R then
                            v22:TigerHunt()
                        elseif p19.KeyCode == Enum.KeyCode.E then
                            v22["1080PoundPhoenix"](v22)
                        elseif p19.KeyCode == Enum.KeyCode.Z then
                            v22:Onigiri()
                        elseif p19.KeyCode == Enum.KeyCode.T then
                            v22:DragonTwister()
                        elseif p19.KeyCode == Enum.KeyCode.X then
                            v22:CrossingSixPaths()
                        elseif p19.KeyCode == Enum.KeyCode.C then
                            v22["Billion-FoldWorld"](v22)
                        end
                    elseif u18 == "2SS" then
                        if p19.KeyCode == Enum.KeyCode.E then
                            v22["72CaliberPhoenix"](v22)
                        elseif p19.KeyCode == Enum.KeyCode.R then
                            v22:RagingWhirl()
                        elseif p19.KeyCode == Enum.KeyCode.Z then
                            v22:TowerClimb()
                        elseif p19.KeyCode == Enum.KeyCode.X then
                            v22:NitoryuStrike()
                        elseif p19.KeyCode == Enum.KeyCode.C then
                            v22:RashomonDraw()
                        end
                    elseif p19.KeyCode == Enum.KeyCode.E then
                        v22["36CaliberPhoenix"](v22)
                    elseif p19.KeyCode == Enum.KeyCode.R then
                        v22:RapidSlashes()
                    elseif p19.KeyCode == Enum.KeyCode.Z then
                        v22:RagingSerpent()
                    elseif p19.KeyCode == Enum.KeyCode.X then
                        v22:ShishiSonson()
                    elseif p19.KeyCode == Enum.KeyCode.C then
                        v22:DragonBlaze()
                    end
                    if p19.KeyCode == Enum.KeyCode.V then
                        v22:SwordStyleSwap()
                    end
                end
            else
                return
            end
        else
            return
        end
    end)
    return u15
end
function v1.matchCooldowns(_) --[[ Line: 125 ]] end
return v1