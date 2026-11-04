 

local v1 = {}
local u2 = {}
function v1.start(_, p3, p4, p5, p6, p7, p8) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    tick()
    local v9 = nil
    if _G.checkRenderDistance(p3.Part0.Position) ~= false then
        if p5 then
            v9 = script.Part:Clone()
            if p6 then
                v9.Size = p6
            end
            if p7 then
                v9.Color = p7
            end
            v9.Parent = workspace.Effects
            _G.tween(v9, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1,
                ["Color"] = p8
            })
        end
        local v10 = u2
        local v11 = {
            v9,
            p3,
            p4,
            CFrame.new(0, 0, v9.Size.X / 6) * CFrame.Angles(0, -1.5707963267948966, 0)
        }
        table.insert(v10, v11)
    end
end
game["Run Service"].RenderStepped:Connect(function() --[[ Line: 37 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    for v12 = #u2, 1, -1 do
        if u2[v12] then
            local v13 = u2[v12]
            local v14, v15, v16, v17 = unpack(v13)
            if v15.Parent == nil then
                if v14 then
                    v14:Destroy()
                end
                table.remove(u2, v12)
            else
                v15.C0 = v15.C0 * v16
                if v14 and v14.Parent ~= nil then
                    v14.CFrame = v15.Part1.CFrame * v17
                else
                    table.remove(u2, v12)
                end
            end
        else
            table.remove(u2, v12)
        end
    end
end)
return v1