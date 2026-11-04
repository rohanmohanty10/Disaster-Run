 

local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("RunService")
require(v1.Modules.MaidClass)
local u3 = workspace.Effects
local u4 = {}
u4.__index = u4
function u4.new(p5) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
    --]]
    local v6 = u4
    local v7 = setmetatable({}, v6)
    v7.Positions = p5.Positions
    v7.Index = 1
    v7.Duration = p5.Duration
    v7.Start = p5.Start
    v7.Model = script.AfterImageClone:Clone()
    v7.Model:ScaleTo(p5.Scale)
    v7.Model.Parent = u3
    v7.Fade = p5.Fade
    v7.Transparency = p5.Transparency
    local v8 = p5.Character
    for _, v9 in pairs(v7.Model:GetChildren()) do
        v9.Transparency = p5.Transparency
        v9.Material = p5.Material
        v9.Color = p5.Colour
        local v10 = v8:FindFirstChild(v9.Name)
        if v10 then
            v9.Size = v10.Size
        end
    end
    return v7
end
function u4.Update(p11) --[[ Line: 38 ]]
    local v12 = (tick() - p11.Start) / p11.Duration
    local v13 = p11.Transparency + (p11.Fade and ((1 - p11.Transparency) * v12 or 0) or 0)
    for _, v14 in pairs(p11.Model:GetChildren()) do
        v14.CFrame = p11.Positions[p11.Index][v14.Name]
        v14.Transparency = v13
    end
    p11.Index = p11.Index + 1
end
function u4.Destroy(p15) --[[ Line: 48 ]]
    p15.Model:Destroy()
    setmetatable(p15, nil)
end
return {
    ["start"] = function(_, u16) --[[ Name: start, Line 56 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u4
        --]]
        local u17 = u16.Character
        if u17 == nil then
            return
        elseif u17:FindFirstChild("LeftHand") ~= nil and _G.checkRenderDistance(u17.PrimaryPart.Position) ~= false then
            local u18 = u16.Duration
            local u19 = u16.Fade
            local u20 = u16.Colour or Color3.new(1, 1, 1)
            local _ = u16.Transparency or 0.75
            local u21 = u16.Material or Enum.Material.SmoothPlastic
            local u22 = 0
            local u23 = u16.MaxClones
            local u24 = {}
            local u25 = {}
            local u26 = tick()
            local u27 = tick()
            tick()
            local u28 = nil
            u28 = u2.Heartbeat:Connect(function(_) --[[ Line: 81 ]]
                --[[
                Upvalues:
                    [1] = u27
                    [2] = u18
                    [3] = u28
                    [4] = u24
                    [5] = u17
                    [6] = u25
                    [7] = u22
                    [8] = u23
                    [9] = u26
                    [10] = u16
                    [11] = u4
                    [12] = u20
                    [13] = u19
                    [14] = u21
                --]]
                if u18 <= tick() - u27 then
                    u28:Disconnect()
                    for _, v29 in pairs(u24) do
                        v29:Destroy()
                    end
                    return
                else
                    local v30 = {}
                    for _, v31 in pairs(script.AfterImageClone:GetChildren()) do
                        if u17:FindFirstChild(v31.Name) then
                            v30[v31.Name] = u17[v31.Name].CFrame
                        end
                    end
                    local v32 = u25
                    table.insert(v32, v30)
                    for _, v33 in pairs(u24) do
                        v33:Update()
                    end
                    if u23 <= u22 then
                        return
                    elseif tick() - u26 > u16.Interval then
                        u22 = u22 + 1
                        u26 = tick()
                        local v34 = u24
                        local v35 = u4.new
                        local v36 = {
                            ["Colour"] = u20,
                            ["Positions"] = u25,
                            ["Transparency"] = u19 and (1 - u16.Transparency) * (u22 / u23) + u16.Transparency or u16.Transparency,
                            ["Material"] = u21,
                            ["Duration"] = u18,
                            ["Start"] = u27,
                            ["Fade"] = u19,
                            ["Scale"] = u17:GetScale() or 1,
                            ["Character"] = u17
                        }
                        table.insert(v34, v35(v36))
                    end
                end
            end)
        end
    end
}