 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 23, Name: Implant
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), Effects (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local _ = Character.HumanoidRootPart;
    local Style = LocalPlayer.Style;
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u2 = u6.MovementController;
    u4 = u6.BallController;
    u5 = u6.Network;
    local v7 = {
        Projectile = {
            NeedsBall = true,
            Distance = 150,
            Ability = require(script.Projectile)
        },
        ["Dash Through"] = {
            NeedsBall = false,
            Ability = require(script["Dash Through"])
        }
    };

    if LocalPlayer:GetAttribute("PsychoBar") and LocalPlayer:GetAttribute("PsychoBar") == -1 then
        Effects:Popup("You must not be going psycho!", 4);

        return u6:ResetCD(1);
    end;

    if not (u6.CurrentImplant and v7[u6.CurrentImplant]) then
        if u5.CharValues.HasBall then
            Effects:Popup("You must not have the ball!", 4);
            u6:ResetCD(1);

            return;
        end;

        if workspace:GetServerTimeNow() - u5.CharValues.LastHadBall < 2 then
            Effects:Popup(`You must not have the ball for at least {2} seconds!`, 4);
            u6:ResetCD(1);

            return;
        end;

        u2.States.Ability = true;
        u2.States.NoWalk = true;
        u3:StopAll();
        u3:PlayChar("Cyber", "Implant", Enum.AnimationPriority.Action3);
        u1.Ability:Fire("OGImplant", {
            State = "RequestImplant",
            TimeSent = workspace:GetServerTimeNow()
        });
        local u8 = false;
        u6.AC:Add(task.delay(7.5, function() -- Line: 67
            -- upvalues: u8 (ref), u6 (copy), u2 (ref)
            if not u8 then
                u6.AC:Clean();
                u2.States.Ability = false;
                u2.States.NoWalk = false;
            end;
        end));
        u6.AC:Connect(u1.Ability, function(p9) -- Line: 75
            -- upvalues: u6 (copy), u8 (ref), u2 (ref), RunService (ref), Style (copy), u5 (ref), LocalPlayer (ref), Effects (ref)
            if p9 and p9.State == "RecieveImplant" then
                u6.AC:Clean();
                u8 = true;
                u2.States.Ability = false;
                u2.States.NoWalk = false;

                if p9.Implant.Type == "Ability" then
                    u6.CurrentImplant = p9.Implant.Name;
                    task.delay(4.166666666666667, function() -- Line: 83
                        -- upvalues: u6 (ref)
                        u6:ResetCD(1);
                    end);
                    local u10 = nil;
                    u10 = RunService.Heartbeat:Connect(function(p11) -- Line: 86
                        -- upvalues: u6 (ref), Style (ref), u10 (ref), u5 (ref), LocalPlayer (ref)
                        if not u6.CurrentImplant or Style.Value ~= "OGCyber" then
                            u10:Disconnect();

                            return;
                        end;

                        if u5.CharValues.InAwakening then
                            u6.CurrentImplant = nil;

                            return;
                        end;

                        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = u6.CurrentImplant;
                    end);
                    Effects:Popup((`You have received a new ability: {u6.CurrentImplant}!`));

                    return;
                end;

                Effects:Popup((`You have received {p9.Implant.Name == "Leg Implant" and "a speed boost" or "increased shooting speed"}!`));

                if p9.Implant.Name == "Leg Implant" then
                    if not u2.ExtraBoosts.LegImplant then
                        u2.ExtraBoosts.LegImplant = 2;

                        return;
                    end;

                    local ExtraBoosts = u2.ExtraBoosts;
                    ExtraBoosts.LegImplant = ExtraBoosts.LegImplant + 2;

                    return;
                end;

                if u6.ArmImplant then
                    local v12 = u6;
                    v12.ArmImplant = v12.ArmImplant + 1;

                    return;
                end;

                u6.ArmImplant = 1;
            end;
        end);

        return;
    end;

    local v13 = v7[u6.CurrentImplant];
    local NeedsBall = v13.NeedsBall;
    local Distance = v13.Distance;
    local NeedsCloseEnemy = v13.NeedsCloseEnemy;
    local EnemyNeedsBall = v13.EnemyNeedsBall;
    local HasBall = u5.CharValues.HasBall;

    if not NeedsBall and HasBall then
        Effects:Popup("You must not have the ball!", 4);
        u6:ResetCD(1);

        return;
    end;

    if NeedsBall and not HasBall then
        Effects:Popup("You must have the ball!", 4);
        u6:ResetCD(1);

        return;
    end;

    if Character.Humanoid.FloorMaterial == Enum.Material.Air then
        Effects:Popup("You must be on the ground!", 4);
        u6:ResetCD(1);

        return;
    end;

    if Distance and Distance < u6:HoopDist() then
        Effects:Popup("You are too far away from the hoop!");
        u6:ResetCD(1);

        return;
    end;

    local v14 = {};

    if NeedsCloseEnemy then
        local _, v15 = u4:GetEnemyWithinDistance(NeedsCloseEnemy, EnemyNeedsBall);

        if not v15 then
            Effects:Popup(`An enemy player{EnemyNeedsBall and " with the ball" or ""} must be close to you!`, 4);
            u6:ResetCD(1);

            return;
        end;

        v14.Closest = v15;
    end;

    local CurrentImplant = u6.CurrentImplant;
    u6.CurrentImplant = nil;
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Implant";

    if v7[CurrentImplant].Ability then
        v7[CurrentImplant].Ability(u6, v14);
    end;
end;