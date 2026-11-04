 

local v1 = game:GetService("ReplicatedStorage")
local v2 = {}
require(v1.Modules.Part_Icles)
function v2.start(_, p3) --[[ Line: 8 ]]
    _G.PlaySound(p3.PrimaryPart, script.attacg).Parent = p3.PrimaryPart
    local v4 = script.newReturn.Attachment:Clone()
    v4.Parent = p3.UpperTorso
    _G.customEmit(v4)
    _G.destroy(v4, 5)
    local v5 = script.newReturn:Clone()
    v5.Attachment:Destroy()
    v5.CFrame = CFrame.new(p3.UpperTorso.Position)
    v5.Parent = workspace.Effects
    _G.customEmit(v5)
    _G.destroy(v5, 5)
end
return v2