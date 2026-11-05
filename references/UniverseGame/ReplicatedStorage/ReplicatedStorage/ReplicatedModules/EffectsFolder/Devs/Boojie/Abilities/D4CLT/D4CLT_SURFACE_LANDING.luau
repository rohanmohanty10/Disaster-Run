  

 

return function(p1, p2) -- Line: 1
    local v3 = nil;
    local v4;

    if typeof(p1) == "CFrame" then
        v4 = p1.Position;
        p2 = p1.LookVector * p2;
    elseif typeof(p1) == "Instance" then
        if p1:IsA("BasePart") then
            v4 = p1.Position;
            v3 = p1;
        elseif p1:IsA("Attachment") then
            v4 = p1.WorldPosition;
            v3 = p1;
        else
            v3 = p1;
            v4 = v3;
            local v5 = v3;
            v3 = v4;
            v5 = v4;
        end;
    else
        v4 = p1;
    end;

    local v6 = RaycastParams.new();
    v6.FilterType = Enum.RaycastFilterType.Whitelist;
    v6.FilterDescendantsInstances = { game.Workspace.Map };
    local v7 = workspace:Raycast(v4, p2, v6);

    if not v7 then
        return;
    end;

    local v8 = CFrame.lookAt(v7.Position, v7.Position - v7.Normal);
    local v9 = game.ReplicatedStorage["Client Assets"]["D4C: Love Train"].HeadBombSurface.Attachment:Clone();
    v9.WorldPosition = v8.Position;
    v9.Parent = workspace.Terrain;

    if v3:FindFirstChildOfClass("Sound") then
        v3:FindFirstChildOfClass("Sound"):Play();
    end;

    for _, descendant in pairs(v9:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            task.spawn(function() -- Line: 36
                -- upvalues: descendant (copy)
                local v10 = descendant:GetAttribute("EmitDelay");

                if v10 and v10 > 0 then
                    task.wait(v10);
                end;

                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end);
        end;
    end;

    task.wait(1);
    v9:Destroy();
end;