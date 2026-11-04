 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 19, Name: Declaration
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), Effects (copy), ReplicatedStorage (copy)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u2 = u6.MovementController;
    u4 = u6.BallController;
    u5 = u6.CameraController;
    local v7 = u6:HoopDist();

    if v7 <= 40 then
        u6:ResetCD(1);
        Effects:Popup("You are too close to the hoop!", 3);

        return;
    end;

    if v7 > 180 then
        u6:ResetCD(1);
        Effects:Popup("You are too far away!", 3);

        return;
    end;

    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u3:StopAll();
    local v8 = u3:PlayChar("UncleSam", "Declaration", Enum.AnimationPriority.Action3, true);
    local v9 = u3:PlayBall("UncleSam", "DeclarationBall", Enum.AnimationPriority.Action3, true);
    local u10 = nil;
    local u11 = nil;
    local u12 = nil;
    u12 = v8.Stopped:Connect(function() -- Line: 50
        -- upvalues: u12 (ref), u10 (ref), u3 (ref)
        if u12 then
            u12:Disconnect();
            u12 = nil;
        end;

        u10 = u3:PlayChar("UncleSam", "DeclarationLoop", Enum.AnimationPriority.Action3, true);
    end);
    local u13 = nil;
    u13 = v9.Stopped:Connect(function() -- Line: 55
        -- upvalues: u13 (ref), u11 (ref), u3 (ref)
        if u13 then
            u13:Disconnect();
            u13 = nil;
        end;

        u11 = u3:PlayBall("UncleSam", "DeclarationBallLoop", Enum.AnimationPriority.Action3, true);
    end);
    local u14 = script.Choose:Clone();
    u14.Parent = LocalPlayer.PlayerGui;
    u14.Enabled = true;
    local v15 = {};
    local u16 = nil;

    for i, v in next, {
        ["Eagle Drive"] = {
            MinimumDistance = 40,
            MaximumDistance = 100
        },
        ["Star Shot"] = {
            MinimumDistance = 40,
            MaximumDistance = 150
        }
    } do
        if v.MinimumDistance <= v7 and v7 <= v.MaximumDistance then
            table.insert(v15, i);
            u14.Background[i].MouseButton1Click:Connect(function() -- Line: 76
                -- upvalues: u16 (ref), i (copy), u14 (copy)
                u16 = i;
                u14:Destroy();
            end);
        else
            u14.Background[i].AbilityName.TextTransparency = 0.5;
            u14.Background[i].AbilityName.UIStroke.Transparency = 0.5;
            u14.Background[i].ImageTransparency = 0.5;
        end;
    end;

    u6.AC:Add(u14);

    if #v15 == 0 then
        Effects:Popup("No Abilities Available Here!", 4, Color3.fromRGB(255, 0, 0));
        u6.AC:Clean();
        v8:Stop();
        v9:Stop();
        u2.States.Ability = false;
        u2.States.NoWalk = false;

        if u13 then
            u13:Disconnect();
            u13 = nil;
        end;

        if u12 then
            u12:Disconnect();
            u12 = nil;
        end;

        u6:ResetCD(1);

        return;
    end;

    u1.Ability:Fire("Declaration", {
        State = "Start",
        TimeSent = workspace:GetServerTimeNow()
    });
    local u17 = false;

    local function DoChosenAbility(p18) -- Line: 108
        -- upvalues: u6 (copy), u1 (ref), u3 (ref), u2 (ref), ReplicatedStorage (ref), LocalPlayer (ref), u4 (ref), HumanoidRootPart (copy)
        u6.AC:Clean();
        u1.Ability:Fire("Declaration", {
            TimeSent = workspace:GetServerTimeNow(),
            State = p18
        });
        u3:StopAll();

        if p18 ~= "Eagle Drive" then
            if p18 == "Star Shot" then
                local v19 = u3:PlayChar("UncleSam", "StarShot", Enum.AnimationPriority.Action3, true);
                local v20 = u3:PlayBall("UncleSam", "StarShotBall", Enum.AnimationPriority.Action3, true);
                v19:AdjustSpeed(1.35);
                v20:AdjustSpeed(1.35);
                u6.AC:Connect(u1.Ability, function(p21) -- Line: 133
                    -- upvalues: u6 (ref), u2 (ref), ReplicatedStorage (ref), LocalPlayer (ref), u4 (ref), HumanoidRootPart (ref)
                    if p21.State == "Shoot" then
                        u6.AC:Clean();
                        u2.States.Ability = false;
                        u2.States.NoWalk = false;
                        local Value = ReplicatedStorage.Basketball.Value;
                        local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
                        Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
                        local v22 = Hoop.Position - Value.Position;
                        local v23, v24;

                        if (HumanoidRootPart.Position - Hoop.Position).Magnitude <= 30 then
                            v23 = v22.Magnitude * 0.0455;
                            v24 = 1.35;
                        else
                            v23 = v22.Magnitude * 0.04;
                            v24 = 0.5;
                        end;

                        local math_log_ret = math.log(v24 + v23);
                        Value.AssemblyLinearVelocity = v22 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
                    end;
                end);
            end;

            return;
        end;

        u3:PlayChar("UncleSam", "EagleDrivePlayer", Enum.AnimationPriority.Action3);
        u3:PlayBall("UncleSam", "EagleDriveBall", Enum.AnimationPriority.Action3);
        u2.States.Dunking = true;
        task.wait(2.9166666666666665);
        u2.States.Dunking = false;
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end;

    u6.AC:Connect(u1.Ability, function(p25) -- Line: 170
        -- upvalues: u17 (ref)
        if p25.State == "CanSend" then
            u17 = true;
        end;
    end);
    local v26 = tick();
    local Shiftlock = u5.Shiftlock;
    u5:SetShiftlock(false);

    repeat
        task.wait();
    until u17 and (u16 ~= nil or (tick() - v26 >= 5 or u6.Network.CharValues.HasBall == false)) or tick() - v26 >= 5;

    u5:SetShiftlock(Shiftlock);

    if u13 then
        u13:Disconnect();
        u13 = nil;
    end;

    if u12 then
        u12:Disconnect();
        u12 = nil;
    end;

    if not u17 then
        return;
    end;

    local v27 = u16 or v15[math.random(1, #v15)];

    if u6.Network.CharValues.HasBall then
        DoChosenAbility(v27);

        return;
    end;

    u6.AC:Clean();
    v8:Stop();
    v9:Stop();
    u2.States.Ability = false;
    u2.States.NoWalk = false;
    u3:StopAll();
end;