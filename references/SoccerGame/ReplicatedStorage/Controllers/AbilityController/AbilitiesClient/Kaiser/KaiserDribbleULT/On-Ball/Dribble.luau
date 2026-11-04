  

return function(u1, u2, u3) -- Line: 1
    local u4 = u1.CopiedStyle and "1" or "3";
    u1.Animations:StopAnims();
    u1.Animations.Abilities.KaiserDribbleZigZag.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.KaiserDribbleZigZag:Play(0, 1, 0.9);
    u1.Animations.Ball.KaiserDribbleZigZag:Play(0, 1, 0.9);
    u1:AbilityCooldown(u4, u1.Animations.Abilities.KaiserDribbleZigZag.Length);
    u1.StatesController.States.Ability = true;
    u1.AbilityService.Ability:Fire("KaiserDribbleULT", {
        State = script.Parent.Name,
        Action = script.Name
    });
    local task_delay_ret = task.delay(3.5, function() -- Line: 16
        -- upvalues: u1 (copy)
        if u1.ABC then
            u1.ABC:Clean();
        end;
    end);
    local u5 = true;
    u1.ABC:Add(function() -- Line: 22
        -- upvalues: task_delay_ret (copy), u1 (copy), u5 (ref), u2 (copy), u4 (copy), u3 (copy)
        if coroutine.status(task_delay_ret) ~= "running" then
            task.cancel(task_delay_ret);
        end;

        u1.StatesController.States.Ability = false;
        task.delay(0.416666667, function() -- Line: 27
            -- upvalues: u1 (ref)
            u1.Animations.Abilities.KaiserDribbleZigZag:Stop();
            u1.Animations.Ball.KaiserDribbleZigZag:Stop();
        end);
        local u6 = not u5 and u2.PlayerGui.InGameUI.Bottom.Abilities:FindFirstChild("3");

        if u6 then
            u1.OverwriteText[u4] = "IMPACT.";
            local UIScale = u6:FindFirstChild("UIScale");
            UIScale.Scale = 1.25;
            u6.ImageColor3 = Color3.fromRGB(26, 255, 53);
            u1.UITween1 = game:GetService("TweenService"):Create(UIScale, TweenInfo.new(0.85, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                Scale = 1
            });
            u1.UITween1:Play();
            u1.UITween2 = game:GetService("TweenService"):Create(u6, TweenInfo.new(0.85, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ImageColor3 = Color3.fromRGB(255, 255, 255)
            });
            u1.UITween2:Play();
            u3:SetAttribute("KaiserDribbleShot", true);
            u1.KaiserDribbleShot = true;
            local u7 = nil;
            u7 = u3.Values.HasBall:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 45
                -- upvalues: u3 (ref), u2 (ref), u1 (ref), u4 (ref), UIScale (copy), u6 (copy), u7 (ref)
                if not u3.Values.HasBall.Value then
                    if u2.PlayerStats.InAwakening.Value then
                        u1.OverwriteText[u4] = "Magnus";
                    elseif u3.Values.HasBall.Value then
                        u1.OverwriteText[u4] = "Emperor\'s Dribble";
                    else
                        u1.OverwriteText[u4] = "Royal Route";
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
                    u6.ImageColor3 = Color3.fromRGB(255, 255, 255);
                    u1.KaiserDribbleShot = nil;
                    u3:SetAttribute("KaiserDribbleShot", nil);
                    u1:AbilityCooldown(u4, 60);
                    u7:Disconnect();
                    u1.LostBallConnection = nil;
                end;
            end);
            u1.LostBallConnection = u7;
            task.delay(0.85, function() -- Line: 68
                -- upvalues: u1 (ref), u7 (ref), u2 (ref), u4 (ref), u3 (ref)
                if not u1.KaiserDribbleShot then
                    return;
                end;

                if u7 then
                    u7:Disconnect();
                end;

                if u1.LostBallConnection then
                    u1.LostBallConnection = nil;
                end;

                if u2.PlayerStats.InAwakening.Value then
                    u1.OverwriteText[u4] = "Magnus";
                elseif u3.Values.HasBall.Value then
                    u1.OverwriteText[u4] = "Emperor\'s Dribble";
                else
                    u1.OverwriteText[u4] = "Royal Route";
                end;

                u1.UITween2 = nil;
                u1.UITween1 = nil;
                u1.KaiserDribbleShot = nil;
                u3:SetAttribute("KaiserDribbleShot", nil);
                u1:AbilityCooldown(u4, 60);
            end);
        end;
    end);
    u1.ABC:Connect(u1.AbilityService.Ability, function(p8) -- Line: 90
        -- upvalues: u1 (copy), u4 (copy), u5 (ref)
        if p8.State ~= "Failed" then
            if p8.State == "PrepareShot" then
                u5 = false;
                u1.ABC:Clean();
            end;

            return;
        end;

        u1:AbilityCooldown(u4, 60);
        u1.ABC:Clean();
    end);
end;