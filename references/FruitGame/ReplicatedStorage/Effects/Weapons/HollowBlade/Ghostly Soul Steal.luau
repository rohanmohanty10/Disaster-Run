 

local v1 = {}
game:GetService("TweenService")
local u2 = game:GetService("RunService")
local u3 = Random.new()
local _ = script
local function u13(p4, p5, p6, p7, p8) --[[ Line: 18 ]]
    local v9 = p4 + (p5 - p4) * p8
    local v10 = p5 + (p6 - p5) * p8
    local v11 = p6 + (p7 - p6) * p8
    local v12 = v9 + (v10 - v9) * p8
    return v12 + (v10 + (v11 - v10) * p8 - v12) * p8
end
function v1.start(_, u14) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u13
        [3] = u2
    --]]
    print("used")
    local u15 = 0
    local u16 = {}
    local u17 = u14.Character
    local u18 = u14.Target
    local u19 = u14.Duration
    local u20 = u14.Amount
    local function u35() --[[ Line: 39 ]]
        --[[
        Upvalues:
            [1] = u18
            [2] = u3
            [3] = u17
            [4] = u13
        --]]
        local v21 = {}
        local u22 = script.MiniSlashTrail:Clone()
        u22.Position = u18.UpperTorso.Position
        u22.Parent = workspace.Effects
        local u23 = math.random(2) == 1 and "lerp" or "cubic"
        local u24 = 0
        local u25 = u3:NextNumber(0.15, 0.25)
        v21.Finished = false
        local v26 = u18.UpperTorso.Position
        local v27 = u17.UpperTorso.Position
        local v28 = (v26 - v27).Magnitude
        if u23 == "lerp" then
            v21.Positions = {
                ["P0"] = v26,
                ["P1"] = CFrame.new(v26, v27) * CFrame.new(u3:NextNumber(-15, 15), u3:NextNumber(-15, 15), -v28 * 1 / 3).Position,
                ["P2"] = CFrame.new(v26, v27) * CFrame.new(u3:NextNumber(-15, 15), u3:NextNumber(-15, 15), -v28 * 2 / 3).Position,
                ["P3"] = v27
            }
        else
            v21.Positions = {
                ["start"] = v26,
                ["middle"] = CFrame.new(v26, v27) * CFrame.new(u3:NextNumber(-15, 15), u3:NextNumber(-15, 15), -v28 * 2 * math.random()).Position,
                ["End"] = v27
            }
        end
        function v21.Update(p29, p30) --[[ Line: 74 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u18
                [3] = u24
                [4] = u25
                [5] = u22
                [6] = u23
                [7] = u13
            --]]
            if u17.Parent and u18.Parent then
                local v31 = u24 / u25
                if v31 >= 1 then
                    p29.Finished = true
                    u22.Trail.Enabled = false
                    _G.destroy(u22, 1)
                else
                    if u23 == "lerp" then
                        u22.Position = u13(p29.Positions.P0, p29.Positions.P1, p29.Positions.P2, p29.Positions.P3, v31)
                    else
                        local v32 = p29.Positions.start
                        local v33 = v32 + (p29.Positions.middle - v32) * v31
                        local v34 = p29.Positions.middle
                        u22.Position = v33 + (v34 + (p29.Positions.End - v34) * v31 - v33) * v31
                    end
                    u24 = u24 + p30
                end
            else
                p29.Finished = true
                return
            end
        end
        return v21
    end
    u14.Interval = u14.Interval or 0.1
    local u36 = u14.Interval
    local u37 = nil
    u37 = u2.Heartbeat:Connect(function(p38) --[[ Line: 108 ]]
        --[[
        Upvalues:
            [1] = u15
            [2] = u19
            [3] = u17
            [4] = u16
            [5] = u18
            [6] = u37
            [7] = u36
            [8] = u20
            [9] = u14
            [10] = u35
        --]]
        u15 = u15 + p38
        if (u19 <= u15 or not u17:GetAttribute("SoulStealing")) and (#u16 == 0 and not (u17.Parent and u18.Parent)) then
            u37:Disconnect()
            u37 = nil
            print(u19 <= u15, u17:GetAttribute("SoulStealing"), #u16)
        else
            if u36 <= u15 and (u20 > 0 and u17:GetAttribute("SoulStealing")) then
                u36 = u36 + u14.Interval
                u20 = u20 - 1
                local v39 = u16
                local v40 = u35()
                table.insert(v39, v40)
            end
            for v41 = #u16, 1, -1 do
                if u16[v41].Finished then
                    table.remove(u16, v41)
                else
                    u16[v41]:Update(p38)
                end
            end
        end
    end)
end
return v1