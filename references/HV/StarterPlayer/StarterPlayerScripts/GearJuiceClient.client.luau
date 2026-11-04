 

 

local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local RunService = game:GetService("RunService");
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local GearEvent = ChickenOrHero.Gear:WaitForChild("GearEvent");
local GearPredictionClient = require(ChickenOrHero.Gear:WaitForChild("GearPredictionClient"));
local AirhornCone = require(ChickenOrHero.Gear:WaitForChild("AirhornCone"));
local GearCatalog = require(ChickenOrHero.Gear:WaitForChild("GearCatalog"));
local u1;

if require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).ClientBots then
    u1 = require(ChickenOrHero:WaitForChild("Bots"):WaitForChild("BotDirectory")) or nil;
else
    u1 = nil;
end;

local Folder = Instance.new("Folder");
Folder.Name = "LocalGearEffects";
Folder.Parent = workspace;
local Color3_fromRGB_ret = Color3.fromRGB(255, 204, 96);
local Color3_fromRGB_ret2 = Color3.fromRGB(119, 229, 255);
local Color3_fromRGB_ret3 = Color3.fromRGB(248, 135, 179);
local Color3_fromRGB_ret4 = Color3.fromRGB(110, 205, 255);
local Color3_fromRGB_ret5 = Color3.fromRGB(186, 192, 204);
local Color3_fromRGB_ret6 = Color3.fromRGB(255, 70, 90);
local u2 = {
    Color3_fromRGB_ret6,
    Color3.fromRGB(255, 214, 90),
    Color3.fromRGB(110, 205, 255),
    Color3.fromRGB(122, 255, 169)
};
local Random_new_ret = Random.new();
local u3 = {};
local u4 = {};

local function part(p5, p6, p7) -- Line: 54
    -- upvalues: Folder (copy), Debris (copy)
    if #Folder:GetChildren() < 100 then
        local Part = Instance.new("Part");
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanTouch = false;
        Part.CanQuery = false;
        Part.CastShadow = false;
        Part.Material = Enum.Material.Neon;
        Part.Color = p6;
        Part.Size = p7;
        Part.CFrame = CFrame.new(p5);
        Part.Parent = Folder;
        Debris:AddItem(Part, 1.4);

        return Part;
    end;
end;

local u8 = {
    RootJoint = "Root",
    Root = "Root",
    ["Left Hip"] = "LeftHip",
    LeftHip = "LeftHip",
    ["Right Hip"] = "RightHip",
    RightHip = "RightHip",
    ["Left Shoulder"] = "LeftShoulder",
    LeftShoulder = "LeftShoulder",
    ["Right Shoulder"] = "RightShoulder",
    RightShoulder = "RightShoulder",
    Neck = "Neck"
};
local CollectionService = game:GetService("CollectionService");
local u9 = {};

local function burst(p10, p11, p12, p13) -- Line: 72
    -- upvalues: part (copy), Random_new_ret (copy), TweenService (copy)
    for i = 1, p12 do
        local v14 = part(p10, p11, Vector3.new(0.16, 0.16, 0.65));
        local v15;

        if v14 then
            local v16 = Random_new_ret:NextNumber(-1, 1);
            local v17 = Random_new_ret:NextNumber(0.1, 1);
            local Unit = Vector3.new(v16, v17, Random_new_ret:NextNumber(-1, 1)).Unit;
            v14.CFrame = CFrame.lookAt(p10, p10 + Unit);
            TweenService:Create(v14, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 1,
                Size = Vector3.new(0.03, 0.03, 0.2),
                CFrame = v14.CFrame + Unit * p13
            }):Play();
            v15 = i;
        else
            v15 = i;
        end;
    end;
end;

local function shakeBox(p18) -- Line: 563
    -- upvalues: u9 (copy)
    if p18:IsA("Model") then
        u9[p18] = true;
    end;
end;

local function sound(p19, p20, p21, p22, p23) -- Line: 112
    -- upvalues: Folder (copy), TweenService (copy), Debris (copy)
    if not p20 then
        return;
    end;

    local v24;

    if typeof(p22) == "Instance" then
        v24 = p22:FindFirstChild("HumanoidRootPart");
    else
        v24 = false;
    end;

    local u25;

    if v24 and v24:IsA("BasePart") then
        u25 = nil;
    else
        v24 = Instance.new("Part");
        v24.Name = "GearSoundOrigin";
        v24.Size = Vector3.new(0.05, 0.05, 0.05);
        v24.Transparency = 1;
        v24.Anchored = true;
        v24.CanCollide = false;
        v24.CanTouch = false;
        v24.CanQuery = false;
        v24.CFrame = CFrame.new(p19);
        v24.Parent = Folder;
        u25 = v24;
    end;

    local Sound = Instance.new("Sound");
    Sound.Name = "GearActionSound";
    Sound.SoundId = p20;
    Sound.Volume = 0.35;
    Sound.RollOffMaxDistance = 100;
    Sound.RollOffMinDistance = 7;
    Sound.RollOffMode = Enum.RollOffMode.InverseTapered;
    Sound.PlaybackSpeed = p21 or 1;
    Sound.Parent = v24;

    local function cleanup() -- Line: 140
        -- upvalues: Sound (copy), u25 (ref)
        Sound:Destroy();

        if u25 then
            u25:Destroy();
        end;
    end;

    Sound.Ended:Once(cleanup);

    if p23 then
        Sound.Played:Once(function() -- Line: 148
            -- upvalues: Sound (copy), TweenService (ref), cleanup (copy)
            task.delay(0.35, function() -- Line: 149
                -- upvalues: Sound (ref), TweenService (ref), cleanup (ref)
                if Sound.Parent then
                    TweenService:Create(Sound, TweenInfo.new(0.2), {
                        Volume = 0
                    }):Play();
                    task.delay(0.2, cleanup);
                end;
            end);
        end);
    end;

    Sound:Play();
    Debris:AddItem(u25 or Sound, 12);
end;

local function pulse(p26, p27, p28) -- Line: 86
    -- upvalues: part (copy), TweenService (copy)
    local v29 = part(p26, p27, Vector3.new(1, 1, 1));

    if not v29 then
        return;
    end;

    v29.Shape = Enum.PartType.Ball;
    v29.Transparency = 0.65;
    TweenService:Create(v29, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Transparency = 1,
        Size = Vector3.new(1, 1, 1) * p28
    }):Play();
end;

local function springPop(u30) -- Line: 514
    -- upvalues: ChickenOrHero (copy), Folder (copy), RunService (copy)
    local SpringBox = ChickenOrHero.Gear.Assets:FindFirstChild("SpringBox");

    if not SpringBox or #Folder:GetChildren() >= 100 then
        return;
    end;

    local u31 = SpringBox:Clone();
    local Open = u31:FindFirstChild("Open");
    local Close = u31:FindFirstChild("Close");
    local u32 = {};

    for _, descendant in u31:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;

            if Close and descendant:IsDescendantOf(Close) then
                descendant.Transparency = 1;
            elseif Open and descendant:IsDescendantOf(Open) then
                descendant.Transparency = 0;
                table.insert(u32, descendant);
            end;
        end;
    end;

    u31:PivotTo(u30);
    local Scale = u31:GetScale();
    local Y = u31:GetExtentsSize().Y;
    u31.Parent = Folder;
    local os_clock_ret = os.clock();
    local u33 = nil;
    u33 = RunService.RenderStepped:Connect(function() -- Line: 539
        -- upvalues: os_clock_ret (copy), u31 (copy), u33 (ref), Scale (copy), u30 (copy), Y (copy), u32 (copy)
        local v34 = os.clock() - os_clock_ret;

        if not u31.Parent or v34 >= 1 then
            u33:Disconnect();
            u31:Destroy();

            return;
        end;

        local v35;

        if v34 < 0.1 then
            v35 = 1 + 0.3 * v34 / 0.1;
        else
            v35 = math.exp(-(v34 - 0.1) * 7) * 0.3 * math.cos((v34 - 0.1) * 24) + 1;
        end;

        local math_max_ret = math.max(0.5, v35);
        u31:ScaleTo(Scale * math_max_ret);
        u31:PivotTo(u30 * CFrame.new(0, (math_max_ret - 1) * Y / 2, 0));
        local math_clamp_ret = math.clamp((v34 - 0.7) / 0.3, 0, 1);

        for _, v in u32 do
            v.Transparency = math_clamp_ret;
        end;
    end);
end;

local u36 = {
    BigDagger = "rbxassetid://105270817990246",
    Cloak = "rbxassetid://96140144540712",
    Adrenaline = "rbxassetid://92981028036615",
    DoorSlam = "rbxassetid://140635119444127",
    Airhorn = "rbxassetid://77661182776010",
    Rescue = "rbxassetid://104414731133846",
    Rocket = "rbxassetid://140324602533286",
    DecoyInflate = "rbxassetid://128355574885118",
    DoorBreak = "rbxassetid://120873363783894",
    BowlingHit = "rbxassetid://4692687595",
    Impact = "rbxassetid://101387462540484",
    LeashThrow = "rbxassetid://74238153433253",
    BananaSlip = "rbxassetid://70557734865364",
    OneHitShield = "rbxassetid://104414731133846",
    ShieldPop = "rbxassetid://120873363783894",
    BearTrapThrow = "rbxassetid://74238153433253",
    BearTrapSnap = "rbxassetid://140635119444127",
    SpringBoxThrow = "rbxassetid://74238153433253",
    SpringBoxPop = "rbxassetid://86691306425795",
    PumpkinBombThrow = "rbxassetid://74238153433253"
};

local function gesture(u37, u38) -- Line: 258
    -- upvalues: u3 (copy), TweenService (copy)
    if typeof(u37) ~= "Instance" or not (u37:IsA("Model") and u37.Parent) then
        return;
    end;

    local v39 = u3[u37];

    if v39 then
        if v39.dance then
            return;
        end;

        v39.restore();
    end;

    local u40 = {};
    u3[u37] = u40;
    local u41 = {};

    for _, descendant in u37:GetDescendants() do
        if descendant:IsA("Motor6D") and (descendant.Name == "Right Shoulder" or (descendant.Name == "RightShoulder" or (descendant.Name == "Left Shoulder" or (descendant.Name == "LeftShoulder" or (descendant.Name == "RightElbow" or (descendant.Name == "LeftElbow" or descendant.Name == "RightWrist")))))) then
            u41[descendant] = {
                base = descendant.C0,
                right = string.find(descendant.Name, "Right") ~= nil
            };
        end;
    end;

    function u40.restore() -- Line: 289
        -- upvalues: u41 (copy), u3 (ref), u37 (copy), u40 (copy)
        for i, v in u41 do
            if v.tween then
                v.tween:Cancel();
            end;

            if i.Parent then
                i.C0 = v.base;
            end;
        end;

        if u3[u37] == u40 then
            u3[u37] = nil;
        end;
    end;

    local function phase(p42, p43, p44, p45) -- Line: 302
        -- upvalues: u3 (ref), u37 (copy), u40 (copy), u41 (copy), u38 (copy), TweenService (ref)
        if u3[u37] ~= u40 or not u37.Parent then
            return false;
        end;

        for i, v in u41 do
            if i.Parent then
                local v46 = v.right and p43 and p43 or p44;
                local CFrame_Angles_ret = CFrame.Angles(math.rad(v46.X), math.rad(v46.Y), (math.rad(v46.Z)));

                if string.find(i.Name, "Elbow") then
                    CFrame_Angles_ret = CFrame.Angles(math.rad(v46.X * 0.22), 0, 0);
                elseif string.find(i.Name, "Wrist") then
                    CFrame_Angles_ret = CFrame.Angles(0, 0, (math.rad(v46.Z * 0.35)));
                end;

                local v47 = v.base * CFrame_Angles_ret;

                if (u38 == "EmergencyAirhorn" or (u38 == "RufusLeash" or (u38 == "BananaPeel" or (u38 == "BearTrap" or (u38 == "SpringBox" or (u38 == "PumpkinBomb" or u38 == "PumpkinBombChaser")))))) and string.find(i.Name, "Shoulder") then
                    local CFrame_Angles_ret2 = CFrame.Angles(math.rad(-v46.X), math.rad(v46.Y), (math.rad(v46.Z)));
                    v47 = CFrame.new(v.base.Position) * CFrame_Angles_ret2 * v.base.Rotation;
                end;

                if v.tween then
                    v.tween:Cancel();
                end;

                v.tween = TweenService:Create(i, TweenInfo.new(p42, p45 or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    C0 = v47
                });
                v.tween:Play();
            end;
        end;

        task.wait(p42);

        return u3[u37] == u40;
    end;

    task.spawn(function() -- Line: 338
        -- upvalues: u38 (copy), phase (copy), u40 (copy)
        if u38 == "EmergencyAirhorn" then
            if not phase(0.1, Vector3.new(-92, -12, 16), Vector3.new(-45, 12, -18), Enum.EasingStyle.Back) then
                return;
            end;

            if not phase(0.065, Vector3.new(-77, -7, 24), Vector3.new(-40, 9, -20)) then
                return;
            end;

            if not phase(0.075, Vector3.new(-96, -12, 12), Vector3.new(-46, 10, -16)) then
                return;
            end;
        elseif u38 == "RufusLeash" or (u38 == "BananaPeel" or (u38 == "BearTrap" or (u38 == "SpringBox" or (u38 == "PumpkinBomb" or u38 == "PumpkinBombChaser")))) then
            if not phase(0.12, Vector3.new(-125, 28, 32), Vector3.new(-20, -12, -25), Enum.EasingStyle.Back) then
                return;
            end;

            if not phase(0.09, Vector3.new(-78, -35, -16), Vector3.new(15, 10, -20), Enum.EasingStyle.Quart) then
                return;
            end;

            if not phase(0.14, Vector3.new(-32, -22, -25), Vector3.new(8, 5, -14)) then
                return;
            end;
        else
            if not phase(0.13, Vector3.new(u38 == "RocketShoes" and -35 or (u38 == "BowlingBall" and 55 or -75), 0, 12), Vector3.new(-20, 0, -12), Enum.EasingStyle.Back) then
                return;
            end;

            task.wait(0.1);
        end;

        if phase(0.25, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0), Enum.EasingStyle.Sine) then
            u40.restore();
        end;
    end);
end;

local function airhornWave(p48) -- Line: 99
    -- upvalues: part (copy), Color3_fromRGB_ret (copy), TweenService (copy), AirhornCone (copy)
    local v49 = part(p48, Color3_fromRGB_ret, Vector3.new(1, 0.6, 1));

    if not v49 then
        return;
    end;

    v49.Shape = Enum.PartType.Ball;
    v49.Transparency = 0.65;
    TweenService:Create(v49, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Transparency = 1,
        Size = Vector3.new(AirhornCone.Range * 2, 1.2, AirhornCone.Range * 2)
    }):Play();
end;

local function trail(p50, p51, p52) -- Line: 478
    -- upvalues: Debris (copy)
    if typeof(p50) ~= "Instance" then
        return;
    end;

    local HumanoidRootPart = p50:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    for _, v in { -1, 1 } do
        local Attachment = Instance.new("Attachment");
        Attachment.Position = Vector3.new(v * 0.7, -1, 0);
        Attachment.Parent = HumanoidRootPart;
        local Attachment2 = Instance.new("Attachment");
        Attachment2.Position = Vector3.new(v * 0.7, -0.5, 0);
        Attachment2.Parent = HumanoidRootPart;
        local Trail = Instance.new("Trail");
        Trail.Attachment0 = Attachment;
        Trail.Attachment1 = Attachment2;
        Trail.Color = ColorSequence.new(p51);
        Trail.Transparency = NumberSequence.new(0, 1);
        Trail.Lifetime = 0.25;
        Trail.LightEmission = 1;
        Trail.FaceCamera = true;
        Trail.Parent = HumanoidRootPart;
        task.delay(p52, function() -- Line: 502
            -- upvalues: Trail (copy)
            if Trail.Parent then
                Trail.Enabled = false;
            end;
        end);
        Debris:AddItem(Attachment, p52 + 0.3);
        Debris:AddItem(Attachment2, p52 + 0.3);
        Debris:AddItem(Trail, p52 + 0.3);
    end;
end;

local u53 = {};
local u54 = {
    OneHitShield = 1.2,
    ShieldPop = 1.35,
    BearTrapThrow = 0.85,
    BearTrapSnap = 1.6,
    SpringBoxThrow = 0.95,
    PumpkinBombThrow = 1.05
};

local function attached(u55, p56, p57, p58, p59) -- Line: 160
    -- upvalues: Folder (copy), ChickenOrHero (copy), u4 (copy), Debris (copy), Color3_fromRGB_ret2 (copy)
    if not (p57 and (p57:IsA("BasePart") and #Folder:GetChildren() < 100)) then
        return;
    end;

    local v60 = ChickenOrHero.Gear.Assets:FindFirstChild(p56);

    if not (v60 and (v60:IsA("Model") or v60:IsA("BasePart"))) then
        return;
    end;

    local v61 = u4[u55];

    if v61 then
        v61:Destroy();
    end;

    local Model = Instance.new("Model");
    local v62 = v60:Clone();
    v62.Parent = Model;

    for _, descendant in Model:GetDescendants() do
        if descendant:IsA("LuaSourceContainer") or (descendant:IsA("JointInstance") or descendant:IsA("Constraint")) then
            descendant:Destroy();
        end;
    end;

    local GripPoint = v62:FindFirstChild("GripPoint", true);
    local v63 = p57.Name == "RightHand";
    local Attribute = v60:GetAttribute(v63 and "HandGripR15" or "HandGripR6");

    if typeof(Attribute) ~= "CFrame" then
        Attribute = CFrame.new(0, -p57.Size.Y * (v63 and 0.35 or 0.5), 0) * p58;
    end;

    local Pivot = Model:GetPivot();
    local v64 = GripPoint and (GripPoint:IsA("Attachment") and Pivot:ToObjectSpace(GripPoint.WorldCFrame)) or CFrame.identity;
    Model:PivotTo(p57.CFrame * Attribute * v64:Inverse());

    for _, descendant in Model:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = false;
            descendant.Massless = true;
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = p57;
            WeldConstraint.Part1 = descendant;
            WeldConstraint.Parent = descendant;
        end;
    end;

    Model.Parent = Folder;
    u4[u55] = Model;
    Debris:AddItem(Model, p59);
    local v65 = p56 == "RufusLeash" and (v62:IsA("BasePart") and v62 and v62 or v62:FindFirstChildWhichIsA("BasePart", true));

    if v65 then
        local Attachment = Instance.new("Attachment");
        Attachment.Position = Vector3.new(-0.12, 0, 0);
        Attachment.Parent = v65;
        local Attachment2 = Instance.new("Attachment");
        Attachment2.Position = Vector3.new(0.12, 0, 0);
        Attachment2.Parent = v65;
        local Trail = Instance.new("Trail");
        Trail.Attachment0 = Attachment;
        Trail.Attachment1 = Attachment2;
        Trail.Color = ColorSequence.new(Color3_fromRGB_ret2);
        Trail.Transparency = NumberSequence.new(0.15, 1);
        Trail.Lifetime = 0.16;
        Trail.LightEmission = 0.8;
        Trail.FaceCamera = true;
        Trail.Parent = v65;
    end;

    task.delay(p59, function() -- Line: 225
        -- upvalues: u4 (ref), u55 (copy), Model (copy)
        if u4[u55] == Model then
            u4[u55] = nil;
        end;
    end);
end;

local function shoes(p66) -- Line: 231
    -- upvalues: part (copy), Color3_fromRGB_ret (copy), TweenService (copy)
    if typeof(p66) ~= "Instance" then
        return;
    end;

    for _, v in { "Left", "Right" } do
        local v67 = p66:FindFirstChild(v .. "Foot") or p66:FindFirstChild(v .. " Leg");

        if v67 and v67:IsA("BasePart") then
            local v68 = part(v67.Position, Color3_fromRGB_ret, Vector3.new(0.65, 0.65, 1.4));

            if v68 then
                v68.Anchored = false;
                v68.Massless = true;
                v68.Material = Enum.Material.Metal;
                v68.CFrame = v67.CFrame * CFrame.new(0, -v67.Size.Y * 0.35, 0.25);
                local WeldConstraint = Instance.new("WeldConstraint");
                WeldConstraint.Part0 = v67;
                WeldConstraint.Part1 = v68;
                WeldConstraint.Parent = v68;
                local PointLight = Instance.new("PointLight");
                PointLight.Color = Color3_fromRGB_ret;
                PointLight.Brightness = 2;
                PointLight.Range = 5;
                PointLight.Parent = v68;
                TweenService:Create(v68, TweenInfo.new(0.6), {
                    Transparency = 1
                }):Play();
            end;
        end;
    end;
end;

local function trapDance(u69, p70, p71) -- Line: 388
    -- upvalues: u3 (copy), u8 (copy), RunService (copy)
    if typeof(u69) ~= "Instance" or not (u69:IsA("Model") and u69.Parent) then
        return;
    end;

    local HumanoidRootPart = u69:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v72 = u3[u69];

    if v72 then
        v72.restore();
    end;

    local v73 = type(p71) == "number" and (p71 or 0.5) or 0.5;
    local math_clamp_ret = math.clamp(v73, 0.2, 2);
    local v74 = p70 == "Left";
    local v75 = u69:FindFirstChild(v74 and "Left Leg" or "Right Leg") or u69:FindFirstChild(v74 and "LeftLowerLeg" or "RightLowerLeg");
    local v76 = v75 and (v75:IsA("BasePart") and HumanoidRootPart.CFrame:PointToObjectSpace(v75.Position - v75.CFrame.UpVector * v75.Size.Y * 0.5)) or Vector3.new(v74 and -0.5 or 0.5, -3, 0);
    local u77 = {};

    for _, descendant in u69:GetDescendants() do
        if descendant:IsA("Motor6D") and (u8[descendant.Name] and (descendant.Part0 and descendant.Part1)) then
            u77[descendant] = {
                base = descendant.C0,
                role = u8[descendant.Name]
            };
        end;
    end;

    local u78 = {
        dance = true
    };
    u3[u69] = u78;
    local u79 = nil;

    function u78.restore() -- Line: 418
        -- upvalues: u79 (ref), u77 (copy), u3 (ref), u69 (copy), u78 (copy)
        if u79 then
            u79:Disconnect();
            u79 = nil;
        end;

        for i, v in u77 do
            if i.Parent then
                i.C0 = v.base;
            end;
        end;

        if u3[u69] == u78 then
            u3[u69] = nil;
        end;
    end;

    local u80 = v74 and "RightHip" or "LeftHip";
    local u81 = v74 and 1 or -1;
    local CFrame_new_ret = CFrame.new(v76);
    local os_clock_ret = os.clock();
    u79 = RunService.RenderStepped:Connect(function() -- Line: 436
        -- upvalues: os_clock_ret (copy), u3 (ref), u69 (copy), u78 (copy), math_clamp_ret (ref), u77 (copy), CFrame_new_ret (copy), u80 (copy), u81 (copy)
        local v82 = os.clock() - os_clock_ret;

        if u3[u69] ~= u78 or (not u69.Parent or math_clamp_ret <= v82) then
            u78.restore();

            return;
        end;

        local v83 = math.min(1, v82 / 0.05) * math.clamp((math_clamp_ret - v82) / (math_clamp_ret * 0.2), 0, 1);
        local v84 = math.max(0, 1 - v82 / 0.15) * v83;
        local v85 = math.sin(v82 * 3.141592653589793 * 10) * v83;

        for i, v in u77 do
            if i.Parent then
                local v86 = nil;

                if v.role == "Root" then
                    v86 = CFrame_new_ret * CFrame.Angles(v84 * -0.24434609527920614, 0, v85 * 0.24434609527920614) * CFrame_new_ret:Inverse();
                else
                    local v87 = nil;

                    if v.role == u80 then
                        v87 = CFrame.Angles(math.sin(v82 * 3.141592653589793 * 14) * 0.8726646259971648 * v83, 0, math.rad(25 * u81) * v83);
                    elseif v.role == "LeftShoulder" or v.role == "RightShoulder" then
                        local v88 = math.sin(v82 * 3.141592653589793 * 12) * 35 + 75;
                        local v89 = math.rad(v88) * v83;
                        v87 = CFrame.Angles(0, 0, v.role == "RightShoulder" and v89 and v89 or -v89);
                    elseif v.role == "Neck" then
                        v87 = CFrame.Angles(0, math.sin(v82 * 3.141592653589793 * 16) * 0.4363323129985824 * v83, 0);
                    end;

                    if v87 then
                        local CFrame_new_ret2 = CFrame.new(v.base.Position);
                        v86 = CFrame_new_ret2 * v87 * CFrame_new_ret2:Inverse();
                    end;
                end;

                if v86 then
                    i.C0 = v86 * v.base;
                end;
            end;
        end;
    end);
end;

for _, v in CollectionService:GetTagged("SpringBoxShake") do
    if v:IsA("Model") then
        u9[v] = true;
    end;
end;

CollectionService:GetInstanceAddedSignal("SpringBoxShake"):Connect(shakeBox);
CollectionService:GetInstanceRemovedSignal("SpringBoxShake"):Connect(function(p90) -- Line: 572
    -- upvalues: u9 (copy)
    u9[p90] = nil;
end);
RunService.RenderStepped:Connect(function() -- Line: 575
    -- upvalues: u9 (copy), GearCatalog (copy)
    if next(u9) == nil then
        return;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();
    local v91 = GearCatalog.Items.SpringBox.ShakeSeconds or 2.5;

    for i in u9 do
        local Attribute = i:GetAttribute("PopAt");
        local Attribute2 = i:GetAttribute("LandAt");
        local Attribute3 = i:GetAttribute("Landing");

        if typeof(Attribute3) == "CFrame" and (type(Attribute) == "number" and (type(Attribute2) == "number" and (Attribute2 + 0.05 <= ServerTimeNow and Attribute - ServerTimeNow <= v91))) then
            i:PivotTo(Attribute3 * GearCatalog.boxShake(Attribute - ServerTimeNow, os.clock()));
        end;
    end;
end);

local function clampRig(p92, p93, p94) -- Line: 589
    -- upvalues: ChickenOrHero (copy), Debris (copy)
    local BearTrap = ChickenOrHero.Gear.Assets:FindFirstChild("BearTrap");
    local v95 = p92:FindFirstChild(p93 == "Left" and "Left Leg" or "Right Leg") or p92:FindFirstChild(p93 == "Left" and "LeftLowerLeg" or "RightLowerLeg");

    if not (BearTrap and (BearTrap:IsA("Model") or BearTrap:IsA("BasePart")) and (v95 and v95:IsA("BasePart"))) then
        return;
    end;

    local BearTrapClamp = p92:FindFirstChild("BearTrapClamp");

    if BearTrapClamp then
        BearTrapClamp:Destroy();
    end;

    local v96 = BearTrap:Clone();
    v96.Name = "BearTrapClamp";
    local Open = v96:FindFirstChild("Open");
    local Close = v96:FindFirstChild("Close");

    if Open and Close then
        Open.Transparency = 1;
        Close.Transparency = 0;
    end;

    local v97 = v96:IsA("Model");
    local v98 = v97 and v96:GetExtentsSize().Y or v96.Size.Y;
    local v99 = v95.CFrame * CFrame.new(0, (v98 - v95.Size.Y) * 0.5 + 0.05, 0) * CFrame.Angles(0, 0.7853981633974483, 0);

    if v97 then
        v96:PivotTo(v99);
    else
        v96.CFrame = v99;
    end;

    for _, v in v97 and (v96:GetDescendants() or { v96 }) or { v96 } do
        if v:IsA("LuaSourceContainer") then
            v:Destroy();
        elseif v:IsA("BasePart") then
            v.Anchored = false;
            v.Massless = true;
            v.CanCollide = false;
            v.CanTouch = false;
            v.CanQuery = false;
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = v95;
            WeldConstraint.Part1 = v;
            WeldConstraint.Parent = v;
        end;
    end;

    v96.Parent = p92;
    local v100 = type(p94) == "number" and p94 and p94 or 0.5;
    Debris:AddItem(v96, (math.clamp(v100, 0.2, 3)));
end;

local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(190, 235, 110), Color3.fromRGB(110, 165, 45));
local u101 = {};
local u102 = nil;
local u103 = nil;

local function watchFart() -- Line: 639
    -- upvalues: u103 (ref), RunService (copy), u101 (copy), GearCatalog (copy), u102 (ref)
    if u103 then
        return;
    end;

    local LocalPlayer = game:GetService("Players").LocalPlayer;
    u103 = RunService.RenderStepped:Connect(function(p104) -- Line: 644
        -- upvalues: LocalPlayer (copy), u101 (ref), GearCatalog (ref), u102 (ref), u103 (ref)
        local os_clock_ret = os.clock();
        local v105 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
        local v106 = LocalPlayer:GetAttribute("GameRole") == "Catcher";
        local v107 = false;

        for i = #u101, 1, -1 do
            local v108 = u101[i];
            local v109;

            if v108.ends <= os_clock_ret then
                table.remove(u101, i);
                v109 = i;
            elseif v106 and (v105 and (((v105.Position - v108.position) * Vector3.new(1, 0, 1)).Magnitude <= v108.radius and math.abs(v105.Position.Y - v108.position.Y) <= 8)) then
                v109 = i;
                v107 = true;
            else
                v109 = i;
            end;
        end;

        local FartCloud = GearCatalog.Items.FartCloud;
        local v110 = v107 and (FartCloud and FartCloud.Blur or 16) or 0;

        if v110 > 0 and not u102 then
            u102 = Instance.new("BlurEffect");
            u102.Name = "FartBlur";
            u102.Size = 0;
            u102.Parent = workspace.CurrentCamera;
        end;

        if u102 then
            local v111 = u102;
            v111.Size = v111.Size + (v110 - u102.Size) * math.min(1, p104 * 6);

            if v110 == 0 and u102.Size < 0.3 then
                u102:Destroy();
                u102 = nil;
            end;
        end;

        if #u101 == 0 and not u102 then
            u103:Disconnect();
            u103 = nil;
        end;
    end);
end;

local function fartCloud(p112, p113, p114) -- Line: 681
    -- upvalues: GearCatalog (copy), sound (copy), Folder (copy), ColorSequence_new_ret (copy), burst (copy), u101 (copy), u103 (ref), RunService (copy), u102 (ref), Debris (copy)
    local FartCloud = GearCatalog.Items.FartCloud;

    if FartCloud then
        FartCloud = FartCloud.Sounds[tonumber(p113.sound) or 1];
    end;

    if FartCloud then
        sound(p112, FartCloud, 1, p114);
    end;

    if #Folder:GetChildren() >= 100 then
        return;
    end;

    local v115 = tonumber(p113.radius) or 9;
    local math_clamp_ret = math.clamp(v115, 2, 20);
    local v116 = tonumber(p113.seconds) or 5;
    local math_clamp_ret2 = math.clamp(v116, 0.5, 10);
    local Part = Instance.new("Part");
    Part.Name = "FartCloud";
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(math_clamp_ret * 1.6, 3, math_clamp_ret * 1.6);
    Part.CFrame = CFrame.new(p112 - Vector3.new(0, 1.2, 0));
    Part.Parent = Folder;
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds";
    ParticleEmitter.Color = ColorSequence_new_ret;
    ParticleEmitter.LightInfluence = 0.4;
    ParticleEmitter.Shape = Enum.ParticleEmitterShape.Box;
    ParticleEmitter.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume;
    ParticleEmitter.Size = NumberSequence.new(3, 6.5);
    ParticleEmitter.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 0.45), NumberSequenceKeypoint.new(1, 1) });
    ParticleEmitter.Lifetime = NumberRange.new(1.6, 2.4);
    ParticleEmitter.Rate = 14;
    ParticleEmitter.Speed = NumberRange.new(0.4, 1.2);
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.Rotation = NumberRange.new(0, 360);
    ParticleEmitter.RotSpeed = NumberRange.new(-25, 25);
    ParticleEmitter.Acceleration = Vector3.new(0, 0.6, 0);
    ParticleEmitter.Parent = Part;
    ParticleEmitter:Emit(18);
    burst(p112 - Vector3.new(0, 1, 0), Color3.fromRGB(150, 210, 70), 10, 4);
    local v117 = {
        position = p112,
        radius = math_clamp_ret,
        ends = os.clock() + math_clamp_ret2
    };
    table.insert(u101, v117);

    if not u103 then
        local LocalPlayer = game:GetService("Players").LocalPlayer;
        u103 = RunService.RenderStepped:Connect(function(p118) -- Line: 644
            -- upvalues: LocalPlayer (copy), u101 (ref), GearCatalog (ref), u102 (ref), u103 (ref)
            local os_clock_ret = os.clock();
            local v119 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
            local v120 = LocalPlayer:GetAttribute("GameRole") == "Catcher";
            local v121 = false;

            for i = #u101, 1, -1 do
                local v122 = u101[i];
                local v123;

                if v122.ends <= os_clock_ret then
                    table.remove(u101, i);
                    v123 = i;
                elseif v120 and (v119 and (((v119.Position - v122.position) * Vector3.new(1, 0, 1)).Magnitude <= v122.radius and math.abs(v119.Position.Y - v122.position.Y) <= 8)) then
                    v123 = i;
                    v121 = true;
                else
                    v123 = i;
                end;
            end;

            local FartCloud2 = GearCatalog.Items.FartCloud;
            local v124 = v121 and (FartCloud2 and FartCloud2.Blur or 16) or 0;

            if v124 > 0 and not u102 then
                u102 = Instance.new("BlurEffect");
                u102.Name = "FartBlur";
                u102.Size = 0;
                u102.Parent = workspace.CurrentCamera;
            end;

            if u102 then
                local v125 = u102;
                v125.Size = v125.Size + (v124 - u102.Size) * math.min(1, p118 * 6);

                if v124 == 0 and u102.Size < 0.3 then
                    u102:Destroy();
                    u102 = nil;
                end;
            end;

            if #u101 == 0 and not u102 then
                u103:Disconnect();
                u103 = nil;
            end;
        end);
    end;

    task.delay(math_clamp_ret2, function() -- Line: 723
        -- upvalues: ParticleEmitter (copy)
        ParticleEmitter.Enabled = false;
    end);
    Debris:AddItem(Part, math_clamp_ret2 + 2.6);
end;

local u126 = {};
local Color3_fromRGB_ret7 = Color3.fromRGB(96, 78, 60);

local function graveAdded(p127) -- Line: 733
    -- upvalues: u126 (copy)
    if not p127:IsA("BasePart") then
        return;
    end;

    u126[p127] = {
        risen = false,
        sunk = false,
        settled = false
    };
    local Attribute = p127:GetAttribute("Landing");

    if typeof(Attribute) == "CFrame" then
        p127.CFrame = Attribute - Vector3.new(0, 1, 0) * (p127.Size.Y + 0.5);
    end;
end;

for _, v in CollectionService:GetTagged("GraveRise") do
    graveAdded(v);
end;

CollectionService:GetInstanceAddedSignal("GraveRise"):Connect(graveAdded);
CollectionService:GetInstanceRemovedSignal("GraveRise"):Connect(function(p128) -- Line: 747
    -- upvalues: u126 (copy)
    u126[p128] = nil;
end);
RunService.RenderStepped:Connect(function() -- Line: 750
    -- upvalues: u126 (copy), burst (copy), Color3_fromRGB_ret7 (copy), sound (copy), GearCatalog (copy)
    if next(u126) == nil then
        return;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();

    for i, v in u126 do
        local Attribute = i:GetAttribute("Landing");
        local Attribute2 = i:GetAttribute("RiseAt");
        local Attribute3 = i:GetAttribute("SinkAt");

        if typeof(Attribute) == "CFrame" and (type(Attribute2) == "number" and type(Attribute3) == "number") then
            local v129, v130;
            local v131 = 0;

            while true do
                if v131 == 0 then
                    v131 = -1;
                    local v132 = i:GetAttribute("Rise") or 0.5;
                    local v133 = i:GetAttribute("Sink") or 0.45;
                    local v134 = i.Size.Y + 0.5;
                    local v135 = Attribute.Position - Vector3.new(0, 1, 0) * (i.Size.Y / 2);
                    v129 = -v134;
                    v130 = 0;

                    if Attribute2 <= ServerTimeNow and ServerTimeNow < Attribute2 + v132 then
                        local v136 = (ServerTimeNow - Attribute2) / v132;
                        v129 = -v134 * (1 - v136) ^ 2.2;
                        v130 = 0.16 * (1 - v136) + 0.04;

                        if not v.risen then
                            v.risen = true;
                            burst(v135, Color3_fromRGB_ret7, 14, 6);
                        end;

                        v131 = 1;
                        continue;
                    end;

                    if Attribute2 + v132 <= ServerTimeNow and ServerTimeNow < Attribute3 then
                        v131 = 2;
                        continue;
                    end;

                    if Attribute3 <= ServerTimeNow and ServerTimeNow < Attribute3 + v133 then
                        local v137 = (ServerTimeNow - Attribute3) / v133;
                        v129 = -v134 * v137 * v137;
                        v130 = 0.14;

                        if not v.sunk then
                            v.sunk = true;
                            i.CanCollide = false;
                            burst(v135, Color3_fromRGB_ret7, 10, 4);

                            if i:GetAttribute("Lead") then
                                sound(v135, GearCatalog.Items.KingsDemise.Sounds.Sink, 1);
                            end;
                        end;
                    end;

                    v131 = 1;
                    continue;
                elseif v131 == 1 then
                    v131 = -1;
                    local v138;

                    if v130 > 0 then
                        v138 = CFrame.new((math.random() - 0.5) * v130 * 2, 0, (math.random() - 0.5) * v130 * 2) * CFrame.Angles((math.random() - 0.5) * v130, 0, (math.random() - 0.5) * v130);
                    else
                        v138 = CFrame.identity;
                    end;

                    i.CFrame = Attribute * v138 + Vector3.new(0, 1, 0) * v129;
                    v131 = 3;
                    continue;
                elseif v131 == 2 then
                    v131 = -1;

                    if not v.settled then
                        v.settled = true;
                        i.CFrame = Attribute;
                    end;

                    v131 = 3;
                    continue;
                elseif v131 == 3 then
                    v131 = -1;
                    break;
                else
                    break;
                end;
            end;
        end;
    end;
end);
local LocalHide = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("LocalHide"));
local u139 = {};

local function hole(p140, p141) -- Line: 808
    -- upvalues: Color3_fromRGB_ret7 (copy), Folder (copy)
    local v142 = {};

    for i, v in {
        {
            "BurrowHoleRim",
            Color3_fromRGB_ret7,
            1.25,
            0.06
        },
        {
            "BurrowHole",
            Color3.fromRGB(8, 6, 5),
            1,
            0.1
        }
    } do
        local Part = Instance.new("Part");
        Part.Name = v[1];
        Part.Shape = Enum.PartType.Cylinder;
        local v143;

        if i == 1 then
            v143 = Enum.Material.Ground;
        else
            v143 = Enum.Material.SmoothPlastic;
        end;

        Part.Material = v143;
        Part.Color = v[2];
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.CanTouch = false;
        Part.CastShadow = false;
        Part.Size = Vector3.new(0.1, 0.05, 0.05);
        Part:SetAttribute("Share", v[3]);
        Part.CFrame = CFrame.new(p140 + Vector3.new(0, 1, 0) * v[4]) * CFrame.Angles(0, 0, 1.5707963267948966);
        Part.Parent = Folder;
        v142[i] = Part;
    end;

    return v142;
end;

local function openHole(p144, p145, p146) -- Line: 826
    for _, v in p144 do
        local v147 = p146 * (v:GetAttribute("Share") or 1) * p145;
        local math_max_ret = math.max(0.05, v147);
        v.Size = Vector3.new(0.1, math_max_ret, math_max_ret);
    end;
end;

local function burrowDig(p148, p149, u150) -- Line: 832
    -- upvalues: GearCatalog (copy), u139 (copy), Folder (copy), hole (copy), sound (copy), burst (copy), Color3_fromRGB_ret7 (copy), RunService (copy), openHole (copy), LocalHide (copy)
    local Burrow = GearCatalog.Items.Burrow;

    if not Burrow then
        return;
    end;

    if typeof(u150) ~= "Instance" or u139[u150] then
        return;
    end;

    local HumanoidRootPart = u150:FindFirstChild("HumanoidRootPart");
    local landing = p149.landing;

    if not HumanoidRootPart or typeof(landing) ~= "CFrame" then
        return;
    end;

    u139[u150] = true;
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { u150, Folder };
    RaycastParams_new_ret.RespectCanCollide = true;
    local v151 = nil;

    for _, v in { "Left Leg", "Right Leg", "LeftFoot", "RightFoot" } do
        local v152 = u150:FindFirstChild(v);

        if v152 and v152:IsA("BasePart") then
            local v153 = HumanoidRootPart.Position.Y - (v152.Position.Y - v152.Size.Y / 2);

            if v151 then
                v151 = math.max(v151, v153);
            else
                v151 = v153;
            end;
        end;
    end;

    local v154 = v151 or u150:GetExtentsSize().Y / 2;
    local math_clamp_ret = math.clamp(v154, 1, 6);

    local function feetAt(p155) -- Line: 863
        -- upvalues: math_clamp_ret (ref), RaycastParams_new_ret (copy)
        local v156 = p155.Y - math_clamp_ret;
        local v157 = workspace:Raycast(p155, Vector3.new(0, 1, 0) * -(math_clamp_ret + 1.5), RaycastParams_new_ret);

        if v157 and v156 < v157.Position.Y then
            v156 = v157.Position.Y;
        end;

        return v156;
    end;

    local v158 = tonumber(p149.windup) or 0.45;
    local math_clamp_ret2 = math.clamp(v158, 0.1, 1);
    local v159 = tonumber(p149.pop) or 0.35;
    local math_clamp_ret3 = math.clamp(v159, 0.1, 1);
    local math_min_ret = math.min(Burrow.HoleOpen or 0.15, math_clamp_ret2 * 0.5);
    local u160 = Burrow.HoleSize or 4.5;
    local u161 = Burrow.TunnelDepth or 5;
    local Position = HumanoidRootPart.Position;
    local Rotation = HumanoidRootPart.CFrame.Rotation;
    local Rotation2 = landing.Rotation;
    local X = Position.X;
    local v162 = Position.Y - math_clamp_ret;
    local v163 = workspace:Raycast(Position, Vector3.new(0, 1, 0) * -(math_clamp_ret + 1.5), RaycastParams_new_ret);

    if v163 and v162 < v163.Position.Y then
        v162 = v163.Position.Y;
    end;

    local Vector3_new_ret = Vector3.new(X, v162, Position.Z);
    local X2 = landing.X;
    local Position2 = landing.Position;
    local v164 = Position2.Y - math_clamp_ret;
    local v165 = workspace:Raycast(Position2, Vector3.new(0, 1, 0) * -(math_clamp_ret + 1.5), RaycastParams_new_ret);

    if v165 and v164 < v165.Position.Y then
        v164 = v165.Position.Y;
    end;

    local Vector3_new_ret2 = Vector3.new(X2, v164, landing.Z);
    local u166 = hole(Vector3_new_ret, u160);
    local u167 = nil;
    local u168 = nil;
    local u169 = nil;
    local u170 = nil;
    local os_clock_ret = os.clock();
    sound(Vector3_new_ret, Burrow.Sounds.Dive, 1, u150);
    burst(Vector3_new_ret, Color3_fromRGB_ret7, 12, 5);
    local v171 = u150:GetAttribute("BotUserId") or u150:GetFullName();
    local u172 = "BurrowDig" .. tostring(v171) .. os.clock();
    local u173 = u150 == game:GetService("Players").LocalPlayer.Character;

    local function finish() -- Line: 890
        -- upvalues: RunService (ref), u172 (copy), u173 (copy), u166 (copy), u167 (ref), u168 (ref), u139 (ref), u150 (copy)
        RunService:UnbindFromRenderStep(u172);

        if u173 then
            RunService:UnbindFromRenderStep(u172 .. "Hide");
        end;

        for _, v in { u166, u167 } do
            for _, v2 in v or {} do
                v2:Destroy();
            end;
        end;

        if u168 then
            u168:restore();
        end;

        u139[u150] = nil;
    end;

    if u173 then
        RunService:BindToRenderStep(u172 .. "Hide", Enum.RenderPriority.Camera.Value + 1, function() -- Line: 906
            -- upvalues: u168 (ref), u150 (copy)
            if u168 then
                u168:model(u150);
            end;
        end);
    end;

    RunService:BindToRenderStep(u172, Enum.RenderPriority.Input.Value + 2, function() -- Line: 912
        -- upvalues: os_clock_ret (copy), u150 (copy), HumanoidRootPart (copy), math_clamp_ret2 (copy), math_clamp_ret3 (copy), finish (copy), openHole (ref), u166 (copy), math_min_ret (copy), u160 (copy), u170 (ref), burst (ref), Vector3_new_ret (copy), Color3_fromRGB_ret7 (ref), u168 (ref), LocalHide (ref), Position (copy), u161 (copy), Rotation (copy), u169 (ref), u167 (ref), hole (ref), Vector3_new_ret2 (copy), sound (ref), Burrow (copy), landing (copy), Rotation2 (copy)
        local v174 = os.clock() - os_clock_ret;

        if not (u150.Parent and (HumanoidRootPart.Parent and math_clamp_ret2 + math_clamp_ret3 + 1 >= v174)) then
            finish();

            return;
        end;

        local v175;

        if v174 < math_clamp_ret2 then
            openHole(u166, math.min(1, v174 / math_min_ret), u160);
            local math_max_ret = math.max(0, (v174 - math_min_ret) / (math_clamp_ret2 - math_min_ret));

            if math_max_ret > 0 and not u170 then
                u170 = true;
                burst(Vector3_new_ret, Color3_fromRGB_ret7, 16, 7);
            end;

            if math_max_ret > 0.55 and not u168 then
                u168 = LocalHide.new();
                u168:model(u150);
            end;

            v175 = CFrame.new(Position - Vector3.new(0, 1, 0) * (u161 + 3) * math_max_ret * math_max_ret) * Rotation;
        else
            if not u169 then
                u169 = true;
                u167 = hole(Vector3_new_ret2, u160);
                openHole(u167, 1, u160);
                burst(Vector3_new_ret2, Color3_fromRGB_ret7, 22, 9);
                sound(Vector3_new_ret2, Burrow.Sounds.Rise, 1, u150);
                sound(Vector3_new_ret2, Burrow.Sounds.Pop, 1.3, u150);

                if u168 then
                    u168:restore();
                    u168 = nil;
                end;
            end;

            local math_min_ret2 = math.min(1, (v174 - math_clamp_ret2) / math_clamp_ret3);
            openHole(u166, math.max(0, 1 - math_min_ret2 * 2), u160);

            if math_min_ret2 >= 1 then
                local math_min_ret3 = math.min(1, (v174 - math_clamp_ret2 - math_clamp_ret3) / 0.2);
                openHole(u167, 1 - math_min_ret3, u160);

                if math_min_ret3 >= 1 and u150:GetAttribute("Burrowing") == nil then
                    finish();
                end;

                return;
            end;

            local v176 = -u161 * (1 - math_min_ret2) ^ 2 + math.sin(3.141592653589793 * math_min_ret2) * 2.2;
            v175 = CFrame.new(landing.Position + Vector3.new(0, 1, 0) * v176) * Rotation2 * CFrame.Angles((1 - math_min_ret2) * -0.4363323129985824, 0, 0);
        end;

        u150:PivotTo(v175 * HumanoidRootPart.CFrame:Inverse() * u150:GetPivot());
    end);
end;

local function renderFX(p177) -- Line: 965
    -- upvalues: u53 (copy), u1 (copy), ChickenOrHero (copy), sound (copy), u36 (copy), u54 (copy), gesture (copy), pulse (copy), Color3_fromRGB_ret4 (copy), burst (copy), attached (copy), fartCloud (copy), burrowDig (copy), GearCatalog (copy), airhornWave (copy), Color3_fromRGB_ret (copy), shoes (copy), trail (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret2 (copy), part (copy), TweenService (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret6 (copy), springPop (copy), u2 (copy), clampRig (copy), trapDance (copy)
    if type(p177) ~= "table" or typeof(p177.position) ~= "Vector3" then
        return;
    end;

    if type(p177.requestId) == "string" and (p177.kind == "Airhorn" or p177.kind == "Use") then
        local u178 = tostring(p177.ownerId) .. ":" .. p177.requestId .. ":" .. tostring(p177.kind);

        if u53[u178] then
            return;
        end;

        u53[u178] = true;
        task.delay(4, function() -- Line: 975
            -- upvalues: u53 (ref), u178 (copy)
            u53[u178] = nil;
        end);
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera or (workspace_CurrentCamera.CFrame.Position - p177.position).Magnitude > 120 then
        return;
    end;

    local position = p177.position;
    local kind = p177.kind;
    local v179;

    if kind == "Use" then
        v179 = p177.item or kind;
    else
        v179 = kind;
    end;

    local character = p177.character;

    if character == nil and (u1 and type(p177.actorId) == "number") then
        local v180 = u1.resolve(p177.actorId);
        character = v180 and v180.Character or nil;
    end;

    local v181;

    if typeof(character) == "Instance" then
        v181 = character:GetAttribute("ClientBot") == true;
    else
        v181 = false;
    end;

    local v182 = ChickenOrHero.Gear.Assets:FindFirstChild(kind .. "Sound");
    local v183 = u36[v179] or v182 and v182:IsA("Sound") and require(game:GetService("ReplicatedFirst"):WaitForChild("LazySound")).id(v182);
    local v184;

    if u36[v179] then
        v184 = u54[v179] or 1;
    else
        v184 = v182 and (v182:IsA("Sound") and v182.PlaybackSpeed) or 1;
    end;

    sound(position, v183, v184, character, kind == "Airhorn");

    if kind == "Use" then
        if p177.item ~= "BigDagger" and (p177.item ~= "Cloak" and (p177.item ~= "BrokenVow" and (p177.item ~= "TimeWarp" and (p177.item ~= "FartCloud" and (p177.item ~= "KingsDemise" and (p177.item ~= "Burrow" and p177.item ~= "PiratesCall")))))) then
            gesture(character, p177.item);
        end;

        if p177.item == "OneHitShield" then
            pulse(position, Color3_fromRGB_ret4, 6.5);
            burst(position, Color3_fromRGB_ret4, 10, 3);
        end;

        if (p177.item == "EmergencyAirhorn" or p177.item == "RufusLeash") and typeof(character) == "Instance" then
            local v185 = character:FindFirstChild("RightHand") or character:FindFirstChild("Right Arm");
            attached(character, p177.item, v185, CFrame.identity, p177.item == "RufusLeash" and 0.23 or 0.72);
        end;
    else
        if kind == "FartCloud" then
            fartCloud(position, p177, character);

            return;
        end;

        if kind == "BurrowDig" then
            burrowDig(position, p177, character);

            return;
        end;

        if kind == "KingsDemise" then
            local KingsDemise = GearCatalog.Items.KingsDemise;

            if KingsDemise then
                sound(position, KingsDemise.Sounds.Rise, 1, character);
                sound(position, KingsDemise.Sounds.Whisper, 1, character);
            end;
        else
            if kind == "Airhorn" then
                airhornWave(position);
                burst(position, Color3_fromRGB_ret, 16, 5);

                return;
            end;

            if kind == "Rocket" then
                shoes(character);
                trail(character, Color3_fromRGB_ret, 0.55);
                burst(position - Vector3.new(0, 1, 0), Color3_fromRGB_ret, 16, 4);

                return;
            end;

            if kind == "DecoyInflate" then
                pulse(position, Color3_fromRGB_ret3, 7);
                burst(position, Color3_fromRGB_ret3, 12, 4);

                return;
            end;

            if kind == "DecoyPop" then
                burst(position, Color3_fromRGB_ret3, 20, 6);
                pulse(position, Color3_fromRGB_ret3, 5);

                return;
            end;

            if kind == "DoorSlam" or kind == "DoorHit" then
                burst(position - Vector3.new(0, 2, 0), Color3_fromRGB_ret, kind == "DoorSlam" and 16 or 8, 4);

                return;
            end;

            if kind == "DoorBreak" then
                burst(position, Color3_fromRGB_ret, 22, 6);
                pulse(position, Color3_fromRGB_ret, 6);

                return;
            end;

            if kind == "DoorFade" then
                burst(position, Color3_fromRGB_ret2, 8, 3);

                return;
            end;

            if kind == "BowlingHit" or kind == "Impact" then
                pulse(position, Color3_fromRGB_ret, 5);
                burst(position, Color3_fromRGB_ret, 14, 4);

                return;
            end;

            if kind == "LeashHit" then
                pulse(position, Color3_fromRGB_ret2, GearCatalog.Items.RufusLeash.HitRadius * 2);
                burst(position, Color3_fromRGB_ret2, 10, 3);
                trail(character, Color3_fromRGB_ret2, 0.3);

                return;
            end;

            if kind == "LeashThrow" then
                burst(position, Color3_fromRGB_ret2, 6, 2);

                return;
            end;

            if kind == "BananaThrow" then
                gesture(character, "BananaPeel");
                burst(position, Color3_fromRGB_ret, 7, 2);

                return;
            end;

            if kind == "BananaSlip" then
                pulse(position - Vector3.new(0, 2, 0), Color3_fromRGB_ret, 4);
                burst(position - Vector3.new(0, 1, 0), Color3_fromRGB_ret, 12, 3);
                trail(character, Color3_fromRGB_ret, 0.65);

                for i = 1, 6 do
                    local v186 = i * 3.141592653589793 / 3;
                    local math_cos_ret = math.cos(v186);
                    local math_sin_ret = math.sin(v186);
                    local v187 = part(position + Vector3.new(math_cos_ret, 1.4, math_sin_ret), Color3_fromRGB_ret, Vector3.new(0.2, 0.2, 0.2));
                    local v188;

                    if v187 then
                        v187.Shape = Enum.PartType.Ball;
                        local TweenInfo_new_ret = TweenInfo.new(0.8, Enum.EasingStyle.Quad);
                        local v189 = {
                            Transparency = 1,
                            Size = Vector3.new(0.04, 0.04, 0.04)
                        };
                        local v190 = math.cos(v186 + 1.7) * 1.8;
                        local v191 = math.sin(v186 + 1.7) * 1.8;
                        v189.Position = position + Vector3.new(v190, 2.3, v191);
                        TweenService:Create(v187, TweenInfo_new_ret, v189):Play();
                        v188 = i;
                    else
                        v188 = i;
                    end;
                end;

                return;
            end;

            if kind == "ShieldPop" then
                pulse(position, Color3_fromRGB_ret4, 8);
                burst(position, Color3_fromRGB_ret4, 18, 6);
                burst(position, Color3.new(1, 1, 1), 8, 4);

                return;
            end;

            if kind == "BearTrapThrow" then
                burst(position, Color3_fromRGB_ret5, 6, 2);

                return;
            end;

            if kind == "SpringBoxThrow" then
                burst(position, Color3_fromRGB_ret6, 6, 2);

                return;
            end;

            if kind == "PumpkinBombThrow" then
                burst(position, Color3.fromRGB(255, 140, 40), 6, 2);

                return;
            end;

            if kind == "SpringBoxPop" then
                springPop(typeof(p177.cf) == "CFrame" and p177.cf or CFrame.new(position));
                pulse(position, Color3_fromRGB_ret6, 5);

                for _, v in u2 do
                    burst(position + Vector3.new(0, 1, 0), v, 5, 6);
                end;

                if p177.burst then
                    local v192 = tonumber(p177.radius) or 10;
                    local math_clamp_ret = math.clamp(v192, 2, 20);
                    pulse(position, Color3.fromRGB(255, 150, 50), math_clamp_ret);
                    burst(position + Vector3.new(0, 1, 0), Color3.fromRGB(255, 120, 30), 22, 14);
                    burst(position + Vector3.new(0, 1, 0), Color3.fromRGB(70, 60, 60), 14, 7);
                    sound(position, "rbxassetid://125205557479599", 1.05);
                end;
            else
                if kind == "BearTrapSnap" then
                    local v193 = position - Vector3.new(0, 2.5, 0);
                    pulse(v193, Color3_fromRGB_ret5, 4);
                    burst(v193, Color3_fromRGB_ret5, 14, 4);

                    for i = 1, 5 do
                        local v194 = i * 3.141592653589793 * 0.4;
                        local v195 = math.cos(v194) * 1.2;
                        local v196 = math.sin(v194) * 1.2;
                        local v197 = part(position + Vector3.new(v195, 2.4, v196), Color3_fromRGB_ret, Vector3.new(0.25, 0.25, 0.25));
                        local v198;

                        if v197 then
                            v197.Shape = Enum.PartType.Ball;
                            local TweenInfo_new_ret = TweenInfo.new(0.55, Enum.EasingStyle.Sine);
                            local v199 = {
                                Transparency = 1,
                                Size = Vector3.new(0.05, 0.05, 0.05)
                            };
                            local v200 = math.cos(v194 + 2.4) * 1.2;
                            local v201 = math.sin(v194 + 2.4) * 1.2;
                            v199.Position = position + Vector3.new(v200, 2.7, v201);
                            TweenService:Create(v197, TweenInfo_new_ret, v199):Play();
                            v198 = i;
                        else
                            v198 = i;
                        end;
                    end;

                    if v181 then
                        clampRig(character, p177.side, p177.duration);
                    end;

                    trapDance(character, p177.side, p177.duration);

                    return;
                end;

                if kind == "Rescue" then
                    pulse(position, Color3.fromRGB(122, 255, 169), 7);
                    burst(position, Color3_fromRGB_ret2, 16, 4);

                    return;
                end;

                if kind == "LifelineThrow" then
                    pulse(position, Color3.fromRGB(240, 92, 80), 5);

                    return;
                end;

                if kind == "LifelineCut" then
                    burst(position, Color3.fromRGB(214, 170, 98), 10, 3);

                    return;
                end;

                if kind == "LifelineSnap" then
                    pulse(position, Color3.fromRGB(255, 90, 80), 5);
                    burst(position, Color3.fromRGB(214, 170, 98), 22, 5);

                    return;
                end;

                if kind == "LifelineSave" then
                    pulse(position, Color3.fromRGB(122, 255, 169), 8);
                    burst(position, Color3.fromRGB(240, 92, 80), 18, 5);

                    return;
                end;

                if kind == "Adrenaline" then
                    pulse(position, Color3_fromRGB_ret2, 6);
                    trail(character, Color3_fromRGB_ret2, 1);
                end;
            end;
        end;
    end;
end;

local u204 = GearEvent.OnClientEvent:Connect(function(p202, p203) -- Line: 1150
    -- upvalues: GearPredictionClient (copy), renderFX (copy)
    if p202 == "FX" and not GearPredictionClient.consumeFX(p203) then
        renderFX(p203);
    end;
end);
local u205 = GearPredictionClient.FX.Event:Connect(renderFX);
local u209 = GearPredictionClient.Cancel.Event:Connect(function(p206) -- Line: 1156
    -- upvalues: u3 (copy), u4 (copy)
    local character = p206.character;
    local v207;

    if character then
        v207 = u3[character];
    else
        v207 = character;
    end;

    if v207 and not v207.dance then
        v207.restore();
    end;

    local v208;

    if character then
        v208 = u4[character];
    else
        v208 = character;
    end;

    if v208 then
        v208:Destroy();
        u4[character] = nil;
    end;
end);
script.Destroying:Connect(function() -- Line: 1169
    -- upvalues: u204 (copy), u205 (copy), u209 (copy), u3 (copy), Folder (copy)
    u204:Disconnect();
    u205:Disconnect();
    u209:Disconnect();

    for _, v in u3 do
        v.restore();
    end;

    Folder:Destroy();
end);