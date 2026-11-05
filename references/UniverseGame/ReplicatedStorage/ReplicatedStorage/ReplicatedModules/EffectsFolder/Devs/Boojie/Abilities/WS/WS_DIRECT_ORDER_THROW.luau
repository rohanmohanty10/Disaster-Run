  

 

local u1 = game.ReplicatedStorage:WaitForChild("Client Assets");

return function(p2, p3) -- Line: 3
    -- upvalues: u1 (copy)
    local v4 = u1.Whitesnake.DirectOrderThrow:Clone();
    v4.CFrame = p2.CFrame * (p3 or CFrame.identity) * CFrame.Angles(0, 3.141592653589793, 0);
    v4.Parent = game.Workspace.Effects;

    for _, descendant in pairs(v4:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
        end;
    end;

    task.wait(1.5);
    v4:Destroy();
end;