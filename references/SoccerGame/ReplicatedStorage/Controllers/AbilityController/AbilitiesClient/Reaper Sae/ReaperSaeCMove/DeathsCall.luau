  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local DeathsCall = require(ReplicatedStorage.AbilityBalancing).DeathsCall;

return function(u1, p2, p3, p4) -- Line: 17, Name: DeathsCall
    -- upvalues: Players (copy), RunService (copy), Popup (copy), DeathsCall (copy), ReplicatedStorage (copy)
    local Players2 = Players:GetPlayers();
    local v5 = nil;

    for _, v in pairs(Players2) do
        if v.Team ~= game.Teams.Visitor and (v.Character:FindFirstChild("HumanoidRootPart") ~= nil and (v.Team == p2.Team and not (v.Character.Values.Goalie.Value and v.Character.Values.IsInPenalty.Value))) and (v.Character.Values.HasBall.Value and not v.Character.Values.Dribbling.Value) then
            v5 = v.Character;
        end;
    end;

    if v5 or not RunService:IsStudio() then
        if not v5 then
            Popup.Popup(p2, "Must have a teammate with the ball!");
        end;
    else
        v5 = workspace.PassRig;
    end;

    u1:AbilityCooldown("1", 35);
    u1.AbilityService.Ability:Fire("DeathsCall", v5);
    u1.ABC:Connect(u1.AbilityService.Ability, function(p6) -- Line: 41
        -- upvalues: u1 (copy), DeathsCall (ref), ReplicatedStorage (ref)
        u1.ABC:Clean();
        local _ = p6.Char.Value;
        local v7 = game.Workspace.CurrentCamera.CFrame.LookVector + DeathsCall.ShotTiltVector;
        u1.StatesController.States.Ability = false;
        u1.InAbility = false;
        ReplicatedStorage.Football.Value.AssemblyLinearVelocity = v7 * DeathsCall.ShotPower;
        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
    end);
end;