 
 

local TypeRegistry = require(script.Parent.TypeRegistry);
local Particles = require(script.Parent.Particles);
local EngineAttr = require(script.Parent.EngineAttr);
local Duration = require(script.Parent.Duration);

local function hasTransformedAncestor(p1, p2) -- Line: 23
    local Parent = p1.Parent;

    while Parent and Parent ~= p2 do
        if Parent:GetAttribute("Transformed") then
            return true;
        end;

        Parent = Parent.Parent;
    end;

    return false;
end;

local function holdsNatives(p3) -- Line: 33
    return p3:IsA("BasePart") or (p3:IsA("Attachment") or p3:IsA("Model"));
end;

local function isNative(p4) -- Line: 37
    return p4:IsA("ParticleEmitter") or (p4:IsA("Trail") or p4:IsA("Beam"));
end;

local function setNativesEnabled(p5, u6) -- Line: 42
    -- upvalues: hasTransformedAncestor (copy)
    for _, descendant in ipairs(p5:GetDescendants()) do
        if (descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("Beam"))) and not (descendant:GetAttribute("Transformed") or hasTransformedAncestor(descendant, p5)) then
            pcall(function() -- Line: 47
                -- upvalues: descendant (copy), u6 (copy)
                descendant.Enabled = u6;
            end);
        end;
    end;
end;

return function(p7) -- Line: 52
    -- upvalues: Particles (copy), Duration (copy), EngineAttr (copy), TypeRegistry (copy), setNativesEnabled (copy)
    function p7._absoluteEmitFire(p8, u9, p10, p11) -- Line: 57
        -- upvalues: Particles (ref)
        if u9:GetAttribute("Transformed") then
            p8:EnableEmit(u9, nil, p11);

            return;
        end;

        local u12 = p8:_makeAliveCheck();

        if u9:IsA("ParticleEmitter") then
            if p10 then
                return;
            end;

            Particles.fireEmitter(u9, u12);

            return;
        end;

        if u9:IsA("Trail") then
            if p10 then
                return;
            end;

            Particles.EnableEmitSingle(u9, u12);

            return;
        end;

        if u9:IsA("Beam") then
            if p10 then
                return;
            end;

            local u13 = tonumber(u9:GetAttribute("EmitDuration")) or 0;
            local v14 = tonumber(u9:GetAttribute("EmitDelay")) or 0;

            if u13 > 0 then
                local u15 = Particles.ReadNativeGen(u9);

                local function doEmit() -- Line: 88
                    -- upvalues: u12 (copy), Particles (ref), u9 (copy), u15 (copy), u13 (copy)
                    if not (u12() and Particles.IsNativeGenCurrent(u9, u15)) then
                        return;
                    end;

                    Particles.SetEnabledForDuration(u9, u13);
                end;

                if v14 > 0 then
                    task.delay(v14, doEmit);

                    return;
                end;

                if u12() then
                    if not Particles.IsNativeGenCurrent(u9, u15) then
                        return;
                    end;

                    Particles.SetEnabledForDuration(u9, u13);
                end;
            end;

            return;
        end;

        local v16 = (u9:IsA("BasePart") or (u9:IsA("Attachment") or u9:IsA("Model"))) and not p10;

        if v16 then
            Particles.EnableEmit(u9, u12);
        end;

        local v17 = v16 or p10;

        for _, child in u9:GetChildren() do
            p8:_absoluteEmitFire(child, v17, p11);
        end;
    end;

    function p7.AbsoluteEmit(p18, p19, p20, p21) -- Line: 110
        -- upvalues: Duration (ref)
        p18:_warnIfNotActivated("AbsoluteEmit");

        if not p19 then
            return 0;
        end;

        p18:_absoluteEmitFire(p19, p20, p21);

        return Duration.computeMaxDuration(p19, 0);
    end;

    function p7.AbsoluteEnable(p22, u23, p24) -- Line: 119
        -- upvalues: EngineAttr (ref), TypeRegistry (ref), setNativesEnabled (ref)
        if not u23 then
            return;
        end;

        if u23:GetAttribute("Transformed") then
            EngineAttr.write(u23, "_PartIclePlaying", true);
            local Config = TypeRegistry.getConfig(u23);

            if Config then
                EngineAttr.write(Config, "Enabled", true);
            end;

            p22:Enable(u23, nil, (1 / 0));

            return;
        end;

        if u23:IsA("ParticleEmitter") or (u23:IsA("Trail") or u23:IsA("Beam")) then
            if p24 then
                return;
            end;

            pcall(function() -- Line: 132
                -- upvalues: u23 (copy)
                u23.Enabled = true;
            end);

            return;
        end;

        local v25 = (u23:IsA("BasePart") or (u23:IsA("Attachment") or u23:IsA("Model"))) and not p24;

        if v25 then
            setNativesEnabled(u23, true);
        end;

        local v26 = v25 or p24;

        for _, child in u23:GetChildren() do
            p22:AbsoluteEnable(child, v26);
        end;
    end;

    function p7.AbsoluteDisable(p27, u28, p29) -- Line: 146
        -- upvalues: setNativesEnabled (ref)
        if not u28 then
            return;
        end;

        if u28:GetAttribute("Transformed") then
            p27:SoftDisable(u28);

            return;
        end;

        if u28:IsA("ParticleEmitter") or (u28:IsA("Trail") or u28:IsA("Beam")) then
            if p29 then
                return;
            end;

            pcall(function() -- Line: 154
                -- upvalues: u28 (copy)
                u28.Enabled = false;
            end);

            return;
        end;

        local v30 = (u28:IsA("BasePart") or (u28:IsA("Attachment") or u28:IsA("Model"))) and not p29;

        if v30 then
            setNativesEnabled(u28, false);
        end;

        local v31 = v30 or p29;

        for _, child in u28:GetChildren() do
            p27:AbsoluteDisable(child, v31);
        end;
    end;

    function p7.AbsoluteSetTimescale(p32, p33, p34, p35, p36) -- Line: 166
        if not p33 then
            return;
        end;

        if p33:GetAttribute("Transformed") or p33:IsA("ParticleEmitter") then
            p32:SetTimescale(p33, p34, p35, p36);

            return;
        end;

        for _, child in p33:GetChildren() do
            p32:AbsoluteSetTimescale(child, p34, p35, p36);
        end;
    end;

    function p7.AbsoluteClearTimescale(p37, p38) -- Line: 178
        if not p38 then
            return;
        end;

        if p38:GetAttribute("Transformed") or p38:IsA("ParticleEmitter") then
            p37:ClearTimescale(p38);

            return;
        end;

        for _, child in p38:GetChildren() do
            p37:AbsoluteClearTimescale(child);
        end;
    end;
end;