 
 

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
            local Miss = p6.Root.Miss;
            enable(Miss.MissEnable, true);
            task.delay(0.15, enable, Miss.MissEnable, false);
            emit(Miss.MissEmit.SwingMiss);
        end },
    { 20, function(p8, p9) -- Line: 35
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
    { 129, function(p10, p11) -- Line: 41
            -- upvalues: emit (copy)
            emit(p10.Root.Miss.SwingDown);
        end },
    { 132, function(p12, p13) -- Line: 46
            -- upvalues: emit (copy)
            emit(p12.Root.Miss.Collision);
            emit(p12.Collision);
        end },
    { 148, function(p14, p15) -- Line: 52
            -- upvalues: emit (copy)
            emit(p14.Root.Miss.MissEmit.Desummon);

            for _, descendant in p15.RightLogic:GetDescendants() do
                if descendant:IsA("MeshPart") then
                    descendant.Transparency = 1;
                end;
            end;

            for _, descendant in p15.LeftLogic:GetDescendants() do
                if descendant:IsA("MeshPart") then
                    descendant.Transparency = 1;
                end;
            end;
        end }
};