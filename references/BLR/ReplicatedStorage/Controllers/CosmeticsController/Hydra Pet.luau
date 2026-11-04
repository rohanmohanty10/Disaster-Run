  

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
    local u5 = ReplicatedStorage.Assets.Misc.FirstSnakeModelMini:Clone();
    u5.Parent = u2;
    local u6 = ReplicatedStorage.Assets.Misc.SecondSnakeMini:Clone();
    u6.Parent = u2;
    local u7 = ReplicatedStorage.Assets.Misc.ThirdSnakeMini:Clone();
    u7.Parent = u2;
    local v8 = u5.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.Emotes["Hydra Ride Snake1"]);
    local v9 = u6.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.Emotes["Hydra Ride Snake2"]);
    local v10 = u7.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.Emotes["Hydra Ride Snake3"]);
    local v11 = ReplicatedStorage.Assets.Misc.HydraPetWelds:Clone();
    local Snake1Weld = v11.Snake1Weld;
    local Snake2Weld = v11.Snake2Weld;
    local Snake3Weld = v11.Snake3Weld;
    Snake1Weld.Parent = u2.HumanoidRootPart;
    Snake1Weld.Part0 = u2.HumanoidRootPart;
    Snake1Weld.Part1 = u5.RootPart;
    Snake2Weld.Parent = u2.HumanoidRootPart;
    Snake2Weld.Part0 = u2.HumanoidRootPart;
    Snake2Weld.Part1 = u6.RootPart;
    Snake3Weld.Parent = u2.HumanoidRootPart;
    Snake3Weld.Part0 = u2.HumanoidRootPart;
    Snake3Weld.Part1 = u7.RootPart;
    v11:Destroy();
    v8:Play();
    v9:Play();
    v10:Play();
    CollectionService:AddTag(u5, (`Cosmetic{p3}`));
    CollectionService:AddTag(u6, (`Cosmetic{p3}`));
    CollectionService:AddTag(u7, (`Cosmetic{p3}`));
    u4 = RunService.RenderStepped:Connect(function(p12) -- Line: 56
        -- upvalues: u2 (copy), u4 (ref), u5 (copy), u6 (copy), u7 (copy), Snake1Weld (copy), Snake2Weld (copy), Snake3Weld (copy)
        if u2 and u2.Parent then
            return;
        end;

        u4:Disconnect();
        u5:Destroy();
        u6:Destroy();
        u7:Destroy();
        Snake1Weld:Destroy();
        Snake2Weld:Destroy();
        Snake3Weld:Destroy();
    end);
end;

return v1;