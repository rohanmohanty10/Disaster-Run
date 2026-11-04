  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
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
    -- upvalues: AbilityBalancing (copy), interface (copy), Players (copy), LocalPlayer (copy), Popup (copy), AbilityUtils (copy)
    local NoFear = AbilityBalancing.NoFear;

    if interface.UsingEgoStoppage then
        return;
    end;

    local v1 = nil;
    local v2 = false;

    for _, v in Players:GetPlayers() do
        if v.Team == LocalPlayer.Team and v ~= LocalPlayer then
            local Character = v.Character;
            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

            if Character and (HumanoidRootPart and Character.Values.HasBall.Value ~= false) then
                if (HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > NoFear.TeammateRange then
                    Popup.Popup(LocalPlayer, "Teammate too far");
                    v2 = true;
                else
                    v1 = Character;
                end;

                break;
            end;
        end;
    end;

    if not (v1 or v2) then
        Popup.Popup(LocalPlayer, "No teammate with ball");

        return;
    end;

    local v3 = nil;

    for _, v in Players:GetPlayers() do
        if v.Team ~= LocalPlayer.Team and v.Team ~= game.Teams.Visitor then
            v3 = true;
            break;
        end;
    end;

    if not v3 then
        Popup.Popup(LocalPlayer, "Need one enemy");

        return;
    end;

    if not (AbilityUtils.rules.offball(LocalPlayer) and (AbilityUtils.rules.grounded(LocalPlayer) and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    interface.AbilityService.Ability:Fire(script.Name, v1);
    AbilityUtils.clientCutsceneSkill(interface, NoFear, 15, 1, true, workspace.CurrentCamera.CFrame.LookVector);
end;