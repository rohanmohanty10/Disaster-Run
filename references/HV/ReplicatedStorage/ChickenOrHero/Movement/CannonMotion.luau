 

 

local Players = game:GetService("Players");
local Parent = script.Parent.Parent;
local AbilityRule = require(Parent:WaitForChild("Game"):WaitForChild("AbilityRule"));
local KnifeAbilities = require(Parent.Weapons.KnifeAbilities);
local Cannon = KnifeAbilities.Cannon;
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
local u2 = Cannon.Distance / Cannon.Flight;
local u3 = {
    Dashing = true,
    Boosting = true,
    Recovering = true
};
local u4 = nil;
local u5 = nil;
local u6 = nil;

local function flat(p7) -- Line: 21
    local v8 = p7 * Vector3.new(1, 0, 1);

    if v8.Magnitude > 0.01 then
        return v8.Unit;
    end;

    return nil;
end;

local function finish(p9) -- Line: 25
    -- upvalues: u4 (ref)
    if u4 == p9 then
        u4 = nil;
    end;

    if p9.velocity then
        p9.velocity:Destroy();
        p9.attachment:Destroy();
        p9.velocity = nil;
        p9.attachment = nil;
    end;
end;

function u1.start(p10, p11) -- Line: 36
    -- upvalues: u4 (ref), u2 (copy), KnifeAbilities (copy), Players (copy)
    local HumanoidRootPart = p10:FindFirstChild("HumanoidRootPart");
    local v12 = p10:FindFirstChildOfClass("Humanoid");

    if not (HumanoidRootPart and v12) then
        return false;
    end;

    if u4 then
        local v13 = u4;

        if u4 == v13 then
            u4 = nil;
        end;

        if v13.velocity then
            v13.velocity:Destroy();
            v13.attachment:Destroy();
            v13.velocity = nil;
            v13.attachment = nil;
        end;
    end;

    local Attachment = Instance.new("Attachment");
    Attachment.Name = "CannonAttachment";
    Attachment.Parent = HumanoidRootPart;
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Name = "CannonVelocity";
    LinearVelocity.Attachment0 = Attachment;
    LinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World;
    LinearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Plane;
    LinearVelocity.PrimaryTangentAxis = Vector3.new(1, 0, 0);
    LinearVelocity.SecondaryTangentAxis = Vector3.new(0, 0, 1);
    LinearVelocity.ForceLimitsEnabled = true;
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.Magnitude;
    LinearVelocity.MaxForce = math.max(1, HumanoidRootPart.AssemblyMass) * 4000;
    local AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity;
    local v14 = u2 + KnifeAbilities.cannonMomentum(AssemblyLinearVelocity, p11);
    LinearVelocity.PlaneVelocity = Vector2.new(p11.X, p11.Z) * v14;
    LinearVelocity.Parent = HumanoidRootPart;
    local X = AssemblyLinearVelocity.X;
    local v15 = KnifeAbilities.cannonLaunch();
    HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(X, v15, AssemblyLinearVelocity.Z);
    v12:ChangeState(Enum.HumanoidStateType.Freefall);
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.RespectCanCollide = true;
    local v16 = {};

    for _, v in Players:GetPlayers() do
        if v.Character then
            table.insert(v16, v.Character);
        end;
    end;

    local ClientBots = workspace:FindFirstChild("ClientBots");

    if ClientBots then
        table.insert(v16, ClientBots);
    end;

    RaycastParams_new_ret.FilterDescendantsInstances = v16;
    u4 = {
        character = p10,
        root = HumanoidRootPart,
        humanoid = v12,
        attachment = Attachment,
        velocity = LinearVelocity,
        started = os.clock(),
        forward = p11,
        speed = v14,
        params = RaycastParams_new_ret
    };

    return true;
end;

function u1.cancel() -- Line: 92
    -- upvalues: u4 (ref)
    if u4 then
        local v17 = u4;

        if u4 == v17 then
            u4 = nil;
        end;

        if v17.velocity then
            v17.velocity:Destroy();
            v17.attachment:Destroy();
            v17.velocity = nil;
            v17.attachment = nil;
        end;
    end;
end;

function u1.step(p18) -- Line: 99
    -- upvalues: u4 (ref), LocalPlayer (copy), Cannon (copy)
    local v19 = u4;

    if not v19 or v19.character ~= p18 then
        return nil;
    end;

    local v20 = os.clock() - v19.started;

    if not v19.root.Parent or (p18:GetAttribute("Ragdolled") or (p18:GetAttribute("MovementLocked") or LocalPlayer:GetAttribute("RunState") ~= "Active")) then
        if u4 == v19 then
            u4 = nil;
        end;

        if v19.velocity then
            v19.velocity:Destroy();
            v19.attachment:Destroy();
            v19.velocity = nil;
            v19.attachment = nil;
        end;

        return false, v19.speed * 0.5, v19.forward, 0.25;
    end;

    if Cannon.Flight <= v20 or Cannon.Flight * 0.55 < v20 and v19.humanoid.FloorMaterial ~= Enum.Material.Air then
        if u4 == v19 then
            u4 = nil;
        end;

        if v19.velocity then
            v19.velocity:Destroy();
            v19.attachment:Destroy();
            v19.velocity = nil;
            v19.attachment = nil;
        end;

        return false, v19.speed, v19.forward, Cannon.CarrySeconds;
    end;

    local v21 = v19.forward * v19.speed;
    local v22 = workspace:Spherecast(v19.root.Position, 1.1, v21 * 0.03333333333333333 + v21.Unit * 1.2, v19.params);

    if v22 and v21:Dot(v22.Normal) < 0 then
        v21 = (v21 - v22.Normal * v21:Dot(v22.Normal)) * Vector3.new(1, 0, 1);
    end;

    v19.velocity.PlaneVelocity = Vector2.new(v21.X, v21.Z);

    return true;
end;

function u1.active(p23) -- Line: 129
    -- upvalues: u4 (ref)
    local v24;

    if u4 == nil then
        v24 = false;
    else
        v24 = u4.character == p23;
    end;

    return v24;
end;

function u1.request() -- Line: 133
    -- upvalues: LocalPlayer (copy), u4 (ref), AbilityRule (copy), KnifeAbilities (copy), u3 (copy), u5 (ref), Parent (copy), u6 (ref), u1 (copy)
    local Character = LocalPlayer.Character;
    local v25;

    if Character then
        v25 = Character:FindFirstChildOfClass("Humanoid");
    else
        v25 = Character;
    end;

    local v26;

    if Character then
        v26 = Character:FindFirstChild("HumanoidRootPart");
    else
        v26 = Character;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();

    if u4 or not (v25 and (v26 and (v25.Health > 0 and (v25.FloorMaterial ~= Enum.Material.Air and not (v26.Anchored or (LocalPlayer:GetAttribute("EquippedKnife") ~= "AlbiesCutlass" or (LocalPlayer:GetAttribute("RunState") ~= "Active" or (AbilityRule.knifeBlocked(LocalPlayer) or (ServerTimeNow < (LocalPlayer:GetAttribute(KnifeAbilities.Skins.AlbiesCutlass.ReadyAt) or 0) or (Character:GetAttribute("TackleActive") or (Character:GetAttribute("GearMotion") or (Character:GetAttribute("Ragdolled") or (Character:GetAttribute("MovementLocked") or (ServerTimeNow < (Character:GetAttribute("RocketUntil") or 0) or u3[Character:GetAttribute("MovementState")])))))))))))))) then
        return false;
    end;

    u5 = u5 or Parent.Weapons:FindFirstChild(KnifeAbilities.Skins.AlbiesCutlass.Remote);

    if not u5 then
        return false;
    end;

    if not u6 then
        u6 = u5.OnClientEvent:Connect(function(p27) -- Line: 164
            -- upvalues: u1 (ref)
            if p27 == "Rejected" then
                u1.cancel();
            end;
        end);
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v28 = v25.MoveDirection * Vector3.new(1, 0, 1);
    local v29;

    if v28.Magnitude > 0.01 then
        v29 = v28.Unit;
    else
        v29 = nil;
    end;

    if not v29 then
        local v30, v31;

        if workspace_CurrentCamera then
            local v32 = workspace_CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1);

            if v32.Magnitude > 0.01 then
                v29 = v32.Unit;
            else
                v29 = nil;
            end;

            if not v29 then
                v30 = v26.CFrame.LookVector * Vector3.new(1, 0, 1);

                if v30.Magnitude > 0.01 then
                    v31 = v30.Unit;
                else
                    v31 = nil;
                end;

                v29 = v31 or Vector3.new(0, 0, 1);
            end;
        else
            v30 = v26.CFrame.LookVector * Vector3.new(1, 0, 1);

            if v30.Magnitude > 0.01 then
                v31 = v30.Unit;
            else
                v31 = nil;
            end;

            v29 = v31 or Vector3.new(0, 0, 1);
        end;
    end;

    if not u1.start(Character, v29) then
        return false;
    end;

    u5:FireServer("Activate", v29);

    return true;
end;

LocalPlayer.CharacterRemoving:Connect(function() -- Line: 182
    -- upvalues: u1 (copy)
    u1.cancel();
end);

return u1;