 
 

local TweenService = game:GetService("TweenService");
local v1 = {};

local function scaleNumberSequence(p2, p3) -- Line: 5
    local v4 = {};

    for _, v in ipairs(p2.Keypoints) do
        table.insert(v4, NumberSequenceKeypoint.new(v.Time, v.Value * p3, v.Envelope * p3));
    end;

    return NumberSequence.new(v4);
end;

local function scaleNumberRange(p5, p6) -- Line: 19
    return NumberRange.new(p5.Min * p6, p5.Max * p6);
end;

function v1.ResizeParticle(p7, p8, p9) -- Line: 23
    -- upvalues: scaleNumberSequence (copy)
    if not p7:IsA("ParticleEmitter") then
        for _, descendant in ipairs(p7:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Size = scaleNumberSequence(descendant.Size, p8);
                local Speed = descendant.Speed;
                descendant.Speed = NumberRange.new(Speed.Min * p8, Speed.Max * p8);
            end;
        end;

        return;
    end;

    local v10 = scaleNumberSequence(p7.Size, p8);
    local Speed = p7.Speed;
    local NumberRange_new_ret = NumberRange.new(Speed.Min * p8, Speed.Max * p8);

    if p9 then
        return v10, NumberRange_new_ret;
    end;

    p7.Size = v10;
    p7.Speed = NumberRange_new_ret;
end;

function v1.EmitParticles(u11) -- Line: 45
    task.spawn(function() -- Line: 46
        -- upvalues: u11 (copy)
        local function emit(p12) -- Line: 47
            if p12:GetAttribute("EmitDelay") then
                task.wait(p12:GetAttribute("EmitDelay"));
            end;

            p12:Emit(p12:GetAttribute("EmitCount") or 0);
            local Attribute = p12:GetAttribute("EmitDuration");

            if not Attribute then
                return;
            end;

            if not p12:GetAttribute("OriginalRate") then
                p12:SetAttribute("OriginalRate", p12.Rate);
            end;

            p12.Rate = p12:GetAttribute("OriginalRate");
            p12.Enabled = true;
            task.wait(Attribute);
            p12.Enabled = false;
        end;

        if u11:IsA("ParticleEmitter") then
            emit(u11);

            return;
        end;

        for _, descendant in ipairs(u11:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.spawn(function() -- Line: 79
                    -- upvalues: emit (copy), descendant (copy)
                    emit(descendant);
                end);
            end;
        end;
    end);
end;

function v1.ToggleParticle(p13) -- Line: 87
    local function prepare(p14) -- Line: 88
        if not p14:GetAttribute("OriginalRate") then
            p14:SetAttribute("OriginalRate", p14.Rate);
        end;

        p14.Rate = p14:GetAttribute("OriginalRate");
        p14.Enabled = not p14.Enabled;
    end;

    if not p13:IsA("ParticleEmitter") then
        for _, descendant in ipairs(p13:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                if not descendant:GetAttribute("OriginalRate") then
                    descendant:SetAttribute("OriginalRate", descendant.Rate);
                end;

                descendant.Rate = descendant:GetAttribute("OriginalRate");
                descendant.Enabled = not descendant.Enabled;
            end;
        end;

        return;
    end;

    if not p13:GetAttribute("OriginalRate") then
        p13:SetAttribute("OriginalRate", p13.Rate);
    end;

    p13.Rate = p13:GetAttribute("OriginalRate");
    p13.Enabled = not p13.Enabled;
end;

function v1.DisableParticle(p15) -- Line: 109
    if p15:IsA("ParticleEmitter") or p15:IsA("Beam") then
        p15.Enabled = false;

        return;
    end;

    for _, descendant in ipairs(p15:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;
end;

function v1.EnableParticle(p16) -- Line: 122
    local function enable(p17) -- Line: 123
        if not p17:GetAttribute("OriginalRate") then
            p17:SetAttribute("OriginalRate", p17.Rate);
        end;

        p17.Rate = p17:GetAttribute("OriginalRate");
        p17.Enabled = true;
    end;

    if not p16:IsA("ParticleEmitter") then
        for _, descendant in ipairs(p16:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                if not descendant:GetAttribute("OriginalRate") then
                    descendant:SetAttribute("OriginalRate", descendant.Rate);
                end;

                descendant.Rate = descendant:GetAttribute("OriginalRate");
                descendant.Enabled = true;
            end;
        end;

        return;
    end;

    if not p16:GetAttribute("OriginalRate") then
        p16:SetAttribute("OriginalRate", p16.Rate);
    end;

    p16.Rate = p16:GetAttribute("OriginalRate");
    p16.Enabled = true;
end;

function v1.TweenBeams(p18, u19, u20, u21) -- Line: 144
    -- upvalues: TweenService (copy)
    local function fadeBeam(u22) -- Line: 145
        -- upvalues: u19 (copy), TweenService (ref), u21 (copy), u20 (copy)
        u22.Enabled = true;
        u22.TextureSpeed = u19;
        local u23 = {};

        for _, v in ipairs(u22.Transparency.Keypoints) do
            table.insert(u23, v);
        end;

        local NumberValue = Instance.new("NumberValue");
        NumberValue.Value = 0;
        local u25 = NumberValue.Changed:Connect(function() -- Line: 158
            -- upvalues: u23 (copy), NumberValue (copy), u22 (copy)
            local v24 = {};

            for _, v in ipairs(u23) do
                table.insert(v24, NumberSequenceKeypoint.new(v.Time, v.Value + (1 - v.Value) * NumberValue.Value, v.Envelope));
            end;

            u22.Transparency = NumberSequence.new(v24);
        end);
        TweenService:Create(NumberValue, u21, {
            Value = 1
        }):Play();
        TweenService:Create(u22, u21, {
            TextureSpeed = u20 or 0
        }):Play();
        task.delay(u21.Time, function() -- Line: 182
            -- upvalues: u25 (copy), NumberValue (copy)
            u25:Disconnect();
            NumberValue:Destroy();
        end);
    end;

    if p18:IsA("Beam") then
        fadeBeam(p18);

        return;
    end;

    for _, descendant in ipairs(p18:GetDescendants()) do
        if descendant:IsA("Beam") then
            fadeBeam(descendant);
        end;
    end;
end;

function v1.WeldParts(p26, p27) -- Line: 200
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p26;
    WeldConstraint.Part1 = p27;
    WeldConstraint.Parent = p26;

    return WeldConstraint;
end;

return v1;