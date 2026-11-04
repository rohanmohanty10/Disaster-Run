  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Popup = require(ReplicatedStorage.Shared.Popup);

return function(u1, u2, u3) -- Line: 5
    -- upvalues: Popup (copy)
    local Players = game.Players:GetPlayers();
    local v4 = {};
    local v5 = nil;
    local v6 = nil;

    for _, v in pairs(Players) do
        if v.Team ~= game.Teams.Visitor and (v.Character:FindFirstChild("HumanoidRootPart") ~= nil and (v.Team ~= u2.Team and not (v.Character.Values.Goalie.Value and v.Character.Values.IsInPenalty.Value))) then
            local v7 = u3.HumanoidRootPart.CFrame.LookVector:Dot((v.Character.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Unit);
            local math_acos_ret = math.acos(v7);
            local _ = math_acos_ret < 1.9039955476301778;

            if math_acos_ret < 1.5707963267948966 then
                table.insert(v4, v.Character);
            end;
        end;
    end;

    for _, v in pairs(v4) do
        local Magnitude = (v.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Magnitude;

        if not v5 or Magnitude < v5 then
            v6 = v;
            v5 = Magnitude;
        end;
    end;

    table.clear(v4);
    table.clear(Players);

    if v6 == nil and workspace:FindFirstChild("PassRig") then
        v6 = workspace.PassRig;
    end;

    if v6 == nil then
        Popup.Popup(u2, "Another player must be infront of you!");

        return;
    end;

    u1.Animations:StopAnims();
    u1.Animations.Abilities.KaiserDribbleZigZag.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.KaiserDribbleZigZag:Play(0, 1, 0.9);
    u1:AbilityCooldown("3", u1.Animations.Abilities.KaiserDribbleZigZag.Length);
    u1.StatesController.States.Ability = true;
    print("hey");
    u1.AbilityService.Ability:Fire("KaiserDribbleULT", {
        State = script.Parent.Name,
        Action = script.Name,
        Object = v6
    });
    local task_delay_ret = task.delay(3.5, function() -- Line: 62
        -- upvalues: u1 (copy)
        if u1.ABC then
            u1.ABC:Clean();
        end;
    end);
    local u8 = true;
    u1.ABC:Add(function() -- Line: 68
        -- upvalues: task_delay_ret (copy), u1 (copy), u8 (ref), u2 (copy), u3 (copy)
        if coroutine.status(task_delay_ret) ~= "running" then
            task.cancel(task_delay_ret);
        end;

        u1.StatesController.States.Ability = false;
        task.delay(0.416666667, function() -- Line: 73
            -- upvalues: u1 (ref)
            u1.Animations.Abilities.KaiserDribbleZigZag:Stop();
            u1.Animations.Ball.KaiserDribbleZigZag:Stop();
        end);
        local u9 = not u8 and u2.PlayerGui.InGameUI.Bottom.Abilities:FindFirstChild("2");

        if u9 then
            u1.OverwriteText["2"] = "Subjugation";
            local UIScale = u9:FindFirstChild("UIScale");
            UIScale.Scale = 1.25;
            u9.ImageColor3 = Color3.fromRGB(26, 255, 53);
            u1.UITween1 = game:GetService("TweenService"):Create(UIScale, TweenInfo.new(0.85, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                Scale = 1
            });
            u1.UITween1:Play();
            u1.UITween2 = game:GetService("TweenService"):Create(u9, TweenInfo.new(0.85, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ImageColor3 = Color3.fromRGB(255, 255, 255)
            });
            u1.UITween2:Play();
            u3:SetAttribute("KaiserDribbleTake", true);
            u1.KaiserDribbleTake = true;
            local u10 = u3.Values.HasBall:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 91
                -- upvalues: u3 (ref), u2 (ref), u1 (ref), UIScale (copy), u9 (copy)
                if not u3.Values.HasBall.Value then
                    if u2.PlayerStats.InAwakening.Value then
                        u1.OverwriteText["2"] = "Magnus";
                    elseif u3.Values.HasBall.Value then
                        u1.OverwriteText["2"] = "Emperor\'s Dribble";
                    else
                        u1.OverwriteText["2"] = "Royal Route";
                    end;

                    if u1.UITween2 then
                        u1.UITween2:Cancel();
                        u1.UITween2 = nil;
                    end;

                    if u1.UITween1 then
                        u1.UITween1:Cancel();
                        u1.UITween1 = nil;
                    end;

                    UIScale.Scale = 1;
                    u9.ImageColor3 = Color3.fromRGB(255, 255, 255);
                    u1.KaiserDribbleTake = nil;
                    u3:SetAttribute("KaiserDribbleTake", nil);
                end;
            end);
            u1.LostBallConnection = u10;
            task.delay(0.85, function() -- Line: 111
                -- upvalues: u1 (ref), u10 (copy), u2 (ref), u3 (ref)
                if not u1.KaiserDribbleTake then
                    return;
                end;

                if u10 then
                    u10:Disconnect();
                end;

                if u1.LostBallConnection then
                    u1.LostBallConnection = nil;
                end;

                if u2.PlayerStats.InAwakening.Value then
                    u1.OverwriteText["2"] = "Magnus";
                elseif u3.Values.HasBall.Value then
                    u1.OverwriteText["2"] = "Emperor\'s Dribble";
                else
                    u1.OverwriteText["2"] = "Royal Route";
                end;

                u1.UITween2 = nil;
                u1.UITween1 = nil;
                u1.KaiserDribbleTake = nil;
                u3:SetAttribute("KaiserDribbleTake", nil);
                u1:AbilityCooldown("3", 60);
            end);
        end;
    end);
    u1.ABC:Connect(u1.AbilityService.Ability, function(p11) -- Line: 133
        -- upvalues: u1 (copy), u8 (ref)
        if p11.State ~= "Failed" then
            if p11.State == "PrepareTake" then
                u8 = false;
                u1.ABC:Clean();
            end;

            return;
        end;

        u1:AbilityCooldown("3", 60);
        u1.ABC:Clean();
    end);
end;