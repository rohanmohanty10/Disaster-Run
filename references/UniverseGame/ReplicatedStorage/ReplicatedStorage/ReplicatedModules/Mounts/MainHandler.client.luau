  

 

local RunService = game:GetService("RunService");
local ContextActionService = game:GetService("ContextActionService");
local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local Parent = script.Parent;
local HumanoidRootPart = Parent:WaitForChild("HumanoidRootPart", 3);
local Humanoid = Parent:WaitForChild("Humanoid", 3);
local CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local TouchEnabled = UserInputService.TouchEnabled;

local function GetAttribute(p1) -- Line: 23
    -- upvalues: Parent (copy)
    return Parent:GetAttribute("OVERRIDE_" .. p1) or Parent:GetAttribute(p1);
end;

local u2 = (Parent:GetAttribute("OVERRIDE_MAX_SPEED") or Parent:GetAttribute("MAX_SPEED") or 90) * 1.2;
local u3 = Parent:GetAttribute("OVERRIDE_BACKWARD_MAX_SPEED") or Parent:GetAttribute("BACKWARD_MAX_SPEED") or 0;
local u4 = Parent:GetAttribute("OVERRIDE_ROTATIONAL_ACCELERATION") or Parent:GetAttribute("ROTATIONAL_ACCELERATION") or 0.05;
local u5 = Parent:GetAttribute("OVERRIDE_MOTIONAL_ACCELERATION") or Parent:GetAttribute("MOTIONAL_ACCELERATION") or 0.5;
local u6 = Parent:GetAttribute("OVERRIDE_MOTIONAL_DECELERATION") or Parent:GetAttribute("MOTIONAL_DECELERATION") or 0.25;
local u7 = Parent:GetAttribute("OVERRIDE_SURFACECAST_WORLD_OFFSET") or Parent:GetAttribute("SURFACECAST_WORLD_OFFSET") or Vector3.new(0, 0, 0);
local u8 = Parent:GetAttribute("FOV_SHIFT");
local u9 = Parent:GetAttribute("HOVER_INFLUENCE");
local u10 = Parent:GetAttribute("OVERRIDE_HOVER_HEIGHT") or Parent:GetAttribute("HOVER_HEIGHT") or 5;
local u11 = Parent:GetAttribute("CHARACTER_TILT_MULTIPLIER") or 1;
local u12 = Parent:GetAttribute("CAMERA_LOCKED_MOUNT");
local u13 = Parent:GetAttribute("ALIGN_NORMAL") == nil and true or Parent:GetAttribute("ALIGN_NORMAL");
local u14 = 0;
local u15 = require(LocalPlayer:WaitForChild("PlayerScripts").PlayerModule):GetControls();
local ReplicatedModules = ReplicatedStorage:FindFirstChild("ReplicatedModules");
local PathShortcuts = require(ReplicatedModules:FindFirstChild("PathShortcuts"));
local u16 = require(PathShortcuts.KnitPath.Knit).GetService("MountService");
local u17 = require(PathShortcuts.KnitPath.Trove).new();
local v18 = ReplicatedModules.MountAnimators[Parent:GetAttribute("MountAnimator") or "BikeAnimator"];
local u19 = require(v18);
u19:Init(v18, u17);
u17:Add(function() -- Line: 59
    -- upvalues: u19 (copy), Parent (copy), CurrentCamera (copy), LocalPlayer (copy)
    u19:StopAllTracks();
    Parent:SetAttribute("PerformingTrick", nil);
    CurrentCamera.FieldOfView = LocalPlayer.Settings.FieldOfView.Value;
end);
local CFrame2 = HumanoidRootPart.CFrame;
local u20 = nil;
local u21 = u17:Clone(script:WaitForChild("RotationalVelocity", 3));
u21.Parent = HumanoidRootPart;
u21.Attachment0 = HumanoidRootPart:WaitForChild("RootAttachment");
u21.MaxTorque = u21.MaxTorque * (u4 / 0.075);
u21.CFrame = CFrame2;
local u22 = u17:Clone(script:WaitForChild("PlanarVelocity", 3));
u22.Parent = HumanoidRootPart;
u22.ForceLimitMode = Enum.ForceLimitMode.Magnitude;
u22.MaxForce = 21500;
u22.PrimaryTangentAxis = Vector3.new(1, 0, 0);
u22.SecondaryTangentAxis = Vector3.new(0, 0, 1);
local v23 = Instance.fromExisting(HumanoidRootPart:WaitForChild("RootAttachment"));
v23.Name = "Relative";
v23.CFrame = CFrame.Angles(-1.5707963267948966, 0, 0);
v23.Parent = HumanoidRootPart;
u22.RelativeTo = Enum.ActuatorRelativeTo.Attachment0;
u22.Attachment0 = v23;
u17:Add(v23);
local u24 = u17:Clone(script:WaitForChild("VerticalVelocity", 3));
u24.Parent = HumanoidRootPart;
u24.Attachment0 = HumanoidRootPart:WaitForChild("RootAttachment");
u24.MaxForce = 50000;
u24.LineDirection = Vector3.new(0, 1, 0);
u24.Enabled = Parent:GetAttribute("MountType") == "Hoverboard";

if TouchEnabled or u12 then
    u21:SetAttribute("CamLocked", true);
end;

u17:Connect(RunService.RenderStepped, function(p25) -- Line: 105
    -- upvalues: Parent (copy), Humanoid (copy), u15 (copy), u5 (copy), u14 (ref), u3 (copy), u2 (copy), u6 (copy), u21 (copy), u22 (copy), u8 (copy), TweenService (copy), CurrentCamera (copy), LocalPlayer (copy), HumanoidRootPart (copy), u10 (copy), u19 (copy), u7 (copy), u24 (copy), u9 (copy), TouchEnabled (copy), u12 (copy), u11 (copy), u4 (copy), CFrame2 (ref), u13 (copy), u20 (ref), u16 (copy)
    if not Parent:IsDescendantOf(game) or (not Parent:GetAttribute("Mount") or Humanoid.Health <= 0) then
        return;
    end;

    local v26 = u15:GetMoveVector();
    local X = v26.X;
    local v27 = -v26.Z;
    local v28 = p25 * 60;
    local v29 = Parent:GetAttribute("OVERRIDE_BikeAccelMultiplier") or Parent:GetAttribute("BikeAccelMultiplier") or 1;
    u14 = math.clamp(u14 + v27 * u5 * v28 * v29 * (v29 < 0 and v27 < 0 and -1 or 1), u3, u2);

    if v27 == 0 and math.abs(u14) > 0 then
        local v30 = (u14 < 0 and 1 or -1) * u6 * v28;
        u14 = math.abs(u14) - math.abs(v30) < u6 and 0 or u14 + v30;
    end;

    if not u21:GetAttribute("PauseCalculations") then
        u22.PlaneVelocity = Vector2.yAxis * u14;
    end;

    if u8 then
        TweenService:Create(CurrentCamera, TweenInfo.new(p25), {
            FieldOfView = LocalPlayer.Settings.FieldOfView.Value + math.abs(u14 / u2) * u8
        }):Play();
    end;

    if Parent:GetAttribute("MountType") == "Hoverboard" then
        local Position = HumanoidRootPart.Position;
        local v31 = HumanoidRootPart.Position - HumanoidRootPart.CFrame.UpVector * u10;
        local v32 = u19:OnGround(-u10, Position + u7);
        local v33 = u19:OnGround(-u10 - u10 / 10, Position + u7);
        local v34 = u10 - (v32 and (v32.Position - HumanoidRootPart.Position).Y or u10);
        local v35;

        if v33 then
            v35 = v34 * (v33.Position - v31).Magnitude * 1.5;
        else
            v35 = -(u9 or u10);
        end;

        u24.LineVelocity = v35;
    end;

    if not u21:GetAttribute("PauseCalculations") then
        local v36 = u19:OnGround(-u10 - 3);

        if TouchEnabled or u12 ~= nil and (u12 ~= false and (u12 ~= 2 or math.abs(u14) >= 0.01)) then
            u21.CFrame = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + Vector3.new(1, 0, 1) * CurrentCamera.CFrame.LookVector);
        elseif u12 ~= 2 then
            local v37 = X * 0.15 * u11;
            CFrame2 = CFrame2 * CFrame.Angles(0, -X * u4 * v28, 0);

            if v36 and u13 then
                local Normal = v36.Normal;
                local Unit = CFrame2.LookVector:Cross(Normal).Unit;
                local Unit2 = Unit:Cross(Normal).Unit;
                local v38 = CFrame.fromMatrix(Vector3.new(0, 0, 0), Unit, Normal, Unit2);
                u21.CFrame = u21.CFrame:Lerp(v38 * CFrame.fromEulerAngles(0, 0, v37, Enum.RotationOrder.XYZ), 0.8);
            else
                u21.CFrame = CFrame2 * CFrame.fromEulerAngles(0, 0, v37, Enum.RotationOrder.XYZ);
            end;
        end;
    end;

    local v39 = math.abs(u14) > 0;

    if u20 ~= v39 then
        u16.MountMoveSignal:Fire(v39);
        u20 = v39;
    end;

    u19:Step(u14, v27, X, u2);
end);
local u40 = {
    [Enum.KeyCode.ButtonA] = Enum.KeyCode.Space
};
local u41 = {};
local u42 = {};

for _, child in script.InputFunctions:GetChildren() do
    local v43 = require(child);
    u41[v43.Keybind] = v43;
end;

ContextActionService:BindActionAtPriority("MountAction", function(p44, p45, p46) -- Line: 206
    -- upvalues: Parent (copy), UserInputService (copy), u41 (copy), u40 (copy), u19 (copy), u42 (copy), u16 (copy), u17 (copy)
    if Parent:GetAttribute("PerformingSkill") ~= nil or UserInputService:GetFocusedTextBox() then
        return Enum.ContextActionResult.Pass;
    end;

    if p45 ~= Enum.UserInputState.Begin then
        return Enum.ContextActionResult.Pass;
    end;

    local v47 = Parent:GetAttribute("Mount");
    local v48 = p46[(p46.UserInputType == Enum.UserInputType.Keyboard or p46.UserInputType == Enum.UserInputType.Gamepad1) and "KeyCode" or "UserInputType"];
    local u49 = u41[u40[v48] or v48];
    local u50;

    if u49 then
        u50 = u49.Name or "Skill" .. u49.Keybind.Name;
    else
        u50 = u49;
    end;

    if not (u49 and u50) then
        return Enum.ContextActionResult.Pass;
    end;

    if typeof(u49.Check) == "function" and not u49:Check(u19, Parent) or u42[u50] then
        return Enum.ContextActionResult.Pass;
    end;

    Parent:SetAttribute("PerformingSkill", u50);
    local u51 = not (v47 and (u49.Overrides and (u49.Overrides[v47] and u49.Overrides[v47].IgnoreSignal)));

    if u51 then
        u16.MountSkillSignal:Fire(u50, true);
    end;

    local v52 = u17:Extend();
    v52:Add(function() -- Line: 238
        -- upvalues: Parent (ref), u51 (ref), u16 (ref), u50 (copy), u49 (copy), u42 (ref)
        Parent:SetAttribute("PerformingSkill", nil);

        if u51 then
            u16.MountSkillSignal:Fire(u50, false);
        end;

        if typeof(u49.Cooldown) == "number" then
            u42[u50] = true;
            task.delay(u49.Cooldown, function() -- Line: 248
                -- upvalues: u42 (ref), u50 (ref)
                u42[u50] = false;
            end);
        end;
    end);
    u49:Start(u19, Parent, v52);

    if u49.AutoStop ~= false then
        u49:Stop(u19, Parent, v52);
        v52:Clean();
    end;

    return Enum.ContextActionResult.Pass;
end, false, 2006, Enum.UserInputType.Keyboard, Enum.UserInputType.Gamepad1);
u17:Add(function() -- Line: 263
    -- upvalues: ContextActionService (copy)
    ContextActionService:UnbindAction("MountAction");
end);

if UserInputService.TouchEnabled then
    local JumpButton = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("TouchGui", (1 / 0)):WaitForChild("TouchControlFrame"):WaitForChild("JumpButton");
    u17:Connect(JumpButton.MouseButton1Down, function(p53) -- Line: 275
        -- upvalues: Parent (copy), UserInputService (copy), u41 (copy), u19 (copy), u42 (copy), u16 (copy), u17 (copy), JumpButton (copy)
        if Parent:GetAttribute("PerformingSkill") ~= nil or UserInputService:GetFocusedTextBox() then
            return;
        end;

        local u54 = u41[Enum.KeyCode.Space];
        local v55 = Parent:GetAttribute("Mount");
        local u56;

        if u54 then
            u56 = u54.Name or "Skill" .. u54.Keybind.Name;
        else
            u56 = u54;
        end;

        local BoolValue = Instance.new("BoolValue");
        BoolValue.Value = true;

        if u54 and u56 then
            if typeof(u54.Check) == "function" and not u54:Check(u19, Parent) or u42[u56] then
                return;
            end;

            Parent:SetAttribute("PerformingSkill", u56);
            local u57 = not (v55 and (u54.Overrides and (u54.Overrides[v55] and u54.Overrides[v55].IgnoreSignal)));

            if u57 then
                u16.MountSkillSignal:Fire(u56, true);
            end;

            local v58 = u17:Extend();
            v58:Add(function() -- Line: 304
                -- upvalues: Parent (ref), u57 (ref), u16 (ref), u56 (copy), u54 (copy), u42 (ref)
                Parent:SetAttribute("PerformingSkill", nil);

                if u57 then
                    u16.MountSkillSignal:Fire(u56, false);
                end;

                if typeof(u54.Cooldown) == "number" then
                    u42[u56] = true;
                    task.delay(u54.Cooldown, function() -- Line: 314
                        -- upvalues: u42 (ref), u56 (ref)
                        u42[u56] = false;
                    end);
                end;
            end);
            JumpButton.MouseButton1Up:Once(function() -- Line: 320
                -- upvalues: BoolValue (copy)
                BoolValue.Value = false;
                task.defer(function() -- Line: 322
                    -- upvalues: BoolValue (ref)
                    BoolValue:Destroy();
                end);
            end);
            u54:Start(u19, Parent, v58, BoolValue);

            if u54.AutoStop ~= false then
                u54:Stop(u19, Parent, v58);
                v58:Clean();
            end;
        end;
    end);
end;

u17:Connect(Parent:GetAttributeChangedSignal("Mount"), function() -- Line: 338
    -- upvalues: Parent (copy), u17 (copy)
    if not Parent:GetAttribute("Mount") then
        u17:Destroy();
    end;
end);
u17:AttachToInstance(Parent);