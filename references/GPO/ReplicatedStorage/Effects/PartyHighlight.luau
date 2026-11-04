 

local v1 = {}
local u2 = {}
function v1.start(_, p3) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v4 = p3.Players
    local v5 = p3.Colour
    local v6 = p3.Type
    local v7 = typeof(v4) ~= "table" and { v4 } or v4
    for _, u8 in pairs(v7) do
        if u8 ~= game.Players.LocalPlayer then
            if v6 == "Add" then
                u2[u8.Name] = {}
                u2[u8.Name].Colour = v5
                u2[u8.Name].AddHighlight = function(p9, p10) --[[ Line: 21 ]]
                    local v11 = Instance.new("Highlight")
                    v11.Name = "PartyHighlight"
                    v11.FillColor = p9.Colour
                    v11.OutlineColor = p9.Colour
                    v11.FillTransparency = 1
                    v11.DepthMode = Enum.HighlightDepthMode.Occluded
                    v11.Parent = p10
                end
                u2[u8.Name].Connection = u8.CharacterAdded:Connect(function(p12) --[[ Line: 31 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u8
                    --]]
                    u2[u8.Name]:AddHighlight(p12)
                end)
                u2[u8.Name]:AddHighlight(u8.Character)
            else
                if u2[u8.Name] then
                    u2[u8.Name].Connection:Disconnect()
                    u2[u8.Name] = nil
                end
                if u8.Character then
                    local v13 = u8.Character:FindFirstChild("PartyHighlight")
                    if v13 then
                        v13:Destroy()
                    end
                end
            end
        end
    end
end
return v1