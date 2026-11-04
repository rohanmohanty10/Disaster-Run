  

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
    local u5 = script.MonsterContractVFX:Clone();
    u5.VFX.Part0 = u5;
    u5.VFX.Part1 = u2.HumanoidRootPart;
    local u6 = ReplicatedStorage.Assets.Misc.MonsterTranceModel:Clone();
    u5.Parent = u6;
    u6.Parent = u2;
    local Weld = Instance.new("Weld", u2.HumanoidRootPart);
    Weld.Part0 = u2.HumanoidRootPart;
    Weld.Part1 = u6.RootPart;
    Weld.C0 = CFrame.new();
    Weld.C1 = CFrame.new(-0.3, 2.8, -2) * CFrame.Angles(0, 0, 0);
    local u7 = u6.AnimationController:LoadAnimation(ReplicatedStorage.Assets.Emotes["Monster Contract Monster"]);
    u7:Play();
    CollectionService:AddTag(u5, (`Cosmetic{p3}`));
    CollectionService:AddTag(Weld, (`Cosmetic{p3}`));
    CollectionService:AddTag(u7, (`Cosmetic{p3}`));
    CollectionService:AddTag(u6, (`Cosmetic{p3}`));
    u4 = RunService.RenderStepped:Connect(function(p8) -- Line: 35
        -- upvalues: u2 (copy), u4 (ref), u5 (copy), u6 (copy), u7 (copy), Weld (copy)
        if u2 and u2.Parent then
            u5.Transparency = 1;

            return;
        end;

        u4:Disconnect();
        u5:Destroy();
        u6:Destroy();
        u7:Destroy();
        Weld:Destroy();
    end);
end;

return v1;