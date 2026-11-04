 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local ContextActionService = game:GetService("ContextActionService");
local GuiService = game:GetService("GuiService");
local Debris = game:GetService("Debris");
local RunService = game:GetService("RunService");
local trove = require(ReplicatedStorage.forum.trove);
local replication = require(ReplicatedStorage.client.replication);
local wiki = require(ReplicatedStorage.wiki);
local v1 = {};
local LocalPlayer = Players.LocalPlayer;
local u2 = setmetatable({}, {
    __mode = "k"
});
local u3 = {
    kick = "KickWindup",
    oldkick = "KickWindup",
    kick2 = "Kick",
    kickwind = "KickWindup",
    kickwindup = "KickWindup"
};

local function refreshMoveset(p4, p5) -- Line: 25
    -- upvalues: LocalPlayer (copy), wiki (copy), replication (copy)
    local character = p5.character;

    if LocalPlayer.Character ~= character then
        return;
    end;

    local v6 = character:GetAttribute("Gubby") == true;

    if not (v6 or p5.wasGubby) then
        return;
    end;

    p5.wasGubby = v6;
    local v7 = wiki.styles[p4.style];
    replication.editMoveset(nil, v6 and "Gun" or (v7 and v7.TSpecial or "[kill slot]"));
end;

local function getAimPosition(p8) -- Line: 38
    -- upvalues: UserInputService (copy), LocalPlayer (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        local v9;

        if UserInputService.GamepadEnabled and not UserInputService.MouseEnabled then
            v9 = workspace_CurrentCamera:ViewportPointToRay(workspace_CurrentCamera.ViewportSize.X / 2, workspace_CurrentCamera.ViewportSize.Y / 2);
        else
            v9 = LocalPlayer:GetMouse().UnitRay;
        end;

        local v10 = { p8 };
        local Effects = workspace:FindFirstChild("Effects");

        if Effects then
            table.insert(v10, Effects);
        end;

        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
        RaycastParams_new_ret.FilterDescendantsInstances = v10;
        RaycastParams_new_ret.IgnoreWater = true;
        local v11 = workspace:Raycast(v9.Origin, v9.Direction * 600, RaycastParams_new_ret);

        return v11 and v11.Position or v9.Origin + v9.Direction * 600;
    end;
end;

local function updateAim(p12) -- Line: 56
    -- upvalues: LocalPlayer (copy), UserInputService (copy), GuiService (copy), getAimPosition (copy)
    local character = p12.character;
    local HumanoidRootPart = character:FindFirstChild("HumanoidRootPart");
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if LocalPlayer.Character ~= character or (LocalPlayer:GetAttribute("BeingControlledBy") or not (HumanoidRootPart and (HumanoidRootPart.Parent and not (HumanoidRootPart.Anchored or (not workspace_CurrentCamera or workspace_CurrentCamera.CameraType == Enum.CameraType.Scriptable))))) then
        return;
    end;

    if not character:GetAttribute("GubbyGunEquipped") or (UserInputService:GetFocusedTextBox() or GuiService.MenuIsOpen) then
        return;
    end;

    local v13 = getAimPosition(character);

    if not v13 then
        return;
    end;

    local Position = HumanoidRootPart.Position;
    local Vector3_new_ret = Vector3.new(v13.X, Position.Y, v13.Z);

    if (Vector3_new_ret - Position).Magnitude < 0.01 then
        return;
    end;

    p12.humanoid.AutoRotate = false;
    HumanoidRootPart.CFrame = CFrame.lookAt(Position, Vector3_new_ret);
end;

local function shoot(p14, p15) -- Line: 74
    -- upvalues: UserInputService (copy), GuiService (copy), LocalPlayer (copy), getAimPosition (copy)
    local character = p15.character;

    if UserInputService:GetFocusedTextBox() or (GuiService.MenuIsOpen or os.clock() - p15.lastShot < 0.4) then
        return;
    end;

    if LocalPlayer:GetAttribute("BeingControlledBy") or (p14.character ~= character or not character:GetAttribute("GubbyGunEquipped")) then
        return;
    end;

    local v16 = getAimPosition(character);

    if not v16 then
        return;
    end;

    p15.lastShot = os.clock();
    p14:senduse({ "gubbyShoot", v16 });
end;

local function loadTrack(p17, p18, p19, p20, p21) -- Line: 86
    local u22 = p17.animator:LoadAnimation(script.Animations[p19]);
    u22.Name = p19;
    u22.Priority = p20;

    if p21 then
        u22.Looped = true;
    end;

    p18:Add(function() -- Line: 93
        -- upvalues: u22 (copy)
        u22:Stop(0);
        u22:Destroy();
    end);

    return u22;
end;

local function stopAction(p23) -- Line: 100
    local action = p23.action;

    if not action then
        return;
    end;

    p23.action = nil;
    action.container:Destroy();
end;

local function syncAction(p24, p25, p26) -- Line: 108
    if p24.action ~= p25 then
        return;
    end;

    local source = p25.source;

    if not source.IsPlaying then
        local action = p24.action;

        if not action then
            return;
        end;

        p24.action = nil;
        action.container:Destroy();

        return;
    end;

    if p25.animationName == "oldkick" then
        if source.Speed == 0 then
            p25.wasPaused = true;
        elseif p25.wasPaused and p25.name == "KickWindup" then
            p25.track:Stop(0);
            p25.name = "Kick";
            local container = p25.container;
            local Priority = source.Priority;
            local u27 = p24.animator:LoadAnimation(script.Animations.Kick);
            u27.Name = "Kick";
            u27.Priority = Priority;
            container:Add(function() -- Line: 93
                -- upvalues: u27 (copy)
                u27:Stop(0);
                u27:Destroy();
            end);
            p25.track = u27;
            p25.track:Play(0, 1, 2.5);
        end;
    end;

    local track = p25.track;
    track.Priority = source.Priority;

    if p25.name == "KickWindup" then
        if track.Length > 0 then
            local math_max_ret = math.max(0, track.Length - 0.001);

            if math_max_ret <= track.TimePosition + (p26 or 0) * 2.5 then
                track.TimePosition = math_max_ret;
                track:AdjustSpeed(0);
            end;
        end;

        return;
    end;

    if p25.name == "Kick" then
        return;
    end;

    local Speed = source.Speed;

    if source.Length > 0 and track.Length > 0 then
        local v28 = track.Length / source.Length;
        Speed = Speed * v28;

        if source.Speed == 0 or p25.syncTime then
            local v29 = source.TimePosition * v28;
            local math_max_ret = math.max(0, track.Length - 0.001);
            track.TimePosition = math.clamp(v29, 0, math_max_ret);
            p25.syncTime = false;
        end;
    end;

    track:AdjustSpeed(Speed);
end;

local function playAction(u30, p31) -- Line: 158
    -- upvalues: ReplicatedStorage (copy), u3 (copy), trove (copy), RunService (copy), syncAction (copy)
    local character = u30.character;
    local Animation = p31.Animation;

    if not (character:GetAttribute("Gubby") and (not character:GetAttribute("GubbyGunEquipped") and (Animation and p31.IsPlaying))) then
        return;
    end;

    if u30.action and u30.action.source == p31 then
        return;
    end;

    local Volley = ReplicatedStorage.Resources:FindFirstChild("Volley");
    local v32 = Volley and Animation:IsDescendantOf(Volley) and "Volley" or u3[Animation.Name];

    if not v32 then
        return;
    end;

    local action = u30.action;

    if action then
        u30.action = nil;
        action.container:Destroy();
    end;

    local v33 = trove.new();
    local u34 = {
        syncTime = true,
        source = p31,
        animationName = Animation.Name,
        name = v32,
        container = v33
    };
    local Priority = p31.Priority;
    local u35 = u30.animator:LoadAnimation(script.Animations[v32]);
    u35.Name = v32;
    u35.Priority = Priority;
    v33:Add(function() -- Line: 93
        -- upvalues: u35 (copy)
        u35:Stop(0);
        u35:Destroy();
    end);
    u34.track = u35;
    u30.action = u34;
    u34.track:Play(0, 1, (v32 == "KickWindup" or v32 == "Kick") and 2.5 or p31.Speed);
    v33:Connect(RunService.PreAnimation, function(p36) -- Line: 180
        -- upvalues: syncAction (ref), u30 (copy), u34 (copy)
        syncAction(u30, u34, p36);
    end);
    v33:Connect(p31.Stopped, function() -- Line: 183
        -- upvalues: u30 (copy), u34 (copy)
        if u30.action == u34 then
            local v37 = u30;
            local action2 = v37.action;

            if not action2 then
                return;
            end;

            v37.action = nil;
            action2.container:Destroy();
        end;
    end);
    syncAction(u30, u34);
end;

local function updateRun(p38, p39) -- Line: 191
    local runTrack = p38.runTrack;

    if not runTrack then
        return;
    end;

    if p39 <= 1 or (p38.airborne or p38.character:GetAttribute("GubbyGunEquipped")) then
        if runTrack.IsPlaying then
            runTrack:Stop(0.1);
        end;

        return;
    end;

    if not runTrack.IsPlaying then
        runTrack:Play(0.1);
    end;

    runTrack:AdjustSpeed(p39 / 16);
end;

local function updateJump(p40, p41) -- Line: 205
    -- upvalues: updateRun (copy)
    local jumpTrack = p40.jumpTrack;

    if not jumpTrack then
        return;
    end;

    p40.airborne = p41 == Enum.HumanoidStateType.Jumping and true or p41 == Enum.HumanoidStateType.Freefall;

    if p41 == Enum.HumanoidStateType.Jumping then
        jumpTrack:Play(0.05);
    elseif not p40.airborne and jumpTrack.IsPlaying then
        jumpTrack:Stop(0.1);
    end;

    updateRun(p40, p40.humanoid.MoveDirection.Magnitude * p40.humanoid.WalkSpeed);
end;

local function startGunIdle(p42, p43, p44) -- Line: 218
    if script.Animations.GunIdle.AnimationId == script.Animations.GunEquip.AnimationId then
        if p44.IsPlaying and p44.Length > 0 then
            p44.TimePosition = math.max(0, p44.Length - 0.05);
            p44:AdjustSpeed(0);
        end;
    else
        local Action3 = Enum.AnimationPriority.Action3;
        local u45 = p42.animator:LoadAnimation(script.Animations.GunIdle);
        u45.Name = "GunIdle";
        u45.Priority = Action3;
        u45.Looped = true;
        p43:Add(function() -- Line: 93
            -- upvalues: u45 (copy)
            u45:Stop(0);
            u45:Destroy();
        end);
        u45:Play(0.1);
    end;
end;

local function refreshGun(u46, u47) -- Line: 230
    -- upvalues: updateRun (copy), trove (copy), RunService (copy), updateAim (copy), startGunIdle (copy), ContextActionService (copy), shoot (copy)
    local character = u47.character;

    if u47.equippedContainer then
        u47.equippedContainer:Destroy();
        u47.equippedContainer = nil;
        u47.shotTrack = nil;
    end;

    if not (character:GetAttribute("Gubby") and (character:GetAttribute("GubbyGunEquipped") and u47.animationContainer)) then
        if u47.humanoid then
            updateRun(u47, u47.humanoid.MoveDirection.Magnitude * u47.humanoid.WalkSpeed);
        end;

        return;
    end;

    local action = u47.action;

    if action then
        u47.action = nil;
        action.container:Destroy();
    end;

    local v48 = trove.new();
    u47.equippedContainer = v48;
    local runTrack = u47.runTrack;

    if runTrack and runTrack.IsPlaying then
        runTrack:Stop(0.1);
    end;

    local AutoRotate = u47.humanoid.AutoRotate;
    local Attribute = character:GetAttribute("lockrotation");
    u47.humanoid.AutoRotate = false;
    character:SetAttribute("lockrotation", true);
    v48:Add(function() -- Line: 253
        -- upvalues: u47 (copy), AutoRotate (copy), character (copy), Attribute (copy)
        if u47.humanoid.Parent then
            u47.humanoid.AutoRotate = AutoRotate;
        end;

        if character:GetAttribute("lockrotation") == true then
            character:SetAttribute("lockrotation", Attribute);
        end;
    end);
    v48:Connect(RunService.PreRender, function() -- Line: 261
        -- upvalues: updateAim (ref), u47 (copy)
        updateAim(u47);
    end);
    updateAim(u47);
    local Action3 = Enum.AnimationPriority.Action3;
    local u49 = u47.animator:LoadAnimation(script.Animations.GunEquip);
    u49.Name = "GunEquip";
    u49.Priority = Action3;
    v48:Add(function() -- Line: 93
        -- upvalues: u49 (copy)
        u49:Stop(0);
        u49:Destroy();
    end);
    u49:Play(0.1);
    v48:Add(task.delay(0.533333, startGunIdle, u47, v48, u49));
    local Action4 = Enum.AnimationPriority.Action4;
    local u50 = u47.animator:LoadAnimation(script.Animations.GunShot);
    u50.Name = "GunShot";
    u50.Priority = Action4;
    v48:Add(function() -- Line: 93
        -- upvalues: u50 (copy)
        u50:Stop(0);
        u50:Destroy();
    end);
    u47.shotTrack = u50;
    ContextActionService:BindActionAtPriority("GubbyGunShoot", function(p51, p52) -- Line: 271
        -- upvalues: shoot (ref), u46 (copy), u47 (copy)
        if p52 == Enum.UserInputState.Begin then
            shoot(u46, u47);
        end;

        return Enum.ContextActionResult.Sink;
    end, true, 3000, Enum.UserInputType.MouseButton1, Enum.KeyCode.ButtonR2);
    ContextActionService:SetTitle("GubbyGunShoot", "Shoot");
    ContextActionService:SetPosition("GubbyGunShoot", UDim2.fromScale(0.8, 0.55));
    v48:Add(function() -- Line: 279
        -- upvalues: ContextActionService (ref)
        ContextActionService:UnbindAction("GubbyGunShoot");
    end);
end;

local function refreshAnimations(p53, u54) -- Line: 284
    -- upvalues: trove (copy), playAction (copy), updateJump (copy), updateRun (copy), refreshGun (copy)
    local character = u54.character;
    local GubbyRig = character:FindFirstChild("GubbyRig");
    local v55 = character:FindFirstChildOfClass("Humanoid");
    local v56;

    if GubbyRig then
        v56 = GubbyRig:FindFirstChildOfClass("AnimationController");
    else
        v56 = GubbyRig;
    end;

    if v56 then
        v56 = v56:FindFirstChildOfClass("Animator");
    end;

    if character:GetAttribute("Gubby") and (GubbyRig and (v56 and (u54.animationContainer and (u54.rig == GubbyRig and u54.animator == v56)))) then
        return;
    end;

    if u54.equippedContainer then
        u54.equippedContainer:Destroy();
        u54.equippedContainer = nil;
        u54.shotTrack = nil;
    end;

    local action = u54.action;

    if action then
        u54.action = nil;
        action.container:Destroy();
    end;

    if u54.animationContainer then
        u54.animationContainer:Destroy();
        u54.animationContainer = nil;
        u54.runTrack = nil;
        u54.jumpTrack = nil;
        u54.airborne = nil;
    end;

    if not (character:GetAttribute("Gubby") and (GubbyRig and (v55 and v56))) then
        return;
    end;

    local v57 = trove.new();
    u54.animationContainer = v57;
    u54.rig = GubbyRig;
    u54.humanoid = v55;
    u54.animator = v56;
    local v58 = v55:FindFirstChildOfClass("Animator");

    if v58 then
        v57:Connect(v58.AnimationPlayed, function(p59) -- Line: 314
            -- upvalues: playAction (ref), u54 (copy)
            playAction(u54, p59);
        end);

        for _, v in v58:GetPlayingAnimationTracks() do
            playAction(u54, v);
        end;
    end;

    local Movement = Enum.AnimationPriority.Movement;
    local u60 = u54.animator:LoadAnimation(script.Animations.Run);
    u60.Name = "Run";
    u60.Priority = Movement;
    u60.Looped = true;
    v57:Add(function() -- Line: 93
        -- upvalues: u60 (copy)
        u60:Stop(0);
        u60:Destroy();
    end);
    u54.runTrack = u60;
    local Action2 = Enum.AnimationPriority.Action2;
    local u61 = u54.animator:LoadAnimation(script.Animations.Jump);
    u61.Name = "Jump";
    u61.Priority = Action2;
    v57:Add(function() -- Line: 93
        -- upvalues: u61 (copy)
        u61:Stop(0);
        u61:Destroy();
    end);
    u54.jumpTrack = u61;
    v57:Connect(v55.StateChanged, function(p62, p63) -- Line: 323
        -- upvalues: updateJump (ref), u54 (copy)
        updateJump(u54, p63);
    end);
    updateJump(u54, v55:GetState());
    v57:Connect(v55.Running, function(p64) -- Line: 327
        -- upvalues: updateRun (ref), u54 (copy)
        updateRun(u54, p64);
    end);
    updateRun(u54, v55.MoveDirection.Magnitude * v55.WalkSpeed);
    refreshGun(p53, u54);
end;

local function movesetReady(p65, p66, p67) -- Line: 334
    -- upvalues: u2 (copy), refreshMoveset (copy)
    if u2[p66.character] ~= p66 then
        return;
    end;

    if p67:GetAttribute("MovesetReady") ~= false then
        refreshMoveset(p65, p66);
    end;
end;

local function bindHotbar(u68, u69, u70) -- Line: 342
    -- upvalues: u2 (copy), refreshMoveset (copy), movesetReady (copy)
    if u70.Name ~= "Hotbar" then
        return;
    end;

    u69.container:Connect(u70:GetAttributeChangedSignal("MovesetReady"), function() -- Line: 345
        -- upvalues: u68 (copy), u69 (copy), u70 (copy), u2 (ref), refreshMoveset (ref)
        local v71 = u68;
        local v72 = u69;

        if u2[v72.character] ~= v72 then
            return;
        end;

        if u70:GetAttribute("MovesetReady") ~= false then
            refreshMoveset(v71, v72);
        end;
    end);
    task.defer(movesetReady, u68, u69, u70);
end;

function v1.unbind(p73) -- Line: 351
    -- upvalues: u2 (copy), refreshMoveset (copy)
    local v74 = u2[p73];

    if not v74 then
        return;
    end;

    refreshMoveset(v74.self, v74);
    v74.parentContainer:Remove(v74.container);
end;

function v1.bind(u75, u76, p77) -- Line: 359
    -- upvalues: u2 (copy), refreshGun (copy), refreshAnimations (copy), LocalPlayer (copy), bindHotbar (copy), refreshMoveset (copy)
    if not u76:GetAttribute("Gubby") or u2[u76] then
        return;
    end;

    local v78 = p77:Extend();
    local u79 = {
        lastShot = (-1 / 0),
        wasGubby = false,
        self = u75,
        character = u76,
        container = v78,
        parentContainer = p77
    };
    u2[u76] = u79;
    v78:Connect(u76:GetAttributeChangedSignal("GubbyGunEquipped"), function() -- Line: 374
        -- upvalues: refreshGun (ref), u75 (copy), u79 (copy)
        refreshGun(u75, u79);
    end);
    v78:Connect(u76.DescendantAdded, function(p80) -- Line: 377
        -- upvalues: refreshAnimations (ref), u75 (copy), u79 (copy)
        if p80.Name == "GubbyRig" or p80:IsA("Animator") then
            refreshAnimations(u75, u79);
        end;
    end);
    v78:Connect(LocalPlayer.PlayerGui.ChildAdded, function(p81) -- Line: 382
        -- upvalues: bindHotbar (ref), u75 (copy), u79 (copy)
        bindHotbar(u75, u79, p81);
    end);
    v78:Add(function() -- Line: 385
        -- upvalues: u2 (ref), u76 (copy), u79 (copy)
        u2[u76] = nil;
        local v82 = u79;
        local action = v82.action;

        if action then
            v82.action = nil;
            action.container:Destroy();
        end;

        if u79.equippedContainer then
            u79.equippedContainer:Destroy();
        end;

        if u79.animationContainer then
            u79.animationContainer:Destroy();
        end;
    end);

    for _, child in LocalPlayer.PlayerGui:GetChildren() do
        bindHotbar(u75, u79, child);
    end;

    refreshAnimations(u75, u79);
    refreshMoveset(u75, u79);
end;

function v1.shot(p83, p84, p85) -- Line: 402
    -- upvalues: LocalPlayer (copy), u2 (copy), replication (copy), Debris (copy)
    if typeof(p84) ~= "Vector3" or typeof(p85) ~= "Vector3" then
        return;
    end;

    if p83 == LocalPlayer.Character then
        local v86 = u2[p83];

        if v86 and v86.shotTrack then
            v86.shotTrack:Play(0.03);
        end;

        replication.cameraShake(5, 0.15, 0.4);
    end;

    if p83 then
        p83 = p83:FindFirstChild("GubbyRig");
    end;

    if p83 then
        p83 = p83:FindFirstChild("GUN");
    end;

    if p83 then
        p83 = p83:FindFirstChild("shotvfx");
    end;

    if p83 then
        for _, descendant in p83:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
            end;
        end;
    end;

    if p83 then
        p84 = p83.WorldPosition or p84;
    end;

    local Magnitude = (p85 - p84).Magnitude;

    if Magnitude < 0.01 then
        return;
    end;

    local Part = Instance.new("Part");
    Part.Name = "GubbyBullet";
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.Material = Enum.Material.Neon;
    Part.Color = Color3.fromRGB(255, 223, 128);
    Part.Size = Vector3.new(0.08, 0.08, Magnitude);
    Part.CFrame = CFrame.lookAt(p84, p85) * CFrame.new(0, 0, -Magnitude / 2);
    Part.Parent = workspace:FindFirstChild("Effects") or workspace;
    Debris:AddItem(Part, 0.08);
end;

return v1;