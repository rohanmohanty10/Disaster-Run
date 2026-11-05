  

 

return function(p1, p2, p3, p4, p5, p6, p7, p8, p9) -- Line: 1
    p1.Character.Archivable = true;
    local v10 = p1.Character:Clone();
    local Folder = Instance.new("Folder", workspace.Effects);
    Folder.Name = "Clones";

    if v10:FindFirstChild("Stand") then
        v10.Stand:Destroy();
    end;

    v10.Parent = Folder;
    v10.HumanoidRootPart.Anchored = true;
    v10.HumanoidRootPart.CFrame = p2;

    if p9 then
        local Humanoid = v10.Humanoid;
        local Animation = Instance.new("Animation", Humanoid);
        Animation.AnimationId = "rbxassetid://" .. p9.AnimationID;
        local u11 = Humanoid:LoadAnimation(Animation);
        u11.Priority = Enum.AnimationPriority.Action;
        u11:Play();

        if p9.INF then
            coroutine.wrap(function() -- Line: 23
                -- upvalues: u11 (copy)
                wait(u11.Length * 0.9);
                u11:AdjustSpeed(0);
            end)();
        end;
    end;

    if p3 then
        v10.HumanoidRootPart.CFrame = CFrame.new(v10.HumanoidRootPart.Position, p3);
    end;

    game.Debris:AddItem(Folder, p5);

    for _, descendant in pairs(v10:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
        end;

        if descendant:IsA("ParticleEmitter") then
            descendant:Destroy();
        end;
    end;

    if p4 then
        for _, descendant in pairs(v10:GetDescendants()) do
            if descendant:IsA("BasePart") and descendant.Name ~= "HumanoidRootPart" then
                descendant.Transparency = p4;
            end;
        end;
    end;

    if p6 then
        for _, descendant in pairs(v10:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.Color = p6;
            end;
        end;
    end;

    if p7 then
        wait(p5 - 0.1);
        TweenService:Create(v10.HumanoidRootPart, TweenInfo.new(0.1), {
            CFrame = p8
        }):Play();
    end;
end;