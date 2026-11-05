  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;

return function(u1, p2, p3, p4, u5, p6, p7, p8, p9, p10) -- Line: 4
    -- upvalues: LocalPlayer (copy)
    local v11 = p6 or false;

    if not u1 or typeof(u1) ~= "Instance" then
        return;
    end;

    local v12 = table.find(p2, LocalPlayer) and true or false;
    local v13 = u1.Parent:IsA("BasePart") and u1.Parent.Position or u1.Parent.WorldPosition;

    if p4 and (v13 and p4 <= (v13 - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude) then
        return;
    end;

    if v12 then
        local v14 = u1:FindFirstAncestorWhichIsA("Model");

        if p8 or p9 then
            for _, child in v14:GetChildren() do
                if child:IsA("Sound") and (child.SoundId == u1.SoundId and child.Name == u1.Name) then
                    if p9 then
                        u1.TimePosition = p7 or 0;
                        u1:Resume();
                    end;

                    if p8 then
                        return;
                    end;

                    break;
                end;
            end;
        end;

        u1:Stop();
        local u15 = u1:Clone();
        u15.Parent = p10 or v14;
        u15.Looped = v11;
        u15.TimePosition = p7 or 0;
        u15:Resume();

        if v11 ~= true and (not p3 or p3 and p3 < 9000000000) then
            task.delay(p3 or u1.TimeLength, function() -- Line: 41
                -- upvalues: u15 (copy)
                task.wait(0.25);
                u15:Destroy();
            end);
        end;

        if u5 then
            u5.AncestryChanged:Once(function() -- Line: 48
                -- upvalues: u5 (copy), u15 (copy)
                if not u5:IsDescendantOf(workspace) then
                    u15:Destroy();
                end;
            end);
        end;
    elseif u1 and u1.Parent then
        u1:Play();

        if u5 then
            u5.AncestryChanged:Once(function() -- Line: 59
                -- upvalues: u5 (copy), u1 (copy)
                if not u5:IsDescendantOf(workspace) then
                    u1:Stop();
                end;
            end);
        end;
    end;
end;