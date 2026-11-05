  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.GenericModule);
local CollectionService = game:GetService("CollectionService");
local _ = PathShortcuts.ClientAssets;
local Trove = require(Knit.Util.Trove);

return function(u1) -- Line: 10
    -- upvalues: Trove (copy), CollectionService (copy)
    local v2 = Trove.new();
    local Stand = u1.Stand;
    v2:Connect(game:GetService("RunService").Heartbeat, function(p3) -- Line: 14
        -- upvalues: CollectionService (ref), u1 (copy), Stand (copy)
        if not CollectionService:HasTag(u1, "Summoned") then
            return;
        end;

        for _, child in pairs(Stand:GetChildren()) do
            if child:IsA("BasePart") and child.Name ~= "HumanoidRootPart" then
                local v4 = tick() * 2.7;
                child.Transparency = math.cos(v4) * 0.25 + 0.4;
            end;
        end;
    end);
    v2:AttachToInstance(u1);
end;