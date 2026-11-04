  

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

local function AssertTypes(p4, ...) -- Line: 59
    local v5 = {};
    local v6 = "";

    for _, v in pairs({ ... }) do
        v5[v] = true;
        v6 = v6 .. (v6 == "" and "" or " or ") .. v;
    end;

    local v7 = type(p4);
    assert(v5[v7], v6 .. " type expected, got: " .. v7);
end;

local function Det3x3(p8: number, p9: number, p10: number, p11: number, p12: number, p13: number, p14: number, p15: number, p16: number) -- Line: 71
    return p8 * (p12 * p16 - p13 * p15) - p9 * (p11 * p16 - p13 * p14) + p10 * (p11 * p15 - p12 * p14);
end;

local function RayIntersection(p17: vector, p18: vector, p19: vector, p20: vector) -- Line: 79
    local v21 = p18:Cross(p20);
    local v22 = p19.X - p17.X;
    local v23 = p19.Y - p17.Y;
    local v24 = p19.Z - p17.Z;
    local Y = p18.Y;
    local v25 = -p20.Y;
    local Y2 = v21.Y;
    local Z = p18.Z;
    local v26 = -p20.Z;
    local Z2 = v21.Z;
    local v27 = p18.X * (v25 * Z2 - Y2 * v26) - -p20.X * (Y * Z2 - Y2 * Z) + v21.X * (Y * v26 - v25 * Z);

    if v27 == 0 then
        return Vector3.new(0, 0, 0);
    end;

    local v28 = -p20.Y;
    local Y3 = v21.Y;
    local v29 = -p20.Z;
    local Z3 = v21.Z;
    local Y4 = p18.Y;
    local Y5 = v21.Y;
    local Z4 = p18.Z;
    local Z5 = v21.Z;
    local v30 = p17 + (v22 * (v28 * Z3 - Y3 * v29) - -p20.X * (v23 * Z3 - Y3 * v24) + v21.X * (v23 * v29 - v28 * v24)) / v27 * p18;
    local v31 = p19 + (p18.X * (v23 * Z5 - Y5 * v24) - v22 * (Y4 * Z5 - Y5 * Z4) + v21.X * (Y4 * v24 - v23 * Z4)) / v27 * p20;

    return (v31 - v30).Magnitude >= 0.25 and Vector3.new(0, 0, 0) or v30 + (v31 - v30) * 0.5;
end;

local BaseOcclusion = require(script.Parent:WaitForChild("BaseOcclusion"));
local u32 = setmetatable({}, BaseOcclusion);
u32.__index = u32;

function u32.new() -- Line: 112
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

function u32.Enable(p35, p36) -- Line: 145
    p35.enabled = p36;

    if not p36 then
        p35:Cleanup();
    end;
end;

function u32.GetOcclusionMode(p37) -- Line: 153
    return Enum.DevCameraOcclusionMode.Invisicam;
end;

function u32.LimbBehavior(p38, p39) -- Line: 158
    for i, _ in pairs(p38.trackedLimbs) do
        p39[#p39 + 1] = i.Position;
    end;
end;

function u32.MoveBehavior(p40, p41) -- Line: 164
    for i = 1, 3 do
        local Position = p40.humanoidRootPart.Position;
        local Velocity = p40.humanoidRootPart.Velocity;
        local v42 = Vector3.new(Velocity.X, 0, Velocity.Z).Magnitude / 2;
        p41[#p41 + 1] = Position + (i - 1) * p40.humanoidRootPart.CFrame.lookVector * v42;
        local _ = i;
    end;
end;

function u32.CornerBehavior(p43, p44) -- Line: 173
    -- upvalues: u3 (copy)
    local CFrame2 = p43.humanoidRootPart.CFrame;
    local Position = CFrame2.Position;
    local v45 = CFrame2 - Position;
    local v46 = p43.char:GetExtentsSize() / 2;
    p44[#p44 + 1] = Position;

    for i = 1, #u3 do
        p44[#p44 + 1] = Position + v45 * (v46 * u3[i]);
        local _ = i;
    end;
end;

function u32.CircleBehavior(p47, p48) -- Line: 184
    -- upvalues: u1 (copy)
    local v49;

    if p47.mode == u1.CIRCLE1 then
        v49 = p47.humanoidRootPart.CFrame;
    else
        local CoordinateFrame = p47.camera.CoordinateFrame;
        v49 = CoordinateFrame - CoordinateFrame.Position + p47.humanoidRootPart.Position;
    end;

    p48[#p48 + 1] = v49.Position;

    for i = 0, 9 do
        local v50 = 0.6283185307179586 * i;
        local math_cos_ret = math.cos(v50);
        local math_sin_ret = math.sin(v50);
        local v51 = Vector3.new(math_cos_ret, math_sin_ret, 0) * 3;
        p48[#p48 + 1] = v49 * v51;
        local _ = i;
    end;
end;

function u32.LimbMoveBehavior(p52, p53) -- Line: 200
    p52:LimbBehavior(p53);
    p52:MoveBehavior(p53);
end;

function u32.CharacterOutlineBehavior(p54, p55) -- Line: 205
    local unit = p54.torsoPart.CFrame.upVector.unit;
    local unit2 = p54.torsoPart.CFrame.rightVector.unit;
    p55[#p55 + 1] = p54.torsoPart.CFrame.p;
    p55[#p55 + 1] = p54.torsoPart.CFrame.p + unit;
    p55[#p55 + 1] = p54.torsoPart.CFrame.p - unit;
    p55[#p55 + 1] = p54.torsoPart.CFrame.p + unit2;
    p55[#p55 + 1] = p54.torsoPart.CFrame.p - unit2;

    if p54.headPart then
        p55[#p55 + 1] = p54.headPart.CFrame.p;
    end;

    local CFrame_new_ret = CFrame.new(Vector3.new(0, 0, 0), (Vector3.new(p54.camera.CoordinateFrame.lookVector.X, 0, p54.camera.CoordinateFrame.lookVector.Z)));
    local v56 = p54.torsoPart and p54.torsoPart.Position or p54.humanoidRootPart.Position;
    local v57 = { p54.torsoPart };

    if p54.headPart then
        v57[#v57 + 1] = p54.headPart;
    end;

    for i = 1, 24 do
        local v58 = 6.283185307179586 * i / 24;
        local math_cos_ret = math.cos(v58);
        local math_sin_ret = math.sin(v58);
        local v59 = CFrame_new_ret * (Vector3.new(math_cos_ret, math_sin_ret, 0) * 3);
        local X = v59.X;
        local math_max_ret = math.max(v59.Y, -2.25);
        local Vector3_new_ret = Vector3.new(X, math_max_ret, v59.Z);
        local Ray_new_ret = Ray.new(v56 + Vector3_new_ret, -3 * Vector3_new_ret);
        local v60, v61 = game.Workspace:FindPartOnRayWithWhitelist(Ray_new_ret, v57, false);
        local v62;

        if v60 then
            p55[#p55 + 1] = v61 + 0.2 * (v56 - v61).unit;
            v62 = i;
        else
            v62 = i;
        end;
    end;
end;

function u32.SmartCircleBehavior(p63, p64) -- Line: 244
    -- upvalues: RayIntersection (copy)
    local unit = p63.torsoPart.CFrame.upVector.unit;
    local unit2 = p63.torsoPart.CFrame.rightVector.unit;
    p64[#p64 + 1] = p63.torsoPart.CFrame.p;
    p64[#p64 + 1] = p63.torsoPart.CFrame.p + unit;
    p64[#p64 + 1] = p63.torsoPart.CFrame.p - unit;
    p64[#p64 + 1] = p63.torsoPart.CFrame.p + unit2;
    p64[#p64 + 1] = p63.torsoPart.CFrame.p - unit2;

    if p63.headPart then
        p64[#p64 + 1] = p63.headPart.CFrame.p;
    end;

    local v65 = p63.camera.CFrame - p63.camera.CFrame.p;
    local v66 = Vector3.new(0, 0.5, 0) + (p63.torsoPart and p63.torsoPart.Position or p63.humanoidRootPart.Position);

    for i = 1, 24 do
        local v67 = 0.2617993877991494 * i - 1.5707963267948966;
        local math_cos_ret = math.cos(v67);
        local math_sin_ret = math.sin(v67);
        local v68 = v66 + v65 * (Vector3.new(math_cos_ret, math_sin_ret, 0) * 2.5);
        local v69 = v68 - p63.camera.CFrame.p;
        local Ray_new_ret = Ray.new(v66, v68 - v66);
        local v70, v71, v72 = game.Workspace:FindPartOnRayWithIgnoreList(Ray_new_ret, { p63.char }, false, false);

        if v70 then
            local v73 = v71 + 0.1 * v72.unit;
            local v74 = v73 - v66;
            local unit3 = v74:Cross(v69).unit:Cross(v72).unit;
            local unit4 = (v73 - p63.camera.CFrame.p).unit;

            if v74.unit:Dot(-unit3) < v74.unit:Dot(unit4) then
                v68 = RayIntersection(v73, unit3, v68, v69);

                if v68.Magnitude > 0 then
                    local Ray_new_ret2 = Ray.new(v73, v68 - v73);
                    local v75, v76, v77 = game.Workspace:FindPartOnRayWithIgnoreList(Ray_new_ret2, { p63.char }, false, false);

                    if v75 then
                        v68 = v76 + 0.1 * v77.unit;
                    end;
                else
                    v68 = v73;
                end;
            else
                v68 = v73;
            end;

            local Ray_new_ret2 = Ray.new(v66, v68 - v66);
            local v78, v79, _ = game.Workspace:FindPartOnRayWithIgnoreList(Ray_new_ret2, { p63.char }, false, false);

            if v78 then
                v68 = v79 - 0.1 * (v68 - v66).unit;
            end;
        end;

        p64[#p64 + 1] = v68;
        local _ = i;
    end;
end;

function u32.CheckTorsoReference(p80) -- Line: 329
    if p80.char then
        p80.torsoPart = p80.char:FindFirstChild("Torso");

        if not p80.torsoPart then
            p80.torsoPart = p80.char:FindFirstChild("UpperTorso");

            if not p80.torsoPart then
                p80.torsoPart = p80.char:FindFirstChild("HumanoidRootPart");
            end;
        end;

        p80.headPart = p80.char:FindFirstChild("Head");
    end;
end;

function u32.CharacterAdded(u81: table, p82: userdata, p83: userdata) -- Line: 343
    -- upvalues: Players (copy), u2 (copy)
    if p83 ~= Players.LocalPlayer then
        return;
    end;

    if u81.childAddedConn then
        u81.childAddedConn:Disconnect();
        u81.childAddedConn = nil;
    end;

    if u81.childRemovedConn then
        u81.childRemovedConn:Disconnect();
        u81.childRemovedConn = nil;
    end;

    u81.char = p82;
    u81.trackedLimbs = {};
    u81.childAddedConn = p82.ChildAdded:Connect(function(p84) -- Line: 359, Name: childAdded
        -- upvalues: u2 (ref), u81 (copy)
        if p84:IsA("BasePart") then
            if u2[p84.Name] then
                u81.trackedLimbs[p84] = true;
            end;

            if p84.Name == "Torso" or p84.Name == "UpperTorso" then
                u81.torsoPart = p84;
            end;

            if p84.Name == "Head" then
                u81.headPart = p84;
            end;
        end;
    end);
    u81.childRemovedConn = p82.ChildRemoved:Connect(function(p85) -- Line: 375, Name: childRemoved
        -- upvalues: u81 (copy)
        u81.trackedLimbs[p85] = nil;
        u81:CheckTorsoReference();
    end);

    for _, child in pairs(u81.char:GetChildren()) do
        if child:IsA("BasePart") then
            if u2[child.Name] then
                u81.trackedLimbs[child] = true;
            end;

            if child.Name == "Torso" or child.Name == "UpperTorso" then
                u81.torsoPart = child;
            end;

            if child.Name == "Head" then
                u81.headPart = child;
            end;
        end;
    end;
end;

function u32.SetMode(p86: table, p87: number) -- Line: 389
    -- upvalues: AssertTypes (copy), u1 (copy)
    AssertTypes(p87, "number");

    for _, v in pairs(u1) do
        if v == p87 then
            p86.mode = p87;
            p86.behaviorFunction = p86.behaviors[p86.mode];

            return;
        end;
    end;

    error("Invalid mode number");
end;

function u32.GetObscuredParts(p88) -- Line: 401
    return p88.savedHits;
end;

function u32.Cleanup(p89) -- Line: 406
    for i, v in pairs(p89.savedHits) do
        i.LocalTransparencyModifier = v;
    end;
end;

function u32.Update(u90: table, p91: number, p92, p93) -- Line: 412
    if not (u90.enabled and u90.char) then
        return p92, p93;
    end;

    u90.camera = game.Workspace.CurrentCamera;

    if not u90.humanoidRootPart then
        local v94 = u90.char:FindFirstChildOfClass("Humanoid");

        if v94 and v94.RootPart then
            u90.humanoidRootPart = v94.RootPart;
        else
            u90.humanoidRootPart = u90.char:FindFirstChild("HumanoidRootPart");

            if not u90.humanoidRootPart then
                return p92, p93;
            end;
        end;

        local u95 = nil;
        u95 = u90.humanoidRootPart.AncestryChanged:Connect(function(p96, p97) -- Line: 437
            -- upvalues: u90 (copy), u95 (ref)
            if p96 == u90.humanoidRootPart and not p97 then
                u90.humanoidRootPart = nil;

                if u95 and u95.Connected then
                    u95:Disconnect();
                    u95 = nil;
                end;
            end;
        end);
    end;

    if not u90.torsoPart then
        u90:CheckTorsoReference();

        if not u90.torsoPart then
            return p92, p93;
        end;
    end;

    local v98 = {};
    u90.behaviorFunction(u90, v98);
    local u99 = {};
    local v100 = { u90.char };

    local function add(p101) -- Line: 463
        -- upvalues: u99 (copy), u90 (copy)
        u99[p101] = true;

        if not u90.savedHits[p101] then
            u90.savedHits[p101] = p101.LocalTransparencyModifier;
        end;
    end;

    local PartsObscuringTarget = u90.camera:GetPartsObscuringTarget({ u90.headPart and u90.headPart.CFrame.p or v98[1], u90.torsoPart and u90.torsoPart.CFrame.p or v98[2] }, v100);
    local v102 = 0;
    local v103 = {};
    local v104 = 0.75;
    local v105 = 0.75;

    for i = 1, #PartsObscuringTarget do
        local v106 = PartsObscuringTarget[i];
        v102 = v102 + 1;
        v103[v106] = true;
        local _ = i;

        for _, child in pairs(v106:GetChildren()) do
            if child:IsA("Decal") or child:IsA("Texture") then
                v102 = v102 + 1;
                break;
            end;
        end;
    end;

    if v102 > 0 then
        v104 = math.pow(0.375 / v102 + 0.375, 1 / v102);
        v105 = math.pow(0.25 / v102 + 0.25, 1 / v102);
    end;

    local PartsObscuringTarget2 = u90.camera:GetPartsObscuringTarget(v98, v100);
    local v107 = {};

    for i = 1, #PartsObscuringTarget2 do
        local v108 = PartsObscuringTarget2[i];
        v107[v108] = v103[v108] and v104 and v104 or v105;

        if v108.Transparency < v107[v108] then
            u99[v108] = true;

            if not u90.savedHits[v108] then
                u90.savedHits[v108] = v108.LocalTransparencyModifier;
            end;
        end;

        local _ = i;

        for _, child in pairs(v108:GetChildren()) do
            if (child:IsA("Decal") or child:IsA("Texture")) and child.Transparency < v107[v108] then
                v107[child] = v107[v108];
                u99[child] = true;

                if not u90.savedHits[child] then
                    u90.savedHits[child] = child.LocalTransparencyModifier;
                end;
            end;
        end;
    end;

    for i, v in pairs(u90.savedHits) do
        if u99[i] then
            i.LocalTransparencyModifier = i.Transparency < 1 and ((v107[i] - i.Transparency) / (1 - i.Transparency) or 0) or 0;
        else
            i.LocalTransparencyModifier = v;
            u90.savedHits[i] = nil;
        end;
    end;

    return p92, p93;
end;

return u32;