 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local u1 = {};

local function multiStepRaycast(p2, p3, p4, p5) -- Line: 12
    local v6 = p3 / p4;

    for i = 1, p4 do
        local v7 = workspace:Raycast(p2, v6, p5);

        if v7 then
            return v7;
        end;

        p2 = p2 + v6;
        local _ = i;
    end;

    return nil;
end;

local function simulate(p8: table, p9: userdata) -- Line: 49
    local CFrame2 = p8.CFrame;
    local CFrame_Angles_ret = CFrame.Angles(0, 0, 0);
    p8.Lifetime = 0;
    local Position = CFrame2.Position;
    local gravity = p8.gravity;
    local v10 = 0.7;
    local v11 = 0.1;
    local v12 = 0.1;
    local v13 = 5;
    local v14 = 0.85;
    local v15 = 0;
    local v16 = p8.curveTime or 0.5;
    local v17 = p8.curvePower or 1;
    local v18 = -CFrame2.RightVector;
    local v19 = p8.Velocity.Magnitude * v16;
    local v20 = p8.DoLoopty or false;
    local v21 = p8.LoopRadius or 2;
    local v22 = p8.LoopSpeed or 6;
    local v23 = p8.LoopWidth or 4;
    local v24 = p8.LoopHeight or 2;
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
    RaycastParams_new_ret.FilterDescendantsInstances = { workspace.map.barriar };
    local IsCurve = p8.IsCurve;
    local v25 = IsCurve == "left" and true or nil;
    local v26 = IsCurve == "up" and true or nil;

    if IsCurve and not v20 then
        if v26 then
            v19 = v19 / 2;
        else
            p8.Velocity = v25 and p8.Velocity + -CFrame2.RightVector * v19 or p8.Velocity + CFrame2.RightVector * v19;
        end;
    end;

    local v27 = p8.Speed or 1.5;
    local v28 = p8.maxTime or (1 / 0);
    local v29 = {
        {
            Age = 0,
            Goal = "",
            Position = Position,
            Velocity = p8.Velocity,
            Rotation = CFrame2.Rotation
        }
    };
    p8.Trajectory = v29;
    p8.Bouncing = {};
    p8.CurrentI = 0;
    local v30 = 0;
    local v31 = 0.015;
    local v32 = 0;

    while true do
        local math_max_ret = math.max(v28 - v30, 0);
        local v33 = v31 < math_max_ret and 0.015 or math_max_ret;
        v30 = v30 + v33;

        if v28 <= v30 then
            break;
        end;

        v32 = v32 + 1;
        local v34 = v33 / v27;

        if p8.Velocity.Magnitude > 0.1 then
            p8.Velocity = p8.Velocity * math.pow(v11, v34);
        end;

        p8.Velocity = p8.Velocity + gravity * v34;
        local Vector3_new_ret = Vector3.new(p8.Velocity.X, 0, p8.Velocity.Z);
        local Y = p8.Velocity.Y;
        local v35 = Vector3_new_ret * v34 * 1.7 / 2;
        local v36 = Position + v35;
        local v37 = workspace:Raycast(Position, v35, RaycastParams_new_ret);

        if not v37 then
            local _ = v36 + v35;
            v37 = workspace:Raycast(v36, v35, RaycastParams_new_ret) or nil;
        end;

        if v37 then
            local Normal = v37.Normal;
            Vector3_new_ret = Vector3_new_ret - 2 * Vector3_new_ret:Dot(Normal) * Normal;
            Position = v37.Position + Normal * 0.1;

            if IsCurve then
                Vector3_new_ret = Vector3_new_ret * 0.5;
                p8.IsCurve = false;
                IsCurve = false;
            end;
        end;

        if v26 then
            if IsCurve and v15 < v16 then
                v15 = math.clamp(v15 + v34, 0, v16);
                Y = Y + 2 * (v19 * v17) / v16 * (1 - v15 / v16) * v34;

                if v16 <= v15 then
                    p8.IsCurve = false;
                    IsCurve = false;
                end;
            end;
        elseif IsCurve and v15 < 0.5 then
            v15 = math.clamp(v15 + v34, 0, 0.5);
            local v38 = v18 * (v19 * v17 * 2) * v34;

            if v25 then
                Vector3_new_ret = Vector3_new_ret - v38;
            else
                Vector3_new_ret = Vector3_new_ret + v38;
            end;
        end;

        if v20 and (Vector3_new_ret.Magnitude > 0.1 and Position.Y > 0.9) then
            local v39 = v30 * v22;
            local Unit = Vector3_new_ret.Unit;
            local Unit2 = Unit:Cross(Vector3.new(0, 1, 0)).Unit;
            local Unit3 = Unit2:Cross(Unit).Unit;
            local v40 = Unit2 * (math.sin(v39) * v21 * v23) + Unit3 * (math.cos(v39) * v21 * v24);

            if v40.Magnitude > 0 then
                Vector3_new_ret = CFrame.fromAxisAngle(v40.Unit, v40.Magnitude * v34):VectorToWorldSpace(Vector3_new_ret);
            end;
        end;

        Position = Position + (Vector3_new_ret * v34 + Vector3.new(0, Y * v34, 0));

        if Position.Y <= v14 then
            Position = Vector3.new(Position.X, v14, Position.Z);

            if v12 < math.abs(Y) and v13 > 0 then
                v13 = v13 - 1;
                local Vector3_new_ret2 = Vector3.new(Vector3_new_ret.X, 0, Vector3_new_ret.Z);
                local v41 = v30;

                for i = 1, 3 do
                    v30 = v30 + 0.015;
                    table.insert(v29, {
                        Goal = nil,
                        Age = v30,
                        Position = Position,
                        Velocity = Vector3_new_ret2,
                        Rotation = CFrame_Angles_ret
                    });
                    local _ = i;
                end;

                Y = -Y * v10;
                table.insert(p8.Bouncing, {
                    Age = v41,
                    Position = Position,
                    bouncePower = Y
                });
                v10 = 0.7;
            else
                Y = 0;
                v10 = 0.7;
            end;

            if Vector3_new_ret.Magnitude < v12 then
                Vector3_new_ret = Vector3.new(0, 0, 0);
            end;
        end;

        local math_pow_ret = math.pow(0.9, v34);
        p8.Velocity = Vector3.new(Vector3_new_ret.X * math_pow_ret, Y * math_pow_ret, Vector3_new_ret.Z * math_pow_ret);

        if Vector3_new_ret.Magnitude >= v12 then
            local v42 = Vector3_new_ret.Magnitude * v34 / 0.85;
            local Unit = (Vector3.new(0, 1, 0)):Cross(Vector3_new_ret).Unit;
            CFrame_Angles_ret = CFrame_Angles_ret * CFrame.fromAxisAngle(Unit, v42);
        end;

        table.insert(v29, {
            Goal = nil,
            Age = v30,
            Position = Position,
            Velocity = p8.Velocity,
            Rotation = CFrame_Angles_ret
        });

        if p8.Velocity.Magnitude < v12 and Position.Y < 1.85 then
            p8.Velocity = Vector3.new(0, 0, 0);
            break;
        end;
    end;

    p8.TrajStamp = (p8.TrajStamp or 0) + 1;
    p8.Step = 0.015 / v27;
    p8.Lifetime = 0;
    p8.CurrentI = 1;
    local v43 = {};

    for i = 1, #v29, 2 do
        table.insert(v43, v29[i]);
        local _ = i;
    end;

    if #v43 == 0 then
        table.insert(v43, v29[#v29]);
    end;

    local function finiteNumber(p44) -- Line: 247
        local v45;

        if type(p44) == "number" and (p44 == p44 and p44 ~= (1 / 0)) then
            v45 = p44 ~= (-1 / 0);
        else
            v45 = false;
        end;

        return v45;
    end;

    local function finiteVector(p46) -- Line: 250
        local v47;

        if typeof(p46) == "Vector3" then
            local X = p46.X;

            if type(X) == "number" and (X == X and X ~= (1 / 0)) then
                v47 = X ~= (-1 / 0);
            else
                v47 = false;
            end;

            if v47 then
                local Y = p46.Y;

                if type(Y) == "number" and (Y == Y and Y ~= (1 / 0)) then
                    v47 = Y ~= (-1 / 0);
                else
                    v47 = false;
                end;

                if v47 then
                    local Z = p46.Z;

                    if type(Z) == "number" and (Z == Z and Z ~= (1 / 0)) then
                        v47 = Z ~= (-1 / 0);
                    else
                        v47 = false;
                    end;
                end;
            end;
        else
            v47 = false;
        end;

        return v47;
    end;

    local function finiteCFrame(p48) -- Line: 253
        if typeof(p48) ~= "CFrame" then
            return false;
        end;

        for _, v in { p48:GetComponents() } do
            local v49;

            if type(v) == "number" and (v == v and v ~= (1 / 0)) then
                v49 = v ~= (-1 / 0);
            else
                v49 = false;
            end;

            if not v49 then
                return false;
            end;
        end;

        return true;
    end;

    local v50 = {};

    for _, v in v43 do
        if type(v) == "table" then
            local Age = v.Age;
            local v51;

            if type(Age) == "number" and (Age == Age and Age ~= (1 / 0)) then
                v51 = Age ~= (-1 / 0);
            else
                v51 = false;
            end;

            if v51 then
                local Position2 = v.Position;
                local v52;

                if typeof(Position2) == "Vector3" then
                    local X = Position2.X;

                    if type(X) == "number" and (X == X and X ~= (1 / 0)) then
                        v52 = X ~= (-1 / 0);
                    else
                        v52 = false;
                    end;

                    if v52 then
                        local Y = Position2.Y;

                        if type(Y) == "number" and (Y == Y and Y ~= (1 / 0)) then
                            v52 = Y ~= (-1 / 0);
                        else
                            v52 = false;
                        end;

                        if v52 then
                            local Z = Position2.Z;

                            if type(Z) == "number" and (Z == Z and Z ~= (1 / 0)) then
                                v52 = Z ~= (-1 / 0);
                            else
                                v52 = false;
                            end;
                        end;
                    end;
                else
                    v52 = false;
                end;

                if v52 then
                    local Velocity = v.Velocity;
                    local v53;

                    if typeof(Velocity) == "Vector3" then
                        local X = Velocity.X;

                        if type(X) == "number" and (X == X and X ~= (1 / 0)) then
                            v53 = X ~= (-1 / 0);
                        else
                            v53 = false;
                        end;

                        if v53 then
                            local Y = Velocity.Y;

                            if type(Y) == "number" and (Y == Y and Y ~= (1 / 0)) then
                                v53 = Y ~= (-1 / 0);
                            else
                                v53 = false;
                            end;

                            if v53 then
                                local Z = Velocity.Z;

                                if type(Z) == "number" and (Z == Z and Z ~= (1 / 0)) then
                                    v53 = Z ~= (-1 / 0);
                                else
                                    v53 = false;
                                end;
                            end;
                        end;
                    else
                        v53 = false;
                    end;

                    if v53 and finiteCFrame(v.Rotation) then
                        table.insert(v50, {
                            Age = v.Age,
                            Position = v.Position,
                            Velocity = v.Velocity,
                            Rotation = v.Rotation,
                            Goal = v.Goal
                        });
                    end;
                end;
            end;
        end;
    end;

    local v54;

    if #v50 > 101 then
        v54 = table.create(101);
        local v55 = (#v50 - 1) / 100;

        for i = 1, 101 do
            v54[i] = v50[math.floor((i - 1) * v55 + 0.5) + 1];
            local _ = i;
        end;
    else
        v54 = v50;
    end;

    return v54;
end;

u1.Simulate = simulate;

local function resolveAdjustedDirection(p56: userdata?, p57: userdata?, p58: any, p59: boolean?) -- Line: 293
    local v60 = p58[4];
    local _, v61, v62 = p57.CFrame:ToEulerAnglesYXZ();
    local LookVector = (CFrame.new(p57.CFrame.Position) * CFrame.fromEulerAnglesYXZ(0, v61, v62)).LookVector;
    local LookVector2 = CFrame.lookAt(p57.CFrame.Position, p57.CFrame.Position + LookVector).LookVector;
    local v63;

    if typeof(v60) == "function" then
        local v64 = p56 and p56.CFrame.LookVector or Vector3.new(0, 0, 1);
        local math_clamp_ret = math.clamp(p57 and p57.CFrame.LookVector.Y or 0, -1, 1);
        v63 = v60((Vector3.new(v64.X, math_clamp_ret, v64.Z)));
    else
        v63 = v60 or (p56 and p56.CFrame.LookVector or Vector3.new(0, 0, 1));
    end;

    local v65;

    if p58[6] or false then
        v65 = v63.Y or nil;
    else
        v65 = nil;
    end;

    if v65 and v65 < 0 then
        v65 = v65 / 3;
    end;

    if p59 then
        local X = LookVector2.X;
        local v66 = v65 or math.clamp(v63.Y, -1, 1);

        return Vector3.new(X, v66, LookVector2.Z);
    end;

    local X = LookVector2.X;
    local v67 = v65 or math.clamp(v63.Y, 0.1, 1);

    return Vector3.new(X, v67, LookVector2.Z);
end;

function u1.BuildCurrent(p68: userdata, p69: table, p70: any) -- Line: 323
    -- upvalues: resolveAdjustedDirection (copy)
    local v71 = p69[1] or {};
    local v72 = p69[5];
    local v73 = p69[6];
    local v74 = p69[7];
    local v75 = p69[9];
    local v76 = p69[10];
    local v77 = p69[12];
    local HumanoidRootPart = p68:FindFirstChild("HumanoidRootPart");

    if not v74 then
        if HumanoidRootPart then
            v74 = HumanoidRootPart.CFrame;
        else
            v74 = HumanoidRootPart;
        end;
    end;

    if not v74 then
        return nil;
    end;

    local v78 = v71[2];
    local v79 = v71[3];
    local v80 = resolveAdjustedDirection(HumanoidRootPart, workspace.CurrentCamera, v71, v77);
    local CFrame_new_ret = CFrame.new(v74.Position, v74.Position + v80);
    local v81 = CFrame_new_ret.LookVector * math.clamp((v78 or 0) / 10, 1, (1 / 0)) * 50;
    local v82 = {
        Velocity = v81,
        CFrame = CFrame_new_ret * CFrame.new(0, 0, -4),
        IsCurve = v79,
        OriginalIsCurve = v79,
        Speed = v73 or 1.5,
        gravity = Vector3.new(0, v72 and -v72 or -workspace.Gravity * 2.5, 0),
        Lifetime = 0,
        curveTime = v75 or 0.5,
        curvePower = v76 or 1,
        DoLoopty = v71[9] or false,
        LoopRadius = v71[11] or 6,
        LoopSpeed = v71[10] or 2,
        curveDelay = v71[7] or 0,
        curveApplied = true,
        isLeft = v79 == "left" and true or nil,
        isUp = v79 == "up" and true or nil,
        Start = workspace:GetServerTimeNow()
    };
    v82.Now = v82.Start;
    v82.maxTime = p70.maxTime or 3;

    return v82;
end;

function u1.Preview(u83: userdata, u84: table, p85: any, p86: any) -- Line: 378
    -- upvalues: u1 (copy), simulate (copy), actionUtil (copy), Lighting (copy), TweenService (copy), RunService (copy)
    local HumanoidRootPart = u83:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return function() -- Line: 381
        end;
    end;

    local u87 = p86 or {};
    local v88 = u87.lineColor or Color3.fromRGB(255, 85, 0);
    local v89 = u87.lineMaterial or Enum.Material.Neon;
    local u90 = u87.lineThickness or 0.25;
    local u91 = u87.updateRate or 0.03333333333333333;
    local v92 = u87.lifetime or 12;
    local v93 = u87.fadeTransparency or 0.5;
    local u94 = u1.BuildCurrent(u83, u84, u87);

    if not u94 then
        return function() -- Line: 395
        end;
    end;

    local u95 = simulate(u94, u83);
    local Model = Instance.new("Model");
    Model.Name = "t";
    local Part = Instance.new("Part");
    Part.Parent = Model;
    Part.CanQuery = false;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = HumanoidRootPart.CFrame;
    Model.PrimaryPart = Part;
    Model:SetAttribute("IgnoresTheKid", true);
    Model.Parent = workspace.Effects;
    local u97 = actionUtil.getworkspace().disabled.Changed:Connect(function(p96) -- Line: 418
        -- upvalues: Model (copy), Lighting (ref)
        Model.Parent = p96 and Lighting or workspace.Effects;
    end);
    local u98 = {};

    for i = 1, #u95 do
        local v99 = u95[i];
        local v100 = u95[i + 1];
        local v101;

        if v100 then
            local Position = v99.Position;
            local Position2 = v100.Position;
            local v102 = Position - Position2;
            local Part2 = Instance.new("Part");
            Part2.Color = v88;
            Part2.Transparency = 1;
            Part2.Material = v89;
            Part2.Anchored = true;
            Part2.CanCollide = false;
            Part2.CanQuery = false;
            Part2.Position = Position2;
            Part2.Parent = Model;
            Part2.Size = Vector3.new(u90, u90, v102.Magnitude);
            Part2.CFrame = CFrame.lookAt(Position2, Position) + v102 / 2;
            table.insert(u98, Part2);
            v101 = i;
        else
            v101 = i;
        end;
    end;

    for i, v in u98 do
        TweenService:Create(v, TweenInfo.new(0.5 + i / 100, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Transparency = v93
        }):Play();
    end;

    local u103 = RunService.PreRender:Connect(function() -- Line: 453
        -- upvalues: Model (copy), HumanoidRootPart (copy)
        if Model.PrimaryPart then
            Model:PivotTo(HumanoidRootPart.CFrame);
        end;
    end);
    local u104 = 0;
    local u107 = RunService.Heartbeat:Connect(function(p105) -- Line: 461
        -- upvalues: u104 (ref), u91 (copy), Model (copy), u94 (ref), u1 (ref), u83 (copy), u84 (copy), u87 (ref), u95 (ref), simulate (ref), u98 (copy), u90 (copy), Part (copy)
        u104 = u104 + p105;

        if u91 <= u104 then
            u104 = 0;
            Model.PrimaryPart = nil;
            u94 = u1.BuildCurrent(u83, u84, u87);

            if u94 then
                u95 = simulate(u94, u83);

                for i, v in u98 do
                    if u95[i] and u95[i + 1] then
                        local Position = u95[i].Position;
                        local Position2 = u95[i + 1].Position;
                        local v106 = Position - Position2;
                        v.Size = Vector3.new(u90, u90, v106.Magnitude);
                        v.CFrame = CFrame.lookAt(Position2, Position) + v106 / 2;
                    end;
                end;
            end;

            Model.PrimaryPart = Part;
        end;
    end);
    local u108 = false;

    local function stop() -- Line: 500
        -- upvalues: u108 (ref), u97 (copy), u103 (copy), u107 (ref), Model (copy)
        if u108 then
            return;
        end;

        u108 = true;
        u97:Disconnect();
        u103:Disconnect();
        u107:Disconnect();
        pcall(game.Destroy, Model);
    end;

    task.delay(v92, stop);

    if p85 and p85.Add then
        p85:Add(stop);
    end;

    return stop;
end;

return u1;