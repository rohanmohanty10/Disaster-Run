  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Trove = require(PathShortcuts.KnitPath.Trove);

return function(p1, p2) -- Line: 8
    -- upvalues: Trove (copy), CollectionService (copy)
    local v3 = workspace.Effects:WaitForChild(p1, 1);

    if not (v3 and (v3:IsDescendantOf(workspace) and p2)) then
        return;
    end;

    local v4 = Trove.new();
    v4:AttachToInstance(v3);
    local u5 = p2:Clone();
    CollectionService:AddTag(u5, (`WOUProjectileClone{p1}`));
    v4:Add(function() -- Line: 18
        -- upvalues: u5 (copy)
        u5.Anchored = true;
        task.wait(2);
        task.wait(0.25);
        u5:Destroy();
    end);
    u5.Anchored = false;
    u5.CanCollide = false;
    local v6 = v4:Construct(Instance, "Weld");
    v6.Part0 = u5;
    v6.Part1 = v3;
    v6.Parent = u5;
    u5.Parent = workspace.Effects;
end;