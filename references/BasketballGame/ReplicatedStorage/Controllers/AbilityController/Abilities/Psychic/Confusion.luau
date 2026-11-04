 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
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

return function(u6) -- Line: 22, Name: Confusion
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), Effects (copy), ReplicatedStorage (copy), Players (copy), RunService (copy)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u2 = u6.MovementController;
    u4 = u6.Network;
    u5 = u6.BallController;

    if u4.CharValues.HasBall then
        local LookingAt = u6.Pass.LookingAt;

        if game:GetService("RunService"):IsStudio() then
            LookingAt = workspace.DefenseRig;
        end;

        if not LookingAt then
            Effects:Popup("You must be looking at a teammate!");

            return u6:ResetCD(2);
        end;

        u2.States.Ability = true;
        u2.States.NoWalk = true;
        u3:StopAll();
        u3:PlayChar("Psychic", "TeleportPass", Enum.AnimationPriority.Action3);
        u3:PlayBall("Psychic", "TeleportPassBall", Enum.AnimationPriority.Action3);
        task.delay(1.6833333333333333, function() -- Line: 52
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
        end);
        u1.Ability:Fire("TeleportPass", {
            TimeSent = workspace:GetServerTimeNow(),
            Target = LookingAt
        });

        return;
    end;

    if ReplicatedStorage.Cooldowns.ConfusionCD.Value > workspace:GetServerTimeNow() then
        local v7 = ReplicatedStorage.Cooldowns.ConfusionCD.Value - workspace:GetServerTimeNow();
        Effects:Popup((`Ability is on global cooldown. Try again in {math.round(v7)}`));
        u6:ResetCD(2);

        return;
    end;

    local v8 = {};
    local v9 = nil;
    local v10 = { "BodyVelocity", "LinearVelocity", "AlignOrientation", "AlignPosition" };

    for _, v in Players:GetPlayers() do
        if v ~= LocalPlayer and (v.Character ~= nil and v.Team ~= LocalPlayer.Team) then
            table.insert(v8, v.Character);
        end;
    end;

    if RunService:IsStudio() then
        table.insert(v8, workspace.DefenseRig);
    end;

    local v11 = 999;

    for _, v in v8 do
        if v:FindFirstChild("HumanoidRootPart") ~= nil then
            local v12, v13 = workspace.CurrentCamera:WorldToScreenPoint(v.HumanoidRootPart.Position);

            if v13 and (HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 180 then
                local Magnitude = (Vector2.new(v12.X, v12.Y) - Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2 - game:GetService("GuiService"):GetGuiInset().Y / 2)).Magnitude;
                Players:FindFirstChild(v.Name);

                if v9 then
                    if Magnitude < v11 then
                        v11 = Magnitude;
                        v9 = v;
                    end;
                else
                    v11 = Magnitude;
                    v9 = v;
                end;
            end;
        end;
    end;

    if not v9 then
        Effects:Popup("You must look at an enemy!");
        u6:ResetCD(2);

        return;
    end;

    if (v9.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude > 50 then
        Effects:Popup("Enemy is too far away!");
        u6:ResetCD(2);

        return;
    end;

    if v9.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        Effects:Popup("Enemy must be on the ground to use");
        u6:ResetCD(2);

        return;
    end;

    for _, descendant in v9:GetDescendants() do
        if table.find(v10, descendant.ClassName) then
            Effects:Popup("Can\'t confuse enemy in ability.");
            u6:ResetCD(2);

            return;
        end;
    end;

    if v9:GetAttribute("FROZEN") then
        Effects:Popup("You can\'t confuse a frozen enemy.");

        return u6:ResetCD(2);
    end;

    if u5:GetCharacterPossessingBall() == v9 then
        Effects:Popup("You can\'t confuse a player with the ball!");

        return u6:ResetCD(2);
    end;

    u1.Ability:Fire("TeleportPass", {
        TimeSent = workspace:GetServerTimeNow(),
        Target = v9
    });
    u6.AC:Add(task.delay(3, function() -- Line: 157
        -- upvalues: u6 (copy)
        u6.AC:Clean();
    end));
    u6.AC:Connect(u1.Ability, function(p14) -- Line: 161
        -- upvalues: u6 (copy), Effects (ref)
        u6.AC:Clean();

        if p14.Success then
            Effects:Popup("INVERTED ENEMY MOVEMENT.");

            return;
        end;

        Effects:Popup("You can\'t invert that enemy!");
        u6:ResetCD(2);
    end);
end;