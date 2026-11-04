 

local v1 = {}
local function u7(p2) --[[ Line: 3 ]]
    local v3, v4, v5 = _G.getRayFloor(p2, 8)
    local v6 = script.Teleport1:Clone()
    v6.CFrame = CFrame.new(p2.Position)
    if v3 then
        v6.Attachment.WhiteSmoke.Color = ColorSequence.new(v3.Color)
        v6.Attachment.WorldCFrame = CFrame.new(v4, v4 + v5) * CFrame.Angles(1.5707963267948966, 0, 0)
    else
        v6.Attachment:Destroy()
    end
    v6.Parent = workspace.Effects
    _G.customEmit(v6)
    _G.destroy(v6, 4)
end
function v1.start(_, p8, u9, p10, p11) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    if p10 then
        if _G.checkRenderDistance(p10.Position) == false then
            return
        end
        if u9 == nil then
            return
        end
        u9:SetPrimaryPartCFrame(p10)
    end
    if p11 then
        _G.transparentCharacter(u9)
        task.delay(p11, function() --[[ Line: 33 ]]
            --[[
            Upvalues:
                [1] = u9
            --]]
            _G.transparentCharacter(u9, false)
        end)
    end
    for v12 = 1, #p8 do
        if _G.checkRenderDistance(p8[v12].Position) ~= false then
            u7(p8[v12])
        end
    end
    if #p8 > 1 then
        _G.PlaySound(p8[#p8], script["Audio/Soru" .. math.random(1, 4)])
    end
end
return v1