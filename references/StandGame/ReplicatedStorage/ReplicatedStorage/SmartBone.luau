 

 

local l__Lighting__1 = game:GetService("Lighting");
local l__CollectionService__2 = game:GetService("CollectionService");
if not game:GetService("RunService"):IsClient() then
    warn("Attempted to initialize SmartBone on Server.");
    return nil;
end;
local l__Dependencies__3 = script:WaitForChild("Dependencies");
local l__Components__4 = script:WaitForChild("Components");
local l__Config__5 = require(l__Dependencies__3.Config);
local l__UnitConversion__6 = require(l__Dependencies__3.UnitConversion);
local l__DefaultSettings__7 = require(l__Dependencies__3.DefaultSettings);
local l__ParticleTree__8 = require(l__Components__4.ParticleTree);
local l__Particle__9 = require(l__Components__4.Particle);
local l__SettingsMath__10 = require(l__Dependencies__3.SettingsMath);
local l__Utilities__11 = require(l__Dependencies__3.Utilities);
local u1 = Random.new(12098135901304);
local u2 = l__CollectionService__2:GetTagged("SmartBone");
local l__Debug__12 = l__Config__5.Debug;
local u3;
if l__Debug__12 then
    u3 = Instance.new("Model");
    u3.Name = "SMARTBONE_DEBUGFOLDER";
    u3.Parent = workspace;
    local v4 = Instance.new("Highlight");
    v4.FillColor = Color3.fromRGB(255, 0, 0);
    v4.OutlineTransparency = 1;
    v4.FillTransparency = 0;
    v4.Parent = u3;
    v4.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
    v4.Enabled = true;
else
    u3 = nil;
end;
local u5 = {};
local u6 = {};
u6.__index = u6;
function u6.new(p7, p8) --[[ Line: 118 ]]
    -- upvalues: u1 (copy), l__UnitConversion__6 (copy), u6 (copy), l__DefaultSettings__7 (copy)
    local v9 = {
        Time = 0,
        WindPreviousPosition = Vector3.new(0, 0, 0),
        Removed = false,
        InRange = false,
        ID = u1:NextInteger(1, 10000000),
        RootPart = p7,
        ParticleTrees = {},
        Connections = {},
        RootList = p8,
        ObjectScale = l__UnitConversion__6.Convert(math.abs(p7.Size.X), "Millimeter"),
        RemovedEvent = Instance.new("BindableEvent"),
        Settings = {}
    };
    local v10 = setmetatable(v9, u6);
    for v11, v12 in l__DefaultSettings__7 do
        v10.Settings[v11] = p7:GetAttribute(v11) or v12;
    end;
    v10.Settings.BlendWeight = 1;
    v10.Settings.UpdateRate = math.floor(v10.Settings.UpdateRate + 0.1);
    v10:Init();
    v10:UpdateParameters(v10.Settings);
    return v10;
end;
function u6.Init(u13) --[[ Line: 149 ]]
    -- upvalues: u5 (copy), l__Lighting__1 (copy)
    local l__RootPart__13 = u13.RootPart;
    u5[u13.ID] = u13;
    u13.Connections.AttributeChanged = l__RootPart__13.AttributeChanged:ConnectParallel(function(p14) --[[ Line: 156 ]]
        -- upvalues: u13 (copy), l__RootPart__13 (copy)
        if u13.Settings[p14] then
            u13:UpdateParameters(p14, l__RootPart__13:GetAttribute(p14));
        end;
    end);
    u13.Connections.LightingAttributeChanged = l__Lighting__1.AttributeChanged:ConnectParallel(function(p15) --[[ Line: 161 ]]
        -- upvalues: u13 (copy), l__Lighting__1 (ref)
        if u13.Settings[p15] then
            u13:UpdateParameters(p15, l__Lighting__1:GetAttribute(p15));
        end;
    end);
    for _, v16 in l__RootPart__13:GetDescendants() do
        if v16:IsA("Bone") and (v16.Parent:IsA("Bone") and #v16:GetChildren() == 0) then
            local v17 = v16.WorldCFrame + v16.WorldCFrame.UpVector.Unit * (v16.WorldPosition - v16.Parent.WorldPosition).Magnitude;
            local v18 = Instance.new("Bone");
            v18.Parent = v16;
            v18.Name = v16.Name .. "_Tail";
            v18.WorldCFrame = v17;
        end;
    end;
    for _, v19 in u13.RootList do
        u13:AppendParticleTree(v19);
    end;
    for _, v20 in u13.ParticleTrees do
        u13:AppendParticles(v20, v20.Root, 0, 0);
    end;
end;
function u6.AppendParticleTree(p21, p22) --[[ Line: 186 ]]
    -- upvalues: l__ParticleTree__8 (copy)
    table.insert(p21.ParticleTrees, l__ParticleTree__8.new(p22, p21.RootPart, p21.Settings.Gravity));
end;
function u6.AppendParticles(p23, p24, p25, p26, p27) --[[ Line: 190 ]]
    -- upvalues: l__Particle__9 (copy), l__Debug__12 (copy), u3 (ref), l__Utilities__11 (copy)
    local l__Settings__14 = p23.Settings;
    local v28 = l__Particle__9.new(p25, p24.Root, p23.RootPart, l__Settings__14);
    local l__WorldPosition__15 = p25.WorldPosition;
    local l__WorldPosition__16 = p25.WorldPosition;
    v28.Position = l__WorldPosition__15;
    v28.LastPosition = l__WorldPosition__16;
    v28.ParentIndex = p26;
    v28.BoneLength = p27;
    v28.HeirarchyLength = 0;
    if l__Debug__12 == true then
        v28.DebugPart = Instance.new("Part");
        v28.DebugPart.Size = Vector3.new(0.1, 0.1, 0.1);
        v28.DebugPart.Anchored = true;
        v28.DebugPart.CanCollide = false;
        v28.DebugPart.CastShadow = false;
        v28.DebugPart.CanTouch = false;
        v28.DebugPart.CanQuery = false;
        v28.DebugPart.Color = Color3.fromRGB(255, 0, 0);
        v28.DebugPart.Parent = u3;
    end;
    if p26 >= 1 then
        p27 = (p24.Particles[p26].Bone.WorldPosition - v28.Position).Magnitude;
        v28.BoneLength = p27;
        v28.Weight = p27 * 0.7;
        v28.HeirarchyLength = l__Utilities__11.GetHierarchyLength(p25, p24.Root);
    end;
    if v28.HeirarchyLength <= l__Settings__14.AnchorDepth then
        v28.Anchored = true;
    end;
    table.insert(p24.Particles, v28);
    local v29 = #p24.Particles;
    local v30 = p25:GetChildren();
    for v31 = 1, #v30 do
        local v32 = v30[v31];
        if v32:IsA("Bone") then
            p23:AppendParticles(p24, v32, v29, p27);
        end;
    end;
end;
function u6.UpdateParameters(p33, p34, p35) --[[ Line: 235 ]]
    -- upvalues: l__SettingsMath__10 (copy)
    if p33.Settings[p34] then
        local l__Settings__17 = p33.Settings;
        if l__SettingsMath__10[p34] then
            p35 = l__SettingsMath__10[p34](p35);
        end;
        l__Settings__17[p34] = p35;
    end;
end;
function u6.PreUpdate(_, p36) --[[ Line: 240 ]]
    local l__RootPart__18 = p36.RootPart;
    local l__Root__19 = p36.Root;
    p36.ObjectMove = l__RootPart__18.Position - p36.ObjectPreviousPosition;
    p36.ObjectPreviousPosition = l__RootPart__18.Position;
    p36.RestGravity = l__Root__19.CFrame:PointToWorldSpace(p36.LocalGravity);
    for _, v37 in p36.Particles do
        v37.LastTransformOffset = v37.TransformOffset;
        if v37.Bone == v37.Root then
            v37.TransformOffset = l__RootPart__18.CFrame * v37.RootTransform;
        else
            v37.TransformOffset = l__Root__19.WorldCFrame * v37.Transform;
        end;
        v37.LocalTransformOffset = l__Root__19.CFrame * v37.LocalTransform;
    end;
end;
function u6.UpdateParticles(p38, p39, p40, p41) --[[ Line: 261 ]]
    local l__Settings__20 = p38.Settings;
    local l__Damping__21 = l__Settings__20.Damping;
    local l__Gravity__22 = l__Settings__20.Gravity;
    local l__Unit__23 = l__Settings__20.Gravity.Unit;
    local v42 = p39.RestGravity:Dot(l__Unit__23);
    local v43 = (l__Gravity__22 - l__Unit__23 * math.max(v42, 0) + l__Settings__20.Force) * (p38.ObjectScale * p40);
    local v44 = p41 == 0 and (p39.ObjectMove or Vector3.new(0, 0, 0)) or Vector3.new(0, 0, 0);
    for _, v45 in p39.Particles do
        if v45.ParentIndex >= 1 and v45.Anchored == false then
            local v46;
            if l__Settings__20.WindInfluence > 0 then
                local v47 = p39.WindOffset + (os.clock() - v45.HeirarchyLength / 5) + (v45.TransformOffset.Position - p39.Root.WorldPosition).Magnitude / 5 * l__Settings__20.WindInfluence;
                local v48 = l__Settings__20.WindDirection.X + l__Settings__20.WindDirection.X * math.sin(v47 * l__Settings__20.WindSpeed);
                local v49 = l__Settings__20.WindDirection.Y + math.sin(v47 * l__Settings__20.WindSpeed) * 0.05;
                local v50 = l__Settings__20.WindDirection.Z + l__Settings__20.WindDirection.X * math.sin(v47 * l__Settings__20.WindSpeed);
                v46 = Vector3.new(v48, v49, v50) / v45.BoneLength * l__Settings__20.WindInfluence * (l__Settings__20.WindStrength / 100 * (math.clamp(v45.HeirarchyLength, 1, 10) / 10)) * v45.Weight;
                p38.WindPreviousPosition = v46;
            else
                v46 = Vector3.new(0, 0, 0);
            end;
            local v51 = v45.Position - v45.LastPosition;
            local v52 = v44 * l__Settings__20.Inertia;
            v45.LastPosition = v45.Position + v52;
            v45.Position = v45.Position + (v51 * (1 - l__Damping__21) + v43 + v52 + v46);
        else
            v45.LastPosition = v45.TransformOffset.Position;
            v45.Position = v45.TransformOffset.Position;
        end;
    end;
end;
function u6.CorrectParticles(p53, p54, p55) --[[ Line: 326 ]]
    local l__Settings__24 = p53.Settings;
    local l__Stiffness__25 = l__Settings__24.Stiffness;
    for _, v56 in p54.Particles do
        local v57 = p54.Particles[v56.ParentIndex];
        if v57 and (v56.ParentIndex >= 1 and v56.Anchored == false) then
            local l__Magnitude__26 = (v57.TransformOffset.Position - v56.TransformOffset.Position).Magnitude;
            if l__Stiffness__25 > 0 or l__Settings__24.Elasticity > 0 then
                local l__Position__27 = (CFrame.new(v57.Position) * v57.TransformOffset.Rotation * CFrame.new(v56.LocalTransformOffset.Position)).Position;
                v56.Position = v56.Position + (l__Position__27 - v56.Position) * (l__Settings__24.Elasticity * p55);
                if l__Stiffness__25 > 0 then
                    local v58 = l__Position__27 - v56.Position;
                    local l__Magnitude__28 = v58.Magnitude;
                    local v59 = l__Magnitude__26 * (1 - l__Stiffness__25) * 2;
                    if v59 < l__Magnitude__28 then
                        v56.Position = v56.Position + v58 * ((l__Magnitude__28 - v59) / l__Magnitude__28);
                    end;
                end;
            end;
            local v60 = v57.Position - v56.Position;
            local l__Magnitude__29 = v60.Magnitude;
            if l__Magnitude__29 > 0 then
                v56.Position = v56.Position + v60 * ((l__Magnitude__29 - l__Magnitude__26) / l__Magnitude__29);
            end;
        end;
    end;
end;
function u6.SkipUpdateParticles(p61, p62) --[[ Line: 366 ]]
    for _, v63 in p62.Particles do
        if v63.ParentIndex >= 1 and not v63.Anchored then
            v63.LastPosition = v63.LastPosition + p62.ObjectMove;
            v63.Position = v63.Position + p62.ObjectMove;
            local v64 = p62.Particles[v63.ParentIndex];
            local l__Magnitude__30 = (v64.TransformOffset.Position - v63.TransformOffset.Position).Magnitude;
            local l__Stiffness__31 = p61.Settings.Stiffness;
            if l__Stiffness__31 > 0 then
                local v65 = v64.Position + CFrame.lookAt(v64.Position, v63.Position).LookVector.Unit * (v64.Position - v63.Position).Magnitude - v63.Position;
                local l__Magnitude__32 = v65.Magnitude;
                local v66 = l__Magnitude__30 * (1 - l__Stiffness__31) * 2;
                if v66 < l__Magnitude__32 then
                    v63.Position = v63.Position + v65 * ((l__Magnitude__32 - v66) / l__Magnitude__32);
                end;
            end;
            local v67 = v64.Position - v63.Position;
            local l__Magnitude__33 = v67.Magnitude;
            if l__Magnitude__30 < l__Magnitude__33 then
                v63.Position = v63.Position + v67 * ((l__Magnitude__33 - l__Magnitude__30) / l__Magnitude__33);
            end;
        else
            v63.LastPosition = v63.TransformOffset.Position;
            v63.Position = v63.TransformOffset.Position;
        end;
    end;
end;
function u6.CalculateTransforms(p68, p69, p70) --[[ Line: 404 ]]
    -- upvalues: l__Utilities__11 (copy)
    if p68.InRange then
        for _, v71 in p69.Particles do
            if v71.ParentIndex >= 1 and v71.Anchored == false then
                local v72 = p69.Particles[v71.ParentIndex];
                local l__Bone__34 = v72.Bone;
                if v72 and (l__Bone__34 and (l__Bone__34:IsA("Bone") and l__Bone__34 ~= p69.Root)) then
                    local l__Position__35 = v72.LocalTransformOffset.Position;
                    local l__TransformOffset__36 = v72.TransformOffset;
                    local v73 = l__TransformOffset__36:PointToObjectSpace(l__Position__35);
                    local v74 = l__Utilities__11.GetRotationBetween(l__TransformOffset__36.UpVector, v71.Position - v72.Position, v73).Rotation * l__TransformOffset__36.Rotation;
                    local v75 = 1 - 0.00001 ^ p70;
                    v72.CalculatedWorldCFrame = l__Bone__34.WorldCFrame:Lerp(CFrame.new(v72.Position) * v74, v75);
                end;
            end;
        end;
    end;
end;
function u6.TransformBones(p76, p77) --[[ Line: 432 ]]
    if p76.InRange then
        for _, v78 in p77.Particles do
            if v78.ParentIndex >= 1 and v78.Anchored == false then
                local v79 = p77.Particles[v78.ParentIndex];
                local l__Bone__37 = v79.Bone;
                if v79 and (l__Bone__37 and (l__Bone__37:IsA("Bone") and l__Bone__37 ~= p77.Root)) then
                    if v79.Anchored and p76.Settings.AnchorsRotate == false then
                        l__Bone__37.WorldCFrame = v79.TransformOffset;
                    else
                        l__Bone__37.WorldCFrame = v79.CalculatedWorldCFrame;
                    end;
                end;
            end;
        end;
    end;
end;
function u6.DEBUG(_, p80) --[[ Line: 453 ]]
    for _, v81 in p80.Particles do
        if v81 then
            v81.DebugPart.CFrame = CFrame.new(v81.Position);
        end;
    end;
end;
function u6.RunLoop(p82, p83, p84, p85) --[[ Line: 461 ]]
    local v86 = p84 * 10;
    local v87;
    if p85 > 0 then
        local v88 = 1 / p85;
        p82.Time = p82.Time + p84;
        if v88 <= p82.Time then
            p82.Time = 0;
            v87 = true;
        else
            v87 = false;
        end;
    else
        v87 = true;
    end;
    if v87 then
        p82:UpdateParticles(p83, v86, 0);
        p82:CorrectParticles(p83, v86);
    else
        p82:SkipUpdateParticles(p83);
    end;
end;
function u6.ResetParticles(_, p89) --[[ Line: 484 ]]
    for _, v90 in p89.Particles do
        v90.LastPosition = v90.TransformOffset.Position;
        v90.Position = v90.TransformOffset.Position;
    end;
end;
function u6.ResetTransforms(_, p91) --[[ Line: 491 ]]
    for _, v92 in p91.Particles do
        local v93;
        if v92.Bone == v92.Root then
            v93 = p91.RootPart.CFrame * v92.RootTransform;
        else
            v93 = p91.Root.WorldCFrame * v92.Transform;
        end;
        v92.Bone.WorldCFrame = v93;
    end;
end;
function u6.UpdateBones(p94, p95, p96) --[[ Line: 505 ]]
    for _, v97 in p94.ParticleTrees do
        p94:PreUpdate(v97, p95);
        p94:RunLoop(v97, p95, p96);
        p94:CalculateTransforms(v97, p95);
    end;
end;
function u6.Start() --[[ Line: 513 ]]
    -- upvalues: l__Debug__12 (copy), l__Utilities__11 (copy), u5 (copy), l__CollectionService__2 (copy), u2 (copy)
    local l__LocalPlayer__38 = game.Players.LocalPlayer;
    local u98 = Instance.new("Folder");
    u98.Name = "Actors";
    u98.Parent = l__LocalPlayer__38:WaitForChild("PlayerScripts");
    local u99 = {};
    local u100 = {};
    local function u111(p101) --[[ Line: 529 ]]
        -- upvalues: l__Utilities__11 (ref), u98 (copy), u99 (copy), u100 (copy), l__Debug__12 (ref)
        if p101:IsA("BasePart") and (l__Utilities__11.WaitForChildOfClass(p101, "Bone", 3) and game.Workspace:IsAncestorOf(p101)) then
            local v102 = {};
            if p101:GetAttribute("Roots") and (p101:GetAttribute("Roots") ~= nil and typeof(p101:GetAttribute("Roots")) == "string") then
                local v103 = string.split(p101:GetAttribute("Roots"), ",");
                for _, v104 in ipairs(v103) do
                    local v105 = p101:FindFirstChild(v104, true);
                    if v105 and v105:IsA("Bone") then
                        table.insert(v102, v105);
                    end;
                end;
            end;
            if #v102 > 0 then
                local u106 = Instance.new("Actor");
                local v107 = Instance.new("BindableFunction");
                v107.Name = "Event";
                v107.Parent = u106;
                local v108 = script.Dependencies.ActorScript:Clone();
                v108.Name = "Runtime";
                v108.Parent = u106;
                u106.Parent = u98;
                v108.Enabled = true;
                u99[p101] = u106.Event:Invoke(p101, v102);
                u106.Name = p101.Name .. u99[p101].ID;
                u99[p101].RemovedEvent.Event:Once(function() --[[ Line: 570 ]]
                    -- upvalues: u106 (copy)
                    u106.Runtime.Enabled = false;
                    u106:Destroy();
                end);
                table.insert(u100, p101);
                local v109 = "Created new SmartBone Object with ID: " .. u99[p101].ID;
                if l__Debug__12 then
                    warn(v109);
                end;
            else
                table.insert(u100, p101);
                local v110 = "Failed to create SmartBone Object for " .. p101:GetFullName() .. "! Make sure you have defined the Root Bone(s) for this object!";
                if l__Debug__12 then
                    warn(v110);
                end;
            end;
        end;
    end;
    local function v118(u112) --[[ Line: 588 ]]
        -- upvalues: u99 (copy), l__Debug__12 (ref), u5 (ref)
        if u99[u112] then
            local v113 = "Removing SmartBone Object with ID: " .. u99[u112].ID;
            if l__Debug__12 then
                warn(v113);
            end;
            task.spawn(function() --[[ Line: 591 ]]
                -- upvalues: u99 (ref), u112 (copy), u5 (ref)
                for _, v114 in pairs(u99[u112].Connections) do
                    v114:Disconnect();
                end;
                u99[u112].SimulationConnection:Disconnect();
                task.wait();
                u99[u112].RemovedEvent:Destroy();
                for _, v115 in ipairs(u99[u112].ParticleTrees) do
                    for _, v116 in v115.Particles do
                        for _, v117 in v116.RecyclingBin do
                            v117:Destroy();
                        end;
                    end;
                end;
                task.wait();
                if u5[u99[u112].ID] then
                    u5[u99[u112].ID] = nil;
                end;
                u99[u112].Removed = true;
                u99[u112].RemovedEvent:Fire();
                u99[u112] = nil;
            end);
        end;
    end;
    l__CollectionService__2:GetInstanceAddedSignal("SmartBone"):Connect(u111);
    l__CollectionService__2:GetInstanceRemovedSignal("SmartBone"):Connect(v118);
    for _, u119 in pairs(u2) do
        if not (u99[u119] or table.find(u100, u119)) then
            task.spawn(function() --[[ Line: 629 ]]
                -- upvalues: u111 (copy), u119 (copy)
                u111(u119);
            end);
        end;
    end;
end;
return u6;