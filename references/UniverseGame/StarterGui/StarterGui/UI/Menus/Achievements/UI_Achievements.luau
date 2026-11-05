  

 

return function(p1) -- Line: 1
    local _ = game:GetService("Players").LocalPlayer;
    p1.Knit.OnStart():await();
    require(script.AchievementsUI).new(script.Parent, p1):Load();
end;