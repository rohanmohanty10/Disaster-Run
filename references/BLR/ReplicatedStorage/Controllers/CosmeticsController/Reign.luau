  

local v1 = {};
game:GetService("RunService");
game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
game:GetService("TweenService");
require(game:GetService("ReplicatedStorage").Shared.Essentials);

function v1.SetupCosmetic(p2, p3) -- Line: 8
    -- upvalues: CollectionService (copy)
    game.Players:GetPlayerFromCharacter(p2);
    local v4 = {};

    for _, child in script.ReignRig:GetChildren() do
        if p2:FindFirstChild(child.Name) and child:IsA("BasePart") then
            local v5 = child;

            for _, child2 in child:GetChildren() do
                if child2:IsA("Attachment") or child2:IsA("ParticleEmitter") then
                    local v6 = child2:Clone();
                    v6.Parent = p2[v5.Name];

                    if v6:IsA("Attachment") then
                        local v7 = v6:FindFirstChildOfClass("Beam");
                        table.insert(v4, v7);
                    end;

                    CollectionService:AddTag(v6, (`Cosmetic{p3}`));
                end;
            end;
        end;
    end;

    for _, v in v4 do
        local _ = v.Attachment0;
        local _ = v.Attachment1;
        v.Attachment0 = v.Parent;
        v.Attachment1 = v.Parent.Parent:FindFirstChild(v.Attachment1.Name);
    end;
end;

return v1;