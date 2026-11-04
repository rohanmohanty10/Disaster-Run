 

local v1 = {}
game:GetService("TweenService")
function v1.start(_, p2, _) --[[ Line: 4 ]]
    if _G.checkRenderDistance(p2.PrimaryPart.Position) ~= false then
        local _, v3 = p2:GetBoundingBox()
        local v4 = script.BirdGust:Clone()
        local v5 = v4.Bite
        v5.CFrame = p2.LowerTorso.CFrame * CFrame.new(0, 0, -v3.Z / 2)
        v4.Parent = workspace.Effects
        _G.customEmit(v5.VFX)
        _G.destroy(v4, 2.5)
    end
end
return v1