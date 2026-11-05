  

 

local u1 = game.ReplicatedStorage:WaitForChild("Client Assets");

return function(p2, p3) -- Line: 3
    -- upvalues: u1 (copy)
    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");
    local HumanoidRootPart2 = p3:FindFirstChild("HumanoidRootPart");
    local Head = p3:FindFirstChild("Head");

    if not (HumanoidRootPart and (HumanoidRootPart2 and Head)) then
        return;
    end;

    local v4, v5, v6 = CFrame.lookAt(HumanoidRootPart2.Position, HumanoidRootPart.Position):ToOrientation();
    local v7 = CFrame.new(Head.Position) * CFrame.Angles(v4, v5, v6) * CFrame.Angles(0, 3.141592653589793, 0);
    local u8 = u1.Whitesnake.Insert:Clone();
    u8.CFrame = v7;
    u8.Parent = game.Workspace.Effects;

    for _, descendant in pairs(u8:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
        end;
    end;

    task.delay(3, function() -- Line: 23
        -- upvalues: u8 (copy)
        u8:Destroy();
    end);
end;