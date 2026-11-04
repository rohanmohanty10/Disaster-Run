  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
local Debris = game:GetService("Debris");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
require(ReplicatedStorage.Controllers.AnimationController);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 33
    -- upvalues: AbilityBalancing (copy), interface (copy), AbilityUtils (copy), LocalPlayer (copy), Popup (copy), Players (copy), Debris (copy)
    local EgoStoppage = AbilityBalancing.EgoStoppage;

    if interface.UsingEgoStoppage then
        return;
    end;

    if not (AbilityUtils.rules.grounded(LocalPlayer) and (AbilityUtils.rules.offball(LocalPlayer, EgoStoppage.BallRange) and AbilityUtils.rules.slotReady(3))) then
        return;
    end;

    local v1 = AbilityUtils.findNearestPlayer({
        team = "Enemy",
        onBall = true,
        distance = EgoStoppage.EnemyRange
    });

    if not v1 then
        Popup.Popup(LocalPlayer, "No enemy close to you with the ball");

        return;
    end;

    if not v1.Values.HasBall.Value then
        Popup.Popup(LocalPlayer, "Closest player to you doesn\'t have the ball");

        return;
    end;

    Popup.Popup(LocalPlayer, "Locked on to: " .. v1.Name .. ", Waiting for them to shoot");
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(v1);

    if not PlayerFromCharacter then
        return;
    end;

    if (v1.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > EgoStoppage.EnemyRange then
        Popup.Popup(LocalPlayer, "Enemy too far away");

        return;
    end;

    local Highlight = Instance.new("Highlight");
    Highlight.FillTransparency = 0.5;
    Highlight.FillColor = Color3.fromRGB(255, 0, 0);
    Highlight.OutlineTransparency = 0;
    Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
    Highlight.Parent = v1;
    Debris:AddItem(Highlight, 5);
    interface.UsingEgoStoppage = true;
    local os_clock_ret = os.clock();

    repeat
        task.wait();
    until PlayerFromCharacter.PlayerStats.HasShot.Value or os.clock() - os_clock_ret > AbilityBalancing.EgoStoppage.ShotDetectDuration;

    if Highlight then
        Highlight:Destroy();
    end;

    interface.UsingEgoStoppage = false;

    if os.clock() - os_clock_ret > AbilityBalancing.EgoStoppage.ShotDetectDuration then
        Popup.Popup(LocalPlayer, "No shot was made");
        interface:AbilityCooldown(tostring(3), 20);

        return;
    end;

    if interface.StatesController.States.Ability then
        Popup.Popup(LocalPlayer, "canceled Ego Stoppage");
        interface:AbilityCooldown(tostring(3), 15);

        return;
    end;

    interface.AbilityService.Ability:Fire(script.Name, v1);
    AbilityUtils.clientCutsceneSkill(interface, EgoStoppage, 10, 3, true, LocalPlayer.Character.HumanoidRootPart.CFrame.RightVector);
end;