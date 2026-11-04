  

local Lighting = game:GetService("Lighting");
local CollectionService = game:GetService("CollectionService");
local RunService = game:GetService("RunService");
local LocalPlayer = game.Players.LocalPlayer;

if not RunService:IsClient() then
    warn("Attempted to initialize SmartBone on Server.");

    return nil;
end;

local Dependencies = script:WaitForChild("Dependencies");
local Components = script:WaitForChild("Components");
local Config = require(Dependencies.Config);
local UnitConversion = require(Dependencies.UnitConversion);
local DefaultSettings = require(Dependencies.DefaultSettings);
local ParticleTree = require(Components.ParticleTree);
local Particle = require(Components.Particle);
local SettingsMath = require(Dependencies.SettingsMath);
local Utilities = require(Dependencies.Utilities);
local Random_new_ret = Random.new(12098135901304);
local Tagged = CollectionService:GetTagged("SmartBone");
local Debug = Config.Debug;
local u1;

if Debug then
    u1 = Instance.new("Model");
    u1.Name = "SMARTBONE_DEBUGFOLDER";
    u1.Parent = workspace;
    local Highlight = Instance.new("Highlight");
    Highlight.FillColor = Color3.fromRGB(255, 0, 0);
    Highlight.OutlineTransparency = 1;
    Highlight.FillTransparency = 0;
    Highlight.Parent = u1;
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
    Highlight.Enabled = true;
else
    u1 = nil;
end;

local u2 = {};
local u3 = {};
u3.__index = u3;

function u3.new(p4: userdata, p5: table, p6: any) -- Line: 119
    -- upvalues: Random_new_ret (copy), UnitConversion (copy), u3 (copy), DefaultSettings (copy)
    local v7 = {
        Time = 0,
        WindPreviousPosition = Vector3.new(0, 0, 0),
        Removed = false,
        InRange = false,
        ID = Random_new_ret:NextInteger(1, 10000000),
        RootPart = p4,
        ParticleTrees = {},
        Connections = {},
        RootList = p5,
        ObjectScale = UnitConversion.Convert(math.abs(p4.Size.X), "Millimeter"),
        RemovedEvent = Instance.new("BindableEvent"),
        Settings = {}
    };
    local v8 = setmetatable(v7, u3);

    for i, v in DefaultSettings do
        v8.Settings[i] = p4:GetAttribute(i) or v;
    end;

    v8.Settings.RootReference = p6;
    v8.Settings.BlendWeight = 1;
    v8.Settings.UpdateRate = math.floor(v8.Settings.UpdateRate + 0.1);
    v8:Init();
    v8:UpdateParameters(v8.Settings);

    return v8;
end;

function u3.Init(u9) -- Line: 151
    -- upvalues: u2 (copy), Lighting (copy)
    local RootPart = u9.RootPart;
    u2[u9.ID] = u9;
    u9.Connections.AttributeChanged = RootPart.AttributeChanged:ConnectParallel(function(p10: string) -- Line: 158
        -- upvalues: u9 (copy), RootPart (copy)
        if not u9.Settings[p10] then
            return;
        end;

        u9:UpdateParameters(p10, RootPart:GetAttribute(p10));
    end);
    u9.Connections.LightingAttributeChanged = Lighting.AttributeChanged:ConnectParallel(function(p11: string) -- Line: 163
        -- upvalues: u9 (copy), Lighting (ref)
        if not u9.Settings[p11] then
            return;
        end;

        u9:UpdateParameters(p11, Lighting:GetAttribute(p11));
    end);

    for _, descendant in RootPart:GetDescendants() do
        if descendant:IsA("Bone") and (descendant.Parent:IsA("Bone") and #descendant:GetChildren() == 0) then
            local v12 = descendant.WorldCFrame + descendant.WorldCFrame.UpVector.Unit * (descendant.WorldPosition - descendant.Parent.WorldPosition).Magnitude;
            local Bone = Instance.new("Bone");
            Bone.Parent = descendant;
            Bone.Name = descendant.Name .. "_Tail";
            Bone.WorldCFrame = v12;
        end;
    end;

    for _, v in u9.RootList do
        u9:AppendParticleTree(v);
    end;

    for _, v in u9.ParticleTrees do
        u9:AppendParticles(v, v.Root, 0, 0);
    end;
end;

function u3.AppendParticleTree(p13: table, p14: userdata) -- Line: 188
    -- upvalues: ParticleTree (copy)
    table.insert(p13.ParticleTrees, ParticleTree.new(p14, p13.RootPart, p13.Settings.Gravity));
end;

function u3.AppendParticles(p15: table, p16: table, p17: userdata, p18: number, p19: number) -- Line: 192
    -- upvalues: Particle (copy), Debug (copy), u1 (ref), Utilities (copy)
    local Settings = p15.Settings;
    local v20 = Particle.new(p17, p16.Root, p15.RootPart, Settings);
    local WorldPosition = p17.WorldPosition;
    v20.Position = p17.WorldPosition;
    v20.LastPosition = WorldPosition;
    v20.ParentIndex = p18;
    v20.BoneLength = p19;
    v20.HeirarchyLength = 0;

    if Debug == true then
        v20.DebugPart = Instance.new("Part");
        v20.DebugPart.Size = Vector3.new(0.1, 0.1, 0.1);
        v20.DebugPart.Anchored = true;
        v20.DebugPart.CanCollide = false;
        v20.DebugPart.CastShadow = false;
        v20.DebugPart.CanTouch = false;
        v20.DebugPart.CanQuery = false;
        v20.DebugPart.Color = Color3.fromRGB(255, 0, 0);
        v20.DebugPart.Parent = u1;
    end;

    if p18 >= 1 then
        p19 = (p16.Particles[p18].Bone.WorldPosition - v20.Position).Magnitude;
        v20.BoneLength = p19;
        v20.Weight = p19 * 0.7;
        v20.HeirarchyLength = Utilities.GetHierarchyLength(p17, p16.Root);
    end;

    if v20.HeirarchyLength <= Settings.AnchorDepth then
        v20.Anchored = true;
    end;

    table.insert(p16.Particles, v20);
    local v21 = #p16.Particles;
    local Children = p17:GetChildren();

    for i = 1, #Children do
        local v22 = Children[i];
        local v23;

        if v22:IsA("Bone") then
            p15:AppendParticles(p16, v22, v21, p19);
            v23 = i;
        else
            v23 = i;
        end;
    end;
end;

function u3.UpdateParameters(p24, p25, p26) -- Line: 237
    -- upvalues: SettingsMath (copy)
    if not p24.Settings[p25] then
        return;
    end;

    local Settings = p24.Settings;

    if SettingsMath[p25] then
        p26 = SettingsMath[p25](p26);
    end;

    Settings[p25] = p26;
end;

function u3.PreUpdate(p27: table, p28: table) -- Line: 242
    local Settings = p27.Settings;
    local RootPart = p28.RootPart;
    local Root = p28.Root;
    p28.ObjectMove = RootPart.Position - p28.ObjectPreviousPosition;
    p28.ObjectPreviousPosition = RootPart.Position;
    local Gravity = Settings.Gravity;
    local v29 = Root.CFrame:PointToWorldSpace(Gravity).Unit * Gravity.Magnitude;
    p28.RestGravity = Root.CFrame:PointToWorldSpace(v29);

    for _, v in p28.Particles do
        v.LastTransformOffset = v.TransformOffset;

        if v.Bone == v.Root then
            v.TransformOffset = RootPart.CFrame * v.RootTransform;
        else
            v.TransformOffset = Root.WorldCFrame * v.Transform;
        end;

        v.LocalTransformOffset = Root.CFrame * v.LocalTransform;
    end;
end;

function u3.UpdateParticles(p30: table, p31: table, p32: number, p33: number) -- Line: 270
    local Settings = p30.Settings;
    local Damping = Settings.Damping;
    local Gravity = Settings.Gravity;
    local Unit = Gravity.Unit;
    local RootReference = Settings.RootReference;

    if RootReference then
        local LookVector = CFrame.new(RootReference.Position, (RootReference.CFrame * p31.LockedDirection).Position).LookVector;

        if p31.ObjectMove:Dot(-LookVector) > 0.1 then
            return p30:SkipUpdateParticles(p31);
        end;
    end;

    local v34 = p31.RestGravity:Dot(Unit);
    local v35 = Gravity + Unit * math.max(v34, 0) * 100;
    local v36 = (v35 + v35 * 0.2) * (p30.ObjectScale * p32);
    local v37 = p33 == 0 and (p31.ObjectMove or Vector3.new(0, 0, 0)) or Vector3.new(0, 0, 0);

    for _, v in p31.Particles do
        if v.ParentIndex >= 1 and v.Anchored == false then
            local v38;

            if Settings.WindInfluence > 0 then
                local v39 = p31.WindOffset + (os.clock() - v.HeirarchyLength / 5) + (v.TransformOffset.Position - p31.Root.WorldPosition).Magnitude / 5 * Settings.WindInfluence;
                local v40 = Settings.WindDirection.X + Settings.WindDirection.X * math.sin(v39 * Settings.WindSpeed);
                local v41 = Settings.WindDirection.Y + math.sin(v39 * Settings.WindSpeed) * 0.05;
                local v42 = Settings.WindDirection.Z + Settings.WindDirection.X * math.sin(v39 * Settings.WindSpeed);
                v38 = Vector3.new(v40, v41, v42) / v.BoneLength * Settings.WindInfluence * (Settings.WindStrength / 100 * (math.clamp(v.HeirarchyLength, 1, 10) / 10)) * v.Weight;
                p30.WindPreviousPosition = v38;
            else
                v38 = Vector3.new(0, 0, 0);
            end;

            local v43 = v37 * Settings.Inertia;
            local v44 = (v.Position - v.LastPosition) * (1 - Damping) + v36 + v43 + v38;
            v.LastPosition = v.Position + v43;
            v.Position = v.Position + v44;
        else
            v.LastPosition = v.TransformOffset.Position;
            v.Position = v.TransformOffset.Position;
        end;
    end;
end;

function u3.CorrectParticles(p45: table, p46: table, p47: number) -- Line: 352
    local Settings = p45.Settings;
    local Stiffness = Settings.Stiffness;

    for _, v in p46.Particles do
        local v48 = p46.Particles[v.ParentIndex];

        if v48 and (v.ParentIndex >= 1 and v.Anchored == false) then
            local Magnitude = (v48.TransformOffset.Position - v.TransformOffset.Position).Magnitude;

            if Stiffness > 0 or Settings.Elasticity > 0 then
                local Position = (CFrame.new(v48.Position) * v48.TransformOffset.Rotation * CFrame.new(v.LocalTransformOffset.Position)).Position;
                v.Position = v.Position + (Position - v.Position) * (Settings.Elasticity * p47);

                if Stiffness > 0 then
                    local v49 = Position - v.Position;
                    local Magnitude2 = v49.Magnitude;
                    local v50 = Magnitude * (1 - Stiffness) * 2;

                    if v50 < Magnitude2 then
                        v.Position = v.Position + v49 * ((Magnitude2 - v50) / Magnitude2);
                    end;
                end;
            end;

            local v51 = v48.Position - v.Position;
            local Magnitude2 = v51.Magnitude;

            if Magnitude2 > 0 then
                v.Position = v.Position + v51 * ((Magnitude2 - Magnitude) / Magnitude2);
            end;
        end;
    end;
end;

function u3.SkipSingleUpdateParticle(p52, p53, p54) -- Line: 392
    if p54.ParentIndex >= 1 and not p54.Anchored then
        p54.LastPosition = p54.LastPosition + p53.ObjectMove;
        p54.Position = p54.Position + p53.ObjectMove;
        local v55 = p53.Particles[p54.ParentIndex];
        local Magnitude = (v55.TransformOffset.Position - p54.TransformOffset.Position).Magnitude;
        local Stiffness = p52.Settings.Stiffness;

        if Stiffness > 0 then
            local v56 = v55.Position + CFrame.lookAt(v55.Position, p54.Position).LookVector.Unit * (v55.Position - p54.Position).Magnitude - p54.Position;
            local Magnitude2 = v56.Magnitude;
            local v57 = Magnitude * (1 - Stiffness) * 2;

            if v57 < Magnitude2 then
                p54.Position = p54.Position + v56 * ((Magnitude2 - v57) / Magnitude2);
            end;
        end;

        local v58 = v55.Position - p54.Position;
        local Magnitude2 = v58.Magnitude;

        if Magnitude < Magnitude2 then
            p54.Position = p54.Position + v58 * ((Magnitude2 - Magnitude) / Magnitude2);
        end;
    else
        p54.LastPosition = p54.TransformOffset.Position;
        p54.Position = p54.TransformOffset.Position;
    end;
end;

function u3.SkipUpdateParticles(p59: table, p60: table) -- Line: 428
    for _, v in p60.Particles do
        p59:SkipSingleUpdateParticle(p60, v);
    end;
end;

function u3.CalculateTransforms(p61: table, p62: table, p63: number) -- Line: 435
    -- upvalues: Utilities (copy)
    if p61.InRange then
        for _, v in p62.Particles do
            if v.ParentIndex >= 1 and v.Anchored == false then
                local v64 = p62.Particles[v.ParentIndex];
                local Bone = v64.Bone;

                if v64 and (Bone and (Bone:IsA("Bone") and Bone ~= p62.Root)) then
                    local TransformOffset = v64.TransformOffset;
                    local v65 = TransformOffset:PointToObjectSpace(v64.LocalTransformOffset.Position);
                    local v66 = Utilities.GetRotationBetween(TransformOffset.UpVector, v.Position - v64.Position, v65).Rotation * TransformOffset.Rotation;
                    v64.CalculatedWorldCFrame = Bone.WorldCFrame:Lerp(CFrame.new(v64.Position) * v66, 1 - 0.00001 ^ p63);
                end;
            end;
        end;
    end;
end;

function u3.TransformBones(p67: table, p68: table) -- Line: 463
    if p67.InRange then
        for _, v in p68.Particles do
            if v.ParentIndex >= 1 and v.Anchored == false then
                local v69 = p68.Particles[v.ParentIndex];
                local Bone = v69.Bone;

                if v69 and (Bone and (Bone:IsA("Bone") and Bone ~= p68.Root)) then
                    if v69.Anchored and p67.Settings.AnchorsRotate == false then
                        Bone.WorldCFrame = v69.TransformOffset;
                    else
                        Bone.WorldCFrame = v69.CalculatedWorldCFrame;
                    end;
                end;
            end;
        end;
    end;
end;

function u3.DEBUG(p70: table, p71: table) -- Line: 484
    for _, v in p71.Particles do
        if v then
            v.DebugPart.CFrame = CFrame.new(v.Position);
        end;
    end;
end;

function u3.RunLoop(p72: table, p73: table, p74: number, p75: number) -- Line: 492
    -- upvalues: LocalPlayer (copy)
    local v76 = true;
    local v77 = p74 * 10;

    if LocalPlayer:GetAttribute("SmartBones") ~= true then
        p72:ResetParticles(p73);

        return;
    end;

    if p75 > 0 then
        p72.Time = p72.Time + p74;

        if 1 / p75 <= p72.Time then
            p72.Time = 0;
            v76 = true;
        else
            v76 = false;
        end;
    end;

    if not v76 then
        p72:SkipUpdateParticles(p73);

        return;
    end;

    p72:UpdateParticles(p73, v77, 0);
    p72:CorrectParticles(p73, v77);
end;

function u3.ResetParticles(p78: table, p79: table) -- Line: 520
    for _, v in p79.Particles do
        v.LastPosition = v.TransformOffset.Position;
        v.Position = v.TransformOffset.Position;
    end;
end;

function u3.ResetTransforms(p80: table, p81: table) -- Line: 527
    for _, v in p81.Particles do
        local v82;

        if v.Bone == v.Root then
            v82 = p81.RootPart.CFrame * v.RootTransform;
        else
            v82 = p81.Root.WorldCFrame * v.Transform;
        end;

        v.Bone.WorldCFrame = v82;
    end;
end;

function u3.UpdateBones(p83: table, p84: number, p85: number, p86: any) -- Line: 541
    for _, v in p83.ParticleTrees do
        p83:PreUpdate(v, p84);
        p83:RunLoop(v, p84, p85);
        p83:CalculateTransforms(v, p84);
    end;
end;

function u3.Start() -- Line: 549
    -- upvalues: Debug (copy), Utilities (copy), u2 (copy), CollectionService (copy), Tagged (copy)
    local LocalPlayer2 = game.Players.LocalPlayer;
    local Folder = Instance.new("Folder");
    Folder.Name = "Actors";
    Folder.Parent = LocalPlayer2:WaitForChild("PlayerScripts");

    local function DebugPrint(p87: string) -- Line: 556
        -- upvalues: Debug (ref)
        if Debug then
            warn(p87);
        end;
    end;

    local u88 = {};
    local u89 = {};

    local function registerSmartBoneObject(p90: userdata) -- Line: 565
        -- upvalues: Utilities (ref), Folder (copy), u88 (copy), u89 (copy), Debug (ref)
        if p90:IsA("BasePart") and (Utilities.WaitForChildOfClass(p90, "Bone", 3) and game.Workspace:IsAncestorOf(p90)) then
            local v91 = {};
            local RootReference = p90:FindFirstChild("RootReference");
            local v92;

            if RootReference then
                v92 = RootReference.Value;
            else
                v92 = nil;
            end;

            if p90:GetAttribute("Roots") and (p90:GetAttribute("Roots") ~= nil and typeof(p90:GetAttribute("Roots")) == "string") then
                local string_split_ret = string.split(p90:GetAttribute("Roots"), ",");

                for _, v in ipairs(string_split_ret) do
                    local v93 = p90:FindFirstChild(v, true);

                    if v93 and v93:IsA("Bone") then
                        table.insert(v91, v93);
                    end;
                end;
            end;

            if #v91 > 0 then
                local Actor = Instance.new("Actor");
                local BindableFunction = Instance.new("BindableFunction");
                BindableFunction.Name = "Event";
                BindableFunction.Parent = Actor;
                local v94 = script.Dependencies.ActorScript:Clone();
                v94.Name = "Runtime";
                v94.Parent = Actor;
                Actor.Parent = Folder;
                v94.Enabled = true;
                u88[p90] = Actor.Event:Invoke(p90, v91, v92);
                Actor.Name = p90.Name .. u88[p90].ID;
                u88[p90].RemovedEvent.Event:Once(function() -- Line: 612
                    -- upvalues: Actor (copy)
                    Actor.Runtime.Enabled = false;
                    Actor:Destroy();
                end);
                table.insert(u89, p90);
                local v95 = "Created new SmartBone Object with ID: " .. u88[p90].ID;

                if Debug then
                    warn(v95);
                end;
            else
                table.insert(u89, p90);
                local v96 = "Failed to create SmartBone Object for " .. p90:GetFullName() .. "! Make sure you have defined the Root Bone(s) for this object!";

                if Debug then
                    warn(v96);
                end;
            end;
        end;
    end;

    local function removeSmartBoneObject(u97: userdata) -- Line: 630
        -- upvalues: u88 (copy), Debug (ref), u2 (ref)
        if u88[u97] then
            local v98 = "Removing SmartBone Object with ID: " .. u88[u97].ID;

            if Debug then
                warn(v98);
            end;

            task.spawn(function() -- Line: 633
                -- upvalues: u88 (ref), u97 (copy), u2 (ref)
                for _, v in pairs(u88[u97].Connections) do
                    v:Disconnect();
                end;

                u88[u97].SimulationConnection:Disconnect();
                task.wait();
                u88[u97].RemovedEvent:Destroy();

                for _, v in ipairs(u88[u97].ParticleTrees) do
                    for _, v2 in v.Particles do
                        for _, v3 in v2.RecyclingBin do
                            v3:Destroy();
                        end;
                    end;
                end;

                task.wait();

                if u2[u88[u97].ID] then
                    u2[u88[u97].ID] = nil;
                end;

                u88[u97].Removed = true;
                u88[u97].RemovedEvent:Fire();
                u88[u97] = nil;
            end);
        end;
    end;

    CollectionService:GetInstanceAddedSignal("SmartBone"):Connect(registerSmartBoneObject);
    CollectionService:GetInstanceRemovedSignal("SmartBone"):Connect(removeSmartBoneObject);

    for _, v in pairs(Tagged) do
        if not (u88[v] or table.find(u89, v)) then
            task.spawn(function() -- Line: 671
                -- upvalues: registerSmartBoneObject (copy), v (copy)
                registerSmartBoneObject(v);
            end);
        end;
    end;
end;

return u3;