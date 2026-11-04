 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("ContentProvider");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local ChickenOrHero = ReplicatedStorage:WaitForChild("ChickenOrHero");
local Weapons = ChickenOrHero:WaitForChild("Weapons");
local SkinCatalog = require(Weapons:WaitForChild("SkinCatalog"));
local KnifeIconCopy = require(Weapons:WaitForChild("KnifeIconCopy"));
local EmoteCatalog = require(ChickenOrHero:WaitForChild("Emotes"):WaitForChild("EmoteCatalog"));
local EmotePlayback = require(ChickenOrHero.Emotes:WaitForChild("EmotePlayback"));
local CharacterClone = require(ChickenOrHero:WaitForChild("Interface"):WaitForChild("CharacterClone"));
local u1 = {
    MAX = 4
};
local u2 = {
    Common = Color3.fromRGB(175, 185, 192),
    Rare = Color3.fromRGB(92, 173, 238),
    Epic = Color3.fromRGB(183, 123, 244),
    Legendary = Color3.fromRGB(242, 191, 89),
    Mythical = Color3.fromRGB(255, 72, 96)
};
local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_new_ret2 = Color3.new(0, 0, 0);
local Color3_fromRGB_ret = Color3.fromRGB(255, 202, 58);
local Color3_fromRGB_ret2 = Color3.fromRGB(204, 190, 170);
local Color3_fromRGB_ret3 = Color3.fromRGB(255, 176, 70);
local u3 = {
    Color3.fromRGB(64, 42, 72),
    Color3.fromRGB(96, 58, 44),
    Color3.fromRGB(38, 28, 50),
    Color3.fromRGB(226, 120, 38)
};
local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);
local u4 = {
    Spring = { 9120972321, 0.5, 1.15 },
    Thud = { 9113480915, 0.8, 0.6 },
    Creak = { 10128760939, 0.14, 1 },
    Pop = { 10128766965, 0.5, 1.2 },
    Rattle = { 9114895481, 0.55, 1 },
    Open = { 91003116339881, 0.85, 1 },
    Boom = { 9113480915, 0.9, 0.45 },
    Reward = { 82803453482376, 0.5, 1 },
    Jackpot = { 9117278724, 0.4, 1 },
    Collect = { 9116395089, 0.55, 1.1 }
};
local NumberRange_new_ret = NumberRange.new(0.45, 1.75);
local Color3_fromRGB_ret4 = Color3.fromRGB(255, 97, 83);
local u5 = {
    HalloweenEmoteCrate = {
        kind = "door",
        lid = { "Cylinder.001" }
    },
    TreatCrate = {
        kind = "chest",
        drop = 0.3,
        lid = { "Cube.011" },
        remove = { "BézierCurve" },
        glow = Color3.fromRGB(176, 98, 255)
    },
    TrickCrate = {
        kind = "chest",
        lid = { "Top", "Leafs.002" }
    }
};

local function timeline(p6, p7) -- Line: 137
    local v8 = {
        land = 0,
        rest = 0,
        explode = 0
    };

    if p6 then
        v8.land = 0.62;
        v8.rest = 1.1199999999999999;
        v8.explode = v8.rest + 2.9 + 0.13;
    end;

    v8.risen = v8.explode + 0.75;
    v8.fly = v8.risen + (p7 and 4.4 or 3.2);
    v8.arrive = v8.fly + 0.55;
    v8.length = v8.arrive + 0.5;

    return v8;
end;

local function make(p9, p10, p11) -- Line: 152
    local Instance_new_ret = Instance.new(p9);

    for i, v in p11 do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p10;

    return Instance_new_ret;
end;

local function lerp(p12, p13, p14) -- Line: 161
    return p12 + (p13 - p12) * p14;
end;

local function unit(p15) -- Line: 164
    return math.clamp(p15, 0, 1);
end;

local function outCubic(p16) -- Line: 167
    return 1 - (1 - math.clamp(p16, 0, 1)) ^ 3;
end;

local function outBack(p17, p18) -- Line: 170
    local v19 = p18 or 1.70158;
    local v20 = math.clamp(p17, 0, 1) - 1;

    return 1 + v20 * v20 * ((v19 + 1) * v20 + v19);
end;

local function ramp(...) -- Line: 176
    local v21 = { ... };
    local v22 = {};

    for i, v in v21 do
        v22[i] = NumberSequenceKeypoint.new((i - 1) / (#v21 - 1), v);
    end;

    return NumberSequence.new(v22);
end;

local function flat(p23) -- Line: 184
    return Vector3.new(p23.X, 0, p23.Z);
end;

local function newPart(p24, p25, p26, p27) -- Line: 189
    local Part = Instance.new("Part");
    Part.Name = p25;
    Part.Size = p26 or Vector3.new(0.3, 0.3, 0.3);
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Transparency = 1;
    local Smooth = Enum.SurfaceType.Smooth;
    Part.TopSurface = Enum.SurfaceType.Smooth;
    Part.BottomSurface = Smooth;

    for i, v in p27 or {} do
        Part[i] = v;
    end;

    Part.Parent = p24;

    return Part;
end;

local function solid(p28) -- Line: 205
    p28.Anchored = true;
    p28.CanCollide = false;
    p28.CanQuery = false;
    p28.CanTouch = false;
end;

local u29 = { "LuaSourceContainer", "Sound", "ForceField", "BillboardGui", "SurfaceGui", "ProximityPrompt", "ClickDetector", "ParticleEmitter", "Trail", "Beam", "Light", "Fire", "Smoke", "Sparkles", "Highlight", "JointInstance", "WeldConstraint", "Constraint", "BodyMover" };

local function scrub(p30, p31) -- Line: 231
    for _, descendant in p30:GetDescendants() do
        if descendant:IsDescendantOf(p30) then
            local v32 = descendant;

            for _, v in p31 do
                if v32:IsA(v) then
                    v32:Destroy();
                    break;
                end;
            end;
        end;
    end;
end;

local function untag(p33) -- Line: 243
    -- upvalues: CollectionService (copy)
    for _, descendant in p33:GetDescendants() do
        local v34 = descendant;

        for _, v in CollectionService:GetTags(descendant) do
            CollectionService:RemoveTag(v34, v);
        end;
    end;

    for _, v in CollectionService:GetTags(p33) do
        CollectionService:RemoveTag(p33, v);
    end;
end;

local u35 = {};
local u36 = { Vector3.new(-1, -1, -1), Vector3.new(-1, -1, 1), Vector3.new(-1, 1, -1), Vector3.new(-1, 1, 1), Vector3.new(1, -1, -1), Vector3.new(1, -1, 1), Vector3.new(1, 1, -1), Vector3.new(1, 1, 1) };

local function crateCopy(p37) -- Line: 273
    -- upvalues: scrub (copy), u29 (copy), untag (copy), u5 (copy), u36 (copy), u35 (copy), Color3_fromRGB_ret4 (copy)
    if not (p37 and p37:IsA("Model")) then
        return nil;
    end;

    local v38 = p37:Clone();
    scrub(v38, u29);
    untag(v38);
    local v39 = u5[p37.Name] and (u5[p37.Name].remove or {}) or {};
    local v40 = {};
    local v41 = 0;
    local v42 = nil;

    for _, descendant in v38:GetDescendants() do
        if descendant:IsA("BasePart") and (descendant.Parent and (descendant.Transparency >= 0.99 or table.find(v39, descendant.Name))) then
            descendant:Destroy();
        end;
    end;

    for _, descendant in v38:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
            table.insert(v40, descendant);
            local v43 = descendant.Size.X * descendant.Size.Y * descendant.Size.Z;

            if v41 < v43 then
                v42 = descendant;
                v41 = v43;
            end;
        end;
    end;

    if not v42 then
        v38:Destroy();

        return nil;
    end;

    local _, v44 = v42.CFrame:ToOrientation();
    local v45 = CFrame.new(v42.Position) * CFrame.Angles(0, v44, 0);
    local v46 = Vector3.new(1, 1, 1) * (1 / 0);
    local v47 = Vector3.new(-1, -1, -1) * (1 / 0);

    for _, v in v40 do
        local v48 = v;

        for _, v2 in u36 do
            local v49 = v45:PointToObjectSpace(v48.CFrame * (v2 * v48.Size / 2));
            v46 = v46:Min(v49);
            v47 = v47:Max(v49);
        end;
    end;

    local v50 = v47 - v46;
    local v51 = v50.X < v50.Z;
    local v52 = (v51 and -1.5707963267948966 or 3.141592653589793) + (u35[p37.Name] or 0);
    local u53 = v45 * CFrame.new((v46.X + v47.X) / 2, v46.Y, (v46.Z + v47.Z) / 2) * CFrame.Angles(0, v52, 0);
    local v54 = p37.Parent and p37.Parent:FindFirstChildWhichIsA("ProximityPrompt", true);

    if v54 then
        v54 = v54.Parent;
    end;

    local v55;

    if v54 and v54:IsA("Attachment") then
        v55 = v54.WorldPosition;
    elseif v54 and v54:IsA("BasePart") then
        v55 = v54.Position;
    else
        v55 = nil;
    end;

    if v55 and u35[p37.Name] == nil then
        local v56 = v55 - u53.Position;
        local Vector3_new_ret = Vector3.new(v56.X, 0, v56.Z);

        if Vector3_new_ret.Magnitude > 0.1 and u53.LookVector:Dot(Vector3_new_ret) < 0 then
            u53 = u53 * CFrame.Angles(0, 3.141592653589793, 0);
        end;
    end;

    v38.WorldPivot = u53;
    local v57 = 9 / math.max(v50.X, v50.Y, v50.Z);
    local math_min_ret = math.min(1, v57);

    local function boundsIn(p58) -- Line: 337
        -- upvalues: u36 (ref), u53 (ref)
        local v59 = Vector3.new(1, 1, 1) * (1 / 0);
        local v60 = Vector3.new(-1, -1, -1) * (1 / 0);

        for _, v in p58 do
            local v61 = v;

            for _, v2 in u36 do
                local v62 = u53:PointToObjectSpace(v61.CFrame * (v2 * v61.Size / 2));
                v59 = v59:Min(v62);
                v60 = v60:Max(v62);
            end;
        end;

        return v59, v60;
    end;

    local v63 = u5[p37.Name];
    local v64 = {};
    local v65 = {};
    local v66 = 0;
    local v67 = nil;

    for _, v in v40 do
        local v68;

        if v63 then
            v68 = table.find(v63.lid, v.Name) ~= nil;
        else
            v68 = u53:PointToObjectSpace(v.Position).Y > v50.Y * 0.55;
        end;

        if v68 then
            table.insert(v64, v);
        else
            table.insert(v65, v);
            local v69 = v.Size.X * v.Size.Y * v.Size.Z;

            if v66 < v69 then
                v67 = v;
                v66 = v69;
            end;
        end;
    end;

    local v70;

    if #v64 > 0 and v67 then
        local v71 = not v63 and "chest" or v63.kind;
        local v72, v73 = boundsIn(v64);
        local v74, v75 = boundsIn({ v67 });
        local v76 = {};

        for _, v in v64 do
            local v77 = {
                part = v,
                offset = u53:ToObjectSpace(v.CFrame)
            };
            table.insert(v76, v77);
        end;

        if v63 and v63.glow then
            local Part = Instance.new("Part");
            Part.Name = "GlowingInside";
            Part.Material = Enum.Material.Neon;
            local v78;

            if typeof(v63.glow) == "Color3" then
                v78 = v63.glow;
            else
                v78 = Color3_fromRGB_ret4;
            end;

            Part.Color = v78;
            Part.Size = Vector3.new((v75.X - v74.X) * 0.72, 0.3, (v75.Z - v74.Z) * 0.72);
            Part.CFrame = u53 * CFrame.new((v74.X + v75.X) / 2, v75.Y - 0.3 - 0.15, (v74.Z + v75.Z) / 2);
            Part.CastShadow = false;
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CanQuery = false;
            Part.CanTouch = false;
            Part.Parent = v38;
            table.insert(v40, Part);
        end;

        v70 = {
            kind = v71,
            lids = v76
        };
        local v79;

        if v71 == "door" then
            v79 = Vector3.new(v73.X, 0, v73.Z);
        else
            v79 = Vector3.new(0, v75.Y, v73.Z);
        end;

        v70.hinge = v79;
        v70.mouth = Vector3.new(0, v75.Y, (v74.Z + v75.Z) / 2);
        v70.drop = v63 and v63.drop or 0;
        v70.floor = v72.Y;
        v70.front = v74.Z;
        v70.doorway = v73.Y - v72.Y;
    else
        v70 = nil;
    end;

    local v80 = {
        model = v38,
        parts = v40,
        full = v38:GetScale() * math_min_ret,
        fit = math_min_ret,
        opening = v70
    };
    local v81;

    if v51 then
        v81 = v50.Z;
    else
        v81 = v50.X;
    end;

    v80.width = v81 * math_min_ret;
    local v82;

    if v51 then
        v82 = v50.X;
    else
        v82 = v50.Z;
    end;

    v80.depth = v82 * math_min_ret;
    v80.height = v50.Y * math_min_ret;

    return v80;
end;

local function knifeHero(p83) -- Line: 417
    -- upvalues: SkinCatalog (copy), Weapons (copy), KnifeIconCopy (copy)
    local v84 = SkinCatalog.get(p83);
    local Models = Weapons:FindFirstChild("Models");

    if Models then
        Models = v84 and Models:FindFirstChild(v84.Model) or Models:FindFirstChild(p83);
    end;

    if Models then
        Models = Models:FindFirstChild("Blade");
    end;

    if not (Models and Models:IsA("BasePart")) then
        return nil;
    end;

    local v85, v86, v87, v88 = KnifeIconCopy.new(Models);
    local Model = Instance.new("Model");

    for i, v in {
        Name = "Knife"
    } do
        Model[i] = v;
    end;

    Model.Parent = nil;
    v85.Parent = Model;

    for _, v in v86 do
        v.Anchored = true;
        local IconWeld = v:FindFirstChild("IconWeld");

        if IconWeld then
            IconWeld:Destroy();
        end;
    end;

    Model.PrimaryPart = v85;
    v85.PivotOffset = CFrame.new(v88);
    Model.WorldPivot = v85.CFrame * CFrame.new(v88);
    local v89 = { Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1) };
    local v90 = { v87.X, v87.Y, v87.Z };
    local v91 = 1;
    local v92 = 1;
    local v93 = v90[2] > v90[v91] and 2 or v91;
    local v94 = v90[2] < v90[v92] and 2 or v92;
    local v95 = v90[3] > v90[v93] and 3 or v93;
    local v96 = v90[3] < v90[v94] and 3 or v94;

    if v96 == v95 then
        v96 = v95 % 3 + 1;
    end;

    local v97 = v89[v95];
    local v98 = v89[v96];
    local GripPoint = Models:FindFirstChild("GripPoint");
    local v99;

    if GripPoint and GripPoint:IsA("Attachment") then
        v99 = GripPoint.Position;
    else
        v99 = Models.PivotOffset.Position;
    end;

    if v99:Dot(v97) > 0 then
        v97 = -v97;
    end;

    return {
        kind = "knife",
        top = 2.64,
        model = Model,
        rest = CFrame.fromMatrix(Vector3.new(0, 0, 0), v97:Cross(v98), v97, v98):Inverse(),
        size = 5.28 / math.max(v87.X, v87.Y, v87.Z, 0.5)
    };
end;

local function emoteHero(p100, p101) -- Line: 475
    -- upvalues: CharacterClone (copy), untag (copy), u36 (copy)
    local v102, v103 = CharacterClone.copy(p100);

    if not v102 then
        return nil;
    end;

    untag(v102);
    v102.Name = "EmoteCopy";
    local HumanoidRootPart = v102:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        local LookVector = HumanoidRootPart.CFrame.LookVector;
        local Vector3_new_ret = Vector3.new(LookVector.X, 0, LookVector.Z);
        v102.WorldPivot = CFrame.lookAt(HumanoidRootPart.Position, HumanoidRootPart.Position + (Vector3_new_ret.Magnitude <= 0.1 and Vector3.new(0, 0, -1) or Vector3_new_ret.Unit));
    end;

    local v104 = 2.5;
    local v105 = 5.2;
    local v106 = 3;

    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        local v107 = (1 / 0);
        local v108 = (-1 / 0);

        for _, child in v102:GetChildren() do
            if child:IsA("BasePart") then
                local v109 = child;

                for _, v in u36 do
                    local Y = (v109.CFrame * (v * v109.Size / 2)).Y;
                    v107 = math.min(v107, Y);
                    v108 = math.max(v108, Y);
                end;
            end;
        end;

        if v107 < v108 then
            v104 = math.max(1, v108 - HumanoidRootPart.Position.Y);
            v105 = math.max(2, v108 - v107);
            v106 = math.max(0.5, HumanoidRootPart.Position.Y - v107);
        end;
    end;

    return {
        kind = "emote",
        size = 0.64,
        model = v102,
        top = v104 * 0.64,
        height = v105,
        bottom = v106,
        animator = v103:FindFirstChildOfClass("Animator"),
        id = p101
    };
end;

local function viewPoint(p110) -- Line: 524
    if p110.viewFrom then
        return p110.viewFrom;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        return workspace_CurrentCamera.CFrame.Position;
    end;

    return p110.root.Position + Vector3.new(0, 4, 12);
end;

local function chestOf(p111, p112) -- Line: 532
    local v113 = p111:FindFirstChild("UpperTorso") or p111:FindFirstChild("Torso");

    if v113 and v113:IsA("BasePart") then
        return v113.Position;
    end;

    return p112.Position + Vector3.new(0, 0.6, 0);
end;

local u114 = {};
local u115 = { 0, 25, -25, 50, -50, 80, -80, 115, -115, 150, -150, 180 };
local u116 = { 1, 0.8, 1.3, 0.6 };

local function landing(p117, p118, p119, p120, p121) -- Line: 552
    -- upvalues: Players (copy), u114 (copy), u116 (copy), u115 (copy)
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.RespectCanCollide = true;
    RaycastParams_new_ret.IgnoreWater = true;
    local v122 = { p117 };

    for _, v in p119 do
        table.insert(v122, v);
    end;

    for _, v in Players:GetPlayers() do
        if v.Character then
            table.insert(v122, v.Character);
        end;
    end;

    RaycastParams_new_ret.FilterDescendantsInstances = v122;
    local v123 = p120 or p118.CFrame.LookVector;
    local Vector3_new_ret = Vector3.new(v123.X, 0, v123.Z);
    local v124 = Vector3_new_ret.Magnitude <= 0.1 and Vector3.new(0, 0, -1) or Vector3_new_ret.Unit;
    local v125;

    if p120 then
        v125 = (v124 * 7.5 + v124:Cross(Vector3.new(0, 1, 0)) * 2.2).Unit;
    else
        v125 = v124;
    end;

    local os_clock_ret = os.clock();

    for i, v in u114 do
        if v.untilAt < os_clock_ret or not i.Parent then
            u114[i] = nil;
        end;
    end;

    local v126 = p121 and (p121.width or 4.5) or 4.5;
    local v127 = p121 and (p121.depth or 4.5) or 4.5;
    local math_clamp_ret = math.clamp(p121 and p121.height or 4, 2, 9);
    local v128 = math.max(v126, v127) / 2 + 0.6;
    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    OverlapParams_new_ret.FilterDescendantsInstances = v122;
    local v129 = p118.Position.Y - 3;

    for _, v in u116 do
        local v130 = v;

        for _, v2 in u115 do
            local v131 = CFrame.Angles(0, math.rad(v2), 0):VectorToWorldSpace(v125);
            local v132 = 7.5 * v130;
            local v133 = not workspace:Raycast(p118.Position, v131 * (v132 + v128), RaycastParams_new_ret) and workspace:Raycast(p118.Position + v131 * v132 + Vector3.new(0, 2, 0), Vector3.new(0, -12, 0), RaycastParams_new_ret);

            if v133 and math.abs(v133.Position.Y - v129) <= 3 then
                local Position = v133.Position;
                local v134 = true;

                for _, v3 in u114 do
                    if (v3.at - Position).Magnitude < v3.radius + v128 then
                        v134 = false;
                        break;
                    end;
                end;

                if v134 then
                    local CFrame_new_ret = CFrame.new(Position + Vector3.new(0, math_clamp_ret / 2 + 0.35, 0));

                    for _, v3 in workspace:GetPartBoundsInBox(CFrame_new_ret, Vector3.new(v128 * 2, math_clamp_ret, v128 * 2), OverlapParams_new_ret) do
                        if v3.Transparency < 0.95 and not v3:IsA("Terrain") then
                            v134 = false;
                            break;
                        end;
                    end;
                end;

                if v134 then
                    return Position, v124, v128;
                end;
            end;
        end;
    end;

    local v135 = 7.5;
    local v136 = workspace:Raycast(p118.Position, v125 * (v135 + 3), RaycastParams_new_ret);

    if v136 then
        v135 = math.clamp(v136.Distance - 3, 2.5, 7.5);
    end;

    local v137 = p118.Position + v125 * v135;
    local v138 = workspace:Raycast(v137 + Vector3.new(0, 2, 0), Vector3.new(0, -45, 0), RaycastParams_new_ret);

    return Vector3.new(v137.X, v138 and v138.Position.Y or p118.Position.Y - 3, v137.Z), v124, v128;
end;

local function labelBoard(p139, p140, p141, p142, p143) -- Line: 634
    -- upvalues: Font_new_ret (copy), Color3_new_ret2 (copy), Color3_new_ret (copy), Color3_fromRGB_ret (copy)
    local v144 = {
        Name = "PrizeLabel",
        StudsOffsetWorldSpace = Vector3.new(0, 1.5, 0),
        MaxDistance = 130,
        AlwaysOnTop = true,
        LightInfluence = 0,
        ResetOnSpawn = false,
        ClipsDescendants = false,
        Active = false,
        Adornee = p139,
        Size = UDim2.fromScale(6, (p143 and 3 or 2) == 3 and 2.5 or 1.95),
        SizeOffset = Vector2.new(0, 0.5),
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    };
    local BillboardGui = Instance.new("BillboardGui");

    for i, v in v144 do
        BillboardGui[i] = v;
    end;

    BillboardGui.Parent = p139;
    local UIScale = Instance.new("UIScale");

    for i, v in {
        Scale = 0.6
    } do
        UIScale[i] = v;
    end;

    UIScale.Parent = BillboardGui;
    local u145 = {};

    local function row(p146, p147, p148, p149, p150) -- Line: 653
        -- upvalues: BillboardGui (copy), Font_new_ret (ref), Color3_new_ret2 (ref), u145 (copy)
        local v151 = {
            BackgroundTransparency = 1,
            TextScaled = true,
            TextWrapped = false,
            TextTransparency = 1,
            ZIndex = 2,
            Position = UDim2.fromScale(0, p148),
            Size = UDim2.fromScale(1, p149),
            FontFace = Font_new_ret,
            Text = p146,
            TextColor3 = p147
        };
        local TextLabel = Instance.new("TextLabel");

        for i, v in v151 do
            TextLabel[i] = v;
        end;

        TextLabel.Parent = BillboardGui;
        local v152 = {
            Transparency = 1,
            Color = Color3_new_ret2,
            Thickness = p150,
            LineJoinMode = Enum.LineJoinMode.Round,
            StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
        };
        local UIStroke = Instance.new("UIStroke");

        for i, v in v152 do
            UIStroke[i] = v;
        end;

        UIStroke.Parent = TextLabel;
        table.insert(u145, { TextLabel, UIStroke });

        return TextLabel;
    end;

    if p143 then
        row(string.upper(p140), p141, 0, 0.4, 0.07);
        row(p142, Color3_new_ret, 0.4, 0.38, 0.07);
        row("+" .. p143 .. " GEMS", Color3_fromRGB_ret, 0.79, 0.21, 0.09);
    else
        row(string.upper(p140), p141, 0, 0.46, 0.07);
        row(p142, Color3_new_ret, 0.46, 0.54, 0.07);
    end;

    return {
        gui = BillboardGui,
        scale = UIScale,
        texts = u145
    };
end;

local function setLabelAlpha(p153, p154) -- Line: 687
    for _, v in p153.texts do
        v[1].TextTransparency = 1 - p154;
        v[2].Transparency = 1 - p154;
    end;
end;

local function glowBoard(p155, p156, p157, p158, p159) -- Line: 694
    local v160 = {
        MaxDistance = 200,
        AlwaysOnTop = false,
        LightInfluence = 0,
        ResetOnSpawn = false,
        Active = false,
        Name = p156,
        Adornee = p155,
        Size = UDim2.fromScale(4, 4),
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    };
    local BillboardGui = Instance.new("BillboardGui");

    for i, v in v160 do
        BillboardGui[i] = v;
    end;

    BillboardGui.Parent = p155;
    local v161 = {
        BackgroundTransparency = 1,
        ImageTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        AnchorPoint = Vector2.zero,
        Image = p157,
        ImageColor3 = p158,
        ScaleType = Enum.ScaleType.Fit,
        ZIndex = p159 or 1
    };
    local ImageLabel = Instance.new("ImageLabel");

    for i, v in v161 do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = BillboardGui;

    return BillboardGui, ImageLabel;
end;

local function sparkEmitter(p162, p163, p164, p165) -- Line: 719
    -- upvalues: Color3_new_ret (copy), ramp (copy)
    local v166 = {
        Texture = "rbxasset://textures/particles/sparkles_main.dds",
        LightEmission = 1,
        LightInfluence = 0,
        Acceleration = Vector3.new(0, -22, 0),
        Drag = 1.5,
        Rate = 0,
        Enabled = false,
        Name = p163,
        Color = ColorSequence.new(p164:Lerp(Color3_new_ret, 0.5), p164),
        Size = ramp(0.9, 0.55, 0),
        Transparency = ramp(0, 0.1, 1),
        Lifetime = NumberRange.new(0.6, 1.1),
        Speed = NumberRange.new(14, 32),
        SpreadAngle = Vector2.new(180, 180),
        Rotation = NumberRange.new(0, 360),
        RotSpeed = NumberRange.new(-120, 120)
    };
    local ParticleEmitter = Instance.new("ParticleEmitter");

    for i, v in v166 do
        ParticleEmitter[i] = v;
    end;

    ParticleEmitter.Parent = p162;

    for i, v in p165 or {} do
        ParticleEmitter[i] = v;
    end;

    return ParticleEmitter;
end;

local function seedOf(p167) -- Line: 745
    local v168 = 17;

    for i = 1, #p167 do
        v168 = (v168 * 31 + string.byte(p167, i)) % 2147483647;
        local _ = i;
    end;

    return v168;
end;

local function build(p169, u170, p171, u172) -- Line: 755
    -- upvalues: u2 (copy), EmoteCatalog (copy), SkinCatalog (copy), crateCopy (copy), timeline (copy), landing (copy), u114 (copy), newPart (copy), sparkEmitter (copy), ramp (copy), Color3_fromRGB_ret2 (copy), glowBoard (copy), Color3_new_ret (copy), labelBoard (copy), Color3_fromRGB_ret3 (copy), emoteHero (copy), knifeHero (copy), u4 (copy), EmotePlayback (copy), u3 (copy), NumberRange_new_ret (copy)
    local prize = p169.prize;
    local HumanoidRootPart = u170:FindFirstChild("HumanoidRootPart");
    local v173 = not u2[prize.rarity] and "Common" or prize.rarity;
    local u174 = u2[v173];
    local u175 = v173 == "Legendary" and true or v173 == "Mythical";
    local Random_new = Random.new;
    local v176 = tostring(p169.id);
    local v177 = 17;

    for i = 1, #v176 do
        v177 = (v177 * 31 + string.byte(v176, i)) % 2147483647;
        local _ = i;
    end;

    local u178 = Random_new(v177);
    local Folder = Instance.new("Folder");
    Folder.Name = "HalloweenCrateShow_" .. tostring(p169.id);
    u172.folder = Folder;
    local u179 = {
        root = HumanoidRootPart,
        viewFrom = p171.viewFrom,
        silent = p171.silent == true
    };
    local u180 = p171.mine == true;
    local v181;

    if prize.kind == "Emote" then
        local v182 = EmoteCatalog.get(prize.id);
        v181 = v182 and v182.Name or tostring(prize.id);
    else
        local v183 = SkinCatalog.get(prize.id);
        v181 = v183 and v183.Name or tostring(prize.id);
    end;

    local string_upper_ret = string.upper(v181);
    local v184;

    if prize.duplicate == true and (type(prize.gems) == "number" and prize.gems > 0) then
        v184 = math.floor(prize.gems);
    else
        v184 = nil;
    end;

    local HalloweenStore = workspace:FindFirstChild("HalloweenStore");
    local u185;

    if p169.model == nil then
        u185 = nil;
    else
        if HalloweenStore then
            HalloweenStore = HalloweenStore:FindFirstChild(p169.model);
        end;

        u185 = crateCopy(HalloweenStore) or nil;
    end;

    if u185 then
        u172.crate = u185.model;
    end;

    local u186 = timeline(u185 ~= nil, u175);
    local u187;

    if u185 then
        u187 = u185.opening;
    else
        u187 = u185;
    end;

    local v188 = { Folder };

    if workspace.CurrentCamera then
        table.insert(v188, workspace.CurrentCamera);
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v189;

    if u180 and workspace_CurrentCamera then
        v189 = workspace_CurrentCamera.CFrame.LookVector;
    else
        v189 = nil;
    end;

    local u190, u191, v192 = landing(u170, HumanoidRootPart, v188, v189, u185 and ({
        width = u185.width,
        depth = u185.depth,
        height = u185.height
    } or nil) or nil);
    u114[Folder] = {
        at = u190,
        radius = v192,
        untilAt = os.clock() + 20
    };
    local Y = u190.Y;
    local v193 = u170:FindFirstChild("UpperTorso") or u170:FindFirstChild("Torso");
    local u194;

    if v193 and v193:IsA("BasePart") then
        u194 = v193.Position;
    else
        u194 = HumanoidRootPart.Position + Vector3.new(0, 0.6, 0);
    end;

    local v195;

    if u179.viewFrom then
        v195 = u179.viewFrom;
    else
        local workspace_CurrentCamera2 = workspace.CurrentCamera;

        if workspace_CurrentCamera2 then
            v195 = workspace_CurrentCamera2.CFrame.Position;
        else
            v195 = u179.root.Position + Vector3.new(0, 4, 12);
        end;
    end;

    local v196 = v195 - u190;
    local Vector3_new_ret = Vector3.new(v196.X, 0, v196.Z);
    local u197;

    if Vector3_new_ret.Magnitude > 0.1 then
        u197 = Vector3_new_ret.Unit;
    else
        u197 = -u191;
    end;

    local CFrame_lookAt_ret = CFrame.lookAt(Vector3.new(0, 0, 0), u197);
    local v198 = not u185 and 5.4 or math.clamp((not u185 and 0 or u185.height * 0.7) * 0.5 + 3, 5.2, 8);
    local u199 = u190 + Vector3.new(0, v198, 0);
    local u200 = newPart(Folder, "Core");
    local u201 = newPart(Folder, "Ears", nil, {
        Position = u194
    });
    local u202 = newPart(Folder, "Prize");
    local v203 = newPart(Folder, "Dust", Vector3.new(1, 0.2, 1), {
        Position = u190 + Vector3.new(0, 0.2, 0)
    });
    local PointLight = Instance.new("PointLight");
    local u204 = u194;

    for i, v in {
        Brightness = 0,
        Range = 10,
        Shadows = false,
        Color = u174
    } do
        PointLight[i] = v;
    end;

    PointLight.Parent = u200;
    local PointLight2 = Instance.new("PointLight");

    for i, v in {
        Brightness = 0,
        Range = 12,
        Shadows = false,
        Color = u174
    } do
        PointLight2[i] = v;
    end;

    PointLight2.Parent = u202;
    local u205 = sparkEmitter(u200, "Leak", u174, {
        Acceleration = Vector3.new(0, 4, 0),
        Speed = NumberRange.new(2, 7),
        Lifetime = NumberRange.new(0.5, 1),
        Size = ramp(0.55, 0.4, 0)
    });
    local u206 = sparkEmitter(u200, "Sparks", u174);
    local u207 = sparkEmitter(u202, "Glints", u174, {
        Acceleration = Vector3.new(0, 1, 0),
        Speed = NumberRange.new(1, 4),
        Lifetime = NumberRange.new(0.7, 1.3),
        Size = ramp(0.5, 0.35, 0)
    });
    local u208 = sparkEmitter(u202, "FlyTrail", u174, {
        Acceleration = Vector3.new(0, 0, 0),
        Drag = 3,
        Speed = NumberRange.new(1, 5),
        Lifetime = NumberRange.new(0.3, 0.6),
        Size = ramp(0.8, 0.5, 0)
    });
    local v209 = {
        Name = "Puffs",
        Texture = "rbxasset://textures/particles/smoke_main.dds",
        LightInfluence = 1,
        Acceleration = Vector3.new(0, -2, 0),
        Drag = 4,
        Rate = 0,
        Enabled = false,
        Color = ColorSequence.new(Color3_fromRGB_ret2),
        Size = ramp(2, 4.4, 6.2),
        Transparency = ramp(0.3, 0.6, 1),
        Lifetime = NumberRange.new(0.6, 1.1),
        Speed = NumberRange.new(8, 16),
        SpreadAngle = Vector2.new(78, 78),
        Rotation = NumberRange.new(0, 360),
        RotSpeed = NumberRange.new(-60, 60)
    };
    local ParticleEmitter = Instance.new("ParticleEmitter");

    for i, v in v209 do
        ParticleEmitter[i] = v;
    end;

    ParticleEmitter.Parent = v203;
    local u210 = select(2, glowBoard(u200, "Flash", "rbxassetid://120639974824188", Color3_new_ret, 3));
    local u211 = select(2, glowBoard(u200, "Rays", "rbxassetid://129028976496842", u174, 2));
    local Parent = u210.Parent;
    local Parent2 = u211.Parent;
    local u212, u213 = glowBoard(u202, "Halo", "rbxassetid://120639974824188", u174, 1);
    local u214, u215 = glowBoard(u202, "Shine", "rbxassetid://129028976496842", u174, 2);
    local u216 = labelBoard(u202, v173, u174, string_upper_ret, v184);
    local Attachment = Instance.new("Attachment");

    for i, v in {
        Name = "TrailA",
        Position = Vector3.new(0, 0.35, 0)
    } do
        Attachment[i] = v;
    end;

    Attachment.Parent = u202;
    local Attachment2 = Instance.new("Attachment");

    for i, v in {
        Name = "TrailB",
        Position = Vector3.new(0, -0.35, 0)
    } do
        Attachment2[i] = v;
    end;

    Attachment2.Parent = u202;
    local v217 = {
        LightEmission = 1,
        Lifetime = 0.4,
        FaceCamera = true,
        Enabled = false,
        Attachment0 = Attachment,
        Attachment1 = Attachment2,
        Color = ColorSequence.new(Color3_new_ret, u174),
        Transparency = ramp(0.1, 0.5, 1),
        WidthScale = ramp(1, 0.6, 0)
    };
    local Trail = Instance.new("Trail");

    for i, v in v217 do
        Trail[i] = v;
    end;

    Trail.Parent = u202;
    local u218;

    if u185 then
        local model = u185.model;
        local v219 = {
            FillTransparency = 1,
            OutlineTransparency = 1,
            Adornee = u185.model,
            FillColor = Color3_fromRGB_ret3,
            OutlineColor = Color3_fromRGB_ret3:Lerp(Color3_new_ret, 0.4),
            DepthMode = Enum.HighlightDepthMode.Occluded
        };
        u218 = Instance.new("Highlight");

        for i, v in v219 do
            u218[i] = v;
        end;

        u218.Parent = model;
    else
        u218 = nil;
    end;

    local u220 = {};

    local function ring(p221, p222, p223, p224, p225, p226, p227) -- Line: 898
        -- upvalues: newPart (ref), Folder (copy), u220 (copy)
        local v228 = newPart(Folder, "Ring", Vector3.new(p224, 0.1, p224), {
            Position = p221
        });
        local v229 = {
            LightInfluence = 0,
            AlwaysOnTop = false,
            Active = false,
            Enabled = false,
            Face = Enum.NormalId.Top,
            SizingMode = Enum.SurfaceGuiSizingMode.FixedSize,
            CanvasSize = Vector2.new(256, 256)
        };
        local SurfaceGui = Instance.new("SurfaceGui");

        for i, v in v229 do
            SurfaceGui[i] = v;
        end;

        SurfaceGui.Parent = v228;
        local v230 = {
            BackgroundTransparency = 1,
            Image = "rbxassetid://120639974824188",
            ImageTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            ImageColor3 = p227
        };
        local ImageLabel = Instance.new("ImageLabel");

        for i, v in v230 do
            ImageLabel[i] = v;
        end;

        ImageLabel.Parent = SurfaceGui;
        local v231 = {
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(0.94, 0.94)
        };
        local Frame = Instance.new("Frame");

        for i, v in v231 do
            Frame[i] = v;
        end;

        Frame.Parent = SurfaceGui;
        local v232 = {
            CornerRadius = UDim.new(0.5, 0)
        };
        local UICorner = Instance.new("UICorner");

        for i, v in v232 do
            UICorner[i] = v;
        end;

        UICorner.Parent = Frame;
        local UIStroke = Instance.new("UIStroke");

        for i, v in {
            Thickness = 16,
            Transparency = 1,
            Color = p227
        } do
            UIStroke[i] = v;
        end;

        UIStroke.Parent = Frame;
        table.insert(u220, {
            part = v228,
            gui = SurfaceGui,
            fill = ImageLabel,
            line = UIStroke,
            born = p222,
            seconds = p223,
            from = p224,
            to = p225,
            alpha = p226
        });
    end;

    if u185 then
        ring(u190 + Vector3.new(0, 0.12, 0), u186.land, 0.5, 2, 12, 0.35, Color3_fromRGB_ret2);
        ring(u190 + Vector3.new(0, 0.12, 0), u186.land + 0.3, 0.4, 2, 8, 0.5, Color3_fromRGB_ret2);
    end;

    ring(u190 + Vector3.new(0, 0.14, 0), u186.explode, 0.6, 3, (u175 and 1.3 or 1) * 28, 0.05, u174);
    ring(u190 + Vector3.new(0, 0.16, 0), u186.explode + 0.12, 0.65, 3, 20, 0.2, u174:Lerp(Color3_new_ret, 0.55));

    if u175 then
        ring(u190 + Vector3.new(0, 0.18, 0), u186.explode + 0.24, 0.75, 3, 34, 0.2, Color3_new_ret);
    end;

    local u233 = nil;
    local v234, v235;

    if prize.kind == "Emote" then
        v234, v235 = pcall(emoteHero, u170, prize.id);
    else
        v234, v235 = pcall(knifeHero, prize.id);
    end;

    if v234 and v235 then
        u172.hero = v235.model;
        u233 = v235;
    elseif not v234 then
        warn("[HalloweenCrateShow]", v235);
    end;

    if not u233 and prize.kind == "Emote" then
        local v236 = {
            Name = "EmoteIcon",
            LightInfluence = 0,
            AlwaysOnTop = false,
            Active = false,
            ResetOnSpawn = false,
            Enabled = false,
            Adornee = u202,
            Size = UDim2.fromScale(2.72, 2.72)
        };
        local BillboardGui = Instance.new("BillboardGui");

        for i, v in v236 do
            BillboardGui[i] = v;
        end;

        BillboardGui.Parent = u202;
        local v237 = {
            BackgroundTransparency = 1,
            Image = "rbxassetid://117630660259402",
            Size = UDim2.fromScale(1, 1),
            ImageColor3 = u174:Lerp(Color3_new_ret, 0.35),
            ScaleType = Enum.ScaleType.Fit
        };
        local ImageLabel = Instance.new("ImageLabel");

        for i, v in v237 do
            ImageLabel[i] = v;
        end;

        ImageLabel.Parent = BillboardGui;
        u233 = {
            kind = "icon",
            size = 1,
            top = 1.36,
            gui = BillboardGui
        };
    end;

    if u185 then
        u185.model.Parent = Folder;
    end;

    local math_max_ret = math.max(1.5, (not (u233 and u233.top) and 1.5 or u233.top) * 1.05 + 0.7);

    if u187 and u187.kind == "chest" then
        u199 = u190 + Vector3.new(0, u187.mouth.Y * u185.fit + (not (u233 and u233.top) and 1.5 or u233.top) + 0.15 - u187.drop * u185.fit, 0);
    end;

    local u238;

    if u187 and (u187.kind == "door" and (u233 and u233.kind == "emote")) then
        local fit = u185.fit;
        local math_clamp_ret = math.clamp(0.5 * u187.doorway * fit / u233.height, 0.4, 1.2);
        u238 = {
            k = math_clamp_ret / u233.size,
            offset = Vector3.new(0, (u187.floor + u187.doorway / 2) * fit + (u233.bottom - u233.height / 2) * math_clamp_ret, u187.front * fit - math_clamp_ret * 0.45)
        };
        math_max_ret = math.max(1.5, (u233.height - u233.bottom) * math_clamp_ret * 1.05 + 0.7);
    else
        u238 = nil;
    end;

    u216.gui.StudsOffsetWorldSpace = Vector3.new(0, math_max_ret, 0);
    local u239 = {};
    local u240 = {};

    local function sfx(p241, p242, p243, p244, p245) -- Line: 1016
        -- upvalues: u179 (copy), u240 (copy), u4 (ref), u201 (copy), u180 (copy), u239 (copy)
        if not u179.silent then
            local v246 = u240[p241];

            if v246 then
                u240[p241] = nil;
                v246:Play();

                return v246;
            end;

            local v247 = u4[p241];
            local v248 = {
                RollOffMinDistance = 8,
                RollOffMaxDistance = 30,
                Name = p241,
                SoundId = "rbxassetid://" .. v247[1],
                Volume = v247[2] * (p243 or 1) * (u180 and 1 or 0.85),
                PlaybackSpeed = p242 or v247[3],
                RollOffMode = Enum.RollOffMode.Linear
            };
            local Sound = Instance.new("Sound");

            for i, v in v248 do
                Sound[i] = v;
            end;

            Sound.Parent = p244 or u201;

            for i, v in p245 or {} do
                if i ~= "ahead" then
                    Sound[i] = v;
                end;
            end;

            table.insert(u239, {
                sound = Sound,
                volume = Sound.Volume
            });

            if p245 and p245.ahead then
                return Sound;
            end;

            Sound:Play();

            return Sound;
        end;
    end;

    if u187 and not u179.silent then
        u240.Open = sfx("Open", nil, 1, nil, {
            ahead = true,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0.14, 60)
        });
    end;

    local u249 = nil;
    local u250 = -1;
    local u251 = u199;
    local u252 = u190 + Vector3.new(0, 3, 0);
    local u253 = {};

    local function crateScale(p254) -- Line: 1064
        -- upvalues: u250 (ref), u185 (copy)
        if p254 ~= u250 then
            u250 = p254;
            u185.model:ScaleTo(u185.full * math.max(p254, 0.02));
        end;
    end;

    local function facing() -- Line: 1073
        -- upvalues: u179 (copy), u190 (copy), CFrame_lookAt_ret (copy)
        local v255 = u179;
        local v256;

        if v255.viewFrom then
            v256 = v255.viewFrom;
        else
            local workspace_CurrentCamera2 = workspace.CurrentCamera;

            if workspace_CurrentCamera2 then
                v256 = workspace_CurrentCamera2.CFrame.Position;
            else
                v256 = v255.root.Position + Vector3.new(0, 4, 12);
            end;
        end;

        local v257 = v256 - u190;
        local Vector3_new_ret2 = Vector3.new(v257.X, 0, v257.Z);

        if Vector3_new_ret2.Magnitude > 0.1 then
            return CFrame.lookAt(Vector3.new(0, 0, 0), Vector3_new_ret2.Unit);
        end;

        return CFrame_lookAt_ret;
    end;

    local function poseCrate(p258) -- Line: 1079
        -- upvalues: u179 (copy), u190 (copy), CFrame_lookAt_ret (copy), u186 (copy), u204 (copy), u191 (copy), u185 (copy), u249 (ref), u4 (ref), u180 (copy), u250 (ref)
        local v259 = u179;
        local v260;

        if v259.viewFrom then
            v260 = v259.viewFrom;
        else
            local workspace_CurrentCamera2 = workspace.CurrentCamera;

            if workspace_CurrentCamera2 then
                v260 = workspace_CurrentCamera2.CFrame.Position;
            else
                v260 = v259.root.Position + Vector3.new(0, 4, 12);
            end;
        end;

        local v261 = v260 - u190;
        local Vector3_new_ret2 = Vector3.new(v261.X, 0, v261.Z);
        local v262;

        if Vector3_new_ret2.Magnitude > 0.1 then
            v262 = CFrame.lookAt(Vector3.new(0, 0, 0), Vector3_new_ret2.Unit);
        else
            v262 = CFrame_lookAt_ret;
        end;

        local v263, v264, v265;

        if p258 < u186.land then
            local v266 = p258 / u186.land;
            local v267 = u204 - Vector3.new(0, 0.5, 0);
            v263 = v267:Lerp(u190, v266) + Vector3.new(0, 13.6 * v266 * (1 - v266), 0);
            local v268 = u190 - v267;
            local Vector3_new_ret3 = Vector3.new(v268.X, 0, v268.Z);
            local v269;

            if Vector3_new_ret3.Magnitude > 0.1 then
                v269 = Vector3_new_ret3.Unit;
            else
                v269 = u191;
            end;

            local v270 = v269:Cross(Vector3.new(0, 1, 0));
            v264 = CFrame.fromAxisAngle(v270, (1 - v266) ^ 2 * 1.1) * v262 * CFrame.Angles(0, (1 - v266) ^ 1.6 * 3.141592653589793 * 2.5, 0);
            v265 = 0.05 + 0.95 * v266 ^ 0.9 + math.sin(3.141592653589793 * v266) ^ 2 * 0.07;
        elseif p258 < u186.rest then
            local v271 = p258 - u186.land;
            local v272, v273;

            if v271 < 0.3 then
                v272 = v271 / 0.3;
                v273 = 1.3;
            else
                v272 = (v271 - 0.3) / 0.2;
                v273 = 0.38;
            end;

            v263 = u190 + Vector3.new(0, v273 * 4 * v272 * (1 - v272), 0);
            local v274 = (v271 < 0.3 and 0.05 or -0.03) * math.sin(v272 * 3.141592653589793);
            v264 = v262 * CFrame.Angles(0, 0, v274);
            v265 = 1;
        else
            local v275 = p258 - u186.rest;
            local math_clamp_ret = math.clamp(v275 / 2.9, 0, 1);
            local v276 = 6.283185307179586 * (math.min(v275, 2.9) * 0.85 + 7.975 * math_clamp_ret ^ 2.5 / 2.5);
            v265 = 1 - 0.30000000000000004 * math_clamp_ret ^ 1.15;
            local v277 = math.rad(3 + 7 * math_clamp_ret ^ 0.7) * math.clamp(7 / u185.height, 0.55, 1);
            local math_clamp_ret2 = math.clamp((v275 - 2.9) / 0.13, 0, 1);

            if math_clamp_ret2 > 0 then
                v265 = 0.7 + 0.30000000000000004 * math_clamp_ret2 ^ 2;
                v277 = v277 * (1 - math_clamp_ret2);
            end;

            local v278 = v277 * math.sin(v276);
            local Vector3_new_ret3 = Vector3.new(-(v278 >= 0 and 1 or -1) * u185.width * 0.5 * v265, 0, 0);
            local v279 = math.max(0, math_clamp_ret - 0.8) / 0.2;
            v263 = u190 + Vector3.new(0, 0, 0);
            v264 = v262 * CFrame.Angles(0, 0.04363323129985824 * math_clamp_ret * math.sin(v276 * 0.5 + 1), 0) * CFrame.new(Vector3_new_ret3) * CFrame.Angles(0, 0, v278) * CFrame.new(-Vector3_new_ret3);
            local v280 = v279 * (1 - math.clamp(math_clamp_ret2 * 4, 0, 1));

            if v280 > 0 then
                local math_sin_ret = math.sin(p258 * 61);
                local math_cos_ret = math.cos(p258 * 53);
                v263 = v263 + Vector3.new(math_sin_ret, 0, math_cos_ret) * 0.07 * v280;
            end;

            if u249 then
                u249.Volume = u4.Rattle[2] * (0.45 + 0.75 * math_clamp_ret) * (1 - math_clamp_ret2) * (u180 and 1 or 0.85);
                u249.PlaybackSpeed = 0.9 + 0.35 * math_clamp_ret;
            end;
        end;

        if v265 ~= u250 then
            u250 = v265;
            u185.model:ScaleTo(u185.full * math.max(v265, 0.02));
        end;

        local v281 = CFrame.new(v263) * v264;
        u185.model:PivotTo(v281);

        return v281, v265;
    end;

    local function poseGlow(p282, p283, p284) -- Line: 1150
        -- upvalues: u185 (copy), u200 (copy), u218 (ref), PointLight (copy), Color3_fromRGB_ret3 (ref), u205 (copy), u211 (copy)
        local v285 = p282:PointToWorldSpace((Vector3.new(0, u185.height * p283 * 0.5, 0)));
        u200.Position = v285;
        local v286 = math.sin(p284 * 46 + 1.3) * 0.5 + 0.5;
        u218.FillTransparency = 1 - (0.08 + 0.3 * p284) * (v286 * 0.45 + 0.55) * math.clamp(p284 * 6, 0, 1);
        u218.OutlineTransparency = 1 - 0.6 * p284;
        PointLight.Color = Color3_fromRGB_ret3;
        PointLight.Brightness = 3 * p284 ^ 1.4 * (v286 * 0.3 + 0.7);
        PointLight.Range = 8 + 6 * p284;
        u205.Enabled = false;
        u211.ImageTransparency = 1;

        return v285;
    end;

    local CFrame_new_ret = CFrame.new(u190);

    local function poseLid(p287, p288, p289) -- Line: 1167
        -- upvalues: u185 (copy), u187 (copy)
        local v290 = u185.fit * p289;
        local CFrame_new_ret2 = CFrame.new(u187.hinge * v290);
        local v291;

        if u187.kind == "door" then
            v291 = CFrame.Angles(0, -1.8325957145940461 * p288, 0);
        else
            v291 = CFrame.Angles(1.8849555921538759 * p288, 0, 0);
        end;

        local v292 = p287 * CFrame_new_ret2 * v291 * CFrame_new_ret2:Inverse();

        for _, v in u187.lids do
            local offset = v.offset;
            v.part.CFrame = v292 * CFrame.new(offset.Position * v290) * offset.Rotation;
        end;
    end;

    local function poseOpened(p293) -- Line: 1178
        -- upvalues: u186 (copy), u250 (ref), u185 (copy), u190 (copy), u179 (copy), CFrame_lookAt_ret (copy), CFrame_new_ret (ref), poseLid (copy), u187 (copy)
        local v294 = 1 - math.clamp((p293 - u186.arrive) / 0.45, 0, 1) ^ 2;
        local math_max_ret2 = math.max(0.02, v294);

        if math_max_ret2 ~= u250 then
            u250 = math_max_ret2;
            u185.model:ScaleTo(u185.full * math.max(math_max_ret2, 0.02));
        end;

        local CFrame_new_ret2 = CFrame.new(u190);
        local v295 = u179;
        local v296;

        if v295.viewFrom then
            v296 = v295.viewFrom;
        else
            local workspace_CurrentCamera2 = workspace.CurrentCamera;

            if workspace_CurrentCamera2 then
                v296 = workspace_CurrentCamera2.CFrame.Position;
            else
                v296 = v295.root.Position + Vector3.new(0, 4, 12);
            end;
        end;

        local v297 = v296 - u190;
        local Vector3_new_ret2 = Vector3.new(v297.X, 0, v297.Z);
        local v298;

        if Vector3_new_ret2.Magnitude > 0.1 then
            v298 = CFrame.lookAt(Vector3.new(0, 0, 0), Vector3_new_ret2.Unit);
        else
            v298 = CFrame_lookAt_ret;
        end;

        local v299 = CFrame_new_ret2 * v298;
        u185.model:PivotTo(v299);
        CFrame_new_ret = v299;
        local math_clamp_ret = math.clamp((p293 - u186.explode) / 0.55, 0, 1);
        local v300 = u187.kind == "door" and 1.1 or 1.4 or 1.70158;
        local v301 = math.clamp(math_clamp_ret, 0, 1) - 1;
        poseLid(v299, 1 + v301 * v301 * ((v300 + 1) * v301 + v300), math_max_ret2);

        return v299, math_max_ret2;
    end;

    local function setHero(p302, p303, p304) -- Line: 1188
        -- upvalues: u233 (ref), u179 (copy), u197 (ref)
        if not u233 then
            return;
        end;

        if u233.kind == "icon" then
            u233.gui.Size = UDim2.fromScale(2.72 * p303, 2.72 * p303);

            return;
        end;

        local v305 = u179;
        local v306;

        if v305.viewFrom then
            v306 = v305.viewFrom;
        else
            local workspace_CurrentCamera2 = workspace.CurrentCamera;

            if workspace_CurrentCamera2 then
                v306 = workspace_CurrentCamera2.CFrame.Position;
            else
                v306 = v305.root.Position + Vector3.new(0, 4, 12);
            end;
        end;

        local v307 = v306 - p302;
        local Vector3_new_ret2 = Vector3.new(v307.X, 0, v307.Z);
        local v308;

        if Vector3_new_ret2.Magnitude > 0.1 then
            v308 = Vector3_new_ret2.Unit;
        else
            v308 = u197;
        end;

        local v309;

        if u233.kind == "knife" then
            v309 = CFrame.new(p302) * CFrame.lookAt(Vector3.new(0, 0, 0), -v308) * CFrame.Angles(0, p304, 0) * u233.rest;
        else
            v309 = CFrame.new(p302) * CFrame.lookAt(Vector3.new(0, 0, 0), v308) * CFrame.Angles(0, p304, 0);
        end;

        if p303 ~= u233.k then
            u233.k = p303;
            u233.model:ScaleTo(u233.size * math.max(p303, 0.02));
        end;

        u233.model:PivotTo(v309);
    end;

    local function heroShown(p310) -- Line: 1211
        -- upvalues: u233 (ref), Folder (copy), EmotePlayback (ref)
        if not u233 then
            return;
        end;

        if u233.kind == "icon" then
            u233.gui.Enabled = p310;
        elseif p310 ~= u233.on then
            local v311;

            if p310 then
                v311 = Folder;
            else
                v311 = nil;
            end;

            u233.model.Parent = v311;

            if p310 and (u233.animator and not u233.track) then
                local success, result = pcall(EmotePlayback.load, u233.animator, u233.id);

                if success and result then
                    u233.track = result;
                    result:Play(0.15);
                end;
            end;
        end;

        u233.on = p310;
    end;

    if u233 then
        if u233.kind == "icon" then
            u233.gui.Enabled = false;
        elseif u233.on ~= false then
            u233.model.Parent = nil;
        end;

        u233.on = false;
    end;

    local function openCrate(p312) -- Line: 1233
        -- upvalues: u249 (ref), poseOpened (copy), u186 (copy), u185 (copy), u187 (copy), u252 (ref), u200 (copy), u218 (ref), PointLight (copy), u174 (copy), u206 (copy), u175 (copy), sfx (copy)
        if u249 then
            u249:Stop();
        end;

        local v313 = poseOpened(u186.explode);
        local fit = u185.fit;
        local v314;

        if u187.kind == "door" then
            v314 = Vector3.new(0, (u187.floor + u187.doorway * 0.5) * fit, u187.front * fit - 0.3);
        else
            v314 = u187.mouth * fit;
        end;

        u252 = v313:PointToWorldSpace(v314);
        u200.Position = u252;
        u218.FillTransparency = 1;
        u218.OutlineTransparency = 1;

        if p312 then
            return;
        end;

        PointLight.Color = u174;
        PointLight.Brightness = 9;
        u206:Emit(u175 and 110 or 60);
        sfx("Open", nil, 1);
    end;

    local function breakCrate(p315) -- Line: 1255
        -- upvalues: poseCrate (copy), u186 (copy), u252 (ref), u185 (copy), u200 (copy), u178 (copy), u253 (copy), Folder (copy), u249 (ref), u172 (copy), u175 (copy), newPart (ref), u174 (copy), Color3_new_ret (ref), u3 (ref), PointLight (copy), u206 (copy), sfx (copy)
        local v316, v317 = poseCrate(u186.explode);
        u252 = v316:PointToWorldSpace((Vector3.new(0, u185.height * v317 * 0.5, 0)));
        u200.Position = u252;

        for _, v in u185.parts do
            local CFrame2 = v.CFrame;
            local v318 = CFrame2.Position - u252;
            local Vector3_new_ret2 = Vector3.new(v318.X, 0, v318.Z);
            local v319;

            if Vector3_new_ret2.Magnitude > 0.3 then
                v319 = Vector3_new_ret2.Unit;
            else
                local v320 = u178:NextNumber(-1, 1);
                v319 = Vector3.new(v320, 0, u178:NextNumber(-1, 1)).Unit;
            end;

            local v321 = math.max(v.Size.X, v.Size.Y, v.Size.Z) / 3;
            local math_clamp_ret = math.clamp(v321, 1, 3);
            local v322 = u178:NextNumber(-1, 1);
            local v323 = u178:NextNumber(-1, 1);
            local Vector3_new_ret3 = Vector3.new(v322, v323, u178:NextNumber(-1, 1));
            local v324 = {
                life = 1.25,
                fadeAt = 0.55,
                part = v,
                p0 = CFrame2.Position,
                rot0 = CFrame2.Rotation
            };
            local v325 = v319 * (6 + u178:NextNumber() * 9) / math.sqrt(math_clamp_ret);
            local v326 = (13 + u178:NextNumber() * 9) / math.sqrt(math_clamp_ret);
            v324.v = v325 + Vector3.new(0, v326, 0);
            v324.axis = Vector3_new_ret3.Magnitude <= 0.1 and Vector3.new(0, 1, 0) or Vector3_new_ret3.Unit;
            v324.spin = (2 + u178:NextNumber() * 5) / math_clamp_ret;
            v324.size0 = v.Size;
            v324.alpha0 = v.Transparency;
            v324.r = math.min(v.Size.X, v.Size.Y, v.Size.Z) * 0.35;
            table.insert(u253, v324);
            v.Parent = Folder;
        end;

        if u249 then
            u249:Stop();
        end;

        u185.model:Destroy();
        u172.crate = nil;

        for i = 1, u175 and 30 or 20 do
            local v327 = i % 2 == 0;
            local v328 = u178:NextNumber(0.25, 0.7);
            local v329 = v328 * u178:NextNumber(0.3, 1);
            local v330 = v328 * u178:NextNumber(1, 2);
            local Vector3_new_ret2 = Vector3.new(v328, v329, v330);
            local v331 = {
                Transparency = 0
            };
            local v332;

            if v327 then
                v332 = u174:Lerp(Color3_new_ret, u178:NextNumber(0, 0.5));
            else
                v332 = u3[u178:NextInteger(1, #u3)];
            end;

            v331.Color = v332;
            local v333;

            if v327 then
                v333 = Enum.Material.Neon;
            else
                v333 = Enum.Material.Wood;
            end;

            v331.Material = v333;
            local v334 = newPart(Folder, "Shard", Vector3_new_ret2, v331);
            local v335 = u178:NextNumber(-1, 1);
            local v336 = u178:NextNumber(0.1, 1);
            local Unit = Vector3.new(v335, v336, u178:NextNumber(-1, 1)).Unit;
            local v337 = {
                alpha0 = 0,
                r = 0.15,
                fadeAt = 0.35,
                part = v334,
                p0 = u252 + Unit * 0.8,
                rot0 = CFrame.Angles(u178:NextNumber(0, 6), u178:NextNumber(0, 6), u178:NextNumber(0, 6))
            };
            local v338 = Unit * u178:NextNumber(9, 20);
            local v339 = u178:NextNumber(4, 12);
            v337.v = v338 + Vector3.new(0, v339, 0);
            local v340 = u178:NextNumber(-1, 1);
            v337.axis = Vector3.new(v340, 1, u178:NextNumber(-1, 1)).Unit;
            v337.spin = u178:NextNumber(4, 12);
            v337.size0 = v334.Size;
            v337.life = v327 and 0.8 or 1.1;
            table.insert(u253, v337);
            local _ = i;
        end;

        if p315 then
            return;
        end;

        PointLight.Color = u174;
        PointLight.Brightness = 9;
        u206:Emit(u175 and 150 or 80);
        sfx("Boom", nil, 1);
        sfx("Pop", nil, 1.3);
    end;

    local function poseFragments(p341) -- Line: 1320
        -- upvalues: u186 (copy), u253 (copy), Y (copy)
        local v342 = p341 - u186.explode;

        for _, v in u253 do
            local math_clamp_ret = math.clamp((v342 - v.fadeAt) / (v.life - v.fadeAt), 0, 1);

            if v342 < 0 or math_clamp_ret >= 1 then
                v.part.Transparency = 1;
            else
                local v343 = v.p0 + v.v * v342 + Vector3.new(0, -29, 0) * v342 * v342;

                if v343.Y < Y + v.r then
                    v343 = Vector3.new(v343.X, Y + v.r, v343.Z);
                end;

                v.part.CFrame = CFrame.new(v343) * CFrame.fromAxisAngle(v.axis, v.spin * v342) * v.rot0;
                local alpha0 = v.alpha0;
                v.part.Transparency = alpha0 + (1 - alpha0) * math_clamp_ret;
                v.part.Size = v.size0 * (1 - 0.5 * math_clamp_ret);
            end;
        end;
    end;

    local function poseRings(p344) -- Line: 1338
        -- upvalues: u220 (copy)
        for _, v in u220 do
            local v345 = (p344 - v.born) / v.seconds;
            local v346;

            if v345 >= 0 then
                v346 = v345 <= 1;
            else
                v346 = false;
            end;

            v.gui.Enabled = v346;

            if v.gui.Enabled then
                local from = v.from;
                local to = v.to;
                local v347 = 1 - (1 - math.clamp(v345, 0, 1)) ^ 3;
                local v348 = from + (to - from) * v347;
                v.part.Size = Vector3.new(v348, 0.1, v348);
                local alpha = v.alpha;
                v.line.Transparency = alpha + (1 - alpha) * v345 ^ 0.7;
                v.line.Thickness = 18 + -13 * v345;
                local v349 = v.alpha + 0.45;
                v.fill.ImageTransparency = v349 + (1 - v349) * v345 ^ 0.6;
            end;
        end;
    end;

    local function poseBurst(p350) -- Line: 1353
        -- upvalues: u175 (copy), Parent (copy), u210 (copy), Parent2 (copy), u211 (copy), PointLight (copy), u174 (copy), u205 (copy)
        local v351 = u175 and 1.35 or 1;
        local math_clamp_ret = math.clamp(p350 / 0.45, 0, 1);
        Parent.Size = UDim2.fromScale((6 + 16 * (1 - (1 - math.clamp(math_clamp_ret, 0, 1)) ^ 3)) * v351, (6 + 16 * (1 - (1 - math.clamp(math_clamp_ret, 0, 1)) ^ 3)) * v351);
        u210.ImageTransparency = p350 < 0 and 1 or math_clamp_ret ^ 0.7;
        local math_clamp_ret2 = math.clamp(p350 / 0.9, 0, 1);
        Parent2.Size = UDim2.fromScale((6 + 22 * (1 - (1 - math.clamp(math_clamp_ret2, 0, 1)) ^ 3)) * v351, (6 + 22 * (1 - (1 - math.clamp(math_clamp_ret2, 0, 1)) ^ 3)) * v351);
        u211.ImageTransparency = p350 < 0 and 1 or 0.05 + 0.95 * math_clamp_ret2 ^ 1.4;
        u211.Rotation = 35 * p350;
        PointLight.Color = u174;
        PointLight.Brightness = (u175 and 12 or 8) * (1 - math.clamp(p350 / 0.55, 0, 1)) ^ 2;
        PointLight.Range = 26;
        u205.Enabled = false;
    end;

    local function posePrize(p352, p353) -- Line: 1369
        -- upvalues: u186 (copy), u252 (ref), u199 (ref), u233 (ref), u238 (ref), CFrame_new_ret (ref), u202 (copy), u251 (ref), setHero (copy), u216 (copy), u175 (copy), u212 (copy), u213 (copy), u214 (copy), u215 (copy), PointLight2 (copy), u207 (copy)
        local math_clamp_ret = math.clamp((p353 - 0.08) / (u186.risen - u186.explode - 0.08), 0, 1);
        local v354 = u252:Lerp(u199, 1 - (1 - math.clamp(math_clamp_ret, 0, 1)) ^ 3);
        local v355 = math.sin(p353 * 2.3) * 0.2 * math_clamp_ret;
        local v356 = v354 + Vector3.new(0, v355, 0);
        local v357 = math.clamp(math_clamp_ret, 0, 1) - 1;
        local v358 = 0.12 + 0.88 * (1 + v357 * v357 * (2.5 * v357 + 1.5));
        local v359;

        if u233 and u233.kind == "emote" then
            v359 = math.sin(p353 * 1.5) * 0.55;
        else
            v359 = math.sin(p353 * 1.7 - 0.4) * 1;
        end;

        if u238 then
            v356 = CFrame_new_ret:PointToWorldSpace(u238.offset);
            v358 = u238.k;
            v359 = 0;
        end;

        u202.Position = v356;
        u251 = v356;
        setHero(v356, v358, v359);
        local math_clamp_ret2 = math.clamp((p353 - 0.3) / 0.3, 0, 1);

        for _, v in u216.texts do
            v[1].TextTransparency = 1 - math_clamp_ret2;
            v[2].Transparency = 1 - math_clamp_ret2;
        end;

        local scale = u216.scale;
        local v360 = math.clamp(math_clamp_ret2, 0, 1) - 1;
        scale.Scale = 0.6 + 0.4 * (1 + v360 * v360 * (2.2 * v360 + 1.2));
        local v361 = math.sin(p353 * 3) * 0.5 + 0.5;
        local v362 = (u175 and 12 or 8.5) * (v361 * 0.06 + 0.94) * math.clamp(p353 / 0.4 + 0.001, 0, 1) * (u238 and 0.65 or 1);
        u212.Size = UDim2.fromScale(v362, v362);
        local math_clamp_ret3 = math.clamp(p353 / 0.4, 0, 1);
        u213.ImageTransparency = 1 + (v361 * 0.1 + 0.52 - 1) * math_clamp_ret3;
        local v363 = (u175 and 15 or 10.5) * math.clamp(p353 / 0.5, 0, 1) * (u238 and 0.65 or 1);
        u214.Size = UDim2.fromScale(v363, v363);
        u215.ImageTransparency = 1 + -0.33999999999999997 * math.clamp(p353 / 0.5, 0, 1);
        u215.Rotation = p353 * 22;
        PointLight2.Brightness = (u175 and 3 or 1.8) * (v361 * 0.2 + 0.8) * math.clamp(p353 / 0.4, 0, 1);
        u207.Rate = u175 and 26 or 10;
        u207.Enabled = true;

        return v356;
    end;

    local function poseFly(p364) -- Line: 1404
        -- upvalues: u186 (copy), HumanoidRootPart (copy), u170 (copy), u194 (ref), u251 (ref), u238 (ref), u202 (copy), u201 (copy), setHero (copy), u216 (copy), math_max_ret (ref), u175 (copy), u212 (copy), u213 (copy), u215 (copy), PointLight2 (copy), u207 (copy), u208 (copy), Trail (ref)
        local math_clamp_ret = math.clamp((p364 - u186.fly) / 0.55, 0, 1);
        local v365;

        if HumanoidRootPart.Parent then
            local v366 = u170;
            local v367 = HumanoidRootPart;
            local v368 = v366:FindFirstChild("UpperTorso") or v366:FindFirstChild("Torso");

            if v368 and v368:IsA("BasePart") then
                v365 = v368.Position;
            else
                v365 = v367.Position + Vector3.new(0, 0.6, 0);
            end;
        else
            v365 = u194;
        end;

        u194 = v365;
        local v369 = math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret);
        local v370 = u251;
        local v371 = v370:Lerp(v365, 0.5) + Vector3.new(0, 2.5, 0);
        local v372 = v370:Lerp(v371, v369):Lerp(v371:Lerp(v365, v369), v369);
        local v373 = not u238 and 1 or u238.k;
        u202.Position = v372;
        u201.Position = v372;
        setHero(v372, v373 + (0.1 - v373) * v369, math.sin((p364 - u186.explode) * 1.7 - 0.4) * 1 + v369 * 6);
        local v374 = 1 - math.clamp(math_clamp_ret * 2, 0, 1);

        for _, v in u216.texts do
            v[1].TextTransparency = 1 - v374;
            v[2].Transparency = 1 - v374;
        end;

        u216.scale.Scale = 1 + -0.5 * v369;
        u216.gui.StudsOffsetWorldSpace = Vector3.new(0, math_max_ret * (1 + -0.6 * v369), 0);
        local v375 = (8.5 + -6.5 * v369) * (u175 and 1.4 or 1);
        u212.Size = UDim2.fromScale(v375, v375);
        u213.ImageTransparency = 0.55 + 0.44999999999999996 * v369;
        u215.ImageTransparency = 0.66 + 0.33999999999999997 * math.clamp(math_clamp_ret * 2, 0, 1);
        PointLight2.Brightness = 1.8 + -1.8 * v369;
        u207.Enabled = false;
        u208.Rate = 110 * (1 - math.clamp(math_clamp_ret - 0.85, 0, 1) / 0.15);
        u208.Enabled = math_clamp_ret < 1;
        Trail.Enabled = math_clamp_ret < 1;

        return v372, math_clamp_ret;
    end;

    local u376 = {};

    local function at(p377, p378) -- Line: 1433
        -- upvalues: u376 (copy)
        table.insert(u376, {
            done = false,
            at = p377,
            fn = p378
        });
    end;

    if u185 then
        table.insert(u376, {
            at = 0,
            done = false,

            fn = function(p379) -- Line: 1437
                -- upvalues: sfx (copy), u201 (copy)
                if not p379 then
                    sfx("Spring", nil, 1, u201);
                end;
            end
        });
        table.insert(u376, {
            done = false,
            at = u186.land,

            fn = function(p380) -- Line: 1443
                -- upvalues: ParticleEmitter (copy), sfx (copy)
                if not p380 then
                    ParticleEmitter:Emit(30);
                    sfx("Thud", nil, 1);
                end;
            end
        });
        table.insert(u376, {
            done = false,
            at = u186.land + 0.3,

            fn = function(p381) -- Line: 1449
                -- upvalues: ParticleEmitter (copy), sfx (copy)
                if not p381 then
                    ParticleEmitter:Emit(10);
                    sfx("Thud", 0.8, 0.5);
                end;
            end
        });
        table.insert(u376, {
            done = false,
            at = u186.rest,

            fn = function() -- Line: 1456
                -- upvalues: u249 (ref), sfx (copy), NumberRange_new_ret (ref)
                u249 = sfx("Rattle", nil, 0.45, nil, {
                    Looped = true,
                    PlaybackRegionsEnabled = true,
                    PlaybackRegion = NumberRange.new(0.35, NumberRange_new_ret.Max),
                    LoopRegion = NumberRange_new_ret
                });
            end
        });

        if u187 then
            breakCrate = openCrate;
        end;

        table.insert(u376, {
            done = false,
            at = u186.explode,
            fn = breakCrate
        });
    end;

    if u238 then
        table.insert(u376, {
            done = false,
            at = u186.explode + 0.165,

            fn = function() -- Line: 1468
                -- upvalues: heroShown (copy)
                heroShown(true);
            end
        });
    end;

    table.insert(u376, {
        done = false,
        at = u186.explode,

        fn = function(p382) -- Line: 1472
            -- upvalues: u238 (ref), heroShown (copy), u185 (copy), u252 (ref), u199 (ref), u200 (copy), u206 (copy), u175 (copy), sfx (copy)
            if not u238 then
                heroShown(true);
            end;

            if not u185 then
                u252 = u199 - Vector3.new(0, 1.2, 0);
                u200.Position = u252;
            end;

            if not (p382 or u185) then
                u206:Emit(u175 and 120 or 60);
                sfx("Pop", nil, 1);
            end;
        end
    });
    table.insert(u376, {
        done = false,
        at = u186.explode + 0.3,

        fn = function(p383) -- Line: 1486
            -- upvalues: sfx (copy), u175 (copy)
            if not p383 then
                sfx("Reward", u175 and 0.9 or 1, u175 and 1.6 or 1);

                if u175 then
                    sfx("Jackpot", nil, 1.5);
                end;
            end;
        end
    });
    table.insert(u376, {
        done = false,
        at = u186.fly,

        fn = function(p384) -- Line: 1494
            -- upvalues: sfx (copy), u202 (copy)
            if not p384 then
                sfx("Collect", nil, 1, u202);
            end;
        end
    });
    table.insert(u376, {
        done = false,
        at = u186.arrive,

        fn = function(p385) -- Line: 1499
            -- upvalues: u233 (ref), u216 (copy), u213 (copy), u215 (copy), PointLight2 (copy), Trail (ref), u200 (copy), u194 (ref), u206 (copy), u187 (copy), ParticleEmitter (copy)
            if u233 then
                if u233.kind == "icon" then
                    u233.gui.Enabled = false;
                elseif u233.on ~= false then
                    u233.model.Parent = nil;
                end;

                u233.on = false;
            end;

            for _, v in u216.texts do
                v[1].TextTransparency = 1;
                v[2].Transparency = 1;
            end;

            for _, v in { u213, u215 } do
                v.ImageTransparency = 1;
            end;

            PointLight2.Brightness = 0;
            Trail.Enabled = false;

            if not p385 then
                u200.Position = u194;
                u206:Emit(14);

                if u187 then
                    ParticleEmitter:Emit(14);
                end;
            end;
        end
    });

    function u179.pose(p386) -- Line: 1518
        -- upvalues: u376 (copy), u185 (copy), u186 (copy), poseCrate (copy), poseGlow (copy), u201 (copy), u187 (copy), poseOpened (copy), poseFragments (copy), poseBurst (copy), posePrize (copy), poseFly (copy), poseRings (copy), u239 (copy)
        for _, v in u376 do
            if not v.done and v.at <= p386 then
                v.done = true;
                v.fn(p386 - v.at > 0.45);
            end;
        end;

        if u185 and p386 < u186.explode then
            local v387, v388 = poseCrate(p386);

            if u186.rest <= p386 then
                poseGlow(v387, v388, (math.clamp((p386 - u186.rest) / 2.9, 0, 1)));
            end;

            u201.Position = v387.Position;
        end;

        if u186.explode <= p386 then
            local v389 = p386 - u186.explode;

            if u187 then
                poseOpened(p386);
            elseif u185 then
                poseFragments(p386);
            end;

            poseBurst(v389);

            if p386 < u186.arrive then
                if p386 < u186.fly then
                    u201.Position = posePrize(p386, v389);
                else
                    poseFly(p386);
                end;
            end;
        end;

        poseRings(p386);
        local v390 = u186.length - p386;

        if v390 < 0.25 then
            for _, v in u239 do
                v.sound.Volume = v.volume * math.clamp(v390 / 0.25, 0, 1);
            end;
        end;
    end;

    function u179.freeze() -- Line: 1559
        -- upvalues: Folder (copy)
        for _, descendant in Folder:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0;
            end;
        end;
    end;

    function u179.lost() -- Line: 1568
        -- upvalues: u170 (copy), HumanoidRootPart (copy)
        local v391 = not (u170.Parent and HumanoidRootPart.Parent);

        if not v391 then
            if u170:FindFirstChildOfClass("Humanoid") == nil then
                v391 = false;
            else
                v391 = u170:FindFirstChildOfClass("Humanoid").Health <= 0;
            end;
        end;

        return v391;
    end;

    function u179.destroy() -- Line: 1573
        -- upvalues: u233 (ref), EmotePlayback (ref), Folder (copy), u172 (copy)
        if u233 and u233.track then
            EmotePlayback.dispose(u233.track);
        end;

        Folder:Destroy();

        if u233 and u233.model then
            u233.model:Destroy();
        end;

        if u172.crate then
            u172.crate:Destroy();
        end;
    end;

    u179.length = u186.length;
    u179.folder = Folder;
    Folder.Parent = workspace.CurrentCamera or workspace;

    return u179;
end;

local u392 = {};
local u393 = 0;
local u394 = 0;
local u395 = nil;
local u396 = {};

local function finish(p397) -- Line: 1601
    -- upvalues: u392 (copy), u393 (ref), u394 (ref), u395 (ref)
    if p397.over then
        return;
    end;

    p397.over = true;
    local success, result = pcall(p397.show.destroy);

    if not success then
        warn("[HalloweenCrateShow]", result);
    end;

    if u392[p397.id] == p397 then
        u392[p397.id] = nil;
        u393 = u393 - 1;

        if p397.mine then
            u394 = u394 - 1;
        end;

        if u393 <= 0 and u395 then
            u395:Disconnect();
            u395 = nil;
        end;
    end;

    if p397.onDone and not pcall(p397.onDone) then
        warn("[HalloweenCrateShow] onDone failed");
    end;
end;

local function step() -- Line: 1629
    -- upvalues: u392 (copy), finish (copy)
    local os_clock_ret = os.clock();

    for _, v in u392 do
        local show = v.show;
        local v398 = v.t0 + (os_clock_ret - v.clock);

        if show.length <= v398 or show.lost() then
            finish(v);
        else
            local success, result = pcall(show.pose, v398);

            if not success then
                warn("[HalloweenCrateShow]", result);
                finish(v);
            end;
        end;
    end;
end;

local function teardown(p399) -- Line: 1646
    if p399.folder then
        p399.folder:Destroy();
    end;

    if p399.hero then
        p399.hero:Destroy();
    end;

    if p399.crate then
        p399.crate:Destroy();
    end;
end;

function u1.seconds(p400) -- Line: 1658
    -- upvalues: timeline (copy)
    local v401;

    if type(p400) == "table" then
        v401 = p400.prize;
    else
        v401 = false;
    end;

    local v402;

    if type(v401) == "table" then
        v402 = v401.rarity == "Legendary" and true or v401.rarity == "Mythical";
    else
        v402 = false;
    end;

    local v403;

    if type(p400) == "table" then
        v403 = p400.model ~= nil;
    else
        v403 = false;
    end;

    return timeline(v403, v402).length;
end;

function u1.active() -- Line: 1664
    -- upvalues: u393 (ref)
    return u393;
end;

function u1.activeMine() -- Line: 1667
    -- upvalues: u394 (ref)
    return u394;
end;

function u1.play(p404, p405, p406) -- Line: 1671
    -- upvalues: u392 (copy), u393 (ref), u1 (copy), build (copy), u394 (ref), u395 (ref), RunService (copy), step (copy), finish (copy)
    local v407 = p406 or {};
    local onDone = v407.onDone;

    local function skip() -- Line: 1674
        -- upvalues: onDone (copy)
        if onDone then
            pcall(onDone);
        end;

        return false;
    end;

    if type(p404) ~= "table" or (type(p404.prize) ~= "table" or typeof(p405) ~= "Instance") then
        if onDone then
            pcall(onDone);
        end;

        return false;
    end;

    local v408 = tostring(p404.id);
    local HumanoidRootPart = p405:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and (HumanoidRootPart:IsA("BasePart") and not u392[v408])) then
        if onDone then
            pcall(onDone);
        end;

        return false;
    end;

    if v407.mine ~= true then
        if u393 >= u1.MAX then
            if onDone then
                pcall(onDone);
            end;

            return false;
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera and (workspace_CurrentCamera.CFrame.Position - HumanoidRootPart.Position).Magnitude > 70 then
            if onDone then
                pcall(onDone);
            end;

            return false;
        end;
    end;

    local v409;

    if type(p404.at) == "number" then
        local v410 = workspace:GetServerTimeNow() - p404.at;
        v409 = math.max(v410 < -1 and 0 or v410, 0);
    else
        v409 = 0;
    end;

    if u1.seconds(p404) - 0.5 <= v409 then
        if onDone then
            pcall(onDone);
        end;

        return false;
    end;

    local v411 = {};
    local success, result = pcall(build, p404, p405, v407, v411);

    if not (success and result) then
        if v411.folder then
            v411.folder:Destroy();
        end;

        if v411.hero then
            v411.hero:Destroy();
        end;

        if v411.crate then
            v411.crate:Destroy();
        end;

        if not success then
            warn("[HalloweenCrateShow]", result);
        end;

        if onDone then
            pcall(onDone);
        end;

        return false;
    end;

    local v412 = {
        id = v408,
        show = result,
        t0 = v409,
        clock = os.clock(),
        onDone = onDone,
        mine = v407.mine == true
    };
    u392[v408] = v412;
    u393 = u393 + 1;

    if v412.mine then
        u394 = u394 + 1;
    end;

    if not u395 then
        u395 = RunService.RenderStepped:Connect(step);
    end;

    local success2, result2 = pcall(result.pose, v409);

    if success2 then
        return true;
    end;

    warn("[HalloweenCrateShow]", result2);
    finish(v412);

    return false;
end;

function u1.stopAll() -- Line: 1737
    -- upvalues: u392 (copy), finish (copy), u396 (copy)
    for _, v in u392 do
        finish(v);
    end;

    for i, v in u396 do
        u396[i] = nil;
        pcall(v.show.destroy);
    end;
end;

function u1.preview(p413, p414, p415, p416) -- Line: 1749
    -- upvalues: u396 (copy), build (copy)
    local v417 = p416 or {};
    local v418 = tostring(p413.id);
    local v419 = u396[v418];

    if not v419 then
        v417.silent = true;
        local v420 = {};
        local success, result = pcall(build, p413, p414, v417, v420);

        if not success then
            if v420.folder then
                v420.folder:Destroy();
            end;

            if v420.hero then
                v420.hero:Destroy();
            end;

            if v420.crate then
                v420.crate:Destroy();
            end;

            error(result, 0);
        end;

        v419 = {
            show = result
        };
        u396[v418] = v419;
    end;

    for _, descendant in v419.show.folder:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant:Clear();
            descendant.TimeScale = 1;
        end;
    end;

    v419.show.pose(p415);

    return v419.show;
end;

function u1.freeze(p421) -- Line: 1776
    -- upvalues: u396 (copy)
    local v422 = u396[tostring(p421)];

    if v422 then
        v422.show.freeze();
    end;
end;

return u1;