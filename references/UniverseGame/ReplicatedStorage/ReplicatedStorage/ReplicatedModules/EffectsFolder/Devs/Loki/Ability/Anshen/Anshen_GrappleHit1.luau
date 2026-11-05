  

 

local PathShortcuts = require(game:GetService("ReplicatedStorage").ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = game.ReplicatedStorage["Client Assets"];

return function(p2, p3, p4) -- Line: 7
    -- upvalues: ParticleHandler (copy), u1 (copy)
    local v5 = p3:IsA("Part") and p3 and p3 or p3:FindFirstChild("Torso");
    local v6 = ParticleHandler.GetUnusualHSVData({
        Character = p2
    });

    if not v5 then
        return;
    end;

    local u7 = u1.Anshen.AnshenPierce:FindFirstChild((tostring(p4 == nil and 1 or p4))):Clone();

    if v6 ~= nil then
        ParticleHandler.Unusualify(u7, {
            HSVData = v6
        });
    end;

    u7.Position = v5.Position;
    u7.Parent = workspace.Terrain;

    for _, child in pairs(u7:GetChildren()) do
        if child:IsA("ParticleEmitter") and child:GetAttribute("EmitCount") then
            child:Emit(child:GetAttribute("EmitCount"));
        end;
    end;

    task.delay(2, function() -- Line: 27
        -- upvalues: u7 (copy)
        u7:Destroy();
    end);
end;