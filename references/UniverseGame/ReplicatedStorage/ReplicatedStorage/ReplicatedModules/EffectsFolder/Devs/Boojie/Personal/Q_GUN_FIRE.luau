  

 

local GunHit = script:WaitForChild("Part").GunHit;

return function(p1, p2) -- Line: 3
    -- upvalues: GunHit (copy)
    local v3;

    if typeof(p1) == "CFrame" then
        v3 = workspace.Terrain;
    else
        v3 = p1;
        p1 = p2;
    end;

    local u4 = GunHit:Clone();
    u4.CFrame = p1;
    u4.Parent = v3;

    for _, child in pairs(u4:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            child:Emit(child:GetAttribute("EmitCount") or 1);
        end;
    end;

    task.delay(1, function() -- Line: 19
        -- upvalues: u4 (copy)
        u4:Destroy();
    end);
end;