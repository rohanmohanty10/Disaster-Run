 

local v1 = {}
function recu(p2, p3)
    local v4 = p2:GetChildren()
    if #v4 ~= 0 then
        v4[1].CFrame = p3
        recu(v4[1], p3)
    end
end
require(game:GetService("ReplicatedStorage").Modules.sBeat)
require(game:GetService("ReplicatedStorage"):WaitForChild("Modules").swoopz)
function v1.start(_, p5, p6, _) --[[ Line: 24 ]]
    if _G.checkRenderDistance(p5.HumanoidRootPart.Position) then
        _G.PlaySound(p6.UpperTorso, script.Woosh)
    end
end
return v1