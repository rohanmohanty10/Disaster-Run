  

local v1 = {};
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
game:GetService("TweenService");
require(game:GetService("ReplicatedStorage").Shared.Essentials);

function v1.SetupCosmetic(u2, p3) -- Line: 7
    -- upvalues: CollectionService (copy), RunService (copy)
    local u4 = nil;
    game.Players:GetPlayerFromCharacter(u2);
    local u5 = script.Model:Clone();
    u5.Parent = u2;
    CollectionService:AddTag(u5, (`Cosmetic{p3}`));
    u5.MainPart.RootPartWeld.Part1 = u2.HumanoidRootPart;
    u4 = RunService.RenderStepped:Connect(function(p6) -- Line: 20
        -- upvalues: u2 (copy), u4 (ref), u5 (copy)
        if u2 and u2.Parent then
            return;
        end;

        u4:Disconnect();
        u5:Destroy();
    end);
end;

return v1;