  

 

return function(p1, p2, p3) -- Line: 1
    local v4 = p3 and TweenInfo.new(unpack(p3)) or TweenInfo.new(0.1, Enum.EasingStyle.Sine);
    game:GetService("TweenService"):Create(p1, v4, {
        CFrame = p1.CFrame * p2
    }):Play();
end;