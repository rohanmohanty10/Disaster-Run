 

local v1 = {}
local u2 = game:GetService("RunService")
local u3 = game:GetService("TweenService")
local u4 = {}
local function u5(...) --[[ Line: 16 ]]
    print("[BUSO EFFECT HANDLER]:", ...)
end
local function u9(p6) --[[ Line: 20 ]]
    for _, v7 in pairs(p6) do
        local v8 = v7:FindFirstChild("busoHighlight")
        if v8 then
            v8:Destroy()
        end
    end
end
local function u11(p10) --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u9
        [3] = u5
    --]]
    if u4[p10.Player] then
        u9(u4[p10.Player].Weapon)
        if u4[p10.Player].Connection then
            u4[p10.Player].Connection:Disconnect()
            u4[p10.Player].Connection = nil
            u5("removed - " .. p10.Player.Name, u4[p10.Player])
        end
    else
        return
    end
end
local function u13(u12) --[[ Line: 42 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u11
    --]]
    u4[u12.Player] = {}
    u4[u12.Player].Left = u12.Player:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 44 ]]
        --[[
        Upvalues:
            [1] = u11
            [2] = u12
            [3] = u4
        --]]
        u11(u12)
        u4[u12.Player].Left:Disconnect()
        u4[u12.Player].Left = nil
        u4[u12.Player] = nil
    end)
end
function v1.start(_, u14) --[[ Line: 56 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u13
        [3] = u9
        [4] = u2
        [5] = u3
        [6] = u11
    --]]
    if u14.Type == "On" then
        if not u4[u14.Player] then
            u13(u14)
        end
        if u4[u14.Player].Weapon then
            u9(u4[u14.Player].Weapon)
        end
        u4[u14.Player].Weapon = u14.Parent
        u4[u14.Player].InRange = false
        local u15 = game.ReplicatedStorage["Stats" .. u14.Player.Name].Customization.BusoColor.Value
        if not u4[u14.Player].Connection then
            u4[u14.Player].Connection = u2.Heartbeat:Connect(function() --[[ Line: 74 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u14
                    [3] = u9
                    [4] = u15
                    [5] = u3
                --]]
                if u4[u14.Player] then
                    if u14.Player.Character then
                        if u14.Player.Character.PrimaryPart == nil or u14.Player.Character.PrimaryPart and not _G.checkRenderDistance(u14.Player.Character.PrimaryPart.Position, 100) then
                            if u4[u14.Player].InRange then
                                u4[u14.Player].InRange = false
                                u9(u4[u14.Player].Weapon)
                                return
                            end
                        elseif not u4[u14.Player].InRange then
                            u4[u14.Player].InRange = true
                            for _, v16 in pairs(u4[u14.Player].Weapon) do
                                if not v16:FindFirstChild("busoHighlight") then
                                    local v17 = Instance.new("Highlight")
                                    v17.DepthMode = Enum.HighlightDepthMode.Occluded
                                    v17.FillTransparency = 0
                                    v17.Name = "busoHighlight"
                                    v17.OutlineColor = u15
                                    v17.FillColor = u15
                                    v17.Parent = v16
                                    u3:Create(v17, TweenInfo.new(0.5), {
                                        ["FillTransparency"] = 1
                                    }):Play()
                                end
                            end
                        end
                    end
                else
                    return
                end
            end)
        end
    else
        if u14.Type == "Off" then
            u11(u14)
        end
        return
    end
end
return v1