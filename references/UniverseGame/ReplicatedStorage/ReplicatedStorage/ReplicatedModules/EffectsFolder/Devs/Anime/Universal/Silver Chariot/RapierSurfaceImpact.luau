  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local _ = ReplicatedStorage["Client Assets"];

return function(p1, p2) -- Line: 6
    -- upvalues: AssetHandler (copy)
    local v3 = AssetHandler.CloneAsset("Particles/RapierSurface", {
        AbilityName = "Silver Chariot",
        SkinName = p2
    });
    v3.CFrame = p1;
    v3.Parent = workspace.Effects;
    task.delay(1.75, v3.Destroy, v3);
    local v4 = next;
    local v5, v6 = v3.Attachment:GetChildren();

    for _, v in v4, v5, v6 do
        if v:IsA("ParticleEmitter") then
            v:Emit(v:GetAttribute("EmitCount"));
        end;
    end;

    v3.Bounce:Play();
end;