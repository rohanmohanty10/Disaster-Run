 

 

local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
local v1 = {};

local function isModel(p2: userdata) -- Line: 9
    if p2 then
        p2 = p2:IsA("Model");
    end;

    return p2;
end;

local function setCFrameFlexible(p3: userdata, p4) -- Line: 13
    local v5;

    if p3 then
        v5 = p3:IsA("Model");
    else
        v5 = p3;
    end;

    if v5 then
        p3:PivotTo(p4);

        return;
    end;

    p3.CFrame = p4;
end;

local function createSparkPart(p6) -- Line: 21
    local v7 = nil;

    if typeof(p6.Template) == "Instance" and p6.Template:IsA("BasePart") then
        v7 = p6.Template;
    elseif typeof(p6.TemplateName) == "string" then
        v7 = script:FindFirstChild(p6.TemplateName);
    end;

    if not v7 then
        for _, child in ipairs(script:GetChildren()) do
            if child:IsA("BasePart") and child:FindFirstChildWhichIsA("Trail", true) then
                v7 = child;
                break;
            end;
        end;
    end;

    assert(v7, "SparkModule: No spark template found (MeshPart with Trail missing).");
    local v8 = v7:Clone();

    local function cleanProps(p9) -- Line: 44
        if p9:IsA("BasePart") then
            p9.Anchored = true;
            p9.CanCollide = false;
            p9.CanQuery = false;
            p9.CanTouch = false;
            p9.Massless = true;
            p9.CastShadow = false;
        end;
    end;

    if v8:IsA("BasePart") then
        v8.Anchored = true;
        v8.CanCollide = false;
        v8.CanQuery = false;
        v8.CanTouch = false;
        v8.Massless = true;
        v8.CastShadow = false;
    end;

    for _, descendant in ipairs(v8:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
            descendant.Massless = true;
            descendant.CastShadow = false;
        end;
    end;

    return v8;
end;

local function reflect(p10, p11, p12) -- Line: 63
    local v13 = p10:Dot(p11);

    return p10 - (1 + p12) * v13 * p11;
end;

local function simulateSpark(u14) -- Line: 68
    -- upvalues: RunService (copy), Debris (copy)
    local u15 = nil;
    u15 = RunService.Heartbeat:Connect(function(p16) -- Line: 70
        -- upvalues: u14 (copy), u15 (ref), Debris (ref)
        local v17 = u14;
        v17.age = v17.age + p16;

        if not (u14.p and u14.p.Parent) then
            u15:Disconnect();

            return;
        end;

        if u14.age >= u14.life then
            u15:Disconnect();
            Debris:AddItem(u14.p, u14.fade or 0.1);

            return;
        end;

        local v18 = u14;
        v18.vel = v18.vel + Vector3.new(0, -u14.gravity, 0) * p16;
        local v19 = u14;
        v19.vel = v19.vel * math.max(0, 1 - u14.drag * p16);
        local v20 = u14.pos + u14.vel * p16;
        local v21 = v20 - u14.pos;
        local v22;

        if v21.Magnitude > 0 then
            v22 = workspace:Raycast(u14.pos, v21, u14.rayParams);
        else
            v22 = nil;
        end;

        if v22 then
            local Normal = v22.Normal;
            u14.pos = v22.Position + Normal * 0.02;
            local vel = u14.vel;
            local bounciness = u14.bounciness;
            local v23 = vel:Dot(Normal);
            u14.vel = vel - (1 + bounciness) * v23 * Normal;
            local v24 = u14.vel:Dot(Normal);
            u14.vel = Normal * v24 + (u14.vel - Normal * v24) * (1 - u14.friction);
            local v25 = u14;
            v25.bounces = v25.bounces + 1;

            if u14.bounces >= u14.maxBounces then
                u15:Disconnect();
                Debris:AddItem(u14.p, u14.fade or 0.1);

                return;
            end;
        else
            u14.pos = v20;
        end;

        if u14.vel.Magnitude < u14.minSpeed then
            u15:Disconnect();
            Debris:AddItem(u14.p, u14.fade or 0.1);

            return;
        end;

        local p = u14.p;
        local CFrame_new_ret = CFrame.new(u14.pos, u14.pos + (u14.vel.Magnitude > 0 and u14.vel.Unit or Vector3.new(0, 1, 0)));
        local v26;

        if p then
            v26 = p:IsA("Model");
        else
            v26 = p;
        end;

        if v26 then
            p:PivotTo(CFrame_new_ret);

            return;
        end;

        p.CFrame = CFrame_new_ret;
    end);
end;

local function emitOne(p27, p28, p29, p30, p31) -- Line: 105
    -- upvalues: createSparkPart (copy), RunService (copy), Debris (copy)
    if typeof(p29) == "string" then
        local v32 = p29:lower();

        if v32 == "up" then
            p29 = Vector3.new(0, 1, 0);
        elseif v32 == "down" then
            p29 = Vector3.new(0, -1, 0);
        elseif v32 == "left" then
            p29 = Vector3.new(-1, 0, 0);
        elseif v32 == "right" then
            p29 = Vector3.new(1, 0, 0);
        elseif v32 == "front" then
            p29 = Vector3.new(0, 0, -1);
        elseif v32 == "back" then
            p29 = Vector3.new(0, 0, 1);
        elseif v32 == "all" then
            local v33 = math.random() - 0.5;
            local v34 = math.random() - 0.5;
            local v35 = math.random() - 0.5;
            p29 = Vector3.new(v33, v34, v35).Unit;
        else
            p29 = Vector3.new(0, 1, 0);
        end;
    end;

    local v36 = math.random() * ((p27.SpeedMax or 55) - (p27.SpeedMin or 35)) + (p27.SpeedMin or 35);
    local math_rad_ret = math.rad(p27.SpreadAngle or 25);
    local CFrame_fromEulerAnglesXYZ_ret = CFrame.fromEulerAnglesXYZ((math.random() - 0.5) * math_rad_ret, (math.random() - 0.5) * math_rad_ret, (math.random() - 0.5) * math_rad_ret);
    local LookVector = (CFrame.lookAt(Vector3.new(0, 0, 0), p29) * CFrame_fromEulerAnglesXYZ_ret).LookVector;
    local v37 = createSparkPart(p27);
    local v38;

    if v37 then
        v38 = v37:IsA("Model");
    else
        v38 = v37;
    end;

    if v38 then
        v37:PivotTo(p28);
    else
        v37.CFrame = p28;
    end;

    v37.Parent = p30;
    local u39 = {
        age = 0,
        bounces = 0,
        p = v37,
        pos = p28.Position,
        vel = LookVector * v36,
        life = p27.Lifetime or 0.6,
        gravity = p27.Gravity or workspace.Gravity,
        drag = p27.Drag or 1.5,
        bounciness = p27.Bounciness or 0.45,
        friction = p27.Friction or 0.2,
        minSpeed = p27.MinSpeed or 1.5,
        maxBounces = p27.MaxBounces or 5,
        fade = p27.FadeTime or 0.1,
        rayParams = p31
    };
    local u40 = nil;
    u40 = RunService.Heartbeat:Connect(function(p41) -- Line: 70
        -- upvalues: u39 (copy), u40 (ref), Debris (ref)
        local v42 = u39;
        v42.age = v42.age + p41;

        if not (u39.p and u39.p.Parent) then
            u40:Disconnect();

            return;
        end;

        if u39.age >= u39.life then
            u40:Disconnect();
            Debris:AddItem(u39.p, u39.fade or 0.1);

            return;
        end;

        local v43 = u39;
        v43.vel = v43.vel + Vector3.new(0, -u39.gravity, 0) * p41;
        local v44 = u39;
        v44.vel = v44.vel * math.max(0, 1 - u39.drag * p41);
        local v45 = u39.pos + u39.vel * p41;
        local v46 = v45 - u39.pos;
        local v47;

        if v46.Magnitude > 0 then
            v47 = workspace:Raycast(u39.pos, v46, u39.rayParams);
        else
            v47 = nil;
        end;

        if v47 then
            local Normal = v47.Normal;
            u39.pos = v47.Position + Normal * 0.02;
            local vel = u39.vel;
            local bounciness = u39.bounciness;
            local v48 = vel:Dot(Normal);
            u39.vel = vel - (1 + bounciness) * v48 * Normal;
            local v49 = u39.vel:Dot(Normal);
            u39.vel = Normal * v49 + (u39.vel - Normal * v49) * (1 - u39.friction);
            local v50 = u39;
            v50.bounces = v50.bounces + 1;

            if u39.bounces >= u39.maxBounces then
                u40:Disconnect();
                Debris:AddItem(u39.p, u39.fade or 0.1);

                return;
            end;
        else
            u39.pos = v45;
        end;

        if u39.vel.Magnitude < u39.minSpeed then
            u40:Disconnect();
            Debris:AddItem(u39.p, u39.fade or 0.1);

            return;
        end;

        local p = u39.p;
        local CFrame_new_ret = CFrame.new(u39.pos, u39.pos + (u39.vel.Magnitude > 0 and u39.vel.Unit or Vector3.new(0, 1, 0)));
        local v51;

        if p then
            v51 = p:IsA("Model");
        else
            v51 = p;
        end;

        if v51 then
            p:PivotTo(CFrame_new_ret);

            return;
        end;

        p.CFrame = CFrame_new_ret;
    end);
end;

function v1.Emit(p52) -- Line: 155
    -- upvalues: emitOne (copy), RunService (copy)
    local v53 = p52.Origin or CFrame.new();
    local v54 = p52.Direction or Vector3.new(0, 1, 0);
    local v55 = p52.Parent or workspace;
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = p52.RaycastIgnore or {};

    if p52.Duration and p52.Duration > 0 then
        local _ = p52.Rate or 50;
        local v56 = os.clock() + p52.Duration;

        while os.clock() < v56 do
            emitOne(p52, v53, v54, v55, RaycastParams_new_ret);
            RunService.Heartbeat:Wait();
        end;
    else
        for i = 1, p52.Amount or 30 do
            emitOne(p52, v53, v54, v55, RaycastParams_new_ret);
            local _ = i;
        end;
    end;
end;

return v1;