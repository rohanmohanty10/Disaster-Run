  

 

local u1 = {};
game:GetService("RunService");
local KeyframeSequenceProvider = game:GetService("KeyframeSequenceProvider");

function u1.lfThread() -- Line: 11
end;

function u1.synchronize(p2) -- Line: 34
end;

function u1.desynchronize(p3) -- Line: 39
end;

function u1.disconnectTable(p4) -- Line: 44
    for i, v in pairs(p4) do
        if typeof(v) == "RBXScriptConnection" then
            v:Disconnect();
        elseif typeof(v) == "thread" then
            task.cancel(v);
        elseif typeof(v) == "Instance" then
            v:Destroy();
        end;

        p4[i] = nil;
    end;

    return p4;
end;

function u1.deepCopy(p5) -- Line: 58
    -- upvalues: u1 (copy)
    local v6 = {};

    for i, v in pairs(p5) do
        if type(v) == "table" then
            local v = u1.deepCopy(v) or v;
        end;

        v6[i] = v;
    end;

    return v6;
end;

function u1.getAllMarker(p7) -- Line: 66
    -- upvalues: KeyframeSequenceProvider (copy)
    local u8 = {};

    local function recurse(p9) -- Line: 69
        -- upvalues: u8 (copy), recurse (copy)
        for _, child in pairs(p9:GetChildren()) do
            if child:IsA("KeyframeMarker") then
                table.insert(u8, child);
            end;

            if #child:GetChildren() > 0 then
                recurse(child);
            end;
        end;
    end;

    recurse((KeyframeSequenceProvider:GetKeyframeSequenceAsync(p7)));

    return u8;
end;

function u1.getOrigin(p10) -- Line: 84
    if not (p10 and p10.Origin) then
        return nil;
    end;

    if typeof(p10.Origin) == "Instance" and p10.Origin:IsA("BasePart") then
        return p10.Origin.Position;
    end;

    if typeof(p10.Origin) == "Instance" and p10.Origin:IsA("Model") then
        return p10.Origin:GetPivot().Position;
    end;

    if typeof(p10.Origin) == "Instance" and p10.Origin:IsA("Attachment") then
        return p10.Origin.WorldPosition;
    end;

    if typeof(p10.Origin) == "CFrame" then
        return p10.Origin.Position;
    end;

    if typeof(p10.Origin) == "Vector3" then
        return p10.Origin;
    end;

    return nil;
end;

function u1.getLifetime(p11) -- Line: 95
    -- upvalues: u1 (copy)
    u1.desynchronize();
    local v12 = 0;

    for _, descendant in ipairs(p11:GetDescendants()) do
        if table.find({ "ParticleEmitter", "Trail" }, descendant.ClassName) then
            local v13 = descendant:GetAttributes();
            local v14 = v13.EmitDuration or 0;
            local _ = v13.EmitDelay or 0;
            local v15;

            if descendant:IsA("ParticleEmitter") then
                v15 = (descendant.Lifetime.Max + v14 + v14) / descendant.TimeScale;
            else
                v15 = descendant.Lifetime;
            end;

            if v13.LifeTime then
                v15 = math.max(v15, v13.LifeTime);
            end;

            if v12 < v15 and v15 < 1000000000 then
                v12 = v15;
            end;
        end;
    end;

    u1.synchronize();

    return v12;
end;

function u1.factorial(p16) -- Line: 123
    if p16 == 0 then
        return 1;
    end;

    local v17 = 1;

    for i = 2, p16 do
        v17 = v17 * i;
    end;

    return v17;
end;

function u1.comb(p18, p19) -- Line: 132
    -- upvalues: u1 (copy)
    return p18 < p19 and 0 or u1.factorial(p18) / (u1.factorial(p19) * u1.factorial(p18 - p19));
end;

function u1.bezier(p20, p21) -- Line: 137
    -- upvalues: u1 (copy)
    u1.desynchronize();
    local v22 = #p21;
    local v23 = Vector3.new(0, 0, 0);

    for i = 1, v22 do
        v23 = v23 + u1.comb(v22 - 1, i - 1) * (1 - p20) ^ (v22 - i) * p20 ^ (i - 1) * p21[i];
    end;

    u1.synchronize();

    return v23;
end;

return u1;