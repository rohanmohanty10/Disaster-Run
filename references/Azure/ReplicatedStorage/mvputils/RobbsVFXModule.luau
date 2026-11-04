 

 

local v1 = {};
local TweenService = game:GetService("TweenService");

local function getVFX(p2) -- Line: 5
    local v3 = {};
    local v4 = {};

    for _, descendant in ipairs(p2:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            table.insert(v3, descendant);
        elseif descendant:IsA("Trail") then
            table.insert(v4, descendant);
        end;
    end;

    return v3, v4;
end;

function v1.Emit(p5, p6) -- Line: 20
    for _, descendant in ipairs(p5:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            local u7 = descendant:GetAttribute("EmitCount") or 1;
            local v8 = descendant:GetAttribute("EmitDelay") or 0;
            task.delay(v8, function() -- Line: 28
                -- upvalues: descendant (copy), u7 (copy)
                if descendant then
                    descendant:Emit(u7);
                end;
            end);
        end;
    end;
end;

function v1.EnableParticles(p9, p10) -- Line: 38
    -- upvalues: getVFX (copy)
    local Duration = (p10 or {}).Duration;
    local u11 = getVFX(p9);

    for _, v in ipairs(u11) do
        v.Enabled = true;
    end;

    if Duration then
        task.delay(Duration, function() -- Line: 49
            -- upvalues: u11 (copy)
            for _, v in ipairs(u11) do
                if v then
                    v.Enabled = false;
                end;
            end;
        end);
    end;
end;

function v1.EnableTrails(p12, p13) -- Line: 59
    -- upvalues: getVFX (copy)
    local Duration = (p13 or {}).Duration;
    local _, u14 = getVFX(p12);

    for _, v in ipairs(u14) do
        v.Enabled = true;
    end;

    if Duration then
        task.delay(Duration, function() -- Line: 70
            -- upvalues: u14 (copy)
            for _, v in ipairs(u14) do
                if v then
                    v.Enabled = false;
                end;
            end;
        end);
    end;
end;

function v1.DisableAll(p15) -- Line: 80
    -- upvalues: getVFX (copy)
    local v16, v17 = getVFX(p15);

    for _, v in ipairs(v16) do
        v.Enabled = false;
    end;

    for _, v in ipairs(v17) do
        v.Enabled = false;
    end;
end;

function v1.TweenTransparency(p18, p19) -- Line: 92
    -- upvalues: TweenService (copy)
    local v20 = p19 or {};
    local v21 = v20.Target or 0;
    local v22 = v20.FadeIn or 0.5;
    local u23 = v20.Hold or 2;
    local v24 = v20.FadeOut or 0.5;
    local v25 = v20.EasingStyle or Enum.EasingStyle.Linear;
    local v26 = v20.EasingDirection or Enum.EasingDirection.Out;

    if typeof(p18) == "string" then
        p18 = workspace:WaitForChild(p18, 5);

        if not p18 then
            return;
        end;
    elseif typeof(p18) ~= "Instance" then
        return;
    end;

    local v27 = {};

    if p18:IsA("BasePart") then
        table.insert(v27, p18);
    elseif p18:IsA("Model") then
        for _, descendant in ipairs(p18:GetDescendants()) do
            if descendant:IsA("BasePart") then
                table.insert(v27, descendant);
            end;
        end;
    end;

    if #v27 == 0 then
        return;
    end;

    for _, v in ipairs(v27) do
        local u28 = TweenService:Create(v, TweenInfo.new(v22, v25, v26), {
            Transparency = v21
        });
        local u29 = TweenService:Create(v, TweenInfo.new(v24, v25, Enum.EasingDirection.In), {
            Transparency = 1
        });
        u28:Play();
        task.spawn(function() -- Line: 143
            -- upvalues: u28 (copy), u23 (copy), u29 (copy)
            u28.Completed:Wait();
            task.wait(u23);
            u29:Play();
        end);
    end;
end;

function v1.EmitForDuration(p30, p31) -- Line: 151
    local v32 = p31 or {};
    local v33 = v32.Duration or 0.1;
    local v34 = v32.Interval or 0.03;
    local v35 = {};

    for _, descendant in ipairs(p30:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            table.insert(v35, descendant);
        end;
    end;

    local v36 = tick();

    while tick() - v36 < v33 do
        for _, v in ipairs(v35) do
            if v then
                local Attribute = v:GetAttribute("EmitCount");

                if Attribute and Attribute > 0 then
                    v:Emit(Attribute);
                end;
            end;
        end;

        task.wait(v34);
    end;
end;

function v1.EmitFreeze(p37, p38) -- Line: 182
    local v39 = p38 or {};
    local v40 = v39.PreDelay or 0.05;
    local v41 = v39.FreezeTime or 0.25;
    local v42 = v39.FreezeScale or 0.3;
    local v43 = v39.ResumeScale or 1;
    local v44 = {};

    for _, descendant in ipairs(p37:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            table.insert(v44, descendant);
        end;
    end;

    for _, v in ipairs(v44) do
        local Attribute = v:GetAttribute("EmitCount");

        if Attribute and Attribute > 0 then
            v:Emit(Attribute);
        end;
    end;

    task.wait(v40);

    for _, v in ipairs(v44) do
        if v then
            v.TimeScale = v42;
        end;
    end;

    task.wait(v41);

    for _, v in ipairs(v44) do
        if v then
            v.TimeScale = v43;
        end;
    end;
end;

return v1;