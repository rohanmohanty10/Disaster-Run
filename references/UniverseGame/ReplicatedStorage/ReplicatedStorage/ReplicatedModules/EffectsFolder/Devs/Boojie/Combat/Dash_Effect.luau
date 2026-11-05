  

 

local u1 = game.ReplicatedStorage:WaitForChild("Client Assets");

return function(p2, p3, p4, p5, p6, p7) -- Line: 10
    -- upvalues: u1 (copy)
    if not p2 then
        return;
    end;

    local v8 = p2:FindFirstChildOfClass("Humanoid");
    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and v8) then
        return;
    end;

    if v8.FloorMaterial == Enum.Material.Air and p7 ~= false then
        return;
    end;

    if p3 == Vector3.new(0, 0, 0) then
        p3 = nil;
    end;

    local v9 = HumanoidRootPart.CFrame + Vector3.new(0, -2.5, 0);
    local v10;

    if p4 then
        v10 = p4:Clone();
    else
        v10 = u1.Combat.Dash:Clone();
    end;

    if p3 then
        v9 = CFrame.lookAt(v9.Position, v9.Position + (p3 or Vector3.new(0, 0, 0))) or v9;
    end;

    v10.CFrame = v9;
    v10.Parent = workspace.Effects;

    if p5 then
        v10.CFrame = v10.CFrame * p5;
    end;

    for _, descendant in pairs(v10:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
        end;
    end;

    task.wait(p6 or 0.75);
    v10:Destroy();
end;