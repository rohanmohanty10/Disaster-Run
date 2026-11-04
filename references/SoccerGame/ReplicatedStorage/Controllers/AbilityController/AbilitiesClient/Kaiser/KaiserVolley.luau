  

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Promise = require(game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Promise"));
local Popup = require(ReplicatedStorage.Shared.Popup);
local KaiserVolley_LastUsage = ReplicatedStorage.GameValues.KaiserVolley_LastUsage;
local KaiserVolley = require(game:GetService("ReplicatedStorage").AbilityBalancing).KaiserVolley;
local ActivationRangePlayer = KaiserVolley.ActivationRangePlayer;

return function(u1, p2, u3) -- Line: 10
    -- upvalues: Players (copy), ReplicatedStorage (copy), KaiserVolley_LastUsage (copy), Popup (copy), ActivationRangePlayer (copy), KaiserVolley (copy), Promise (copy), RunService (copy)
    if p2:GetAttribute("CRRequest") == "KaiserKiyoraCR" then
        local Attribute = p2:GetAttribute("CRSender");
        local v4;

        if typeof(Attribute) == "number" then
            v4 = Players:GetPlayerByUserId(Attribute) or nil;
        else
            v4 = nil;
        end;

        local v5;

        if v4 then
            v5 = v4:FindFirstChild("PlayerStats");
        else
            v5 = v4;
        end;

        local v6;

        if v4 then
            v6 = v4.Character;
        else
            v6 = v4;
        end;

        if v4 and (v4 ~= p2 and (v4.Team == p2.Team and (v4.Team ~= game.Teams.Visitor and (v5 and (v5:FindFirstChild("Style") and (v5.Style.Value == "Kiyora" and (v6 and v6:FindFirstChild("HumanoidRootPart")))))))) then
            local v7 = u1.UngroupedAbilities and u1.UngroupedAbilities.KaiserKiyoraCRReceiver;

            if v7 then
                v7(u1, p2, u3, v6);
            end;
        end;

        return;
    end;

    local v8;

    if u3 then
        v8 = u3:FindFirstChild("HumanoidRootPart");
    else
        v8 = u3;
    end;

    local Value = ReplicatedStorage.Football.Value;

    if not (v8 and workspace.CurrentCamera) then
        return;
    end;

    if u3.Values.HasBall.Value then
        return;
    end;

    if Value and Value.IFrame.Value > workspace:GetServerTimeNow() then
        return;
    end;

    if workspace:GetServerTimeNow() - KaiserVolley_LastUsage.Value < 10 then
        return Popup.Popup(p2, "Global Cooldown");
    end;

    if u1.AbilityThree > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local v9 = nil;

    for _, v in Players:GetPlayers() do
        if v.Team == p2.Team then
            local Character = v.Character;
            local v10;

            if Character then
                v10 = Character:FindFirstChild("Values");
            else
                v10 = Character;
            end;

            local v11;

            if v10 then
                v11 = v10:FindFirstChild("HasBall");
            else
                v11 = v10;
            end;

            local v12;

            if v10 then
                v12 = v10:FindFirstChild("InCutscene");
            else
                v12 = v10;
            end;

            local v13;

            if v10 then
                v13 = v10:FindFirstChild("Goalie");
            else
                v13 = v10;
            end;

            if v10 then
                v10 = v10:FindFirstChild("IsInPenalty");
            end;

            if v11 and (v11.Value and not (v12 and v12.Value)) and not (v13.Value and v10.Value) then
                local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

                if HumanoidRootPart and (not p2.PlayerStats.HasShot.Value and (v8.Position - HumanoidRootPart.Position).Magnitude < ActivationRangePlayer) then
                    v9 = Character;
                    break;
                end;
            end;
        end;
    end;

    local v14;

    if v9 then
        v14 = v9;
    else
        v14 = workspace:FindFirstChild("PassRig");

        if v14 and v14:GetAttribute("IsTrainingDummy") then
            local HumanoidRootPart = v14:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart then
                local Values = v14:FindFirstChild("Values");

                if Values then
                    Values = Values:FindFirstChild("HasBall");
                end;

                if Values and Values.Value then
                    v14 = v9;
                elseif (v8.Position - HumanoidRootPart.Position).Magnitude >= ActivationRangePlayer then
                    v14 = v9;
                end;
            else
                v14 = v9;
            end;
        else
            v14 = v9;
        end;
    end;

    if not v14 then
        return Popup.Popup(p2, "No target character");
    end;

    u1.StatesController.States.Ability = true;
    u1:AbilityCooldown("3", KaiserVolley.Cooldown);
    u1.AbilityService.Ability:Fire("KaiserVolley", v14);
    u1.ABC:Connect(u1.AbilityService.Ability, function(p15, p16, p17) -- Line: 105
        local _ = p17 == "shoot";
    end);
    local u18 = false;
    task.delay(2, function() -- Line: 114
        -- upvalues: u18 (ref), u1 (copy)
        if not u18 then
            u1.StatesController.States.Ability = false;
            u1.ABC:Clean();
        end;
    end);
    u1.ABC:Connect(u1.AbilityService.Ability, function(u19, u20, p21) -- Line: 121
        -- upvalues: Promise (ref), u1 (copy), RunService (ref), u3 (copy), u18 (ref), KaiserVolley (ref), ReplicatedStorage (ref)
        print("Client fired", p21);

        if p21 == "start" then
            local u22 = tick();
            local u23 = nil;
            Promise.new(function(u24, p25, p26) -- Line: 127
                -- upvalues: u23 (ref), u1 (ref), RunService (ref), u22 (copy), u19 (copy)
                u23 = u1.ABC:Connect(RunService.Heartbeat, function(p27) -- Line: 128
                    -- upvalues: u22 (ref), u19 (ref), u23 (ref), u24 (copy)
                    if tick() > u22 + 5 or (not u19 or u19.OnPlayer.Value) then
                        u23:Disconnect();
                        u24();
                    end;
                end);
            end):catch(warn);
            u1.Animations:StopAnims();
            u1.Animations.Abilities.KaiserVolley.Priority = Enum.AnimationPriority.Action4;
            u1.Animations.Abilities.KaiserVolley:Play();
            u1.Animations.Ball.KaiserVolley.Priority = Enum.AnimationPriority.Action4;
            u1.Animations.Ball.KaiserVolley:Play();
            u1.ABC:Clean();

            repeat
                task.wait();
            until not u3.Values.HasBall.Value;

            u18 = true;
            u1.StatesController.States.Ability = false;
            u19.AssemblyLinearVelocity = (game.Workspace.CurrentCamera.CFrame.LookVector + KaiserVolley.ShotTiltVector + u20 / 2) * KaiserVolley.ShotPower;
            task.delay(0.1, function() -- Line: 148
                -- upvalues: u1 (ref), RunService (ref), u19 (copy), u20 (copy)
                local u28 = -40;
                u1.ABC:Connect(RunService.Heartbeat, function(p29) -- Line: 151
                    -- upvalues: u28 (ref), u1 (ref), u19 (ref), u20 (ref)
                    u28 = u28 + 25 * p29;

                    if u28 >= -25 then
                        u1.ABC:Clean();
                        print("CLEANED!");
                    end;

                    u19.AssemblyLinearVelocity = u19.AssemblyLinearVelocity:Lerp(u19.AssemblyLinearVelocity + u20 * u28, 6.5 * p29);
                end);
            end);
            u1.BallController:DragBall(ReplicatedStorage.Football.Value);
        end;
    end);
end;