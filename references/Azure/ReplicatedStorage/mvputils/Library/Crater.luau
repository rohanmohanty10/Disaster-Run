 

 

local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local v1 = {};
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
RaycastParams_new_ret.FilterDescendantsInstances = {};

local function createRockPart(p2, p3, p4) -- Line: 11
    local Children = script:GetChildren();

    if #Children == 0 then
        return nil;
    end;

    local v5 = Children[math.random(1, #Children)]:Clone();
    v5.Size = p2;
    v5.Material = p3 or Enum.Material.Slate;
    v5.Color = p4 or Color3.fromRGB(100, 100, 100);
    v5.Anchored = false;
    v5.CanCollide = true;
    v5.CastShadow = true;
    v5.Massless = false;
    v5.TopSurface = Enum.SurfaceType.Smooth;
    v5.BottomSurface = Enum.SurfaceType.Smooth;
    v5.CollisionGroup = "NoCollision";

    return v5;
end;

local function parseOrigin(p6) -- Line: 33
    if typeof(p6) == "CFrame" then
        return p6;
    end;

    if typeof(p6) == "Vector3" then
        return CFrame.new(p6);
    end;

    if typeof(p6) == "Instance" and p6:IsA("BasePart") then
        return p6.CFrame;
    end;

    return CFrame.new(0, 0, 0);
end;

local function parseDirection(p7, p8) -- Line: 45
    if typeof(p7) == "Vector3" then
        return p7.Magnitude == 0 and Vector3.new(0, 1, 0) or p7.Unit;
    end;

    if typeof(p7) == "CFrame" then
        return p7.LookVector;
    end;

    if typeof(p7) == "string" then
        local v9 = p7:lower();

        if v9 == "front" then
            return p8.LookVector;
        end;

        if v9 == "back" then
            return -p8.LookVector;
        end;

        if v9 == "left" then
            return -p8.RightVector;
        end;

        if v9 == "right" then
            return p8.RightVector;
        end;

        if v9 == "up" then
            return p8.UpVector;
        end;

        if v9 == "down" then
            return -p8.UpVector;
        end;

        if v9 == "all" then
            local v10 = math.random() - 0.5;
            local v11 = math.random() - 0.5;
            local v12 = math.random() - 0.5;

            return Vector3.new(v10, v11, v12).Unit;
        end;
    end;

    return p8 and p8.LookVector or Vector3.new(0, 1, 0);
end;

local function spawnOneRock(p13, p14, p15, p16, p17) -- Line: 64
    -- upvalues: RaycastParams_new_ret (copy), createRockPart (copy), TweenService (copy)
    local v18 = p13.MinSize or Vector3.new(0.15, 0.15, 0.15);
    local v19 = p13.MaxSize or Vector3.new(0.5, 0.5, 0.5);
    local math_random_ret = math.random(p13.SpeedMin or (p13.Speed or 35), p13.SpeedMax or (p13.Speed or 35));
    local v20 = p13.Lifetime or 2;
    local v21 = p13.Material or Enum.Material.Slate;
    local v22 = p13.Color or Color3.fromRGB(100, 100, 100);
    local math_rad_ret = math.rad(p13.SpreadAngle or 45);
    local v23 = p13.SpinAmount or 10;
    RaycastParams_new_ret.FilterDescendantsInstances = p17;
    local v24 = math.random() * (v19.X - v18.X) + v18.X;
    local v25 = math.random() * (v19.Y - v18.Y) + v18.Y;
    local v26 = math.random() * (v19.Z - v18.Z) + v18.Z;
    local Vector3_new_ret = Vector3.new(v24, v25, v26);
    local u27 = createRockPart(Vector3_new_ret, v21, v22);
    local v28 = (math.random() - 0.5) * 0.2;
    local v29 = (math.random() - 0.5) * 0.2;
    local v30 = (math.random() - 0.5) * 0.2;
    local Vector3_new_ret2 = Vector3.new(v28, v29, v30);
    local v31 = workspace:Raycast(p14.Position + Vector3_new_ret2 + Vector3.new(0, 5, 0), Vector3.new(0, -20, 0), RaycastParams_new_ret);

    if v31 and (v31.Position and v31.Instance) then
        u27.Material = v31.Instance.Material;
        u27.Color = v31.Instance.Color;
        local CFrame_new_ret = CFrame.new(v31.Position + Vector3.new(0, Vector3_new_ret.Y / 2, 0));
        local CFrame_Angles = CFrame.Angles;
        local math_random_ret2 = math.random(0, 360);
        local math_rad_ret2 = math.rad(math_random_ret2);
        local math_random_ret3 = math.random(0, 360);
        local math_rad_ret3 = math.rad(math_random_ret3);
        local math_random_ret4 = math.random(0, 360);
        u27.CFrame = CFrame_new_ret * CFrame_Angles(math_rad_ret2, math_rad_ret3, (math.rad(math_random_ret4)));
    else
        local CFrame_Angles = CFrame.Angles;
        local math_random_ret2 = math.random(0, 360);
        local math_rad_ret2 = math.rad(math_random_ret2);
        local math_random_ret3 = math.random(0, 360);
        local math_rad_ret3 = math.rad(math_random_ret3);
        local math_random_ret4 = math.random(0, 360);
        u27.CFrame = p14 * CFrame_Angles(math_rad_ret2, math_rad_ret3, (math.rad(math_random_ret4)));
    end;

    u27.Parent = p16;
    local CFrame_fromEulerAnglesXYZ_ret = CFrame.fromEulerAnglesXYZ((math.random() - 0.5) * math_rad_ret, (math.random() - 0.5) * math_rad_ret, (math.random() - 0.5) * math_rad_ret);
    u27.AssemblyLinearVelocity = (CFrame.lookAt(Vector3.new(0, 0, 0), p15) * CFrame_fromEulerAnglesXYZ_ret).LookVector * math_random_ret;
    local v32 = (math.random() - 0.5) * v23;
    local v33 = (math.random() - 0.5) * v23;
    local v34 = (math.random() - 0.5) * v23;
    u27.AssemblyAngularVelocity = Vector3.new(v32, v33, v34);
    task.delay(v20 - 0.5, function() -- Line: 120
        -- upvalues: u27 (copy), TweenService (ref)
        if u27 and u27.Parent then
            local v35 = TweenService:Create(u27, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Size = Vector3.new(0, 0, 0),
                Transparency = 1
            });
            v35:Play();
            v35.Completed:Wait();

            if u27 then
                u27:Destroy();
            end;
        end;
    end);
end;

function v1.FlyingRocks(p36) -- Line: 134
    -- upvalues: parseOrigin (copy), parseDirection (copy), spawnOneRock (copy)
    local v37 = p36 or {};
    local v38 = v37.Direction or "Up";
    local v39 = v37.Parent or (workspace:FindFirstChild("Ignore") or workspace.Effects);
    local v40 = v37.Offset or Vector3.new(0, 0, 0);
    local v41 = { workspace:FindFirstChild("Ignore"), workspace:FindFirstChild("Live"), (workspace:FindFirstChild("Effects")) };
    local v42 = v37.Duration or 0;
    local v43 = v37.Rate or 10;

    if v42 > 0 then
        local v44 = os.clock() + v42;

        while os.clock() < v44 do
            local v45 = parseOrigin(v37.Origin) * CFrame.new(v40);
            spawnOneRock(v37, v45, parseDirection(v38, v45), v39, v41);
            task.wait(1 / v43);
        end;
    else
        for i = 1, v37.Amount or 6 do
            local v46 = parseOrigin(v37.Origin) * CFrame.new(v40);
            spawnOneRock(v37, v46, parseDirection(v38, v46), v39, v41);
            local _ = i;
        end;
    end;
end;

local Random_new_ret = Random.new();

local function refreshRandom(p47: number?) -- Line: 165
    -- upvalues: Random_new_ret (ref)
    Random_new_ret = p47 and Random.new(p47) or Random.new();
end;

local function applySurfaceProps(p48: userdata, p49, p50: userdata, p51: boolean) -- Line: 169
    if not (p51 and (p49 and p49.Instance)) then
        if p50.materialOverride then
            p48.Material = p50.materialOverride;
        end;

        if p50.colorOverride then
            p48.Color = p50.colorOverride;
        end;

        if p50.transparencyOverride then
            p48.Transparency = p50.transparencyOverride;
        end;

        if p50.reflectanceOverride then
            p48.Reflectance = p50.reflectanceOverride;
        end;

        return;
    end;

    local Instance2 = p49.Instance;

    if not Instance2:IsA("BasePart") then
        p48.Material = p49.Material;
        p48.Color = p50.colorOverride or Color3.fromRGB(127, 127, 127);

        return;
    end;

    p48.Material = Instance2.Material;
    p48.Color = Instance2.Color;
    p48.Transparency = Instance2.Transparency;
    p48.Reflectance = Instance2.Reflectance;
end;

function v1.GroundRocks(p52: table) -- Line: 224
    -- upvalues: RaycastParams_new_ret (copy), Random_new_ret (ref), applySurfaceProps (copy), TweenService (copy), Debris (copy)
    local v53 = {
        showTime = 0.25,
        hideTime = 3,
        easingStyle = Enum.EasingStyle.Quad,
        easingDirection = Enum.EasingDirection.Out,
        trailGrowTime = 0.1,
        trailShrinkTime = 0.3,
        startAngleDeg = 11,
        placementRayLength = 10,
        baseOffsetHeight = 5,
        baseOffsetCFrame = CFrame.Angles(-1.5707963267948966, 0, 0),
        maxRockRotation = 0.7,
        sizeJitter = {
            x = NumberRange.new(0.6, 1.1),
            y = NumberRange.new(0.9, 1),
            z = NumberRange.new(0.9, 1.4)
        },
        rotationJitter = {
            x = NumberRange.new(-0.7, -0.4),
            y = NumberRange.new(-0.1, 0.1),
            z = NumberRange.new(-0.1, 0.2)
        },
        lingerTime = NumberRange.new(7, 9),
        shrinkFactor = 0.5,
        hideDepthMultiplier = 1,
        anchored = true,
        canCollide = true,
        canQuery = true,
        canTouch = true,
        castShadow = true,
        collisionGroup = "Default",
        useSurfaceAppearance = true,
        colorOverride = nil,
        materialOverride = nil,
        transparencyOverride = nil,
        reflectanceOverride = nil,
        finalSizeScalar = NumberRange.new(0.5, 1),
        growTime = 0.1,
        shrinkDelay = NumberRange.new(3, 4),
        shrinkTime = 0.3,
        TrailuseSurfaceAppearance = true,
        TrailcolorOverride = nil,
        TrailmaterialOverride = nil,
        TrailtransparencyOverride = nil,
        TrailreflectanceOverride = nil
    };

    if p52.config then
        for i, v in pairs(p52.config) do
            if v53[i] ~= nil then
                v53[i] = v;
            end;
        end;
    end;

    RaycastParams_new_ret.FilterDescendantsInstances = { workspace:FindFirstChild("Ignore"), workspace:FindFirstChild("Live"), (workspace:FindFirstChild("Effects")) };
    local v54 = workspace:Raycast(p52.origin, p52.direction, RaycastParams_new_ret);

    if not v54 then
        return {};
    end;

    local startAngleDeg = v53.startAngleDeg;
    local v55 = 360 / p52.amount;
    local v56 = {};

    for i = 1, p52.amount do
        local v57 = CFrame.lookAt(v54.Position, v54.Position + v54.Normal) * v53.baseOffsetCFrame * CFrame.fromEulerAnglesXYZ(0, math.rad(startAngleDeg), 0) * CFrame.new(p52.radius / 2 + p52.radius / 15, p52.offsetHeight or v53.baseOffsetHeight, 0);
        startAngleDeg = startAngleDeg + v55;
        RaycastParams_new_ret.FilterDescendantsInstances = { workspace:FindFirstChild("Ignore"), workspace:FindFirstChild("Live"), (workspace:FindFirstChild("Effects")) };
        local v58 = workspace:Raycast(v57.Position, -v54.Normal * v53.placementRayLength, RaycastParams_new_ret);
        local v59;

        if v58 then
            local v60 = p52.size.X * Random_new_ret:NextNumber(v53.sizeJitter.x.Min, v53.sizeJitter.x.Max);
            local v61 = p52.size.Y * Random_new_ret:NextNumber(v53.sizeJitter.y.Min, v53.sizeJitter.y.Max);
            local v62 = p52.size.Z * Random_new_ret:NextNumber(v53.sizeJitter.z.Min, v53.sizeJitter.z.Max);
            local Vector3_new_ret = Vector3.new(v60, v61, v62);
            local v63 = v58.Normal * (p52.size.Y * Random_new_ret:NextNumber(0.325, 0.45));
            local CFrame_lookAt_ret = CFrame.lookAt(v58.Position - v63, v54.Position, v54.Normal);
            local v64 = p52.maxRotation or v53.maxRockRotation;
            local v65 = Random_new_ret:NextNumber(v53.rotationJitter.x.Min, v53.rotationJitter.x.Max);
            local math_clamp_ret = math.clamp(v65, -v64, v64);
            local v66 = CFrame_lookAt_ret * CFrame.Angles(math_clamp_ret, Random_new_ret:NextNumber(v53.rotationJitter.y.Min, v53.rotationJitter.y.Max), Random_new_ret:NextNumber(v53.rotationJitter.z.Min, v53.rotationJitter.z.Max));
            local v67 = v66 + v58.Normal * -Vector3_new_ret.Y / 2;
            local Part = Instance.new("Part");
            Part.Size = Vector3_new_ret;
            Part.CFrame = v67;
            Part.Anchored = v53.anchored;
            Part.CanCollide = v53.canCollide;
            Part.CanQuery = v53.canQuery;
            Part.CanTouch = v53.canTouch;
            Part.CastShadow = v53.castShadow;
            applySurfaceProps(Part, v58, v53, v53.useSurfaceAppearance);
            Part.Parent = workspace:FindFirstChild("Ignore") or workspace.Effects;
            Part.CollisionGroup = v53.collisionGroup;
            table.insert(v56, Part);
            TweenService:Create(Part, TweenInfo.new(v53.showTime), {
                Position = v66.Position
            }):Play();
            local v68 = Random_new_ret:NextNumber(v53.lingerTime.Min, v53.lingerTime.Max);
            local v69 = v66 + v58.Normal * -(Vector3_new_ret.Y * v53.hideDepthMultiplier);
            local TweenInfo_new_ret = TweenInfo.new(v53.hideTime, v53.easingStyle, v53.easingDirection);
            local TweenInfo_new_ret2 = TweenInfo.new(v53.hideTime, v53.easingStyle, v53.easingDirection);
            local u70 = TweenService:Create(Part, TweenInfo_new_ret, {
                Position = v69.Position
            });
            local u71 = TweenService:Create(Part, TweenInfo_new_ret2, {
                Size = Part.Size * v53.shrinkFactor
            });
            task.delay(v68, function() -- Line: 348
                -- upvalues: u70 (copy), u71 (copy), Debris (ref), Part (copy), TweenInfo_new_ret (copy)
                u70:Play();
                u71:Play();
                Debris:AddItem(Part, TweenInfo_new_ret.Time);
            end);
            v59 = i;
        else
            v59 = i;
        end;
    end;

    return v56;
end;

return v1;