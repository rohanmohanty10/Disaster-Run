 

 

local function emit(p1) -- Line: 1
    for _, descendant in p1:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount"));
        end;
    end;
end;

local function enable(p2, p3) -- Line: 9
    for _, descendant in p2:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = p3;
        end;
    end;
end;

local function show(p4, p5) -- Line: 17
    for _, descendant in p4:GetDescendants() do
        if descendant:IsA("MeshPart") then
            descendant.Transparency = p5 and 0 or 1;
        end;
    end;
end;

return {
    { 10, function(p6, p7) -- Line: 27
            -- upvalues: enable (copy), emit (copy)
            local Shoot = p6.Root.Shoot;
            enable(Shoot.ShootEnable, true);
            task.delay(0.15, enable, Shoot.ShootEnable, false);
            emit(Shoot.ShootEmit.SwingShoot);
        end },
    { 19, function(p8, p9) -- Line: 35
            shared.vfx.emit(p8.Root.Shoot.ShootEnable);

            for _, descendant in p9.RightLogic:GetDescendants() do
                if descendant:IsA("MeshPart") then
                    descendant.Transparency = 0;
                end;
            end;

            for _, descendant in p9.LeftLogic:GetDescendants() do
                if descendant:IsA("MeshPart") then
                    descendant.Transparency = 0;
                end;
            end;
        end },
    { 80, function(p10, p11) -- Line: 42
            -- upvalues: emit (copy)
            local Fire = p10.Root.Shoot.ShootEmit.Fire;
            emit(Fire);
            Fire.PointLight.Enabled = true;
            task.delay(0.1, function() -- Line: 46
                -- upvalues: Fire (copy)
                Fire.PointLight.Enabled = false;
            end);
        end },
    { 133, function(p12, p13) -- Line: 52
            shared.vfx.emit(p12.Root.Miss.SwingDown.Right);
        end },
    { 146, function(p14, p15) -- Line: 57
            -- upvalues: emit (copy)
            emit(p14.Root.Shoot.ShootEmit.Desummon.Right);

            for _, descendant in p15.RightLogic:GetDescendants() do
                if descendant:IsA("MeshPart") then
                    descendant.Transparency = 1;
                end;
            end;
        end },
    { 165, function(p16, p17) -- Line: 63
            shared.vfx.emit(p16.Root.Miss.SwingDown.Left);
        end },
    { 172, function(p18, p19) -- Line: 68
            -- upvalues: emit (copy)
            emit(p18.Root.Shoot.ShootEmit.Desummon.Left);

            for _, descendant in p19.LeftLogic:GetDescendants() do
                if descendant:IsA("MeshPart") then
                    descendant.Transparency = 1;
                end;
            end;
        end }
};