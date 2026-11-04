 

local v1 = {}
local function u4(p2) --[[ Line: 3 ]]
    local v3 = script.FlashStep:Clone()
    v3.CFrame = CFrame.new(p2.PrimaryPart.Position)
    v3.Parent = workspace.Effects
    _G.destroy(v3, 3)
    _G.customEmit(v3)
end
function v1.start(_, p5, p6, p7) --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    if not p7 or p7 ~= game.Players.LocalPlayer then
        local v8 = p6 == nil and 0.5 or p6
        _G.PlaySound(p5.PrimaryPart, script["RokuFlashstep" .. math.random(1, 4)]).Parent = p5.PrimaryPart
        u4(p5)
        _G.transparentCharacter(p5)
        task.wait(v8)
        u4(p5)
        _G.PlaySound(p5.PrimaryPart, script["RokuFlashstepEnd" .. math.random(1, 4)])
        _G.transparentCharacter(p5, true)
    end
end
return v1