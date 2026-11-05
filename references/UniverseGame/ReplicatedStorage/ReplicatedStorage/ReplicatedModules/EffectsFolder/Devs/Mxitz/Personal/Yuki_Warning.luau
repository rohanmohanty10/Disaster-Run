  

 

local Attachment = script["Warning Indicator"].Attachment;
local u1 = { "ParticleEmitter", "Beam", "Trail", "PointLight", "SpotLight" };

local function Enable(p2, p3) -- Line: 5
    -- upvalues: u1 (copy), Enable (copy)
    local v4;

    if typeof(p2) == "Instance" then
        v4 = p2:GetDescendants();
    else
        v4 = p2;
    end;

    if typeof(p2) == "Instance" and table.find(u1, p2.ClassName) then
        p2.Enabled = p3;
    end;

    for _, v in v4 do
        if typeof(v) == "table" then
            Enable(v, p3);
        elseif table.find(u1, v.ClassName) then
            v.Enabled = p3;
        end;
    end;
end;

local function Emit(p5) -- Line: 25
    -- upvalues: Emit (copy), Enable (copy)
    if typeof(p5) == "Instance" then
        p5 = p5:GetDescendants();
    end;

    for _, v in p5 do
        if typeof(v) == "table" then
            Emit(v);
        elseif table.find({ "ParticleEmitter" }, v.ClassName) then
            task.spawn(function() -- Line: 37
                -- upvalues: v (copy), Enable (ref)
                if v:GetAttribute("EmitDelay") then
                    task.wait(v:GetAttribute("EmitDelay"));
                end;

                v:Emit(v:GetAttribute("EmitCount") or (v:GetAttribute("Rate") or v.Rate));

                if v:GetAttribute("EmitDuration") then
                    Enable(v, true);
                    task.wait((tonumber(v:GetAttribute("EmitDuration"))));
                    Enable(v, false);
                end;
            end);
        end;
    end;
end;

local function GetMaxLifetime(p6) -- Line: 55
    if typeof(p6) == "Instance" and p6:GetAttribute("Lifetime") then
        return p6:GetAttribute("Lifetime");
    end;

    local v7 = 0;

    if typeof(p6) == "Instance" then
        p6 = p6:GetDescendants() or p6;
    end;

    for _, v in p6 do
        if typeof(v) == "Instance" then
            if v:IsA("ParticleEmitter") then
                local v8 = v:GetAttributes();
                local v9 = (v.Lifetime.Max + (v8.EmitDuration or 0) + (v8.EmitDelay or 0)) / v.TimeScale;

                if v8.Lifetime then
                    v9 = math.max(v9, v8.LifeTime);
                end;

                if v7 < v9 and v9 < (1 / 0) then
                    v7 = v9;
                end;
            elseif v:IsA("Sound") then
                local v10 = v.TimeLength / v.PlaybackSpeed;

                if v7 < v10 and v10 < (1 / 0) then
                    v7 = v10;
                end;
            end;
        end;
    end;

    return v7;
end;

return function(p11, p12, p13) -- Line: 96
    -- upvalues: Attachment (copy), Emit (copy), GetMaxLifetime (copy)
    local Head = p11:FindFirstChild("Head");

    if not Head then
        print((`{p11:GetFullName()} has no head`));

        return;
    end;

    local v14 = p12 or 1;
    local v15 = Attachment:Clone();
    v15.Parent = Head;

    if v15:FindFirstChild("Sound") and p13 then
        v15.Sound:Play();
    end;

    for _, descendant in v15:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.Lifetime = NumberRange.new(descendant.Lifetime.Min * v14, descendant.Lifetime.Max * v14);
        end;
    end;

    Emit(v15);
    task.wait(GetMaxLifetime(v15));
    v15:Destroy();
end;