  

 

local KnitPackage = game.ReplicatedStorage.ReplicatedModules.KnitPackage;
local Trove = require(KnitPackage.Trove);
local Timer = require(KnitPackage.Timer);
local RunService = game:GetService("RunService");
local u1 = RunService:IsServer() and RunService.Heartbeat or RunService.RenderStepped;

local function GenerateCode(p2) -- Line: 11
    local v3 = "";

    for _ = 1, (type(p2) ~= "number" or (p2 < 5 or not p2)) and 5 or p2 do
        v3 = v3 .. string.char(math.random(65, 90));
    end;

    return v3;
end;

local u4 = {};
u4.__index = u4;

local function ChangeProperties(p5, p6) -- Line: 23
    for i, v in pairs(p6) do
        p5[i] = v;
    end;
end;

function u4.new(p7) -- Line: 29
    -- upvalues: Trove (copy), GenerateCode (copy), u4 (copy)
    local v8 = {
        Object = p7.Particle or p7.Object,
        Particle = p7.Particle or p7.Object,
        ParticleInfo = p7.ParticleInfo,
        SkinName = p7.SkinName,
        Cache = {},
        Trove = Trove.new()
    };

    if p7.AutoSerialize and not v8.ParticleInfo then
        v8.ParticleInfo = {};

        for _, descendant in ipairs(v8.Particle:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                local v9 = GenerateCode(5);
                descendant.Name = v9;
                v8.ParticleInfo[v9] = {
                    State = "Emit",
                    Emit = descendant:GetAttribute("EmitCount") or 16
                };
            end;
        end;
    end;

    if v8.ParticleInfo then
        local SkinName = v8.SkinName;

        for i, v in pairs(v8.ParticleInfo) do
            local v10 = v8.Particle:FindFirstChild(v.ActualName or i, true);

            if v.AlternateProperties and v.AlternateProperties[SkinName] then
                for i2, v2 in pairs(v.AlternateProperties[SkinName]) do
                    v10[i2] = v2;
                end;
            end;
        end;

        setmetatable(v8, u4);

        return v8;
    end;

    v8.Trove:Destroy();
    warn(debug.traceback("No particleinfo found"));
end;

function u4.Emit(p11) -- Line: 68
    local SkinName = p11.SkinName;
    local v12 = p11.Particle or p11.Object;

    for i, v in pairs(p11.ParticleInfo) do
        local u13 = v12:FindFirstChild(v.ActualName or i, true);

        if u13 then
            if v.AlternateProperties and v.AlternateProperties[SkinName] then
                for i2, v2 in pairs(v.AlternateProperties[SkinName]) do
                    u13[i2] = v2;
                end;
            end;

            if type(v.Delay) == "number" then
                task.delay(v.Delay, function() -- Line: 78
                    -- upvalues: u13 (copy), v (copy)
                    u13:Emit(v.Emit);
                end);
            else
                u13:Emit(v.Emit);
            end;
        end;
    end;
end;

function u4.AttachTo(p14, p15) -- Line: 87
    if p14.Particle:IsA("BasePart") then
        p14.Particle.CanCollide = false;
        p14.Particle.Anchored = false;
        local Weld = Instance.new("Weld");
        Weld.Part0 = p14.Particle;
        Weld.Part1 = p15;
        Weld.Parent = p14.Particle;
    end;
end;

function u4.Goto(p16, p17) -- Line: 98
    if p16.Particle:IsA("BasePart") then
        p16.Particle.CanCollide = false;
        p16.Particle.Anchored = true;

        if typeof(p17) == "CFrame" then
            p16.Particle.CFrame = p17;

            return;
        end;

        if typeof(p17) == "Vector3" then
            p16.Particle.CFrame = CFrame.new(p17);
        end;
    end;
end;

function u4._StartParticle(u18, u19, u20, u21) -- Line: 110
    -- upvalues: Timer (copy), u1 (copy)
    local function StartParticle() -- Line: 111
        -- upvalues: u21 (copy), u20 (copy), u18 (copy), u19 (copy), Timer (ref), u1 (ref)
        if u21.State == "Emit" and type(u21.Emit) == "number" then
            u20:Emit(u21.Emit);

            if type(u21.Interval) == "number" then
                u18.Cache[u19] = u18.Trove:Add(Timer.Simple(u21.Interval, function() -- Line: 116
                    -- upvalues: u20 (ref), u21 (ref)
                    u20:Emit(u21.Emit);
                end, false, u1, os.clock));
            end;
        elseif u21.State == "Toggle" then
            u18.Cache[u19] = u20;
            u20.Enabled = true;
        end;
    end;

    if type(u21.Delay) == "number" then
        task.delay(u21.Delay, StartParticle);

        return;
    end;

    StartParticle();
end;

function u4.Start(p22, p23) -- Line: 129
    if p22.Started then
        return;
    end;

    p22.Started = true;
    local v24 = p23 or {};
    local v25 = tostring(v24.Stage);

    if not v24.NoParent then
        p22.Particle.Parent = workspace.Effects;
    end;

    for i, v in pairs(p22.ParticleInfo) do
        if not v.Stages or v.Stages[v25] then
            p22:_StartParticle(i, p22.Particle:FindFirstChild(v.ActualName or i, true), v);
        end;
    end;
end;

function u4.ChangeStage(p26, p27) -- Line: 143
    if not p26.Started then
        return;
    end;

    local v28 = tostring(p27);

    for i, v in pairs(p26.ParticleInfo) do
        local v29 = p26.Particle:FindFirstChild(v.ActualName or i, true);
        local v30 = p26.Cache[i];

        if type(v.Stages) == "table" then
            if v.Stages[v28] and not v30 then
                p26:_StartParticle(i, v29, v);
            elseif not v.Stages[v28] and v30 then
                if typeof(v30) == "Instance" then
                    v30.Enabled = false;
                    p26.Cache[i] = nil;
                elseif typeof(v30) == "RBXScriptConnection" then
                    p26.Trove:Remove(v30);
                    p26.Cache[i] = nil;
                end;
            end;
        else
            if typeof(v30) == "RBXScriptConnection" then
                p26.Trove:Remove(v30);
                p26.Cache[i] = nil;
            end;

            p26:_StartParticle(i, v29, v);
        end;
    end;
end;

function u4.Restart(p31, p32) -- Line: 174
    if not p31.Started then
        return;
    end;

    local v33 = tostring(p32);
    p31.Trove:Clean();
    table.clear(p31.Cache);

    for i, v in pairs(p31.ParticleInfo) do
        if not v.Stages or v.Stages[v33] then
            p31:_StartParticle(i, p31.Particle:FindFirstChild(v.ActualName or i, true), v);
        end;
    end;
end;

function u4.GetObject(p34) -- Line: 187
    return p34.Object;
end;

function u4.Destroy(p35) -- Line: 191
    local v36 = 0;

    for _, descendant in ipairs(p35.Particle:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
            local v37 = descendant.Lifetime.Max / descendant.TimeScale;

            if descendant:GetAttribute("Lifetime") then
                v37 = math.max(v37, descendant:GetAttribute("Lifetime"));
            end;

            if v36 < v37 and v37 < (1 / 0) then
                v36 = v37;
            end;
        end;
    end;

    p35.Trove:Destroy();
    task.delay(v36, p35.Particle.Destroy, p35.Particle);
    table.clear(p35.Cache);
    table.clear(p35);
end;

return u4;