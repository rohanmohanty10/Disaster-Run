 

 

local Players = game:GetService("Players");
local Parent = script.Parent.Parent;
local AbilityRule = require(Parent:WaitForChild("Game"):WaitForChild("AbilityRule"));
local KnifeAbilities = require(Parent.Weapons.KnifeAbilities);
local KnifeClips = require(Parent.Weapons.KnifeClips);
local StepOver = KnifeAbilities.StepOver;
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
local u2 = StepOver.FakeTime + StepOver.BigTime;
local u3 = KnifeAbilities.stepOverBurstSpeed();
local u4 = {
    Dashing = true,
    Boosting = true,
    Recovering = true
};
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = setmetatable({}, {
    __mode = "k"
});

local function hump(p9, p10, p11) -- Line: 25
    if p9 <= 0 or p11 <= p9 then
        return 0;
    end;

    local v12 = p9 / p11;

    return p10 / p11 * 6 * v12 * (1 - v12);
end;

local function burst(p13) -- Line: 33
    -- upvalues: StepOver (copy), u3 (copy)
    if p13 <= 0 then
        return 0;
    end;

    local math_min_ret = math.min(1, p13 / StepOver.BigTime);

    return u3 * (1 - (1 - math_min_ret) * (1 - math_min_ret));
end;

local function flat(p14) -- Line: 40
    local v15 = p14 * Vector3.new(1, 0, 1);

    if v15.Magnitude > 0.01 then
        return v15.Unit;
    end;

    return nil;
end;

local function load(p16) -- Line: 44
    -- upvalues: u8 (ref), Parent (copy), KnifeClips (copy)
    local v17 = u8[p16];

    if v17 then
        return v17;
    end;

    local Futbol = Parent.Weapons.Models:FindFirstChild("Futbol");
    local v18 = {};

    for _, v in { "StepOverAnim", "LeftDashAnim", "RightDashAnim" } do
        local v19;

        if Futbol then
            v19 = KnifeClips.normalize(Futbol:GetAttribute(v));
        else
            v19 = Futbol;
        end;

        if v19 then
            local Animation = Instance.new("Animation");
            Animation.AnimationId = v19;
            local success, result = pcall(p16.LoadAnimation, p16, Animation);
            Animation:Destroy();

            if success then
                result.Priority = Enum.AnimationPriority.Action2;
                v18[v] = result;
            end;
        end;
    end;

    u8[p16] = v18;

    return v18;
end;

local function play(p20, p21) -- Line: 67
    if p20 then
        p20.Looped = false;
        p20:Play(0.08, 1, 0.7 / p21);
    end;
end;

local function finish(p22) -- Line: 74
    -- upvalues: u5 (ref)
    if u5 == p22 then
        u5 = nil;
    end;

    if p22.velocity then
        p22.velocity:Destroy();
        p22.attachment:Destroy();
        p22.velocity = nil;
        p22.attachment = nil;
    end;
end;

function u1.start(p23, p24) -- Line: 85
    -- upvalues: u5 (ref), load (copy), StepOver (copy), Players (copy)
    local HumanoidRootPart = p23:FindFirstChild("HumanoidRootPart");
    local v25 = p23:FindFirstChildOfClass("Humanoid");

    if v25 then
        v25 = v25:FindFirstChildOfClass("Animator");
    end;

    if not (HumanoidRootPart and v25) then
        return false;
    end;

    if u5 then
        local v26 = u5;

        if u5 == v26 then
            u5 = nil;
        end;

        if v26.velocity then
            v26.velocity:Destroy();
            v26.attachment:Destroy();
            v26.velocity = nil;
            v26.attachment = nil;
        end;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v27, v28, v29;

    if workspace_CurrentCamera then
        local v30 = workspace_CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1);

        if v30.Magnitude > 0.01 then
            v27 = v30.Unit;
        else
            v27 = nil;
        end;

        if not v27 then
            v28 = HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1);

            if v28.Magnitude > 0.01 then
                v29 = v28.Unit;
            else
                v29 = nil;
            end;

            v27 = v29 or Vector3.new(0, 0, 1);
        end;
    else
        v28 = HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1);

        if v28.Magnitude > 0.01 then
            v29 = v28.Unit;
        else
            v29 = nil;
        end;

        v27 = v29 or Vector3.new(0, 0, 1);
    end;

    local v31 = v27:Cross(Vector3.new(0, 1, 0));
    local Attachment = Instance.new("Attachment");
    Attachment.Name = "StepOverAttachment";
    Attachment.Parent = HumanoidRootPart;
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Name = "StepOverVelocity";
    LinearVelocity.Attachment0 = Attachment;
    LinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World;
    LinearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Plane;
    LinearVelocity.PrimaryTangentAxis = Vector3.new(1, 0, 0);
    LinearVelocity.SecondaryTangentAxis = Vector3.new(0, 0, 1);
    LinearVelocity.ForceLimitsEnabled = true;
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.Magnitude;
    LinearVelocity.MaxForce = math.max(1, HumanoidRootPart.AssemblyMass) * 2500;
    LinearVelocity.Parent = HumanoidRootPart;
    local v32 = load(v25);

    if not StepOver.FakeTowardInput then
        p24 = -p24;
    end;

    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.RespectCanCollide = true;
    local v33 = {};

    for _, v in Players:GetPlayers() do
        if v.Character then
            table.insert(v33, v.Character);
        end;
    end;

    local ClientBots = workspace:FindFirstChild("ClientBots");

    if ClientBots then
        table.insert(v33, ClientBots);
    end;

    RaycastParams_new_ret.FilterDescendantsInstances = v33;
    local v34 = {
        character = p23,
        root = HumanoidRootPart,
        attachment = Attachment,
        velocity = LinearVelocity,
        started = os.clock(),
        forward = v27,
        right = v31,
        fake = p24,
        speed = math.max(0, HumanoidRootPart.AssemblyLinearVelocity:Dot(v27)),
        params = RaycastParams_new_ret,
        step = v32.StepOverAnim
    };
    local v35;

    if p24 > 0 then
        v35 = v32.LeftDashAnim;
    else
        v35 = v32.RightDashAnim;
    end;

    v34.dash = v35;
    u5 = v34;
    local step = u5.step;
    local FakeTime = StepOver.FakeTime;

    if step then
        step.Looped = false;
        step:Play(0.08, 1, 0.7 / FakeTime);
    end;

    return true;
end;

function u1.cancel() -- Line: 147
    -- upvalues: u5 (ref)
    local v36 = u5;

    if not v36 then
        return;
    end;

    if u5 == v36 then
        u5 = nil;
    end;

    if v36.velocity then
        v36.velocity:Destroy();
        v36.attachment:Destroy();
        v36.velocity = nil;
        v36.attachment = nil;
    end;

    for _, v in { v36.step, v36.dash } do
        if v and v.IsPlaying then
            v:Stop(0.1);
        end;
    end;
end;

function u1.step(p37) -- Line: 161
    -- upvalues: u5 (ref), LocalPlayer (copy), StepOver (copy), u2 (copy), u3 (copy)
    local v38 = u5;

    if not v38 or v38.character ~= p37 then
        return nil;
    end;

    local v39 = os.clock() - v38.started;

    if not v38.root.Parent or (p37:GetAttribute("Ragdolled") or (p37:GetAttribute("MovementLocked") or LocalPlayer:GetAttribute("RunState") ~= "Active")) then
        if u5 == v38 then
            u5 = nil;
        end;

        if v38.velocity then
            v38.velocity:Destroy();
            v38.attachment:Destroy();
            v38.velocity = nil;
            v38.attachment = nil;
        end;

        return false, v38.speed * StepOver.Forward, v38.forward, 0.25;
    end;

    if u2 <= v39 then
        local v40 = v38.root.AssemblyLinearVelocity * Vector3.new(1, 0, 1);

        if u5 == v38 then
            u5 = nil;
        end;

        if v38.velocity then
            v38.velocity:Destroy();
            v38.attachment:Destroy();
            v38.velocity = nil;
            v38.attachment = nil;
        end;

        if v40.Magnitude < 0.5 then
            return false, v38.speed * StepOver.Forward, v38.forward, 0.25;
        end;

        return false, math.min(v40.Magnitude, 64), v40.Unit, StepOver.CarrySeconds;
    end;

    if not v38.dashed and StepOver.FakeTime <= v39 then
        v38.dashed = true;

        if v38.step then
            v38.step:Stop(0.08);
        end;

        local dash = v38.dash;
        local DashClipTime = StepOver.DashClipTime;

        if dash then
            dash.Looped = false;
            dash:Play(0.08, 1, 0.7 / DashClipTime);
        end;
    end;

    local FakeDistance = StepOver.FakeDistance;
    local FakeTime = StepOver.FakeTime;
    local v41;

    if v39 <= 0 or FakeTime <= v39 then
        v41 = 0;
    else
        local v42 = v39 / FakeTime;
        v41 = FakeDistance / FakeTime * 6 * v42 * (1 - v42);
    end;

    local v43 = v39 - StepOver.FakeTime;
    local v44;

    if v43 <= 0 then
        v44 = 0;
    else
        local math_min_ret = math.min(1, v43 / StepOver.BigTime);
        v44 = u3 * (1 - (1 - math_min_ret) * (1 - math_min_ret));
    end;

    local v45 = v38.forward * (v38.speed * StepOver.Forward) + v38.right * ((v41 - v44) * v38.fake);
    local v46;

    if v45.Magnitude > 0.01 then
        v46 = workspace:Spherecast(v38.root.Position, 1.1, v45 * 0.03333333333333333 + v45.Unit * 1.2, v38.params);
    else
        v46 = false;
    end;

    if v46 and v45:Dot(v46.Normal) < 0 then
        v45 = v45 - v46.Normal * v45:Dot(v46.Normal);
    end;

    v38.velocity.PlaneVelocity = Vector2.new(v45.X, v45.Z);

    return true;
end;

function u1.active(p47) -- Line: 202
    -- upvalues: u5 (ref)
    local v48;

    if u5 == nil then
        v48 = false;
    else
        v48 = u5.character == p47;
    end;

    return v48;
end;

function u1.request() -- Line: 206
    -- upvalues: LocalPlayer (copy), u5 (ref), AbilityRule (copy), KnifeAbilities (copy), u4 (copy), u6 (ref), Parent (copy), u7 (ref), u1 (copy), StepOver (copy)
    local Character = LocalPlayer.Character;
    local v49;

    if Character then
        v49 = Character:FindFirstChildOfClass("Humanoid");
    else
        v49 = Character;
    end;

    local v50;

    if Character then
        v50 = Character:FindFirstChild("HumanoidRootPart");
    else
        v50 = Character;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();

    if u5 or not (v49 and (v50 and (v49.Health > 0 and (v49.FloorMaterial ~= Enum.Material.Air and not (v50.Anchored or (LocalPlayer:GetAttribute("EquippedKnife") ~= "Futbol" or (AbilityRule.knifeBlocked(LocalPlayer) or (ServerTimeNow < (LocalPlayer:GetAttribute(KnifeAbilities.Skins.Futbol.ReadyAt) or 0) or (Character:GetAttribute("TackleActive") or (Character:GetAttribute("GearMotion") or (Character:GetAttribute("Ragdolled") or (Character:GetAttribute("MovementLocked") or (ServerTimeNow < (Character:GetAttribute("RocketUntil") or 0) or u4[Character:GetAttribute("MovementState")]))))))))))))) then
        return false;
    end;

    u6 = u6 or Parent.Weapons:FindFirstChild(KnifeAbilities.Skins.Futbol.Remote);

    if not u6 then
        return false;
    end;

    if not u7 then
        u7 = u6.OnClientEvent:Connect(function(p51) -- Line: 236
            -- upvalues: u1 (ref)
            if p51 == "Rejected" then
                u1.cancel();
            end;
        end);
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v52, v53, v54;

    if workspace_CurrentCamera then
        local v55 = workspace_CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1);

        if v55.Magnitude > 0.01 then
            v52 = v55.Unit;
        else
            v52 = nil;
        end;

        if not v52 then
            v53 = v50.CFrame.LookVector * Vector3.new(1, 0, 1);

            if v53.Magnitude > 0.01 then
                v54 = v53.Unit;
            else
                v54 = nil;
            end;

            v52 = v54 or Vector3.new(0, 0, 1);
        end;
    else
        v53 = v50.CFrame.LookVector * Vector3.new(1, 0, 1);

        if v53.Magnitude > 0.01 then
            v54 = v53.Unit;
        else
            v54 = nil;
        end;

        v52 = v54 or Vector3.new(0, 0, 1);
    end;

    local v56 = v49.MoveDirection:Dot(v52:Cross(Vector3.new(0, 1, 0)));
    local v57 = v56 > 0.3 and 1 or (v56 < -0.3 and -1 or (StepOver.FakeTowardInput and -1 or 1));

    if not u1.start(Character, v57) then
        return false;
    end;

    u6:FireServer("Activate", v57);

    return true;
end;

LocalPlayer.CharacterRemoving:Connect(function() -- Line: 253
    -- upvalues: u1 (copy), u8 (ref)
    u1.cancel();
    u8 = setmetatable({}, {
        __mode = "k"
    });
end);

return u1;