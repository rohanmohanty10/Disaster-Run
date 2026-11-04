  

local v1 = {};
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
game:GetService("TweenService");
require(game:GetService("ReplicatedStorage").Shared.Essentials);

function v1.SetupCosmetic(u2, p3) -- Line: 8
    -- upvalues: ReplicatedStorage (copy), CollectionService (copy), RunService (copy)
    local u4 = nil;
    game.Players:GetPlayerFromCharacter(u2);
    local u5 = ReplicatedStorage.Assets.Misc.PredatorSharkModel3:Clone();
    u5.Parent = u2;
    local v6 = u5.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.Emotes["Hammerhead Ride Shark"]);
    local v7 = ReplicatedStorage.Assets.Misc.PredatorSharkPetWelds:Clone();
    local Snake2Weld = v7.Snake2Weld;
    Snake2Weld.Parent = u2.HumanoidRootPart;
    Snake2Weld.Part0 = u2.HumanoidRootPart;
    Snake2Weld.Part1 = u5.RootPart;
    v7:Destroy();
    v6:Play();
    CollectionService:AddTag(u5, (`Cosmetic{p3}`));
    u4 = RunService.RenderStepped:Connect(function(p8) -- Line: 35
        -- upvalues: u2 (copy), u4 (ref), u5 (copy), Snake2Weld (copy)
        if u2 and u2.Parent then
            return;
        end;

        u4:Disconnect();
        u5:Destroy();
        Snake2Weld:Destroy();
    end);
end;

return v1;