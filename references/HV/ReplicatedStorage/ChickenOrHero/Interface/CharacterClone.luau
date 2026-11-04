 

 

local v1 = {
    RETRY_SECONDS = 3,
    RETRIES = 5
};
local Color3_new_ret = Color3.new(0, 0, 0);
local u2 = { "LuaSourceContainer", "Sound", "ForceField", "BillboardGui", "SurfaceGui", "ProximityPrompt", "ClickDetector", "ParticleEmitter", "Trail", "Beam", "Light", "Fire", "Smoke", "Sparkles", "Highlight", "BodyMover", "Constraint" };

local function onBone(p3) -- Line: 30
    local v4 = p3:IsA("RigidConstraint");

    if v4 then
        v4 = p3.Attachment0 ~= nil and p3.Attachment0:IsA("Bone");

        if not v4 then
            if p3.Attachment1 == nil then
                v4 = false;
            else
                v4 = p3.Attachment1:IsA("Bone");
            end;
        end;
    end;

    return v4;
end;

local function strip(p5) -- Line: 35
    -- upvalues: u2 (copy)
    for _, descendant in p5:GetDescendants() do
        local v6 = descendant:IsA("RigidConstraint");

        if v6 then
            v6 = descendant.Attachment0 ~= nil and descendant.Attachment0:IsA("Bone");

            if not v6 then
                if descendant.Attachment1 == nil then
                    v6 = false;
                else
                    v6 = descendant.Attachment1:IsA("Bone");
                end;
            end;
        end;

        if not v6 then
            local v7 = descendant;

            for _, v in u2 do
                if v7:IsA(v) then
                    v7:Destroy();
                    break;
                end;
            end;
        end;
    end;
end;

function v1.dressed(p8) -- Line: 53
    -- upvalues: Color3_new_ret (copy)
    if not p8 then
        return false;
    end;

    for _, child in p8:GetChildren() do
        if child:IsA("Clothing") or (child:IsA("ShirtGraphic") or (child:IsA("Accessory") or child:IsA("CharacterMesh"))) then
            return true;
        end;
    end;

    for _, v in { "Head", "Torso", "UpperTorso" } do
        local v9 = p8:FindFirstChild(v);

        if v9 and (v9:IsA("BasePart") and v9.Color ~= Color3_new_ret) then
            return true;
        end;
    end;

    return false;
end;

function v1.copy(p10) -- Line: 72
    -- upvalues: strip (copy)
    if not (p10 and p10:FindFirstChildOfClass("Humanoid")) then
        return nil;
    end;

    local Archivable = p10.Archivable;
    p10.Archivable = true;
    local success, result = pcall(p10.Clone, p10);
    p10.Archivable = Archivable;

    if not (success and result) then
        return nil;
    end;

    strip(result);
    local v11 = result:FindFirstChildOfClass("Humanoid");
    local HumanoidRootPart = result:FindFirstChild("HumanoidRootPart");

    if not (v11 and HumanoidRootPart) then
        result:Destroy();

        return nil;
    end;

    v11.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    v11.EvaluateStateMachine = false;

    if not v11:FindFirstChildOfClass("Animator") then
        Instance.new("Animator").Parent = v11;
    end;

    for _, descendant in result:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = descendant == HumanoidRootPart;
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;
            descendant.CastShadow = false;
        elseif descendant:IsA("Motor6D") then
            descendant.Enabled = true;
            descendant.Transform = CFrame.identity;
        end;
    end;

    result:SetAttribute("Ragdolled", nil);
    result.PrimaryPart = HumanoidRootPart;

    return result, v11, HumanoidRootPart;
end;

function v1.knifeIdle(p12, p13, p14) -- Line: 117
    local EquippedDagger = p12:FindFirstChild("EquippedDagger");

    if not (EquippedDagger and p13) then
        return nil;
    end;

    local Parent = script.Parent.Parent;
    local KnifeChains = require(Parent.Weapons.KnifeChains);

    if not KnifeChains.has(EquippedDagger) then
        return nil;
    end;

    local KnifeClips = require(Parent.Weapons.KnifeClips);
    local v15;

    if type(p14) == "string" then
        v15 = require(Parent.Weapons.SkinCatalog).get(p14);
    else
        v15 = false;
    end;

    if v15 then
        v15 = Parent.Weapons.Models:FindFirstChild(v15.Model);
    end;

    local v16 = {
        chains = KnifeChains.attach(EquippedDagger, p12),
        skin = p14
    };
    local u17 = KnifeChains.followers(EquippedDagger, p12);

    if u17 then
        v16.follow = game:GetService("RunService").PreSimulation:Connect(function() -- Line: 134
            -- upvalues: KnifeChains (copy), u17 (copy)
            KnifeChains.place(u17);
        end);
    end;

    local v18 = v15 and KnifeClips.stow(v15) or KnifeClips.stow(EquippedDagger);

    if v18 then
        local Animation = Instance.new("Animation");
        Animation.AnimationId = v18;
        local success, result = pcall(p13.LoadAnimation, p13, Animation);
        Animation:Destroy();

        if success and result then
            result.Priority = KnifeClips.Stow.priority;
            result.Looped = true;
            result:Play(0);
            v16.track = result;
        end;
    end;

    return v16;
end;

function v1.holdChains(p19, p20) -- Line: 156
    if not (p19 and p19.chains) then
        return;
    end;

    local EmoteCatalog = require(script.Parent.Parent.Emotes.EmoteCatalog);

    if p20 then
        p20 = EmoteCatalog.get(p20);
    end;

    local v21;

    if p20 == nil or p20.Prop == nil then
        v21 = false;
    else
        v21 = EmoteCatalog.playsWith(p20.Id, p19.skin);
    end;

    local v22;

    if v21 then
        v22 = EmoteCatalog.holdsIdle(p20.Id, p19.skin);
    else
        v22 = v21;
    end;

    if require(script.Parent.Parent.Weapons.KnifeChains).hold(p19.chains, v21, not v22 and "Right Arm" or nil) and p19.track then
        p19.track:Stop(0);
        p19.track:Play(0);
    end;
end;

function v1.dropIdle(p23) -- Line: 171
    if p23 and p23.follow then
        p23.follow:Disconnect();
        p23.follow = nil;
    end;

    if p23 and p23.track then
        p23.track:Stop(0);
        p23.track:Destroy();
        p23.track = nil;
    end;
end;

return v1;