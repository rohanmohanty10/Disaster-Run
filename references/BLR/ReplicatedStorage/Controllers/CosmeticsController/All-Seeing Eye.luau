  

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
    local u5 = ReplicatedStorage.Assets.Misc.AllSeeingEye:Clone();
    u5.Parent = u2;
    local Weld = Instance.new("Weld", u2.HumanoidRootPart);
    Weld.Part0 = u2.HumanoidRootPart;
    Weld.Part1 = u5.RootPart;
    Weld.C0 = CFrame.new();
    Weld.C1 = CFrame.new(-4.5, 2, 0) * CFrame.Angles(0, 3.141592653589793, 0);
    u5.AnimationController:LoadAnimation(ReplicatedStorage.Assets.Emotes["Puppeteer Hand"]):Play();
    CollectionService:AddTag(u5, (`Cosmetic{p3}`));
    u4 = RunService.RenderStepped:Connect(function(p6) -- Line: 30
        -- upvalues: u2 (copy), u4 (ref), u5 (copy)
        if u2 and u2.Parent then
            return;
        end;

        u4:Disconnect();
        u5:Destroy();
    end);
end;

return v1;