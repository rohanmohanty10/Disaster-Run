  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local LocalPlayer = Players.LocalPlayer;

return function(u1, p2) -- Line: 9, Name: Move
    -- upvalues: AbilityUtils (copy), LocalPlayer (copy), Players (copy), RunService (copy)
    local Character = AbilityUtils.getCharacter(LocalPlayer);

    if u1.AbilityOne > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local Players2 = Players:GetPlayers();
    local v3 = {};
    local v4 = 27;
    local v5 = nil;

    for _, v in pairs(Players2) do
        if v.Team ~= game.Teams.Visitor and (v.Character:FindFirstChild("HumanoidRootPart") ~= nil and (v.Team ~= LocalPlayer.Team and not (v.Character.Values.Goalie.Value and v.Character.Values.IsInPenalty.Value))) then
            local v6 = Character.HumanoidRootPart.CFrame.LookVector:Dot((v.Character.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Unit);
            local math_acos_ret = math.acos(v6);
            local _ = math_acos_ret < 1.9039955476301778;

            if math_acos_ret < 1.5707963267948966 then
                table.insert(v3, v.Character);
            end;
        end;
    end;

    for _, v in pairs(v3) do
        local Magnitude = (v.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude;

        if Magnitude < v4 then
            v5 = v;
            v4 = Magnitude;
        end;
    end;

    table.clear(v3);
    table.clear(Players2);

    if RunService:IsStudio() then
        v5 = workspace.PassRig;
    end;

    local u7 = LocalPlayer.PlayerStats.Style.Value == "Reo";
    u1:AbilityCooldown("1", u7 and 50 or 0.5);
    u1.StatesController.States.Ability = true;
    u1.StatesController.OwnWalkState = true;
    u1.StatesController.SpeedBoost = 5;
    u1.ABC:Add(function() -- Line: 66
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
        u1.StatesController.OwnWalkState = false;
        u1.StatesController.SpeedBoost = 0;
    end);
    u1.ABC:Add(task.delay(2, function() -- Line: 72
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
    end));
    u1.Animations:StopAnims();
    u1.Animations.Abilities.RouletteOnBall.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.RouletteOnBall:Play();
    u1.AbilityService.Ability:Fire("Roulette", {
        Action = "RouletteMove",
        Type = "OnBall",
        Enemy = v5
    });
    print("Fired");
    u1.Animations.Abilities.RouletteOnBall.Stopped:Connect(function() -- Line: 84
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
    end);
    u1.ABC:Add(function() -- Line: 88
        -- upvalues: u1 (copy), u7 (copy), Character (copy), LocalPlayer (ref)
        u1.StatesController.States.Ability = false;

        if u7 then
            return;
        end;

        if Character.Values.HasBall.Value then
            local Value = LocalPlayer.PlayerStats.Style.Value;
            local v8 = LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities:FindFirstChild("1");

            if v8 then
                local UIScale = v8:FindFirstChild("UIScale");
                UIScale.Scale = 1.25;
                v8.ImageColor3 = Color3.fromRGB(26, 255, 53);
                u1.UITween1 = game:GetService("TweenService"):Create(UIScale, TweenInfo.new(0.85, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    Scale = 1
                });
                u1.UITween1:Play();
                u1.UITween2 = game:GetService("TweenService"):Create(v8, TweenInfo.new(0.85, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    ImageColor3 = Color3.fromRGB(255, 255, 255)
                });
                u1.UITween2:Play();
                u1.NELBachiraLift = true;
                task.delay(1, function() -- Line: 111
                    -- upvalues: u1 (ref), Value (copy)
                    if not u1.NELBachiraLift then
                        return;
                    end;

                    u1.UITween2 = nil;
                    u1.UITween1 = nil;
                    u1.NELBachiraLift = nil;

                    if Value == "Reo" then
                        return;
                    end;

                    u1:AbilityCooldown("1", 50);
                end);
            end;
        else
            u1:AbilityCooldown("1", 50);
        end;
    end);
end;