 
 

local InstanceHandler = require(script.Parent:WaitForChild("InstanceHandler"));
local Modes = require(script.Parent:WaitForChild("Modes"));
game:GetService("TweenService");
local PhysicsService = game:GetService("PhysicsService");
local RaycastParams_new_ret = RaycastParams.new();
local Random_new_ret = Random.new();
InstanceHandler.new(Instance.new("Part"), 250, "DebrisCache");
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
RaycastParams_new_ret.FilterDescendantsInstances = { workspace.Courts2 };
RaycastParams_new_ret.IgnoreWater = true;

local function _(p1, p2, p3) -- Line: 26
    return p1 + (p2 - p1) * p3;
end;

local function _(p4) -- Line: 29
    if typeof(p4) == "Vector3" then
        return CFrame.new(p4);
    end;

    return p4;
end;

local function _(p5, p6) -- Line: 35
    return math.cos(p5) * p6, math.sin(p5) * p6;
end;

local function _(p7, p8, p9, p10) -- Line: 41
    return (1 - p7) ^ 2 * p8 + 2 * (1 - p7) * p7 * p9 + p7 ^ 2 * p10;
end;

local function u14(p11, p12) -- Line: 45
    -- upvalues: InstanceHandler (copy)
    local v13 = InstanceHandler.getInstance(p11 or "Part") or Instance.new(p11);

    for i, v in next, p12 do
        if i ~= "Parent" or i ~= "ObjectName" then
            v13[i] = v;
        end;
    end;

    return v13;
end;

local function _(p15, p16) -- Line: 55
    -- upvalues: RaycastParams_new_ret (copy)
    local v17 = workspace:Raycast(p15.Position, p16, RaycastParams_new_ret);

    if v17 then
        return v17.Instance, v17.Position, v17.Material, v17.Normal;
    end;

    return false;
end;

local function u28(p18, p19, p20) -- Line: 63
    -- upvalues: RaycastParams_new_ret (copy), u14 (copy)
    local v21 = workspace:Raycast(p18.Position, -p18.UpVector * p19, RaycastParams_new_ret);
    local v22, v23, v24;

    if v21 then
        v22 = v21.Instance;
        v23 = v21.Position;
        v24 = v21.Material;
        local _ = v21.Normal;
    else
        v22 = false;
        v24 = nil;
        v23 = nil;
    end;

    if v22 then
        local v25 = {
            Anchored = true,
            CanCollide = false,
            Material = v24,
            Size = p20,
            Color = v22.Color,
            Reflectance = v22.Reflectance,
            Transparency = v22.Transparency
        };
        local v26;

        if typeof(v23) == "Vector3" then
            v26 = CFrame.new(v23);
        else
            v26 = v23;
        end;

        v25.CFrame = v26;
        local v27 = u14("Part", v25);

        for _, child in ipairs(v27:GetChildren()) do
            child:Destroy();
        end;

        for _, child in ipairs(v22:GetChildren()) do
            if child:IsA("Texture") then
                child:Clone().Parent = v27;
            end;
        end;

        return v27, v23;
    end;
end;

local function u31(p29, p30) -- Line: 88
    -- upvalues: Random_new_ret (copy)
    return Random_new_ret:NextNumber(p29, p30);
end;

local function u40(p32, p33, p34, p35) -- Line: 93
    local v36 = {};

    for i = 1, p34 + 1 do
        local v37 = i * (6.283185307179586 / p34);
        local v38 = math.cos(v37) * p33;
        local v39 = math.sin(v37) * p33;
        v36[i] = p32 * Vector3.new(v38, 0, v39);
        local _ = i;
    end;

    return v36;
end;

return {
    Crater = function(p41, p42) -- Line: 107
        -- upvalues: u40 (copy), Random_new_ret (copy), u28 (copy), u31 (copy), Modes (copy), InstanceHandler (copy)
        local v43 = p42.BlockSize or { 2, 3.5 };
        local v44 = p42.Range or 5;
        local v45 = p42.Angle or { 45, 65 };
        local v46 = p42.Height or { 0, 0 };
        local v47 = p42.Tilt or { 0, 0 };
        local v48 = p42.PartOffset or { 0, 0 };
        local u49 = p42.FlourishTypes or {};
        local v50 = p42.IterateSpeed or {};
        local v51 = p42.CircleComplete or 1;
        local v52 = u40(p41, p42.Radius or 8, p42.PartCount or 10);
        local v53 = 1;
        local u54 = {};

        for i = 1, math.floor(#v52 * v51 + 0.5) do
            local v55;

            if v52[i + 1] == nil then
                v55 = i;
            else
                local v56 = v52[i];
                local Magnitude = (v56 - v52[i + 1]).Magnitude;
                local v57 = Random_new_ret:NextNumber(v43[1], v43[2]);
                local Vector3_new_ret = Vector3.new(Magnitude + 0.5, v57, v57);

                if typeof(v56) == "Vector3" then
                    v56 = CFrame.new(v56);
                end;

                local u58, _ = u28(v56, v44, Vector3_new_ret);

                if u58 then
                    local v59 = CFrame.lookAt(u58.Position, (Vector3.new(p41.X, 0, p41.Z))) * CFrame.new(0, Random_new_ret:NextNumber(v46[1], v46[2]), u31(v48[1], v48[2]));
                    local CFrame_fromEulerAnglesXYZ = CFrame.fromEulerAnglesXYZ;
                    local v60 = Random_new_ret:NextNumber(v45[1], v45[2]);
                    local math_rad_ret = math.rad(v60);
                    local v61 = Random_new_ret:NextNumber(v47[1], v47[2]);
                    local v62 = {
                        CFrame = v59 * CFrame_fromEulerAnglesXYZ(math_rad_ret, math.rad(v61), 0)
                    };
                    u58.CFrame = CFrame.lookAt(u58.Position, (Vector3.new(p41.X, 0, p41.Z)));
                    task.spawn(function() -- Line: 139
                        -- upvalues: u54 (copy), u58 (copy)
                        u54[#u54 + 1] = u58;
                    end);
                    Modes[u49.Entrance or "Enlarge"](u58, u49.EntranceSpeed or 0.3, v62);

                    if v50.Entrance then
                        if v50.EntranceDivision == "Iterate" then
                            if v50.Entrance == "Stepped" then
                                task.wait();
                                v55 = i;
                            else
                                task.wait(v50.Entrance);
                                v55 = i;
                            end;
                        else
                            local v63 = (math.floor(#v52 * v51 + 0.5) - 1) * (v53 / (v50.EntranceDivision or 3));

                            if math.floor(v63) == i and i ~= math.floor(#v52 * v51 + 0.5) - 1 then
                                if v50.Entrance == "Stepped" then
                                    task.wait();
                                else
                                    task.wait(v50.Entrance);
                                end;

                                v53 = v53 + 1;
                                v55 = i;
                            else
                                v55 = i;
                            end;
                        end;
                    else
                        v55 = i;
                    end;
                else
                    v55 = i;
                end;
            end;
        end;

        task.wait(p42.HoldTime or 5);
        local v64 = 1;

        for i = 1, #u54 do
            Modes[u49.Exit or "Shrink"](u54[i], u49.ExitSpeed or 0.3);

            if v50.Exit then
                if v50.ExitDivision == "Iterate" then
                    if v50.Exit == "Stepped" then
                        task.wait();
                    else
                        task.wait(v50.Exit);
                    end;
                elseif math.floor(#u54 * (v64 / (v50.ExitDivision or 2))) == i and i ~= #u54 then
                    if v50.Exit == "Stepped" then
                        task.wait();
                    else
                        task.wait(v50.Exit);
                    end;

                    v64 = v64 + 1;
                end;
            end;

            task.spawn(function() -- Line: 184
                -- upvalues: u49 (copy), InstanceHandler (ref), u54 (copy), i (copy)
                task.wait((u49.ExitSpeed or 0.3) + 0.15);
                InstanceHandler.returnInstance("Part", u54[i]);
            end);
            local _ = i;
        end;
    end,

    ChunkCrater = function(p65, p66) -- Line: 191
        -- upvalues: u40 (copy), Random_new_ret (copy), u28 (copy), u14 (copy), u31 (copy), Modes (copy), InstanceHandler (copy)
        local v67 = p66.BlockSize or { 2, 3.5 };
        local v68 = p66.Range or 5;
        local v69 = p66.Angle or { 45, 65 };
        local v70 = p66.Height or { 0, 0 };
        local v71 = p66.Tilt or { 0, 0 };
        local v72 = p66.PartOffset or { 0, 0 };
        local u73 = p66.FlourishTypes or {};
        local v74 = p66.IterateSpeed or {};
        local v75 = p66.CircleComplete or 1;
        local v76 = u40(p65, p66.Radius or 8, p66.PartCount or 10);
        local u77 = {};
        local u78 = {};
        local v79 = 1;

        for i = 1, math.floor(#v76 * v75 + 0.5) do
            local v80;

            if v76[i + 1] == nil then
                v80 = i;
            else
                local v81 = v76[i];
                local Magnitude = (v81 - v76[i + 1]).Magnitude;
                local v82 = Random_new_ret:NextNumber(v67[1], v67[2]);
                local Vector3_new_ret = Vector3.new(Magnitude + 0.5, v82, v82);

                if typeof(v81) == "Vector3" then
                    v81 = CFrame.new(v81);
                end;

                local u83, v84 = u28(v81, v68, (Vector3.new(Magnitude + 0.55, 0.5, v82 + 0.05)));

                if u83 then
                    local v85 = {
                        Anchored = true,
                        CanCollide = false,
                        Material = Enum.Material.Slate,
                        Size = Vector3_new_ret,
                        Color = Color3.fromRGB(90, 76, 66)
                    };

                    if typeof(v84) == "Vector3" then
                        v84 = CFrame.new(v84);
                    end;

                    v85.CFrame = v84;
                    local u86 = u14("Part", v85);
                    u86.CFrame = CFrame.lookAt(u86.Position, (Vector3.new(p65.X, 0, p65.Z)));
                    u83.CFrame = u86.CFrame;
                    local v87 = CFrame.lookAt(u86.Position, (Vector3.new(p65.X, 0, p65.Z))) * CFrame.new(0, Random_new_ret:NextNumber(v70[1], v70[2]), u31(v72[1], v72[2]));
                    local CFrame_fromEulerAnglesXYZ = CFrame.fromEulerAnglesXYZ;
                    local v88 = Random_new_ret:NextNumber(v69[1], v69[2]);
                    local math_rad_ret = math.rad(v88);
                    local v89 = Random_new_ret:NextNumber(v71[1], v71[2]);
                    local v90 = v87 * CFrame_fromEulerAnglesXYZ(math_rad_ret, math.rad(v89), 0);
                    task.spawn(function() -- Line: 236
                        -- upvalues: u77 (copy), u83 (copy), u78 (copy), u86 (copy)
                        u77[#u77 + 1] = u83;
                        u78[#u78 + 1] = u86;
                    end);
                    Modes[u73.Entrance or "Enlarge"](u86, u73.EntranceSpeed or 0.3, {
                        CFrame = v90
                    });
                    Modes[u73.Entrance or "Enlarge"](u83, u73.EntranceSpeed or 0.3, {
                        CFrame = v90 * CFrame.new(0, v82 / 2 + 0.15, 0)
                    });

                    if v74.Entrance then
                        if v74.EntranceDivision == "Iterate" then
                            if v74.Entrance == "Stepped" then
                                task.wait();
                                v80 = i;
                            else
                                task.wait(v74.Entrance);
                                v80 = i;
                            end;
                        else
                            local v91 = (math.floor(#v76 * v75 + 0.5) - 1) * (v79 / (v74.EntranceDivision or 3));

                            if math.floor(v91) == i and i ~= math.floor(#v76 * v75 + 0.5) - 1 then
                                if v74.Entrance == "Stepped" then
                                    task.wait();
                                else
                                    task.wait(v74.Entrance);
                                end;

                                v79 = v79 + 1;
                                v80 = i;
                            else
                                v80 = i;
                            end;
                        end;
                    else
                        v80 = i;
                    end;
                else
                    v80 = i;
                end;
            end;
        end;

        task.wait(p66.HoldTime or 5);
        local v92 = 1;

        for i = 1, #u77 do
            Modes[u73.Exit or "Shrink"](u77[i], u73.ExitSpeed or 0.3);
            Modes[u73.Exit or "Shrink"](u78[i], u73.ExitSpeed or 0.3);

            if v74.Exit and (math.floor(#u77 * (v92 / (v74.ExitDivision or 2))) == i and i ~= #u77) then
                if v74.Exit == "Stepped" then
                    task.wait();
                else
                    task.wait(v74.Exit);
                end;

                v92 = v92 + 1;
            end;

            task.spawn(function() -- Line: 280
                -- upvalues: u73 (copy), InstanceHandler (ref), u77 (copy), i (copy), u78 (copy)
                task.wait((u73.ExitSpeed or 0.3) + 0.15);
                InstanceHandler.returnInstance("Part", u77[i]);
                InstanceHandler.returnInstance("Part", u78[i]);
            end);
            local _ = i;
        end;
    end,

    Orbit = function(p93, p94) -- Line: 288
        -- upvalues: u40 (copy), Random_new_ret (copy), u28 (copy), u31 (copy), Modes (copy), InstanceHandler (copy)
        local v95 = p94.BlockSize or { 2, 3.5 };
        local v96 = p94.Range or 5;
        local v97 = p94.Angle or { 45, 65 };
        local v98 = p94.Height or { 0, 0 };
        local v99 = p94.Tilt or { 0, 0 };
        local v100 = p94.PartOffset or { 0, 0 };
        local u101 = p94.FlourishTypes or {};
        local v102 = p94.IterateSpeed or {};
        local v103 = p94.CircleComplete or 1;
        local v104 = u40(p93, p94.Radius or 8, p94.PartCount or 10);
        local u105 = {};
        local v106 = 1;

        for i = 1, math.floor(#v104 * v103 + 0.5) - 1 do
            local v107 = v104[i];
            local v108 = Random_new_ret:NextNumber(v95[1], v95[2]);

            if typeof(v107) == "Vector3" then
                v107 = CFrame.new(v107);
            end;

            local u109, _ = u28(v107, v96, (Vector3.new(v108, v108, v108)));
            local v110;

            if u109 then
                local v111 = CFrame.lookAt(u109.Position, (Vector3.new(p93.X, 0, p93.Z))) * CFrame.new(0, Random_new_ret:NextNumber(v98[1], v98[2]), u31(v100[1], v100[2]));
                local CFrame_fromEulerAnglesXYZ = CFrame.fromEulerAnglesXYZ;
                local v112 = Random_new_ret:NextNumber(v97[1], v97[2]);
                local math_rad_ret = math.rad(v112);
                local v113 = Random_new_ret:NextNumber(v99[1], v99[2]);
                local v114 = {
                    CFrame = v111 * CFrame_fromEulerAnglesXYZ(math_rad_ret, math.rad(v113), 0)
                };
                u109.CFrame = CFrame.lookAt(u109.Position, (Vector3.new(p93.X, 0, p93.Z)));
                task.spawn(function() -- Line: 314
                    -- upvalues: u105 (copy), u109 (copy)
                    u105[#u105 + 1] = u109;
                end);
                Modes[u101.Entrance or "Enlarge"](u109, u101.EntranceSpeed or 0.3, v114);

                if v102.Entrance then
                    if v102.EntranceDivision == "Iterate" then
                        if v102.Entrance == "Stepped" then
                            task.wait();
                            v110 = i;
                        else
                            task.wait(v102.Entrance);
                            v110 = i;
                        end;
                    else
                        local v115 = (math.floor(#v104 * v103 + 0.5) - 1) * (v106 / (v102.EntranceDivision or 3));

                        if math.floor(v115) == i and i ~= math.floor(#v104 * v103 + 0.5) - 1 then
                            if v102.Entrance == "Stepped" then
                                task.wait();
                            else
                                task.wait(v102.Entrance);
                            end;

                            v106 = v106 + 1;
                            v110 = i;
                        else
                            v110 = i;
                        end;
                    end;
                else
                    v110 = i;
                end;
            else
                v110 = i;
            end;
        end;

        task.wait(p94.HoldTime or 5);
        local v116 = 1;

        for i = 1, #u105 do
            Modes[u101.Exit or "Shrink"](u105[i], u101.ExitSpeed or 0.3);

            if v102.Exit then
                if v102.ExitDivision == "Iterate" then
                    if v102.Exit == "Stepped" then
                        task.wait();
                    else
                        task.wait(v102.Exit);
                    end;
                elseif math.floor(#u105 * (v116 / (v102.ExitDivision or 2))) == i and i ~= #u105 then
                    if v102.Exit == "Stepped" then
                        task.wait();
                    else
                        task.wait(v102.Exit);
                    end;

                    v116 = v116 + 1;
                end;
            end;

            task.spawn(function() -- Line: 360
                -- upvalues: u101 (copy), InstanceHandler (ref), u105 (copy), i (copy)
                task.wait((u101.ExitSpeed or 0.3) + 0.15);
                InstanceHandler.returnInstance("Part", u105[i]);
            end);
            local _ = i;
        end;
    end,

    Path = function(p117, p118) -- Line: 367
        -- upvalues: u28 (copy), Random_new_ret (copy), Modes (copy), InstanceHandler (copy)
        local v119 = p118.BlockSize or { 1.5, 2 };
        local v120 = p118.Distance or 15;
        local v121 = p118.StepSize or v119[1];
        local v122 = p118.Width or { 1, 3 };
        local v123 = p118.Range or 5;
        local v124 = p118.Angle or { -1000, 1000 };
        local v125 = p118.Height or { 0, 0 };
        local v126 = p118.Tilt or { -1000, 1000 };
        local v127 = p118.RightCurve and (-p118.RightCurve or 0) or 0;
        local v128 = p118.LeftCurve or 0;
        local v129 = p118.RightOffset or 0;
        local v130 = p118.LeftOffset or 0;
        local u131 = p118.FlourishTypes or {};
        local v132 = p118.IterateSpeed or {};
        local v133 = p117 * CFrame.new(v122[1], 0, 0);
        local v134 = p117 * CFrame.new(v122[2], 0, -v120);
        local v135 = p117 * CFrame.new(-v122[1], 0, 0);
        local v136 = p117 * CFrame.new(-v122[2], 0, -v120);
        local v137 = (v133.Position + v134.Position) / 2;
        local v138 = (v135.Position + v136.Position) / 2;
        local u139 = {};
        local u140 = {};
        local v141 = 1;

        for i = 0, v120, v121 do
            local v142 = v122[1];
            local _ = v142 + (v122[2] - v142) * (i / v120);
            local v143 = v119[1];
            local v144 = v143 + (v119[2] - v143) * (i / v120);
            local v145 = i / v120;
            local Position = v133.Position;
            local Position2 = (CFrame.lookAt(v137, v133.Position) * CFrame.new(v127, 0, v129)).Position;
            local v146 = (1 - v145) ^ 2 * Position + 2 * (1 - v145) * v145 * Position2 + v145 ^ 2 * v134.Position;

            if typeof(v146) == "Vector3" then
                v146 = CFrame.new(v146);
            end;

            local u147 = u28(v146, v123, (Vector3.new(v144, v144, v144)));
            local v148 = i / v120;
            local Position3 = v135.Position;
            local Position4 = (CFrame.lookAt(v138, v135.Position) * CFrame.new(v128, 0, v130)).Position;
            local v149 = (1 - v148) ^ 2 * Position3 + 2 * (1 - v148) * v148 * Position4 + v148 ^ 2 * v136.Position;

            if typeof(v149) == "Vector3" then
                v149 = CFrame.new(v149);
            end;

            local u150 = u28(v149, v123, (Vector3.new(v144, v144, v144)));

            if u147 then
                local v151 = Random_new_ret:NextNumber(v124[1], v124[2]);
                local v152 = Random_new_ret:NextNumber(v126[1], v126[2]);
                local v153 = u147.CFrame * CFrame.new(0, Random_new_ret:NextNumber(v125[1], v125[2]), 0) * CFrame.fromEulerAnglesXYZ(math.rad(v151), math.rad(v152), 0);
                local math_rad_ret = math.rad(v151);
                local math_rad_ret2 = math.rad(v152);
                u147.Orientation = Vector3.new(math_rad_ret, math_rad_ret2, 0);
                Modes[u131.Entrance or "Enlarge"](u147, u131.EntranceSpeed or 0.3, {
                    CFrame = v153
                });
            end;

            if u150 then
                local v154 = Random_new_ret:NextNumber(v124[1], v124[2]);
                local v155 = Random_new_ret:NextNumber(v126[1], v126[2]);
                local v156 = u150.CFrame * CFrame.new(0, Random_new_ret:NextNumber(v125[1], v125[2]), 0) * CFrame.fromEulerAnglesXYZ(math.rad(v154), math.rad(v155), 0);
                local math_rad_ret = math.rad(v154);
                local math_rad_ret2 = math.rad(v155);
                u150.Orientation = Vector3.new(math_rad_ret, math_rad_ret2, 0);
                Modes[u131.Entrance or "Enlarge"](u150, u131.EntranceSpeed or 0.3, {
                    CFrame = v156
                });
            end;

            task.spawn(function() -- Line: 418
                -- upvalues: u139 (copy), u147 (copy), u140 (copy), u150 (copy)
                u139[#u139 + 1] = u147;
                u140[#u140 + 1] = u150;
            end);
            local v157;

            if v132.Entrance then
                if v132.EntranceDivision == "Iterate" then
                    if v132.Entrance == "Stepped" then
                        task.wait();
                        v157 = i;
                    else
                        task.wait(v132.Entrance);
                        v157 = i;
                    end;
                elseif math.floor(v120 * (v141 / (v132.EntranceDivision or 3))) == i and i ~= v120 - 1 then
                    if v132.Entrance == "Stepped" then
                        task.wait();
                    else
                        task.wait(v132.Entrance);
                    end;

                    v141 = v141 + 1;
                    v157 = i;
                else
                    v157 = i;
                end;
            else
                v157 = i;
            end;
        end;

        task.wait(p118.HoldTime or 5);
        local v158 = 1;

        for i = 1, math.max(#u139, #u140) do
            if u139[i] then
                Modes[u131.Exit or "Shrink"](u139[i], u131.ExitSpeed or 0.3);
            end;

            if u140[i] then
                Modes[u131.Exit or "Shrink"](u140[i], u131.ExitSpeed or 0.3);
            end;

            if v132.Exit then
                if v132.ExitDivision == "Iterate" then
                    if v132.Exit == "Stepped" then
                        task.wait();
                    else
                        task.wait(v132.Exit);
                    end;
                elseif math.floor(#u139 * (v158 / (v132.ExitDivision or 2))) == i and i ~= #u139 then
                    if v132.Exit == "Stepped" then
                        task.wait();
                    else
                        task.wait(v132.Exit);
                    end;

                    v158 = v158 + 1;
                end;
            end;

            task.spawn(function() -- Line: 468
                -- upvalues: u131 (copy), InstanceHandler (ref), u139 (copy), i (copy), u140 (copy)
                task.wait((u131.ExitSpeed or 0.3) + 0.15);
                InstanceHandler.returnInstance("Part", u139[i]);
                InstanceHandler.returnInstance("Part", u140[i]);
            end);
            local _ = i;
        end;
    end,

    Break = function(p159, p160) -- Line: 476
        -- upvalues: Random_new_ret (copy), u31 (copy), u28 (copy), PhysicsService (copy), Modes (copy), InstanceHandler (copy)
        local v161 = p160.BlockSize or { 0.25, 0.5 };
        local v162 = p160.PartCount or 10;
        local v163 = p160.Radius or 8;
        local v164 = p160.Width or { -8, 8 };
        local v165 = p160.Range or 5;
        local v166 = p160.Angle or { 45, 65 };
        local v167 = p160.Height or { 0, 0 };
        local u168 = p160.FlourishTypes or {};
        local v169 = p160.IterateSpeed or {};
        local u170 = {};
        local v171 = 1;

        for i = 1, v162 do
            local v172 = Random_new_ret:NextNumber(v161[1], v161[2]);
            local v173 = Random_new_ret:NextNumber(v161[1], v161[2]);
            local Vector3_new_ret = Vector3.new(v172, v173, u31(v161[1], v161[2]));
            local v174, _ = u28(p159 * CFrame.new(Random_new_ret:NextNumber(-v163, v163), 0, u31(-v163, v163)), v165, Vector3_new_ret);
            local v175;

            if v174 then
                PhysicsService:SetPartCollisionGroup(v174, "Blocks");
                v174.CFrame = v174.CFrame * CFrame.new(0, v174.Size.Y / 2, 0);
                v174.Anchored = false;
                v174.CanCollide = true;
                u170[#u170 + 1] = v174;
                Modes[u168.Entrance or "Enlarge"](v174, u168.EntranceSpeed or 0.3, {
                    CFrame = v174.CFrame
                });
                local BodyVelocity = Instance.new("BodyVelocity", v174);
                BodyVelocity.MaxForce = Vector3.new(inf, inf, inf);
                BodyVelocity.P = 100000;
                local v176 = Random_new_ret:NextNumber(v164[1], v164[2]);
                local v177 = Random_new_ret:NextNumber(v167[1], v167[2]);
                BodyVelocity.Velocity = Vector3.new(v176, v177, u31(v164[1], v164[2]));
                local BodyAngularVelocity = Instance.new("BodyAngularVelocity");
                BodyAngularVelocity.Name = "BodyAngularVelocityBasketball";
                BodyAngularVelocity.Parent = v174;
                local v178 = Random_new_ret:NextNumber(-v166[1], v166[2]);
                local v179 = Random_new_ret:NextNumber(-v166[1], v166[2]);
                BodyAngularVelocity.AngularVelocity = Vector3.new(v178, v179, u31(-v166[1], v166[2]));
                BodyAngularVelocity.MaxTorque = Vector3.new(inf, inf, inf);
                BodyAngularVelocity.P = 100000;
                game:GetService("Debris"):AddItem(BodyVelocity, 0.25);
                game:GetService("Debris"):AddItem(BodyAngularVelocity, 0.1);

                if v169.Entrance then
                    if v169.EntranceDivision == "Iterate" then
                        if v169.Entrance == "Stepped" then
                            task.wait();
                            v175 = i;
                        else
                            task.wait(v169.Entrance);
                            v175 = i;
                        end;
                    elseif math.floor(v162 * (v171 / (v169.EntranceDivision or 3)) + 0.5) == i and i ~= v162 then
                        if v169.Entrance == "Stepped" then
                            task.wait();
                        else
                            task.wait(v169.Entrance);
                        end;

                        v171 = v171 + 1;
                        v175 = i;
                    else
                        v175 = i;
                    end;
                else
                    v175 = i;
                end;
            else
                v175 = i;
            end;
        end;

        task.wait(p160.HoldTime or 5);
        local v180 = 1;

        for i = 1, #u170 do
            Modes[u168.Exit or "Shrink"](u170[i], u168.ExitSpeed or 0.3);

            if v169.Exit then
                if v169.ExitDivision == "Iterate" then
                    if v169.Exit == "Stepped" then
                        task.wait();
                    else
                        task.wait(v169.Exit);
                    end;
                elseif math.floor(#u170 * (v180 / (v169.ExitDivision or 2))) == i and i ~= #u170 then
                    if v169.Exit == "Stepped" then
                        task.wait();
                    else
                        task.wait(v169.Exit);
                    end;

                    v180 = v180 + 1;
                end;
            end;

            task.spawn(function() -- Line: 556
                -- upvalues: u168 (copy), InstanceHandler (ref), u170 (copy), i (copy)
                task.wait((u168.ExitSpeed or 0.3) + 0.15);
                InstanceHandler.returnInstance("Part", u170[i]);
            end);
            local _ = i;
        end;
    end
};