  

 

return function(p1) -- Line: 1
    local Needle = p1.Character.Stand.Needle;

    for _, child in pairs(Needle:GetChildren()) do
        if child.ClassName == "Beam" then
            child.Enabled = true;
        end;
    end;

    Needle.Transparency = 1;
    local v8 = game:GetService("RunService").RenderStepped:Connect(function(p2) -- Line: 10
        -- upvalues: Needle (copy)
        for _, child in pairs(Needle:GetChildren()) do
            if child.ClassName == "Attachment" then
                local Angles = CFrame.Angles;
                local v3 = math.random(-180, 180);
                local v4 = math.rad(v3);
                local v5 = math.random(-180, 180);
                local v6 = math.rad(v5);
                local v7 = math.random(-180, 180);
                child.CFrame = Angles(v4, v6, (math.rad(v7))) * CFrame.new(0, 0, -math.random(1, 2000) / 150) * CFrame.Angles(1.5707963267948966, 0, 0);
            end;
        end;
    end);
    wait(1.5);
    v8:Disconnect();
    Needle.Transparency = 0;

    for _, child in pairs(Needle:GetChildren()) do
        if child.ClassName == "Beam" then
            child.Enabled = false;
        end;
    end;
end;