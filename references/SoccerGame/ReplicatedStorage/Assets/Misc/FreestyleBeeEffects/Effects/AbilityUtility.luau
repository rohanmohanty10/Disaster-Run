  

local u1 = {};
local TweenService = game:GetService("TweenService");

function u1.EmitAll(p2, p3) -- Line: 5
    local function Emit(p4) -- Line: 6
        for _, descendant in pairs(p4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                if descendant:GetAttribute("EmitDelay") then
                    task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 10
                        -- upvalues: descendant (copy)
                        descendant:Emit(descendant:GetAttribute("EmitCount"));
                    end);
                else
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end;
    end;

    if typeof(p3) == "table" then
        for _, v in p3 do
            Emit(v);
        end;

        return;
    end;

    Emit(p3);
end;

function u1.AllVFX(p5, p6, p7, p8) -- Line: 31
    local function v12(u9, p10, p11) -- Line: 32
        for _, descendant in ipairs(u9:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("Beam")) then
                descendant.Enabled = p10;
            end;
        end;

        if p11 then
            task.delay(p11, function() -- Line: 40
                -- upvalues: u9 (copy)
                for _, descendant in ipairs(u9:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("Beam")) then
                        descendant.Enabled = false;
                    end;
                end;
            end);
        end;
    end;

    if typeof(p6) == "table" then
        for _, v in p6 do
            v12(v, p7, p8);
        end;

        return;
    end;

    v12(p6, p7, p8);
end;

function u1.Weld(p13, p14, p15, p16, p17) -- Line: 61
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p14;
    WeldConstraint.Part1 = p15;
    WeldConstraint.Part1.CFrame = p16;
    WeldConstraint.Parent = p14;

    if p17 then
        WeldConstraint.Name = p17;
    end;

    return WeldConstraint;
end;

function u1.LightOut(p18, p19, p20) -- Line: 74
    -- upvalues: TweenService (copy)
    for _, descendant in ipairs(p19:GetDescendants()) do
        if descendant:IsA("PointLight") or descendant:IsA("SpotLight") then
            TweenService:Create(descendant, TweenInfo.new(p20), {
                Brightness = 0,
                Range = 0
            }):Play();
        end;
    end;
end;

function u1.LightUp(p21, u22, u23, p24) -- Line: 83
    -- upvalues: TweenService (copy), u1 (copy)
    for _, descendant in ipairs(u22:GetDescendants()) do
        if descendant:IsA("PointLight") or descendant:IsA("SpotLight") then
            local Brightness = descendant.Brightness;
            local Brightness2 = descendant.Brightness;
            descendant.Brightness = 0;
            descendant.Range = 0;
            TweenService:Create(descendant, TweenInfo.new(u23), {
                Brightness = Brightness,
                Range = Brightness2
            }):Play();
        end;
    end;

    if p24 then
        task.delay(p24, function() -- Line: 98
            -- upvalues: u1 (ref), u22 (copy), u23 (copy)
            u1:LightOut(u22, u23);
        end);
    end;
end;

function u1.AutoBeam(p25, p26, u27, p28) -- Line: 104
    -- upvalues: TweenService (copy)
    for _, descendant in ipairs(p26:GetDescendants()) do
        if descendant:IsA("Beam") then
            descendant.Enabled = true;
            local Width0 = descendant.Width0;
            local Width1 = descendant.Width1;
            descendant.Width0 = 0;
            descendant.Width1 = 0;
            TweenService:Create(descendant, TweenInfo.new(u27), {
                Width0 = Width0,
                Width1 = Width1
            }):Play();

            if p28 then
                task.delay(p28, function() -- Line: 118
                    -- upvalues: TweenService (ref), descendant (copy), u27 (copy)
                    TweenService:Create(descendant, TweenInfo.new(u27), {
                        Width0 = 0,
                        Width1 = 0
                    }):Play();
                end);
            end;
        end;
    end;
end;

function u1.KillBeam(p29, p30, p31) -- Line: 127
    -- upvalues: TweenService (copy)
    for _, descendant in ipairs(p30:GetDescendants()) do
        if descendant:IsA("Beam") then
            TweenService:Create(descendant, TweenInfo.new(p31), {
                Width0 = 0,
                Width1 = 0
            }):Play();
        end;
    end;
end;

return u1;