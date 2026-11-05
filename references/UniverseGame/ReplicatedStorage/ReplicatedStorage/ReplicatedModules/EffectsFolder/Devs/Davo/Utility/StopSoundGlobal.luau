  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;

return function(p1, p2, p3, p4, p5, p6) -- Line: 4
    -- upvalues: LocalPlayer (copy)
    local v7 = table.find(p2, LocalPlayer) and true or false;
    local v8 = p1.Parent:IsA("BasePart") and p1.Parent.Position or p1.Parent.WorldPosition;

    if p3 and (v8 and p3 <= (v8 - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude) then
        return;
    end;

    if not v7 then
        if p1 and p1.Parent then
            p1:Stop();
        end;

        return;
    end;

    if p6 then
        p1:Stop();
    end;

    if p5 then
        p1.TimePosition = p5;
        p1:Resume();
    end;

    for _, child in p1:FindFirstAncestorWhichIsA("Model"):GetChildren() do
        if child:IsA("Sound") and (child.SoundId == p1.SoundId and child.Name == p1.Name) then
            child:Stop();

            if p4 then
                child:Destroy();
            end;
        end;
    end;
end;