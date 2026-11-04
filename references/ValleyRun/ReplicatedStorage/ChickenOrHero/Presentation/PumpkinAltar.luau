 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local CollectionService = game:GetService("CollectionService");
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local Presentation = ChickenOrHero:WaitForChild("Presentation");
local PumpkinHuntConfig = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("PumpkinHuntConfig"));
local success, result = pcall(function() -- Line: 34
    -- upvalues: ChickenOrHero (copy)
    return require(ChickenOrHero:WaitForChild("Game"):WaitForChild("RandomPrizePolicy", 10)).start();
end);

if not success or type(result) ~= "table" then
    warn("[PumpkinAltar] Game.RandomPrizePolicy didn\'t load (" .. tostring(result) .. "); nobody is treated as restricted");
    result = {
        restricted = function() -- Line: 41, Name: restricted
            return false;
        end,

        start = function() -- Line: 41, Name: start
        end,

        Changed = Instance.new("BindableEvent")
    };
end;

local HudNavigation = require(Presentation:WaitForChild("HudNavigation"));
local LocalHide = require(Presentation:WaitForChild("LocalHide"));
local LocalLooks = require(Presentation:WaitForChild("LocalLooks"));
local SacrificeScreen = require(Presentation:WaitForChild("SacrificeScreen"));
local Weapons = ChickenOrHero:WaitForChild("Weapons");
local SkinCatalog = require(Weapons:WaitForChild("SkinCatalog"));
local KnifeIconCopy = require(Weapons:WaitForChild("KnifeIconCopy"));
local Session = ChickenOrHero:WaitForChild("Game"):WaitForChild("Session");
local LocalPlayer = Players.LocalPlayer;
local Vector2_new_ret = Vector2.new(0.178, 0.56);
local u1 = { 0.04, 0.2, 0.32, 0.83 };
local u2 = {};
local u3 = false;
local u4 = nil;
local u5 = nil;
local u6 = false;
local u7 = true;
local u8 = nil;
local u9 = setmetatable({}, {
    __mode = "k"
});

local function flat(p10) -- Line: 78
    return Vector3.new(p10.X, 0, p10.Z);
end;

local function alive() -- Line: 81
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;
    local v11;

    if Character then
        v11 = Character:FindFirstChildOfClass("Humanoid");
    else
        v11 = Character;
    end;

    local v12;

    if Character then
        v12 = Character:FindFirstChild("HumanoidRootPart");
    else
        v12 = Character;
    end;

    local v13;

    if v11 == nil or v11.Health <= 0 then
        v13 = false;
    else
        v13 = v12 ~= nil;
    end;

    return Character, v11, v12, v13;
end;

local function pedestal() -- Line: 87
    -- upvalues: CollectionService (copy), PumpkinHuntConfig (copy)
    for _, v in CollectionService:GetTagged(PumpkinHuntConfig.Tag) do
        local v14 = v:IsDescendantOf(workspace) and v:FindFirstChild("Bowl", true);

        if v14 and v14:IsA("BasePart") then
            return v, v14;
        end;
    end;

    return nil;
end;

local function shotOf(p15, p16) -- Line: 96
    local v17 = p16.Position + Vector3.new(-0, -0.5, -0);
    local CameraSpot = p15:FindFirstChild("CameraSpot", true);

    if CameraSpot and CameraSpot:IsA("Attachment") then
        return CFrame.lookAt(CameraSpot.WorldPosition, v17);
    end;

    local LookVector = p16.CFrame.LookVector;
    local Vector3_new_ret = Vector3.new(LookVector.X, 0, LookVector.Z);

    if Vector3_new_ret.Magnitude < 0.1 then
        local LookVector2 = p15:GetPivot().LookVector;
        Vector3_new_ret = Vector3.new(LookVector2.X, 0, LookVector2.Z);
    end;

    return CFrame.lookAt(p16.Position + (Vector3_new_ret.Magnitude <= 0.01 and Vector3.new(1, 0, 0) or Vector3_new_ret.Unit) * 11 + Vector3.new(0, 0.6, 0), v17);
end;

local function remember(p18) -- Line: 113
    -- upvalues: u9 (copy)
    for i, v in p18.saved do
        if u9[i] == nil then
            u9[i] = v;
        end;
    end;
end;

local function sweepLeftovers(p19) -- Line: 122
    -- upvalues: u8 (ref), u9 (copy), LocalLooks (copy)
    if u8 then
        return;
    end;

    local v20 = 0;

    for i, v in u9 do
        local success2, result2 = pcall(function() -- Line: 128
            -- upvalues: i (copy)
            return i.LocalTransparencyModifier;
        end);

        if success2 and (i.Parent and (result2 >= 1 and (v < 1 and not LocalLooks.has(i, "LocalTransparencyModifier")))) then
            pcall(function() -- Line: 132
                -- upvalues: i (copy), v (copy)
                i.LocalTransparencyModifier = v;
            end);
            v20 = v20 + 1;
        end;
    end;

    table.clear(u9);

    if v20 > 0 then
        warn(("[PumpkinAltar] %d hidden parts were still hidden (%s): shown again"):format(v20, p19));
    end;
end;

local function watchPlate(p21, u22) -- Line: 145
    if p21.plates[u22] or (not u22:IsA("BillboardGui") or string.sub(u22.Name, 1, 15) ~= "PlayerOverhead_") then
        return;
    end;

    local u23 = {
        own = 0,
        wanted = u22.Enabled
    };
    p21.plates[u22] = u23;

    local function suppress() -- Line: 151
        -- upvalues: u22 (copy), u23 (copy)
        if u22.Enabled then
            local v24 = u23;
            v24.own = v24.own + 1;
            u22.Enabled = false;
        end;
    end;

    u23.connection = u22:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 157
        -- upvalues: u22 (copy), u23 (copy)
        if u22.Enabled or u23.own <= 0 then
            u23.wanted = u22.Enabled;

            if u22.Enabled then
                local v25 = u23;
                v25.own = v25.own + 1;
                u22.Enabled = false;
            end;

            return;
        end;

        local v26 = u23;
        v26.own = v26.own - 1;
    end);

    if u22.Enabled then
        u23.own = u23.own + 1;
        u22.Enabled = false;
    end;
end;

local function showPlates(p27) -- Line: 167
    for i, v in p27.plates do
        v.connection:Disconnect();

        if i.Parent then
            pcall(function() -- Line: 171
                -- upvalues: i (copy), v (copy)
                i.Enabled = v.wanted;
            end);
        end;
    end;

    local v28 = 0;

    for i, v in p27.plates do
        if i.Parent and i.Enabled ~= v.wanted then
            v28 = v28 + 1;
            pcall(function() -- Line: 181
                -- upvalues: i (copy), v (copy)
                i.Enabled = v.wanted;
            end);
        end;
    end;

    if v28 > 0 then
        warn(("[PumpkinAltar] %d nameplates weren\'t back after the altar: fixed"):format(v28));
    end;

    table.clear(p27.plates);
end;

local function hideAll(u29) -- Line: 191
    -- upvalues: u9 (copy)
    pcall(function() -- Line: 192
        -- upvalues: u29 (copy)
        u29.hide:sweep();

        if u29.character.Parent then
            u29.hide:model(u29.character);
        end;
    end);

    for i, v in u29.hide.saved do
        if u9[i] == nil then
            u9[i] = v;
        end;
    end;
end;

local function buildShowcase() -- Line: 204
    -- upvalues: SkinCatalog (copy), PumpkinHuntConfig (copy), Weapons (copy), KnifeIconCopy (copy)
    local v30 = SkinCatalog.get(PumpkinHuntConfig.Knife);
    local Models = Weapons:FindFirstChild("Models");

    if Models then
        if v30 then
            v30 = Models:FindFirstChild(v30.Model);
        end;
    else
        v30 = Models;
    end;

    if v30 then
        v30 = v30:FindFirstChild("Blade") or v30:FindFirstChildWhichIsA("BasePart", true);
    end;

    if not v30 then
        return nil;
    end;

    local v31, _, v32, v33 = KnifeIconCopy.new(v30);
    local v34 = { Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1) };
    local v35 = { v32.X, v32.Y, v32.Z };
    local v36 = 1;
    local v37 = 1;
    local v38 = v35[2] > v35[v36] and 2 or v36;
    local v39 = v35[2] < v35[v37] and 2 or v37;
    local v40 = v35[3] > v35[v38] and 3 or v38;
    local v41 = v35[3] < v35[v39] and 3 or v39;

    if v41 == v40 then
        v41 = v40 % 3 + 1;
    end;

    local v42 = v34[v40];
    local v43 = v34[v41];
    local GripPoint = v30:FindFirstChild("GripPoint");
    local v44;

    if GripPoint and GripPoint:IsA("Attachment") then
        v44 = GripPoint.Position;
    else
        v44 = v30.PivotOffset.Position;
    end;

    if v44:Dot(v42) > 0 then
        v42 = -v42;
    end;

    local v45 = CFrame.fromMatrix(Vector3.new(0, 0, 0), v42:Cross(v43), v42, v43):Inverse();
    local Model = Instance.new("Model");
    Model.Name = "PumpkinAltarShowcase";
    v31.Parent = Model;
    Model.PrimaryPart = v31;

    for _, descendant in Model:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
            descendant.CastShadow = false;
        end;
    end;

    local v46 = 2.4 / math.max(v32.X, v32.Y, v32.Z, 0.1);
    Model:ScaleTo(v46);
    local Attachment = Instance.new("Attachment");
    Attachment.Name = "Glow";
    Attachment.Position = v33 * v46;
    Attachment.Parent = v31;
    local PointLight = Instance.new("PointLight");
    PointLight.Color = Color3.fromRGB(255, 226, 150);
    PointLight.Brightness = 1.2;
    PointLight.Range = 3.5;
    PointLight.Shadows = false;
    PointLight.Parent = Attachment;
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds";
    ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 236, 140), Color3.fromRGB(198, 140, 255));
    ParticleEmitter.LightEmission = 1;
    ParticleEmitter.LightInfluence = 0;
    ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.24), NumberSequenceKeypoint.new(1, 0) });
    ParticleEmitter.Lifetime = NumberRange.new(0.8, 1.4);
    ParticleEmitter.Speed = NumberRange.new(0.3, 0.9);
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.Rate = 7;
    ParticleEmitter.Parent = Attachment;

    return Model, v31, v45 * CFrame.new(-v33 * v46);
end;

local function showcaseCentre(p47) -- Line: 273
    -- upvalues: u4 (ref), Vector2_new_ret (copy)
    local frame = u4.frame;
    local ViewportSize = p47.camera.ViewportSize;

    if not (frame and (frame.AbsoluteSize.X > 0 and (ViewportSize.X > 0 and ViewportSize.Y > 0))) then
        return nil;
    end;

    local v48 = frame.AbsolutePosition + frame.AbsoluteSize * Vector2_new_ret;
    local v49 = p47.shot:VectorToWorldSpace(Vector3.new((v48.X / ViewportSize.X * 2 - 1) * (0.4663076581549986 * ViewportSize.X / ViewportSize.Y), (1 - v48.Y / ViewportSize.Y * 2) * 0.4663076581549986, -1).Unit);

    return p47.shot.Position + v49 * 7;
end;

local function stopShowcase(p50) -- Line: 286
    local showcase = p50.showcase;

    if not showcase then
        return;
    end;

    p50.showcase = nil;

    for _, v in showcase.connections do
        v:Disconnect();
    end;

    pcall(function() -- Line: 295
        -- upvalues: showcase (copy)
        showcase.model:Destroy();
    end);
end;

local function startShowcase(p51) -- Line: 299
    -- upvalues: u8 (ref), result (copy), buildShowcase (copy), showcaseCentre (copy), u4 (ref), u1 (copy), UserInputService (copy), RunService (copy)
    if p51.showcase or (p51.finishing or (u8 ~= p51 or result.restricted())) then
        return;
    end;

    local v52, u53, u54, u55 = pcall(buildShowcase);

    if not (v52 and u53) then
        if not v52 then
            warn("[PumpkinAltar] couldn\'t build the knife showcase: " .. tostring(u53));
        end;

        return;
    end;

    local u56 = showcaseCentre(p51);

    if not u56 then
        u53:Destroy();

        return;
    end;

    local v57 = p51.shot.Position - u56;
    local Vector3_new_ret = Vector3.new(v57.X, 0, v57.Z);
    local Rotation = CFrame.lookAt(u56, u56 - (Vector3_new_ret.Magnitude <= 0.01 and Vector3.new(0, 0, 1) or Vector3_new_ret.Unit)).Rotation;
    local u58 = {
        yaw = 0,
        pitch = 0,
        spin = 0.9,
        dragging = nil,
        last = nil,
        flick = 0,
        model = u53,
        connections = {},
        born = os.clock()
    };
    p51.showcase = u58;
    u54.CFrame = CFrame.new(u56) * Rotation * u55;
    local v59 = {};

    for _, descendant in u53:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.LocalTransparencyModifier = 1;
            table.insert(v59, descendant);
        end;
    end;

    u53.Parent = p51.camera;

    for _, v in v59 do
        game:GetService("TweenService"):Create(v, TweenInfo.new(0.35), {
            LocalTransparencyModifier = 0
        }):Play();
    end;

    local function inside(p60) -- Line: 332
        -- upvalues: u4 (ref), u1 (ref)
        local frame = u4.frame;

        if not frame or frame.AbsoluteSize.X <= 0 then
            return false;
        end;

        local v61 = (Vector2.new(p60.X, p60.Y) - frame.AbsolutePosition) / frame.AbsoluteSize;
        local v62;

        if v61.X >= u1[1] and (v61.Y >= u1[2] and v61.X <= u1[3]) then
            v62 = v61.Y <= u1[4];
        else
            v62 = false;
        end;

        return v62;
    end;

    table.insert(u58.connections, UserInputService.InputBegan:Connect(function(p63, p64) -- Line: 340
        -- upvalues: inside (copy), u58 (copy)
        if p64 then
            return;
        end;

        local UserInputType = p63.UserInputType;

        if (UserInputType == Enum.UserInputType.MouseButton1 or UserInputType == Enum.UserInputType.Touch) and inside(p63.Position) then
            u58.dragging = p63;
            u58.last = Vector2.new(p63.Position.X, p63.Position.Y);
            u58.flick = 0;
        end;
    end));
    table.insert(u58.connections, UserInputService.InputChanged:Connect(function(p65) -- Line: 351
        -- upvalues: u58 (copy)
        local dragging = u58.dragging;

        if not dragging then
            return;
        end;

        local v66;

        if dragging.UserInputType == Enum.UserInputType.MouseButton1 and p65.UserInputType == Enum.UserInputType.MouseMovement then
            v66 = true;
        elseif dragging.UserInputType == Enum.UserInputType.Touch then
            v66 = p65 == dragging;
        else
            v66 = false;
        end;

        if not v66 then
            return;
        end;

        local Vector2_new_ret2 = Vector2.new(p65.Position.X, p65.Position.Y);
        local v67 = Vector2_new_ret2 - u58.last;
        u58.last = Vector2_new_ret2;
        local v68 = u58;
        v68.yaw = v68.yaw + v67.X * 0.012;
        u58.pitch = math.clamp(u58.pitch + v67.Y * 0.008, -0.35, 0.35);
        u58.flick = v67.X * 0.7;
    end));
    table.insert(u58.connections, UserInputService.InputEnded:Connect(function(p69) -- Line: 368
        -- upvalues: u58 (copy)
        local dragging = u58.dragging;

        if dragging and (p69 == dragging or dragging.UserInputType == Enum.UserInputType.MouseButton1 and p69.UserInputType == Enum.UserInputType.MouseButton1) then
            u58.dragging = nil;
            u58.spin = math.clamp(u58.flick, -12, 12);
        end;
    end));
    table.insert(u58.connections, RunService.RenderStepped:Connect(function(p70) -- Line: 376
        -- upvalues: u53 (copy), u58 (copy), u54 (copy), u56 (copy), Rotation (copy), u55 (copy)
        if not u53.Parent then
            return;
        end;

        if not u58.dragging then
            local v71 = u58;
            v71.spin = v71.spin + (0.9 - u58.spin) * math.min(1, p70 * 1.5);
            local v72 = u58;
            v72.yaw = v72.yaw + u58.spin * p70;
            local v73 = u58;
            v73.pitch = v73.pitch - u58.pitch * math.min(1, p70 * 2);
        end;

        local v74 = os.clock() - u58.born;
        local v75 = Vector3.new(0, 1, 0) * (1 - math.cos(v74 * 2.2)) * 0.05;
        local CFrame_fromAxisAngle_ret = CFrame.fromAxisAngle(Vector3.new(0, 0, 1), math.sin(v74 * 1.3) * 0.10471975511965978);
        u54.CFrame = CFrame.new(u56 + v75) * Rotation * CFrame.fromAxisAngle(Vector3.new(1, 0, 0), u58.pitch) * CFrame_fromAxisAngle_ret * CFrame.fromAxisAngle(Vector3.new(0, 1, 0), u58.yaw) * u55;
    end));
end;

local function fly(u76, u77, u78, u79) -- Line: 404
    -- upvalues: RunService (copy), u2 (copy)
    local camera = u76.camera;
    local CFrame2 = camera.CFrame;
    local FieldOfView = camera.FieldOfView;
    local u80 = u77 == u76.shot and 50 or u76.saved.fov;
    local v81 = Vector3.new(0, 1, 0) * math.clamp((u77.Position - CFrame2.Position).Magnitude * 0.35, 2, 10);
    local u82 = (CFrame2.Position + u77.Position) / 2 + v81;
    local os_clock_ret = os.clock();

    if u76.flight then
        u76.flight:Disconnect();
    end;

    u76.flight = RunService.RenderStepped:Connect(function() -- Line: 414
        -- upvalues: os_clock_ret (copy), u78 (copy), CFrame2 (copy), u82 (copy), u77 (copy), camera (copy), FieldOfView (copy), u80 (copy), u76 (copy), u79 (copy), u2 (ref)
        local success2, result2 = pcall(function() -- Line: 415
            -- upvalues: os_clock_ret (ref), u78 (ref), CFrame2 (ref), u82 (ref), u77 (ref), camera (ref), FieldOfView (ref), u80 (ref), u76 (ref), u79 (ref)
            local v83 = (os.clock() - os_clock_ret) / u78;
            local math_clamp_ret = math.clamp(v83, 0, 1);
            local v84 = math_clamp_ret * math_clamp_ret * (3 - math_clamp_ret * 2);
            local v85 = CFrame2.Position:Lerp(u82, v84):Lerp(u82:Lerp(u77.Position, v84), v84);
            local v86 = (CFrame2 - CFrame2.Position):Lerp(u77 - u77.Position, v84);
            camera.CFrame = CFrame.new(v85) * v86;
            camera.FieldOfView = FieldOfView + (u80 - FieldOfView) * v84;

            if math_clamp_ret >= 1 then
                u76.flight:Disconnect();
                u76.flight = nil;

                if u79 then
                    u79();
                end;
            end;
        end);

        if not success2 then
            warn("[PumpkinAltar] camera flight failed: " .. tostring(result2));

            if u76.flight then
                u76.flight:Disconnect();
                u76.flight = nil;
            end;

            u2.leave("instant");
        end;
    end);
end;

local function restoreCamera(p87) -- Line: 442
    -- upvalues: LocalPlayer (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera ~= p87.camera then
        return;
    end;

    local type2 = p87.saved.type;

    if type2 == Enum.CameraType.Scriptable then
        type2 = Enum.CameraType.Custom;
    end;

    workspace_CurrentCamera.CameraType = type2;
    local Character = LocalPlayer.Character;
    local v88;

    if Character then
        v88 = Character:FindFirstChildOfClass("Humanoid");
    else
        v88 = Character;
    end;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if v88 ~= nil and v88.Health > 0 then
        local _ = Character == nil;
    end;

    local subject = p87.saved.subject;

    if subject and subject.Parent then
        if subject:IsA("Humanoid") then
            if subject.Health <= 0 then
                subject = v88;
            end;
        end;
    else
        subject = v88;
    end;

    workspace_CurrentCamera.CameraSubject = subject or v88;
    workspace_CurrentCamera.FieldOfView = p87.saved.fov;
end;

local function finish(u89) -- Line: 464
    -- upvalues: u8 (ref), stopShowcase (copy), LocalPlayer (copy), Session (copy), fly (copy), RunService (copy), restoreCamera (copy), showPlates (copy), sweepLeftovers (copy)
    local u90 = u8;

    if not u90 then
        return;
    end;

    if u90.finishing then
        if u89 ~= "fly" then
            u90.abort = u89;
        end;

        return;
    end;

    u90.finishing = true;
    pcall(stopShowcase, u90);

    for _, v in u90.connections do
        v:Disconnect();
    end;

    table.clear(u90.connections);

    if u90.flight then
        u90.flight:Disconnect();
        u90.flight = nil;
    end;

    local v91 = {};

    local function urgent(p92) -- Line: 488
        -- upvalues: u90 (copy)
        u90.abort = p92;
    end;

    local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("InMatch");
    table.insert(v91, AttributeChangedSignal:Connect(function() -- Line: 491
        -- upvalues: LocalPlayer (ref), u90 (copy)
        if LocalPlayer:GetAttribute("InMatch") == true then
            u90.abort = "instant";
        end;
    end));
    local AttributeChangedSignal2 = Session:GetAttributeChangedSignal("MapChanging");
    table.insert(v91, AttributeChangedSignal2:Connect(function() -- Line: 496
        -- upvalues: Session (ref), u90 (copy)
        if Session:GetAttribute("MapChanging") == true then
            u90.abort = "instant";
        end;
    end));
    local AttributeChangedSignal3 = LocalPlayer:GetAttributeChangedSignal("CutsceneActive");
    table.insert(v91, AttributeChangedSignal3:Connect(function() -- Line: 501
        -- upvalues: LocalPlayer (ref), u90 (copy)
        if LocalPlayer:GetAttribute("CutsceneActive") == true then
            u90.abort = "instant";
        end;
    end));
    local success2, result2 = pcall(function() -- Line: 506
        -- upvalues: u89 (ref), u90 (copy), LocalPlayer (ref), fly (ref), RunService (ref)
        if u89 == "fly" and (workspace.CurrentCamera == u90.camera and u90.camera.CameraType == Enum.CameraType.Scriptable) then
            local Character = LocalPlayer.Character;
            Character = Character;
            local v93;

            if Character then
                v93 = Character:FindFirstChildOfClass("Humanoid");
            else
                v93 = Character;
            end;

            local v94 = Character and Character:FindFirstChild("HumanoidRootPart");
            local v95;

            if v93 == nil or v93.Health <= 0 then
                v95 = false;
            else
                v95 = v94 ~= nil;
            end;

            if v95 and v94 then
                local u96 = false;
                fly(u90, v94.CFrame * u90.offset, 0.75, function() -- Line: 511
                    -- upvalues: u96 (ref)
                    u96 = true;
                end);
                local os_clock_ret = os.clock();

                while not (u96 or (u90.abort or os.clock() - os_clock_ret >= 1.75)) do
                    RunService.RenderStepped:Wait();
                end;

                if u90.flight then
                    u90.flight:Disconnect();
                    u90.flight = nil;
                end;

                if u90.abort == "external" then
                    u89 = "external";
                end;
            end;
        end;
    end);

    if not success2 then
        warn("[PumpkinAltar] flying back failed: " .. tostring(result2));
    end;

    for _, v in v91 do
        v:Disconnect();
    end;

    if u89 ~= "external" then
        pcall(restoreCamera, u90);
    end;

    pcall(function() -- Line: 539
        -- upvalues: u90 (copy)
        u90.hide:restore();
    end);
    pcall(showPlates, u90);
    u8 = nil;
    pcall(sweepLeftovers, "after the altar");
    LocalPlayer:SetAttribute("PumpkinAltarActive", nil);
end;

local function enter() -- Line: 548
    -- upvalues: LocalPlayer (copy), pedestal (copy), shotOf (copy), LocalHide (copy), u8 (ref), u9 (copy), watchPlate (copy), fly (copy), u2 (copy), Session (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local v97;

    if Character then
        v97 = Character:FindFirstChildOfClass("Humanoid");
    else
        v97 = Character;
    end;

    Character = Character;
    local v98;

    if Character then
        v98 = Character:FindFirstChild("HumanoidRootPart");
    end;

    local v99;

    if v97 == nil or v97.Health <= 0 then
        v99 = false;
    else
        v99 = v98 ~= nil;
    end;

    local u100, v101 = pedestal();
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not (v99 and (u100 and workspace_CurrentCamera)) then
        return false;
    end;

    local u102 = {
        camera = workspace_CurrentCamera,
        character = Character,
        saved = {
            type = workspace_CurrentCamera.CameraType,
            subject = workspace_CurrentCamera.CameraSubject,
            fov = workspace_CurrentCamera.FieldOfView
        },
        offset = v98.CFrame:ToObjectSpace(workspace_CurrentCamera.CFrame),
        shot = shotOf(u100, v101),
        hide = LocalHide.new(),
        plates = {},
        connections = {}
    };
    u8 = u102;
    LocalPlayer:SetAttribute("PumpkinAltarActive", true);
    pcall(function() -- Line: 192
        -- upvalues: u102 (copy)
        u102.hide:sweep();

        if u102.character.Parent then
            u102.hide:model(u102.character);
        end;
    end);

    for i, v in u102.hide.saved do
        if u9[i] == nil then
            u9[i] = v;
        end;
    end;

    local v103 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if v103 then
        for _, child in v103:GetChildren() do
            watchPlate(u102, child);
        end;

        table.insert(u102.connections, v103.ChildAdded:Connect(function(p104) -- Line: 574
            -- upvalues: watchPlate (ref), u102 (copy)
            watchPlate(u102, p104);
        end));
    end;

    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    fly(u102, u102.shot, 0.9, nil);
    local connections = u102.connections;
    local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("InMatch");
    table.insert(connections, AttributeChangedSignal:Connect(function() -- Line: 581
        -- upvalues: LocalPlayer (ref), u2 (ref)
        if LocalPlayer:GetAttribute("InMatch") == true then
            u2.leave("instant");
        end;
    end));
    local connections2 = u102.connections;
    local AttributeChangedSignal2 = Session:GetAttributeChangedSignal("MapChanging");
    table.insert(connections2, AttributeChangedSignal2:Connect(function() -- Line: 586
        -- upvalues: Session (ref), u2 (ref)
        if Session:GetAttribute("MapChanging") == true then
            u2.leave("instant");
        end;
    end));
    local connections3 = u102.connections;
    local AttributeChangedSignal3 = LocalPlayer:GetAttributeChangedSignal("CutsceneActive");
    table.insert(connections3, AttributeChangedSignal3:Connect(function() -- Line: 593
        -- upvalues: LocalPlayer (ref), u2 (ref)
        if LocalPlayer:GetAttribute("CutsceneActive") == true then
            u2.leave("instant");
        end;
    end));
    table.insert(u102.connections, Character.AncestryChanged:Connect(function() -- Line: 598
        -- upvalues: Character (copy), u2 (ref)
        if not Character:IsDescendantOf(workspace) then
            u2.leave("instant");
        end;
    end));
    local v105 = Character:FindFirstChildOfClass("Humanoid");

    if v105 then
        table.insert(u102.connections, v105.Died:Connect(function() -- Line: 605
            -- upvalues: u2 (ref)
            u2.leave("instant");
        end));
    end;

    local connections4 = u102.connections;
    local PropertyChangedSignal = workspace_CurrentCamera:GetPropertyChangedSignal("CameraType");
    table.insert(connections4, PropertyChangedSignal:Connect(function() -- Line: 609
        -- upvalues: workspace_CurrentCamera (copy), u2 (ref)
        if workspace_CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
            u2.leave("external");
        end;
    end));
    local connections5 = u102.connections;
    local PropertyChangedSignal2 = workspace:GetPropertyChangedSignal("CurrentCamera");
    table.insert(connections5, PropertyChangedSignal2:Connect(function() -- Line: 614
        -- upvalues: u2 (ref)
        u2.leave("external");
    end));
    table.insert(u102.connections, u100.AncestryChanged:Connect(function() -- Line: 617
        -- upvalues: u100 (copy), u2 (ref)
        if not u100:IsDescendantOf(workspace) then
            u2.leave("instant");
        end;
    end));
    local u106 = 0;
    table.insert(u102.connections, RunService.Heartbeat:Connect(function() -- Line: 624
        -- upvalues: u106 (ref), u102 (copy), u9 (ref)
        local os_clock_ret = os.clock();

        if os_clock_ret < u106 then
            return;
        end;

        u106 = os_clock_ret + 0.3;
        local u107 = u102;
        pcall(function() -- Line: 192
            -- upvalues: u107 (copy)
            u107.hide:sweep();

            if u107.character.Parent then
                u107.hide:model(u107.character);
            end;
        end);

        for i, v in u107.hide.saved do
            if u9[i] == nil then
                u9[i] = v;
            end;
        end;
    end));

    return true;
end;

function u2.leave(p108) -- Line: 639
    -- upvalues: u6 (ref), LocalPlayer (copy), u4 (ref), u8 (ref), finish (copy)
    if u6 then
        u6 = false;
        LocalPlayer:SetAttribute("PumpkinSacrificeOpen", nil);

        if u4 then
            u4:closed();

            if p108 == "fly" then
                u4:altarOut();
            else
                u4.frame.Visible = false;
            end;
        end;
    end;

    if u8 then
        task.spawn(finish, p108);
    end;
end;

local function setOpen(p109) -- Line: 657
    -- upvalues: u6 (ref), LocalPlayer (copy), Session (copy), u2 (copy), u7 (ref), u8 (ref), u4 (ref), SacrificeScreen (copy), HudNavigation (copy), enter (copy), finish (copy), startShowcase (copy)
    if p109 == u6 then
        return;
    end;

    if not p109 then
        local v110 = LocalPlayer:GetAttribute("InMatch") == true and true or Session:GetAttribute("MapChanging") == true;
        local Character = LocalPlayer.Character;
        local v111;

        if Character then
            v111 = Character:FindFirstChildOfClass("Humanoid");
        else
            v111 = Character;
        end;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        local v112;

        if v111 == nil or v111.Health <= 0 then
            v112 = false;
        else
            v112 = Character ~= nil;
        end;

        u2.leave((v110 or not v112) and "instant" or "fly");

        return;
    end;

    if not u7 or (u8 or (LocalPlayer:GetAttribute("InMatch") == true or LocalPlayer:GetAttribute("CutsceneActive") == true)) then
        return;
    end;

    if not u4:available() then
        SacrificeScreen.notice(SacrificeScreen.UNAVAILABLE);

        return;
    end;

    HudNavigation.opening("PumpkinSacrifice");
    local success2, result2 = pcall(enter);

    if not success2 then
        warn("[PumpkinAltar] couldn\'t start: " .. tostring(result2));
        finish("instant");

        return;
    end;

    if not result2 then
        return;
    end;

    u6 = true;
    LocalPlayer:SetAttribute("PumpkinSacrificeOpen", true);
    u4:opened();
    local u113 = u8;
    task.delay(0.63, function() -- Line: 694
        -- upvalues: u6 (ref), u8 (ref), u113 (copy), u4 (ref)
        if u6 and u8 == u113 then
            u4:altarIn();
        end;
    end);
    task.delay(0.9500000000000001, function() -- Line: 700
        -- upvalues: u6 (ref), u8 (ref), u113 (copy), startShowcase (ref)
        if u6 and u8 == u113 then
            startShowcase(u113);
        end;
    end);
end;

function u2.start() -- Line: 708
    -- upvalues: u3 (ref), u4 (ref), SacrificeScreen (copy), u5 (ref), LocalPlayer (copy), pedestal (copy), u6 (ref), Session (copy), u2 (copy), HudNavigation (copy), setOpen (copy), UserInputService (copy), u7 (ref), sweepLeftovers (copy), u8 (ref)
    if u3 then
        return;
    end;

    u3 = true;
    u4 = SacrificeScreen.new({
        altar = true
    });
    u5 = Instance.new("ScreenGui");
    u5.Name = "PumpkinAltar";
    u5.ResetOnSpawn = false;
    u5.IgnoreGuiInset = true;
    u5.DisplayOrder = 66;
    u5.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    u4.frame.Visible = false;
    u4.frame.Parent = u5;
    u5.Parent = LocalPlayer:WaitForChild("PlayerGui");

    function u4.sparkTarget() -- Line: 724
        -- upvalues: pedestal (ref), u4 (ref), u5 (ref)
        local _, v114 = pedestal();
        local workspace_CurrentCamera = workspace.CurrentCamera;
        local frame = u4.frame;

        if not (v114 and (workspace_CurrentCamera and (frame and frame.AbsoluteSize.X > 0))) then
            return nil;
        end;

        local v115 = workspace_CurrentCamera:WorldToViewportPoint(v114.Position);
        local v116;

        if u5.IgnoreGuiInset then
            v116 = Vector2.zero;
        else
            v116 = game:GetService("GuiService"):GetGuiInset();
        end;

        return (Vector2.new(v115.X, v115.Y) - v116 - frame.AbsolutePosition) / frame.AbsoluteSize;
    end;

    u4.closeButton.Activated:Connect(function() -- Line: 736
        -- upvalues: u6 (ref), LocalPlayer (ref), Session (ref), u2 (ref)
        if u6 == false then
            return;
        end;

        local v117 = LocalPlayer:GetAttribute("InMatch") == true and true or Session:GetAttribute("MapChanging") == true;
        local Character = LocalPlayer.Character;
        local v118;

        if Character then
            v118 = Character:FindFirstChildOfClass("Humanoid");
        else
            v118 = Character;
        end;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        local v119;

        if v118 == nil or v118.Health <= 0 then
            v119 = false;
        else
            v119 = Character ~= nil;
        end;

        u2.leave((v117 or not v119) and "instant" or "fly");
    end);
    HudNavigation.register("PumpkinSacrifice", function() -- Line: 739
        -- upvalues: setOpen (ref), u6 (ref)
        setOpen(not u6);
    end);
    HudNavigation.Opening.Event:Connect(function(p120) -- Line: 742
        -- upvalues: u6 (ref), LocalPlayer (ref), Session (ref), u2 (ref)
        if p120 ~= "PumpkinSacrifice" then
            if u6 == false then
                return;
            end;

            local v121 = LocalPlayer:GetAttribute("InMatch") == true and true or Session:GetAttribute("MapChanging") == true;
            local Character = LocalPlayer.Character;
            local v122;

            if Character then
                v122 = Character:FindFirstChildOfClass("Humanoid");
            else
                v122 = Character;
            end;

            if Character then
                Character = Character:FindFirstChild("HumanoidRootPart");
            end;

            local v123;

            if v122 == nil or v122.Health <= 0 then
                v123 = false;
            else
                v123 = Character ~= nil;
            end;

            u2.leave((v121 or not v123) and "instant" or "fly");
        end;
    end);
    UserInputService.InputBegan:Connect(function(p124) -- Line: 747
        -- upvalues: u6 (ref), LocalPlayer (ref), Session (ref), u2 (ref)
        if u6 and p124.KeyCode == Enum.KeyCode.Escape then
            if u6 == false then
                return;
            end;

            local v125 = LocalPlayer:GetAttribute("InMatch") == true and true or Session:GetAttribute("MapChanging") == true;
            local Character = LocalPlayer.Character;
            local v126;

            if Character then
                v126 = Character:FindFirstChildOfClass("Humanoid");
            else
                v126 = Character;
            end;

            if Character then
                Character = Character:FindFirstChild("HumanoidRootPart");
            end;

            local v127;

            if v126 == nil or v126.Health <= 0 then
                v127 = false;
            else
                v127 = Character ~= nil;
            end;

            u2.leave((v125 or not v127) and "instant" or "fly");
        end;
    end);
    u4:start({
        open = function() -- Line: 753, Name: open
            -- upvalues: setOpen (ref)
            setOpen(true);
        end,

        close = function() -- Line: 756, Name: close
            -- upvalues: u6 (ref), LocalPlayer (ref), Session (ref), u2 (ref)
            if u6 == false then
                return;
            end;

            local v128 = LocalPlayer:GetAttribute("InMatch") == true and true or Session:GetAttribute("MapChanging") == true;
            local Character = LocalPlayer.Character;
            local v129;

            if Character then
                v129 = Character:FindFirstChildOfClass("Humanoid");
            else
                v129 = Character;
            end;

            if Character then
                Character = Character:FindFirstChild("HumanoidRootPart");
            end;

            local v130;

            if v129 == nil or v129.Health <= 0 then
                v130 = false;
            else
                v130 = Character ~= nil;
            end;

            u2.leave((v128 or not v130) and "instant" or "fly");
        end,

        isOpen = function() -- Line: 759, Name: isOpen
            -- upvalues: u6 (ref)
            return u6;
        end,

        setAvailable = function(p131) -- Line: 762, Name: setAvailable
            -- upvalues: u7 (ref), HudNavigation (ref)
            u7 = p131;
            HudNavigation.setAvailable("PumpkinSacrifice", p131);
        end
    });
    LocalPlayer:GetAttributeChangedSignal("InMatch"):Connect(function() -- Line: 769
        -- upvalues: sweepLeftovers (ref)
        task.defer(sweepLeftovers, "match");
    end);
    LocalPlayer.CharacterAdded:Connect(function() -- Line: 772
        -- upvalues: sweepLeftovers (ref), u8 (ref), LocalPlayer (ref)
        task.defer(function() -- Line: 773
            -- upvalues: sweepLeftovers (ref), u8 (ref), LocalPlayer (ref)
            sweepLeftovers("respawn");

            if not u8 and LocalPlayer:GetAttribute("PumpkinAltarActive") ~= nil then
                LocalPlayer:SetAttribute("PumpkinAltarActive", nil);
            end;
        end);
    end);
end;

function u2.state() -- Line: 783
    -- upvalues: u6 (ref), u8 (ref)
    local v132 = {
        open = u6,
        visit = u8 ~= nil
    };
    local v133;

    if u8 == nil then
        v133 = false;
    else
        v133 = u8.finishing == true;
    end;

    v132.finishing = v133;

    return v132;
end;

result.Changed.Event:Connect(function(p134, p135) -- Line: 787
    -- upvalues: Players (copy), u8 (ref), stopShowcase (copy)
    if p135 and (p134 == Players.LocalPlayer and u8) then
        stopShowcase(u8);
    end;
end);

return u2;