 

 

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");

local function getBezierFrameAndBasis(p1: number, p2, p3, p4, p5) -- Line: 5
    local v6 = 1 - p1;
    local v7 = v6 * v6;
    local v8 = p1 * p1;
    local Position = p2.Position;
    local Position2 = p3.Position;
    local Position3 = p4.Position;
    local Position4 = p5.Position;
    local v9 = Position * (v7 * v6) + Position2 * (v7 * 3 * p1) + Position3 * (v6 * 3 * v8) + Position4 * (v8 * p1);
    local v10 = (Position2 - Position) * (v7 * 3) + (Position3 - Position2) * (v6 * 6 * p1) + (Position4 - Position3) * (v8 * 3);

    if v10.Magnitude < 0.001 then
        if p1 < 0.5 then
            v10 = Position2 - Position;
        else
            v10 = Position4 - Position3;
        end;

        if v10.Magnitude < 0.001 then
            local v11 = Position4 - Position;
            v10 = v11.Magnitude < 0.001 and Vector3.new(0, 0, -1) or v11;
        end;
    end;

    local Unit = v10.Unit;
    local v12 = Unit:Cross(Vector3.new(0, 1, 0));

    if v12.Magnitude < 0.0001 then
        v12 = Unit:Cross(Vector3.new(0, 0, -1));
    end;

    local Unit2 = v12.Unit;
    local Unit3 = Unit2:Cross(Unit).Unit;

    return CFrame.lookAt(v9, v9 + Unit), Unit2, Unit3, Unit;
end;

local function cubicBezier(p13, p14, p15, p16, p17) -- Line: 53
    local v18 = 1 - p17;

    return v18 * v18 * v18 * p13 + 3 * (v18 * v18) * p17 * p14 + 3 * v18 * (p17 * p17) * p15 + p17 * p17 * p17 * p16;
end;

local function randomUnitVector() -- Line: 58
    local v19 = math.random() * 2 - 1;
    local v20 = math.random() * 2 - 1;
    local v21 = math.random() * 2 - 1;
    local Vector3_new_ret = Vector3.new(v19, v20, v21);

    return Vector3_new_ret.Magnitude < 0.0001 and Vector3.new(0, 1, 0) or Vector3_new_ret.Unit;
end;

local function expDamp(p22: vector, p23: number, p24: number) -- Line: 69
    if p23 <= 0 then
        return p22;
    end;

    return p22 * math.exp(-p23 * p24);
end;

local function lerp(p25, p26, p27) -- Line: 75
    return p25 + (p26 - p25) * p27;
end;

local function parseDirection(p28, p29) -- Line: 79
    local v30 = typeof(p29);

    if v30 == "Vector3" then
        return p29.Unit;
    end;

    if v30 == "string" then
        local string_lower_ret = string.lower(p29);

        if string_lower_ret == "front" or string_lower_ret == "forward" then
            return p28.LookVector;
        end;

        if string_lower_ret == "back" or string_lower_ret == "backward" then
            return -p28.LookVector;
        end;

        if string_lower_ret == "right" then
            return p28.RightVector;
        end;

        if string_lower_ret == "left" then
            return -p28.RightVector;
        end;

        if string_lower_ret == "up" then
            return p28.UpVector;
        end;

        if string_lower_ret == "down" then
            return -p28.UpVector;
        end;

        if string_lower_ret == "random" then
            local v31 = math.random() - 0.5;
            local v32 = math.random() - 0.5;
            local v33 = math.random() - 0.5;
            local Vector3_new_ret = Vector3.new(v31, v32, v33);

            return (Vector3_new_ret.Magnitude < 0.001 and Vector3.new(0, 0, -1) or Vector3_new_ret).Unit;
        end;
    end;

    error("BezierLightning: \'direction\' must be Vector3 or one of: front, back, left, right, up, down, random");
end;

local function resolveRangeDegrees(p34) -- Line: 99
    if typeof(p34) ~= "table" or #p34 < 2 then
        return p34 or 0;
    end;

    local v35 = p34[1];
    local v36 = p34[2];

    if v36 >= v35 then
        local v37 = v36;
        v36 = v35;
        v35 = v37;
    end;

    return v36 + (v35 - v36) * math.random();
end;

local function randomSpread(p38, p39) -- Line: 108
    local v40;

    if typeof(p39) == "table" and #p39 >= 2 then
        local v41 = p39[1];
        local v42 = p39[2];

        if v42 >= v41 then
            local v43 = v42;
            v42 = v41;
            v41 = v43;
        end;

        v40 = v42 + (v41 - v42) * math.random();
    else
        v40 = p39 or 0;
    end;

    if v40 <= 0 then
        return p38.Unit;
    end;

    local math_random_ret = math.random();
    local math_random_ret2 = math.random();
    local Unit = Vector3.new(math_random_ret, math_random_ret2, math.random()).Unit;
    local v44 = (math.random() - 0.5) * 2 * v40;
    local math_rad_ret = math.rad(v44);

    return CFrame.fromAxisAngle(Unit, math_rad_ret):VectorToWorldSpace(p38).Unit;
end;

local function perpendicular(p45) -- Line: 117
    local Unit = p45.Unit;
    local Unit2 = Unit:Cross(math.abs(Unit.Y) > 0.9 and Vector3.new(1, 0, 0) or Vector3.new(0, 1, 0)).Unit;

    return Unit2, Unit2:Cross(Unit).Unit;
end;

local function makeBoltInstance(p46, p47, p48) -- Line: 125
    local v49 = p46:Clone();
    v49.Parent = p47;
    local v50 = v49:IsA("BasePart") and v49 and v49 or v49:FindFirstChildWhichIsA("BasePart", true);

    if not v50 then
        v49:Destroy();
        error("BezierLightning: template must be a Part or contain a Part (with your Trail)");
    end;

    v50.Anchored = true;
    v50.CanCollide = p48 and true or false;
    v50.CanQuery = false;
    v50.CanTouch = false;

    return v49, v50;
end;

local function warpTime(p51) -- Line: 140
    return p51 * p51 * (3 - 2 * p51);
end;

local function lookAt(p52, p53) -- Line: 144
    if (p53 - p52).Magnitude < 0.001 then
        return CFrame.new(p52);
    end;

    return CFrame.lookAt(p52, p53);
end;

return {
    Charge = function(u54, p55: table) -- Line: 195, Name: Charge
        -- upvalues: RunService (copy), TweenService (copy), getBezierFrameAndBasis (copy), Debris (copy)
        local u56 = {
            Count = 30,
            SpawnRadius = 20,
            MinDuration = 0.8,
            MaxDuration = 1.5,
            Lifetime = 1,
            ParticleTemplate = "nil",
            ControlPointHeight = 15,
            RandomControlOffset = 8,
            SpawnDelay = 0.05,
            SwirlStrength = 0,
            Speed = 1,
            WorldAcceleration = Vector3.new(0, 0, 0),
            InitialVelocity = Vector3.new(0, 0, 0),
            Drag = 0,
            Noise = 0,
            NoiseFrequency = 0,
            RandomRotation = false,
            AlignToTangent = true,
            Loop = false,
            EmitOnCreate = true,
            SpiralBeforeTravel = false,
            SpiralTime = 1,
            SpiralRadius = 15,
            SpiralSpeed = 6.283185307179586,
            SpiralHeight = 0,
            SpiralInward = true,
            Parent = workspace:FindFirstChild("Ignore") or workspace.Effects,
            EasingStyle = Enum.EasingStyle.Quart,
            EasingDirection = Enum.EasingDirection.Out,
            RotationSpeedRange = NumberRange.new(-45, 45)
        };
        local v57 = typeof(u54) == "CFrame";
        assert(v57, "TargetCFrame Is Not A CFrame");
        assert(p55.Parent, "Parent Required");
        local v58 = p55.ParticleTemplate and p55.ParticleTemplate:IsA("BasePart");
        assert(v58, "Particle Template Nil Or Not A BasePart");

        for i, _ in u56 do
            if p55[i] then
                u56[i] = p55[i];
            end;
        end;

        warn(u56);

        for i = 1, u56.Count do
            task.spawn(function() -- Line: 246
                -- upvalues: u56 (copy), i (copy), u54 (copy), RunService (ref), TweenService (ref), getBezierFrameAndBasis (ref), Debris (ref)
                if u56.SpawnDelay > 0 then
                    task.wait(i * u56.SpawnDelay);
                end;

                local u59 = u56.ParticleTemplate:Clone();
                u59.Anchored = false;
                u59.CanCollide = false;
                u59.CanTouch = false;
                u59.Massless = true;
                u59.Parent = u56.Parent;
                local v60 = math.random() * 2 - 1;
                local v61 = math.random() * 2 - 1;
                local v62 = math.random() * 2 - 1;
                local Vector3_new_ret = Vector3.new(v60, v61, v62);
                local v63 = (Vector3_new_ret.Magnitude < 0.0001 and Vector3.new(0, 1, 0) or Vector3_new_ret.Unit) * math.random(0, u56.SpawnRadius);
                u59.CFrame = CFrame.new(u54.Position + v63);

                if u56.SpiralBeforeTravel then
                    local os_clock_ret = os.clock();

                    while os.clock() - os_clock_ret < u56.SpiralTime do
                        local v64 = os.clock() - os_clock_ret;
                        local math_clamp_ret = math.clamp(v64 / u56.SpiralTime, 0, 1);
                        local v65 = u56.SpiralInward and u56.SpiralRadius * (1 - math_clamp_ret) or u56.SpiralRadius;
                        local v66 = v64 * u56.SpiralSpeed;
                        local v67 = math.cos(v66) * v65;
                        local v68 = math.sin(v66) * v65;
                        local v69 = u54.Position + Vector3.new(v67, u56.SpiralHeight * math_clamp_ret, v68);
                        local v70 = -math.sin(v66);
                        local math_cos_ret = math.cos(v66);
                        local Vector3_new_ret2 = Vector3.new(v70, 0, math_cos_ret);
                        local v71 = Vector3_new_ret2.Magnitude < 0.0001 and Vector3.new(0, 0, 1) or Vector3_new_ret2;

                        if u56.AlignToTangent then
                            u59.CFrame = CFrame.lookAt(v69, v69 + v71);
                        else
                            u59.CFrame = CFrame.new(v69);
                        end;

                        RunService.Heartbeat:Wait();
                    end;
                end;

                local v72 = math.random(u56.MinDuration * 100, u56.MaxDuration * 100) / 100 / u56.Speed;
                local CFrame_new_ret = CFrame.new(u59.Position);
                local u73 = u54;
                local v74 = CFrame_new_ret:Lerp(u73, 0.5);
                local v75 = math.random() * 2 - 1;
                local v76 = math.random() * 2 - 1;
                local v77 = math.random() * 2 - 1;
                local Vector3_new_ret2 = Vector3.new(v75, v76, v77);
                local v78 = (Vector3_new_ret2.Magnitude < 0.0001 and Vector3.new(0, 1, 0) or Vector3_new_ret2.Unit) * (math.random() * u56.RandomControlOffset);
                local v79 = math.random() * 2 - 1;
                local v80 = math.random() * 2 - 1;
                local v81 = math.random() * 2 - 1;
                local Vector3_new_ret3 = Vector3.new(v79, v80, v81);
                local v82 = (Vector3_new_ret3.Magnitude < 0.0001 and Vector3.new(0, 1, 0) or Vector3_new_ret3.Unit) * (math.random() * u56.RandomControlOffset);
                local v83 = u73.Position - CFrame_new_ret.Position;
                local v84 = v83.Magnitude > 0.0001 and v83.Unit or Vector3.new(0, 0, -1);
                local v85 = v84:Cross(Vector3.new(0, 1, 0));

                if v85.Magnitude < 0.0001 then
                    v85 = v84:Cross(Vector3.new(0, 0, -1));
                end;

                local Unit = v85.Unit;
                local v86 = Unit * ((math.random() * 2 - 1) * u56.SwirlStrength);
                local v87 = Unit * ((math.random() * 2 - 1) * u56.SwirlStrength);
                local v88 = CFrame_new_ret.Position:Lerp(v74.Position, 0.3) + Vector3.new(0, u56.ControlPointHeight, 0) + v78 + v86;
                local v89 = v74.Position:Lerp(u73.Position, 0.7) + Vector3.new(0, u56.ControlPointHeight, 0) + v82 + v87;
                local CFrame_new_ret2 = CFrame.new(v88);
                local CFrame_new_ret3 = CFrame.new(v89);
                local NumberValue = Instance.new("NumberValue");
                NumberValue.Value = 0;
                local u90 = TweenService:Create(NumberValue, TweenInfo.new(v72, u56.EasingStyle, u56.EasingDirection, 0, false, 0), {
                    Value = 1
                });
                local os_clock_ret = os.clock();
                local u91 = os_clock_ret;
                local InitialVelocity = u56.InitialVelocity;
                local u92 = 0;
                local math_random_ret = math.random(u56.RotationSpeedRange.Min, u56.RotationSpeedRange.Max);
                local u93 = nil;
                local u104 = RunService.Heartbeat:Connect(function(p94) -- Line: 342
                    -- upvalues: u59 (copy), u93 (ref), InitialVelocity (ref), u56 (ref), getBezierFrameAndBasis (ref), NumberValue (copy), CFrame_new_ret (copy), CFrame_new_ret2 (copy), CFrame_new_ret3 (copy), u73 (copy), os_clock_ret (copy), i (ref), u91 (ref), u92 (ref), math_random_ret (copy)
                    if not (u59 and u59.Parent) then
                        u93();

                        return;
                    end;

                    local v95 = InitialVelocity;
                    local Drag = u56.Drag;

                    if Drag > 0 then
                        v95 = v95 * math.exp(-Drag * p94);
                    end;

                    InitialVelocity = v95 + u56.WorldAcceleration * p94;
                    local v96, v97, v98, v99 = getBezierFrameAndBasis(NumberValue.Value, CFrame_new_ret, CFrame_new_ret2, CFrame_new_ret3, u73);
                    local v100 = os.clock() - os_clock_ret;
                    local math_noise_ret = math.noise(v100 * u56.NoiseFrequency, i, 0);
                    local math_noise_ret2 = math.noise(v100 * u56.NoiseFrequency, 0, i);
                    local v101 = (v97 * math_noise_ret + v98 * math_noise_ret2) * u56.Noise;
                    local v102 = InitialVelocity * (os.clock() - u91);
                    u91 = os.clock();

                    if u56.RandomRotation then
                        u92 = u92 + math.rad(math_random_ret) * p94;
                        v96 = v96 * CFrame.fromAxisAngle(v99, u92);
                    end;

                    local v103 = v96.Position + v101 + v102;

                    if u56.AlignToTangent then
                        u59.CFrame = CFrame.lookAt(v103, v103 + v99);

                        return;
                    end;

                    u59.CFrame = CFrame.new(v103);
                end);
                local u105 = nil;

                u93 = function() -- Line: 380
                    -- upvalues: u104 (ref), u105 (ref), NumberValue (copy)
                    if u104 then
                        u104:Disconnect();
                    end;

                    if u105 then
                        u105:Disconnect();
                    end;

                    NumberValue:Destroy();
                end;

                local function playOnce() -- Line: 386
                    -- upvalues: NumberValue (copy), u90 (copy)
                    NumberValue.Value = 0;
                    u90:Play();
                end;

                if u56.EmitOnCreate then
                    NumberValue.Value = 0;
                    u90:Play();
                end;

                u105 = u90.Completed:Connect(function() -- Line: 395
                    -- upvalues: u56 (ref), u59 (copy), os_clock_ret (copy), NumberValue (copy), u90 (copy), u93 (ref)
                    if not (u56.Loop and (u59 and (u59.Parent and os.clock() - os_clock_ret < u56.Lifetime))) then
                        u93();

                        return;
                    end;

                    NumberValue.Value = 0;
                    u90:Play();
                end);
                Debris:AddItem(u59, u56.Lifetime);
            end);
            local _ = i;
        end;
    end,

    Projectile = function(p106: table) -- Line: 423, Name: Projectile
        local RootCF = p106.RootCF;
        local ProjectileTemplate = p106.ProjectileTemplate;
        local u107 = p106.OnHit or function() -- Line: 426
        end;
        local v108 = p106.Count or 1;
        local v109 = p106.SpreadRadius or 5;
        local u110 = p106.Duration or 1;
        local u111 = p106.ArcHeight or 10;
        local v112 = p106.EvenlySpaced or false;
        local u113 = p106.Rotate or false;
        local v114 = p106.SpawnDelay or 0;
        local u115 = p106.Lifetime or 1;
        local u116 = RootCF.Position + Vector3.new(0, p106.StartHeight or 5, 0);

        for i = 1, v108 do
            local v117;

            if v112 then
                local v118 = i / v108 * 3.141592653589793 * 2;
                local v119 = math.cos(v118) * v109;
                local v120 = math.sin(v118) * v109;
                v117 = Vector3.new(v119, 0, v120);
            else
                local math_random_ret = math.random(-v109, v109);
                v117 = Vector3.new(math_random_ret, 0, math.random(-v109, v109));
            end;

            local u121 = RootCF.Position + v117;
            local v122 = math.random() * v114;
            task.delay(v122, function() -- Line: 459
                -- upvalues: ProjectileTemplate (copy), u116 (copy), u121 (copy), u111 (copy), u110 (copy), u107 (copy), u115 (copy), u113 (copy)
                local u123 = ProjectileTemplate:Clone();
                u123.CFrame = CFrame.new(u116);
                u123.Parent = workspace:FindFirstChild("Ignore") or workspace.Effects;
                local u124 = (u116 + u121) / 2 + Vector3.new(0, u111, 0);
                local u125 = u110 / 30;
                local u126 = 0;

                local function bezierPoint(p127, p128, p129, p130) -- Line: 470
                    return (1 - p127) ^ 2 * p128 + 2 * (1 - p127) * p127 * p129 + p127 ^ 2 * p130;
                end;

                local u131 = nil;
                u131 = game:GetService("RunService").Heartbeat:Connect(function(p132) -- Line: 475
                    -- upvalues: u123 (copy), u131 (ref), u126 (ref), u125 (copy), u107 (ref), u115 (ref), u116 (ref), u124 (copy), u121 (ref), u113 (ref)
                    if not (u123 and u123.Parent) then
                        if u131 then
                            u131:Disconnect();
                        end;

                        return;
                    end;

                    u126 = u126 + p132 / u125;

                    if u126 >= 30 then
                        u131:Disconnect();

                        if u123 and u123.Parent then
                            for _, child in ipairs(u123:GetChildren()) do
                                if child:IsA("ParticleEmitter") then
                                    child:Emit(child:GetAttribute("EmitCount") or 30);
                                end;
                            end;

                            u107(u123.Position, u123);
                            task.delay(u115, function() -- Line: 491
                                -- upvalues: u123 (ref)
                                if u123 and u123.Parent then
                                    u123:Destroy();
                                end;
                            end);
                        end;
                    else
                        local v133 = u126 / 30;
                        local v134 = (1 - v133) ^ 2 * u116 + 2 * (1 - v133) * v133 * u124 + v133 ^ 2 * u121;
                        u123.CFrame = CFrame.new(v134);

                        if u113 then
                            u123.CFrame = CFrame.new(v134, v134 + (u121 - v134).Unit);
                        end;
                    end;
                end);
            end);
            local _ = i;
        end;
    end,

    Lightning = function(p135) -- Line: 511, Name: Lightning
        -- upvalues: parseDirection (copy), Debris (copy), randomSpread (copy), makeBoltInstance (copy), RunService (copy)
        local v136;

        if p135 then
            v136 = typeof(p135) == "table";
        else
            v136 = p135;
        end;

        assert(v136, "params table required");
        local v137 = typeof(p135.originCFrame) == "CFrame";
        assert(v137, "originCFrame (CFrame) is required");
        assert(p135.direction ~= nil, "direction is required (Vector3 or keyword)");
        local originCFrame = p135.originCFrame;
        local v138 = parseDirection(originCFrame, p135.direction);
        local v139 = p135.range or 60;
        local v140 = p135.count or 6;
        local v141 = p135.spreadAngle or 6;
        local v142 = p135.speed or 120;
        local v143 = p135.amplitude or 2.5;
        local v144 = p135.frequency or 24;
        local u145 = p135.lifetime or 0.25;
        local template = p135.template;
        local v146 = p135.parent or (workspace:FindFirstChild("Ignore") or workspace.Effects);
        local v147 = p135.collide or false;
        assert(template, "BezierLightning: No template found. Pass params.template or create ReplicatedStorage.Assets.Skills.PunchOverdrive.BezierTrail");
        local u149 = {
            _alive = true,
            _connections = {},
            _bolts = {},

            Destroy = function(p148) -- Line: 534, Name: Destroy
                -- upvalues: Debris (ref)
                if not p148._alive then
                    return;
                end;

                p148._alive = false;

                for _, v in ipairs(p148._connections) do
                    v:Disconnect();
                end;

                for _, v in ipairs(p148._bolts) do
                    if v and v.instance then
                        Debris:AddItem(v.instance, 0);
                    end;
                end;

                p148._connections = {};
                p148._bolts = {};
            end
        };

        for i = 1, v140 do
            local v150 = randomSpread(v138, v141);
            local Position = originCFrame.Position;
            local u151 = Position + v150 * v139;
            local Unit = v150.Unit;
            local Unit2 = Unit:Cross(math.abs(Unit.Y) > 0.9 and Vector3.new(1, 0, 0) or Vector3.new(0, 1, 0)).Unit;
            local Unit3 = Unit2:Cross(Unit).Unit;
            local v152 = v139 * (0.1 + math.random() * 0.2);
            local v153 = v139 * (0.15 + math.random() * 0.25);
            local v154 = v139 * (0.5 + math.random() * 0.35);
            local v155 = Unit2 * (v152 * (math.random() - 0.5) * 2) + Unit3 * (v152 * (math.random() - 0.5) * 1.2);
            local v156 = Unit2 * (v152 * (math.random() - 0.5) * 1.2) + Unit3 * (v152 * (math.random() - 0.5) * 2);
            local u157 = Position + v150 * v153 + v155;
            local u158 = Position + v150 * v154 + v156;
            local u159, u160 = makeBoltInstance(template, v146, v147);
            u160.CFrame = CFrame.new(Position);
            local math_max_ret = math.max(0.05, v139 / v142);
            local u161 = 0;
            local u162 = math.random() * 3.141592653589793 * 2;
            local u163 = Position;
            local u164 = v144 * (0.85 + math.random() * 0.3);
            local u165 = v143 * (0.85 + math.random() * 0.3);
            local u166 = nil;
            u166 = RunService.Heartbeat:Connect(function(p167) -- Line: 575
                -- upvalues: u149 (copy), u166 (ref), u161 (ref), math_max_ret (copy), Position (copy), u157 (copy), u158 (copy), u151 (copy), u162 (copy), u164 (copy), u165 (copy), Unit2 (copy), Unit3 (copy), u160 (copy), u163 (ref), Debris (ref), u159 (copy), u145 (copy)
                if not u149._alive then
                    u166:Disconnect();

                    return;
                end;

                u161 = u161 + p167 / math_max_ret;
                local math_clamp_ret = math.clamp(u161, 0, 1);
                local v168 = math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret);
                local v169 = 1 - v168;
                local v170 = math.sin(u162 + v168 * u164 * 3.141592653589793 * 2) * u165;
                local v171 = math.cos(u162 * 0.77 + v168 * u164 * 1.618 * 3.141592653589793 * 2) * (u165 * 0.6);
                local v172 = v169 * v169 * v169 * Position + 3 * (v169 * v169) * v168 * u157 + 3 * v169 * (v168 * v168) * u158 + v168 * v168 * v168 * u151 + Unit2 * v170 + Unit3 * v171;
                local v173 = u163;
                local v174;

                if (v172 - v173).Magnitude < 0.001 then
                    v174 = CFrame.new(v173);
                else
                    v174 = CFrame.lookAt(v173, v172);
                end;

                u160.CFrame = v174;
                u160.Position = v172;
                u163 = v172;

                if v168 >= 1 then
                    u166:Disconnect();
                    Debris:AddItem(u159, u145);
                end;
            end);
            table.insert(u149._connections, u166);
            table.insert(u149._bolts, {
                instance = u159
            });
            local _ = i;
        end;

        return u149;
    end
};