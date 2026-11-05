  

 

local Players = game:GetService("Players");
local u1 = {
    LIMBS = 2,
    MOVEMENT = 3,
    CORNERS = 4,
    CIRCLE1 = 5,
    CIRCLE2 = 6,
    LIMBMOVE = 7,
    SMART_CIRCLE = 8,
    CHAR_OUTLINE = 9
};
local u2 = {
    Head = true,
    ["Left Arm"] = true,
    ["Right Arm"] = true,
    ["Left Leg"] = true,
    ["Right Leg"] = true,
    LeftLowerArm = true,
    RightLowerArm = true,
    LeftUpperLeg = true,
    RightUpperLeg = true
};
local u3 = { Vector3.new(1, 1, -1), Vector3.new(1, -1, -1), Vector3.new(-1, -1, -1), Vector3.new(-1, 1, -1) };

local function AssertTypes(p4, ...) -- Line: 58
    local v5 = {};
    local v6 = "";

    for _, v in pairs({ ... }) do
        v5[v] = true;
        v6 = v6 .. (v6 == "" and "" or " or ") .. v;
    end;

    local v7 = type(p4);
    assert(v5[v7], v6 .. " type expected, got: " .. v7);
end;

local function Det3x3(p8, p9, p10, p11, p12, p13, p14, p15, p16) -- Line: 70
    return p8 * (p12 * p16 - p13 * p15) - p9 * (p11 * p16 - p13 * p14) + p10 * (p11 * p15 - p12 * p14);
end;

local function RayIntersection(p17, p18, p19, p20) -- Line: 78
    local v21 = p18:Cross(p20);
    local v22 = p19.x - p17.x;
    local v23 = p19.y - p17.y;
    local v24 = p19.z - p17.z;
    local y = p18.y;
    local v25 = -p20.y;
    local y2 = v21.y;
    local z = p18.z;
    local v26 = -p20.z;
    local z2 = v21.z;
    local v27 = p18.x * (v25 * z2 - y2 * v26) - -p20.x * (y * z2 - y2 * z) + v21.x * (y * v26 - v25 * z);

    if v27 == 0 then
        return Vector3.new(0, 0, 0);
    end;

    local v28 = -p20.y;
    local y3 = v21.y;
    local v29 = -p20.z;
    local z3 = v21.z;
    local y4 = p18.y;
    local y5 = v21.y;
    local z4 = p18.z;
    local z5 = v21.z;
    local v30 = p17 + (v22 * (v28 * z3 - y3 * v29) - -p20.x * (v23 * z3 - y3 * v24) + v21.x * (v23 * v29 - v28 * v24)) / v27 * p18;
    local v31 = p19 + (p18.x * (v23 * z5 - y5 * v24) - v22 * (y4 * z5 - y5 * z4) + v21.x * (y4 * v24 - v23 * z4)) / v27 * p20;

    return (v31 - v30).Magnitude >= 0.25 and Vector3.new(0, 0, 0) or v30 + 0.5 * (v31 - v30);
end;

local BaseOcclusion = require(script.Parent:WaitForChild("BaseOcclusion"));
local u32 = setmetatable({}, BaseOcclusion);
u32.__index = u32;

function u32.new() -- Line: 111
    -- upvalues: BaseOcclusion (copy), u32 (copy), u1 (copy)
    local v33 = BaseOcclusion.new();
    local v34 = setmetatable(v33, u32);
    v34.char = nil;
    v34.humanoidRootPart = nil;
    v34.torsoPart = nil;
    v34.headPart = nil;
    v34.childAddedConn = nil;
    v34.childRemovedConn = nil;
    v34.behaviors = {};
    v34.behaviors[u1.LIMBS] = v34.LimbBehavior;
    v34.behaviors[u1.MOVEMENT] = v34.MoveBehavior;
    v34.behaviors[u1.CORNERS] = v34.CornerBehavior;
    v34.behaviors[u1.CIRCLE1] = v34.CircleBehavior;
    v34.behaviors[u1.CIRCLE2] = v34.CircleBehavior;
    v34.behaviors[u1.LIMBMOVE] = v34.LimbMoveBehavior;
    v34.behaviors[u1.SMART_CIRCLE] = v34.SmartCircleBehavior;
    v34.behaviors[u1.CHAR_OUTLINE] = v34.CharacterOutlineBehavior;
    v34.mode = u1.SMART_CIRCLE;
    v34.behaviorFunction = v34.SmartCircleBehavior;
    v34.savedHits = {};
    v34.trackedLimbs = {};
    v34.camera = game.Workspace.CurrentCamera;
    v34.enabled = false;

    return v34;
end;

function u32.Enable(p35, p36) -- Line: 144
    p35.enabled = p36;

    if not p36 then
        p35:Cleanup();
    end;
end;

function u32.GetOcclusionMode(p37) -- Line: 152
    return Enum.DevCameraOcclusionMode.Invisicam;
end;

function u32.LimbBehavior(p38, p39) -- Line: 157
    for i, _ in pairs(p38.trackedLimbs) do
        p39[#p39 + 1] = i.Position;
    end;
end;

function u32.MoveBehavior(p40, p41) -- Line: 163
    for i = 1, 3 do
        local Position = p40.humanoidRootPart.Position;
        local Velocity = p40.humanoidRootPart.Velocity;
        local v42 = Vector3.new(Velocity.X, 0, Velocity.Z).Magnitude / 2;
        p41[#p41 + 1] = Position + (i - 1) * p40.humanoidRootPart.CFrame.lookVector * v42;
    end;
end;

function u32.CornerBehavior(p43, p44) -- Line: 172
    -- upvalues: u3 (copy)
    local CFrame2 = p43.humanoidRootPart.CFrame;
    local p = CFrame2.p;
    local v45 = CFrame2 - p;
    local v46 = p43.char:GetExtentsSize() / 2;
    p44[#p44 + 1] = p;

    for i = 1, #u3 do
        p44[#p44 + 1] = p + v45 * (v46 * u3[i]);
    end;
end;

function u32.CircleBehavior(p47, p48) -- Line: 183
    -- upvalues: u1 (copy)
    local v49;

    if p47.mode == u1.CIRCLE1 then
        v49 = p47.humanoidRootPart.CFrame;
    else
        local CoordinateFrame = p47.camera.CoordinateFrame;
        v49 = CoordinateFrame - CoordinateFrame.p + p47.humanoidRootPart.Position;
    end;

    p48[#p48 + 1] = v49.p;

    for i = 0, 9 do
        local v50 = 0.6283185307179586 * i;
        local v51 = math.cos(v50);
        local v52 = math.sin(v50);
        local v53 = Vector3.new(v51, v52, 0) * 3;
        p48[#p48 + 1] = v49 * v53;
    end;
end;

function u32.LimbMoveBehavior(p54, p55) -- Line: 199
    p54:LimbBehavior(p55);
    p54:MoveBehavior(p55);
end;

function u32.CharacterOutlineBehavior(p56, p57) -- Line: 204
    local unit = p56.torsoPart.CFrame.upVector.unit;
    local unit2 = p56.torsoPart.CFrame.rightVector.unit;
    p57[#p57 + 1] = p56.torsoPart.CFrame.p;
    p57[#p57 + 1] = p56.torsoPart.CFrame.p + unit;
    p57[#p57 + 1] = p56.torsoPart.CFrame.p - unit;
    p57[#p57 + 1] = p56.torsoPart.CFrame.p + unit2;
    p57[#p57 + 1] = p56.torsoPart.CFrame.p - unit2;

    if p56.headPart then
        p57[#p57 + 1] = p56.headPart.CFrame.p;
    end;

    local v58 = CFrame.new(Vector3.new(0, 0, 0), (Vector3.new(p56.camera.CoordinateFrame.lookVector.X, 0, p56.camera.CoordinateFrame.lookVector.Z)));
    local v59 = p56.torsoPart and p56.torsoPart.Position or p56.humanoidRootPart.Position;
    local v60 = { p56.torsoPart };

    if p56.headPart then
        v60[#v60 + 1] = p56.headPart;
    end;

    for i = 1, 24 do
        local v61 = 6.283185307179586 * i / 24;
        local v62 = math.cos(v61);
        local v63 = math.sin(v61);
        local v64 = v58 * (Vector3.new(v62, v63, 0) * 3);
        local X = v64.X;
        local v65 = math.max(v64.Y, -2.25);
        local v66 = Vector3.new(X, v65, v64.Z);
        local v67 = Ray.new(v59 + v66, -3 * v66);
        local v68, v69 = game.Workspace:FindPartOnRayWithWhitelist(v67, v60, false, false);

        if v68 then
            p57[#p57 + 1] = v69 + 0.2 * (v59 - v69).unit;
        end;
    end;
end;

function u32.SmartCircleBehavior(p70, p71) -- Line: 243
    -- upvalues: RayIntersection (copy)
    local unit = p70.torsoPart.CFrame.upVector.unit;
    local unit2 = p70.torsoPart.CFrame.rightVector.unit;
    p71[#p71 + 1] = p70.torsoPart.CFrame.p;
    p71[#p71 + 1] = p70.torsoPart.CFrame.p + unit;
    p71[#p71 + 1] = p70.torsoPart.CFrame.p - unit;
    p71[#p71 + 1] = p70.torsoPart.CFrame.p + unit2;
    p71[#p71 + 1] = p70.torsoPart.CFrame.p - unit2;

    if p70.headPart then
        p71[#p71 + 1] = p70.headPart.CFrame.p;
    end;

    local v72 = p70.camera.CFrame - p70.camera.CFrame.p;
    local v73 = Vector3.new(0, 0.5, 0) + (p70.torsoPart and p70.torsoPart.Position or p70.humanoidRootPart.Position);

    for i = 1, 24 do
        local v74 = 0.2617993877991494 * i - 1.5707963267948966;
        local v75 = math.cos(v74);
        local v76 = math.sin(v74);
        local v77 = v73 + v72 * (Vector3.new(v75, v76, 0) * 2.5);
        local v78 = v77 - p70.camera.CFrame.p;
        local v79 = Ray.new(v73, v77 - v73);
        local v80, v81, v82 = game.Workspace:FindPartOnRayWithIgnoreList(v79, { p70.char }, false, false);

        if v80 then
            local v83 = v81 + 0.1 * v82.unit;
            local v84 = v83 - v73;
            local unit3 = v84:Cross(v78).unit:Cross(v82).unit;
            local unit4 = (v83 - p70.camera.CFrame.p).unit;

            if v84.unit:Dot(-unit3) < v84.unit:Dot(unit4) then
                v77 = RayIntersection(v83, unit3, v77, v78);

                if v77.Magnitude > 0 then
                    local v85 = Ray.new(v83, v77 - v83);
                    local v86, v87, v88 = game.Workspace:FindPartOnRayWithIgnoreList(v85, { p70.char }, false, false);

                    if v86 then
                        v77 = v87 + 0.1 * v88.unit;
                    end;
                else
                    v77 = v83;
                end;
            else
                v77 = v83;
            end;

            local v89 = Ray.new(v73, v77 - v73);
            local v90, v91, _ = game.Workspace:FindPartOnRayWithIgnoreList(v89, { p70.char }, false, false);

            if v90 then
                v77 = v91 - 0.1 * (v77 - v73).unit;
            end;
        end;

        p71[#p71 + 1] = v77;
    end;
end;

function u32.CheckTorsoReference(p92) -- Line: 328
    if p92.char then
        p92.torsoPart = p92.char:FindFirstChild("Torso");

        if not p92.torsoPart then
            p92.torsoPart = p92.char:FindFirstChild("UpperTorso");

            if not p92.torsoPart then
                p92.torsoPart = p92.char:FindFirstChild("HumanoidRootPart");
            end;
        end;

        p92.headPart = p92.char:FindFirstChild("Head");
    end;
end;

function u32.CharacterAdded(u93, p94, p95) -- Line: 342
    -- upvalues: Players (copy), u2 (copy)
    if p95 ~= Players.LocalPlayer then
        return;
    end;

    if u93.childAddedConn then
        u93.childAddedConn:Disconnect();
        u93.childAddedConn = nil;
    end;

    if u93.childRemovedConn then
        u93.childRemovedConn:Disconnect();
        u93.childRemovedConn = nil;
    end;

    u93.char = p94;
    u93.trackedLimbs = {};
    u93.childAddedConn = p94.ChildAdded:Connect(function(p96) -- Line: 358, Name: childAdded
        -- upvalues: u2 (ref), u93 (copy)
        if p96:IsA("BasePart") then
            if u2[p96.Name] then
                u93.trackedLimbs[p96] = true;
            end;

            if p96.Name == "Torso" or p96.Name == "UpperTorso" then
                u93.torsoPart = p96;
            end;

            if p96.Name == "Head" then
                u93.headPart = p96;
            end;
        end;
    end);
    u93.childRemovedConn = p94.ChildRemoved:Connect(function(p97) -- Line: 374, Name: childRemoved
        -- upvalues: u93 (copy)
        u93.trackedLimbs[p97] = nil;
        u93:CheckTorsoReference();
    end);

    for _, child in pairs(u93.char:GetChildren()) do
        if child:IsA("BasePart") then
            if u2[child.Name] then
                u93.trackedLimbs[child] = true;
            end;

            if child.Name == "Torso" or child.Name == "UpperTorso" then
                u93.torsoPart = child;
            end;

            if child.Name == "Head" then
                u93.headPart = child;
            end;
        end;
    end;
end;

function u32.SetMode(p98, p99) -- Line: 388
    -- upvalues: AssertTypes (copy), u1 (copy)
    AssertTypes(p99, "number");

    for _, v in pairs(u1) do
        if v == p99 then
            p98.mode = p99;
            p98.behaviorFunction = p98.behaviors[p98.mode];

            return;
        end;
    end;

    error("Invalid mode number");
end;

function u32.GetObscuredParts(p100) -- Line: 400
    return p100.savedHits;
end;

function u32.Cleanup(p101) -- Line: 405
    for i, v in pairs(p101.savedHits) do
        i.LocalTransparencyModifier = v;
    end;
end;

function u32.Update(u102, p103, p104, p105) -- Line: 411
    if not (u102.enabled and u102.char) then
        return p104, p105;
    end;

    u102.camera = game.Workspace.CurrentCamera;

    if not u102.humanoidRootPart then
        local v106 = u102.char:FindFirstChildOfClass("Humanoid");

        if v106 and v106.RootPart then
            u102.humanoidRootPart = v106.RootPart;
        else
            u102.humanoidRootPart = u102.char:FindFirstChild("HumanoidRootPart");

            if not u102.humanoidRootPart then
                return p104, p105;
            end;
        end;

        local u107 = nil;
        u107 = u102.humanoidRootPart.AncestryChanged:Connect(function(p108, p109) -- Line: 436
            -- upvalues: u102 (copy), u107 (ref)
            if p108 == u102.humanoidRootPart and not p109 then
                u102.humanoidRootPart = nil;

                if u107 and u107.Connected then
                    u107:Disconnect();
                    u107 = nil;
                end;
            end;
        end);
    end;

    if not u102.torsoPart then
        u102:CheckTorsoReference();

        if not u102.torsoPart then
            return p104, p105;
        end;
    end;

    local v110 = {};
    u102.behaviorFunction(u102, v110);
    local u111 = {};
    local v112 = { u102.char };

    local function add(p113) -- Line: 462
        -- upvalues: u111 (copy), u102 (copy)
        u111[p113] = true;

        if not u102.savedHits[p113] then
            u102.savedHits[p113] = p113.LocalTransparencyModifier;
        end;
    end;

    local v114 = u102.camera:GetPartsObscuringTarget({ u102.headPart and u102.headPart.CFrame.p or v110[1], u102.torsoPart and u102.torsoPart.CFrame.p or v110[2] }, v112);
    local v115 = 0;
    local v116 = {};
    local v117 = 0.75;
    local v118 = 0.75;

    for i = 1, #v114 do
        local v119 = v114[i];
        v115 = v115 + 1;
        v116[v119] = true;

        for _, child in pairs(v119:GetChildren()) do
            if child:IsA("Decal") or child:IsA("Texture") then
                v115 = v115 + 1;
                break;
            end;
        end;
    end;

    if v115 > 0 then
        v117 = math.pow(0.375 / v115 + 0.375, 1 / v115);
        v118 = math.pow(0.25 / v115 + 0.25, 1 / v115);
    end;

    local v120 = u102.camera:GetPartsObscuringTarget(v110, v112);
    local v121 = {};

    for i = 1, #v120 do
        local v122 = v120[i];
        v121[v122] = v116[v122] and v117 and v117 or v118;

        if v122.Transparency < v121[v122] then
            u111[v122] = true;

            if not u102.savedHits[v122] then
                u102.savedHits[v122] = v122.LocalTransparencyModifier;
            end;
        end;

        for _, child in pairs(v122:GetChildren()) do
            if (child:IsA("Decal") or child:IsA("Texture")) and child.Transparency < v121[v122] then
                v121[child] = v121[v122];
                u111[child] = true;

                if not u102.savedHits[child] then
                    u102.savedHits[child] = child.LocalTransparencyModifier;
                end;
            end;
        end;
    end;

    for i, v in pairs(u102.savedHits) do
        if u111[i] then
            i.LocalTransparencyModifier = i.Transparency < 1 and ((v121[i] - i.Transparency) / (1 - i.Transparency) or 0) or 0;
        else
            i.LocalTransparencyModifier = v;
            u102.savedHits[i] = nil;
        end;
    end;

    return p104, p105;
end;

return u32;