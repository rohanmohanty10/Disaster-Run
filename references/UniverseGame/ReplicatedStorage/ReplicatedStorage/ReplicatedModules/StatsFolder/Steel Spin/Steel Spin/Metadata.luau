  

 

game:GetService("RunService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Middleware = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ClientModulesPath.TweenModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
Knit.OnStart():andThen(function() -- Line: 18
    -- upvalues: u5 (ref), Knit (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref)
    u5 = Knit.GetService("StatService");
    u1 = Knit.GetService("RigService");
    u2 = Knit.GetService("EffectService");
    u3 = Knit.GetService("TagService");
    u4 = Knit.GetService("AnimationService");
end);

return {
    PostRig = function(p6) -- Line: 27, Name: PostRig
        -- upvalues: Middleware (copy), u3 (ref), u4 (ref), AssetHandler (copy), ParticleHandler (copy)
        local Player = p6.Player;
        local Character = p6.Character;
        local _ = p6.Trove;

        repeat
            task.wait(0.25);
        until Character:WaitForChild("Head");

        if Player:IsA("Player") then
            Player:HasAppearanceLoaded();
        end;

        local Humanoid = Character:FindFirstChild("Humanoid");

        if not (Humanoid and Character:FindFirstChild("HumanoidRootPart")) then
            warn("Cannot find Humanoid or RootPart");

            return;
        end;

        Middleware.GetMiddleware("CombatService");

        if not u3:GetContainer(Character) then
            warn("Cannot find Tags");

            return;
        end;

        if not u4.Get(Humanoid:FindFirstChildWhichIsA("Animator")) then
            warn("Cannot find Animator");

            return;
        end;

        local v7 = AssetHandler.CloneAsset("Models/Belt", {
            AbilityName = "Steel Spin",
            SkinName = p6.SkinName
        });
        v7.Parent = Character;
        ParticleHandler.AttachTo(v7, {
            Part = Character:FindFirstChild("Torso"),
            Offset = CFrame.new(0.008, 0.8, 0.001) * CFrame.Angles(0, 3.141592653589793, 0)
        });
    end
};