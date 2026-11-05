  

 

local Core = require(game.ReplicatedStorage.ReplicatedRoot.Core);
local u1 = {
    Name = "PhysicsService"
};
require(Core.ReplicatedLibraries.Utility.TableUtil);
local TweenService = game:GetService("TweenService");

function u1.CreateTemporaryAttachment(p2) -- Line: 10
    local Attachment = Instance.new("Attachment");
    Attachment.Name = "TempAttachment";
    Attachment.Parent = p2;

    return Attachment;
end;

function u1.CreateLinearVelocity(p3) -- Line: 17
    -- upvalues: u1 (copy)
    local v4 = p3 or {};
    local _ = v4.Parent;
    local Mover = v4.Mover;
    local Object = v4.Object;
    local v5 = v4.Attachment or u1.CreateTemporaryAttachment(Object);
    local v6 = v4.Velocity or Vector3.new(0, 0, 0);
    local v7 = v4.MaxForce or Vector3.new(100000, 100000, 100000);

    if not Mover then
        Mover = Instance.new("LinearVelocity");
        Mover.Name = "StepVelocity";
    end;

    Mover.Attachment0 = v5;
    Mover.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    Mover.MaxAxesForce = v7;
    Mover.VectorVelocity = v6;
    Mover.Parent = Object;

    return Mover;
end;

function u1.StepVelocity(p8) -- Line: 48
    -- upvalues: u1 (copy), TweenService (copy)
    local u9 = p8 or {};
    local Parent = u9.Parent;
    local Mover = u9.Mover;
    local Object = u9.Object;
    local Attachment = u9.Attachment;
    local v10 = u9.Name or "StepVelocity";
    local Cancel = u9.Cancel;

    if u9.Override == nil and true or u9.Override or Cancel then
        for _, child in pairs(Object:GetChildren()) do
            if child:IsA("LinearVelocity") and child.Name == v10 then
                child.Enabled = false;
                child:SetAttribute("Overrided", true);
            end;
        end;
    end;

    if not Cancel then
        local u11;

        if Attachment then
            u11 = false;
        else
            Attachment = u1.CreateTemporaryAttachment(Object);
            Attachment.Position = Vector3.new(0, 0, 0);

            if Object:IsGrounded() then
                Attachment.WorldPosition = Object.Position;
                u11 = true;
            else
                Attachment.WorldPosition = Object.AssemblyCenterOfMass;
                u11 = true;
            end;
        end;

        local u12 = u9.Velocity or Vector3.new(0, 0, 0);
        local v13 = u9.StartSpeed or (u9.Speed or 0);
        local u14 = u9.EndSpeed or (u9.Speed or v13);
        local u15 = u9.Direction or Vector3.new(0, 0, 0);
        local u16 = u9.Normal or Vector3.new(0, 0, 0);
        local u17 = u9.StartMaxForce or (u9.MaxForce or Vector3.new(40000, 0, 40000));
        local u18 = u9.EndMaxForce or (u9.MaxForce or u17);
        local TargetHeight = u9.TargetHeight;
        local u19 = Object.AssemblyLinearVelocity * (u9.VelocityInheritance or Vector3.new(0, 0, 0));
        local v20 = u9.Time or 0.2;
        local u21 = v20 == (1 / 0) and 0.2 or v20;
        local u22 = u9.TimeDelay or 0;
        local u23 = u9.Turn or false;
        local _ = u9.Raycast;
        local Distance = u9.Distance;
        local MaxDistance = u9.MaxDistance;
        local u24 = u9.EasingStyle or Enum.EasingStyle.Linear;
        local u25 = u9.EasingDirection or Enum.EasingDirection.Out;
        local Target = u9.Target;
        local RaycastParameters = u9.RaycastParameters;

        if not RaycastParameters then
            RaycastParameters = RaycastParams.new();
            RaycastParameters.FilterType = RaycastParameters.FilterType or Enum.RaycastFilterType.Exclude;
            local v26 = { Object, Parent };

            if u9.Filter then
                for _, v in pairs(u9.Filter) do
                    table.insert(v26, v);
                end;
            end;

            RaycastParameters.FilterDescendantsInstances = v26;
            RaycastParameters.CollisionGroup = u9.CollisionGroup or "Default";
        end;

        local function GetCFrame() -- Line: 134
            -- upvalues: Object (copy)
            return Object.CFrame;
        end;

        local function GetTargetCFrame() -- Line: 138
            -- upvalues: Target (copy)
            if typeof(Target) == "CFrame" then
                return Target;
            end;

            if typeof(Target) == "Vector3" then
                return CFrame.new(Target);
            end;

            if typeof(Target) == "Instance" then
                if Target:IsA("BasePart") then
                    return Target.CFrame;
                end;

                if Target:IsA("Model") then
                    local HumanoidRootPart = Target:FindFirstChild("HumanoidRootPart");

                    return HumanoidRootPart and HumanoidRootPart.CFrame or Target:GetPivot();
                end;
            end;
        end;

        local u27;

        if typeof(u16) == "Vector3" then
            u27 = Object.CFrame:VectorToWorldSpace(u16);
        else
            u27 = false;
        end;

        local u28 = nil;

        local function GetDirection() -- Line: 155
            -- upvalues: u16 (copy), u15 (copy), GetTargetCFrame (copy), u23 (copy), u28 (ref), Object (copy), u27 (copy)
            if typeof(u16) == "function" then
                return u15 + u16();
            end;

            local v29 = GetTargetCFrame();

            if u23 then
                if v29 then
                    return CFrame.lookAt(Object.Position, v29.Position).LookVector;
                end;

                return u15 + Object.CFrame:VectorToWorldSpace(u16);
            end;

            if not v29 then
                return u15 + u27;
            end;

            if not u28 then
                u28 = CFrame.lookAt(Object.Position, v29.Position).LookVector;
            end;

            return u28;
        end;

        if not Mover then
            Mover = Instance.new("LinearVelocity");
            Mover.Name = v10;
        end;

        Mover.Attachment0 = Attachment;
        Mover.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        Mover.MaxAxesForce = u17;

        local function GetTimescale() -- Line: 186
            -- upvalues: Parent (copy)
            return Parent and Parent:GetAttribute("Timescale") or 1;
        end;

        local u30 = os.clock();
        local u31 = v13;

        local function GetVelocity() -- Line: 192
            -- upvalues: Parent (copy), TweenService (ref), u30 (copy), u21 (ref), u24 (copy), u25 (copy), u12 (copy), GetDirection (copy), u31 (ref), u14 (copy), u17 (copy), u18 (copy), Mover (ref), MaxDistance (copy), Distance (copy), Object (copy), RaycastParameters (ref), u9 (copy), GetTargetCFrame (copy), u19 (copy), TargetHeight (copy)
            local _ = Parent and Parent:GetAttribute("Timescale");
            local v32 = TweenService:GetValue((os.clock() - u30) / u21, u24, u25);
            local v33 = math.clamp(v32, 0, 1);
            local v34 = u12 + GetDirection() * math.lerp(u31, u14, v33);
            local Unit = v34.Unit;
            u31 = v34.Magnitude;
            local v35 = u17 ~= u18 and u17:Lerp(u18, v33) or u17;
            local v36 = Mover:GetAttribute("MaxForceMultiplier");

            if v36 then
                v35 = v35 * v36;
            end;

            if MaxDistance then
                local v37 = MaxDistance or Distance;
                local v38 = Distance or v37;
                local v39 = workspace:Raycast(Object.Position, v34, RaycastParameters);

                if v39 and u9.Raycast ~= false then
                    v38 = (Object.Position - v39.Position).Magnitude;
                end;

                local v40 = GetTargetCFrame();
                local v41;

                if v40 then
                    v41 = (Object.Position - v40.Position).Magnitude;

                    if v41 >= v38 then
                        v41 = v38;
                    end;
                else
                    v41 = v38;
                end;

                local v42 = math.clamp(v41, 0, v37) / v37;
                u31 = math.lerp(0, u31, v42);
                v34 = Unit * math.max(0, u31);
            end;

            local v43 = u19:Lerp(Vector3.new(0, 0, 0), v33);
            local v44;

            if TargetHeight then
                local v45 = math.clamp((TargetHeight - Object.Position.Y) * 2, -u31, u31);
                v44 = Vector3.new(0, v45, 0);
            else
                v44 = Vector3.new(0, 0, 0);
            end;

            return v34 + v43 + v44, v35;
        end;

        Mover.VectorVelocity = GetVelocity();
        Mover.Parent = Object;
        task.spawn(function() -- Line: 272
            -- upvalues: u21 (ref), u22 (copy), Mover (ref), Object (copy), GetVelocity (copy), u11 (ref), Attachment (ref), Parent (copy)
            local v46 = 0;

            while Mover and (Mover:IsDescendantOf(game) and v46 <= u21 + u22) do
                if not Object:IsGrounded() then
                    local v47, v48 = GetVelocity();

                    if u11 then
                        Attachment.WorldPosition = Object.AssemblyCenterOfMass;
                    end;

                    Mover.VectorVelocity = v47;
                    Mover.MaxAxesForce = v48 * (Object.AssemblyMass * 21.952 * (workspace.Gravity / 3.57));
                end;

                local v49 = Parent and Parent:GetAttribute("Timescale") or 1;
                local v50 = task.wait() * v49;

                if v49 <= 0 then
                    task.wait();
                else
                    v46 = v46 + v50;
                end;
            end;

            Mover:Destroy();

            if u11 then
                Attachment:Destroy();
            end;
        end);

        return Mover;
    end;
end;

function u1.FreezeWeld(p51) -- Line: 304
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = workspace.Terrain;
    WeldConstraint.Part1 = p51;
    WeldConstraint.Enabled = true;
    WeldConstraint.Parent = p51;

    return WeldConstraint;
end;

return u1;