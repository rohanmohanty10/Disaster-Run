  

 

return function(u1) -- Line: 1
    if not u1.HumanoidRootPart then
        return nil;
    end;

    task.spawn(function() -- Line: 4
        -- upvalues: u1 (copy)
        local v2 = game:GetService("ReplicatedStorage")["Client Assets"]["SANS AAAAAAAA"].DodgeText:Clone();
        v2.CFrame = u1.PrimaryPart.CFrame * CFrame.new(math.random(-20, 20) / 20, math.random(-20, 20) / 20 + 3, math.random(-20, 20) / 20);
        v2.Parent = u1;
        game:GetService("TweenService"):Create(v2, TweenInfo.new(1, Enum.EasingStyle.Cubic), {
            CFrame = v2.CFrame * CFrame.new(0, 1, 0)
        }):Play();
        wait(1);
        game:GetService("TweenService"):Create(v2, TweenInfo.new(1, Enum.EasingStyle.Cubic), {
            CFrame = v2.CFrame * CFrame.new(0, -1, 0)
        }):Play();
        game:GetService("TweenService"):Create(v2.GUIObject.ImageLabel, TweenInfo.new(0.5), {
            ImageTransparency = 1
        }):Play();
    end);
end;