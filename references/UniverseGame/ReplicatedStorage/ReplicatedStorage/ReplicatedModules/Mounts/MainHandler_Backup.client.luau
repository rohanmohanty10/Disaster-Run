  

 

local RunService = game:GetService("RunService");
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
local u1 = Parent:GetAttribute("MAX_SPEED") or 90;
local u2 = Parent:GetAttribute("BACKWARD_MAX_SPEED") or 0;
local u3 = Parent:GetAttribute("ROTATIONAL_ACCELERATION") or 0.05;
local u4 = Parent:GetAttribute("MOTIONAL_ACCELERATION") or 0.5;
local u5 = Parent:GetAttribute("MOTIONAL_DECELERATION") or 0.25;
local u6 = Parent:GetAttribute("FOV_SHIFT");
local u7 = Parent:GetAttribute("HOVER_INFLUENCE");
local u8 = Parent:GetAttribute("HOVER_HEIGHT") or 5;
local u9 = Parent:GetAttribute("CHARACTER_TILT_MULTIPLIER") or 1;
local u10 = Parent:GetAttribute("CAMERA_LOCKED_MOUNT");
local u11 = 0;
local u12 = require(LocalPlayer:WaitForChild("PlayerScripts").PlayerModule):GetControls();
local ReplicatedModules = ReplicatedStorage:FindFirstChild("ReplicatedModules");
local PathShortcuts = require(ReplicatedModules:FindFirstChild("PathShortcuts"));
local u13 = require(PathShortcuts.KnitPath.Knit).GetService("MountService");
local u14 = require(PathShortcuts.KnitPath.Trove).new();
local v15 = ReplicatedModules.MountAnimators[Parent:GetAttribute("MountAnimator") or "BikeAnimator"];
local u16 = require(v15);
u16:Init(v15);
u14:Add(function() -- Line: 52
    -- upvalues: u16 (copy), Parent (copy), CurrentCamera (copy), LocalPlayer (copy)
    u16:StopAllTracks();
    Parent:SetAttribute("PerformingTrick", nil);
    CurrentCamera.FieldOfView = LocalPlayer.Settings.FieldOfView.Value;
end);
local u17 = u14:Clone(script:WaitForChild("MountGyro", 3));
u17.Parent = HumanoidRootPart;
u17.P = u17.P * (u3 / 0.075);
local u18 = u14:Clone(script:WaitForChild("MountVelocity", 3));
u18.Parent = HumanoidRootPart;

if Parent:GetAttribute("MountType") == "Hoverboard" then
    u18.MaxForce = Vector3.new(1, 1, 1) * u18.MaxForce.X;
end;

if TouchEnabled or u10 then
    u17.P = 10000;
    u17.D = 100;
    u17:SetAttribute("CamLocked", true);
end;

local CFrame2 = HumanoidRootPart.CFrame;
u17.CFrame = CFrame2;
local u19 = nil;
u14:Connect(RunService.RenderStepped, function(p20) -- Line: 80
    -- upvalues: Parent (copy), Humanoid (copy), u12 (copy), u4 (copy), u11 (ref), u2 (copy), u1 (copy), u5 (copy), u18 (copy), HumanoidRootPart (copy), u6 (copy), TweenService (copy), CurrentCamera (copy), LocalPlayer (copy), u8 (copy), u16 (copy), u7 (copy), u17 (copy), TouchEnabled (copy), u10 (copy), CFrame2 (ref), u3 (copy), u9 (copy), u19 (ref), u13 (copy)
    if not Parent:IsDescendantOf(game) or (not Parent:GetAttribute("Mount") or Humanoid.Health <= 0) then
        return;
    end;

    local v21 = u12:GetMoveVector();
    local X = v21.X;
    local v22 = -v21.Z;
    local v23 = p20 * 60;
    local v24 = Parent:GetAttribute("BikeAccelMultiplier") or 1;
    u11 = math.clamp(u11 + v22 * u4 * v23 * v24 * (v24 < 0 and v22 < 0 and -1 or 1), u2, u1);

    if v22 == 0 and math.abs(u11) > 0 then
        local v25 = (u11 < 0 and 1 or -1) * u5 * v23;

        if math.abs(u11) - math.abs(v25) < u5 then
            u11 = 0;
        else
            u11 = u11 + v25;
        end;
    end;

    if not u18:GetAttribute("PauseCalculations") then
        u18.Velocity = Vector3.new(1, 0, 1) * HumanoidRootPart.CFrame.LookVector * u11;
    end;

    if u6 then
        TweenService:Create(CurrentCamera, TweenInfo.new(p20), {
            FieldOfView = LocalPlayer.Settings.FieldOfView.Value + math.abs(u11 / u1) * u6
        }):Play();
    end;

    if Parent:GetAttribute("MountType") == "Hoverboard" then
        local v26 = HumanoidRootPart.Position - HumanoidRootPart.CFrame.UpVector * u8;
        local v27 = u16:OnGround(-u8);
        local v28 = u18;
        v28.Velocity = v28.Velocity + Vector3.new(0, v27 and (u8 * (v27.Position - v26)).Magnitude * 1.75 or -(u7 or u8), 0);
    end;

    if not u17:GetAttribute("PauseCalculations") then
        if TouchEnabled or u10 then
            u17.CFrame = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + Vector3.new(1, 0, 1) * CurrentCamera.CFrame.LookVector);
        else
            CFrame2 = CFrame2 * CFrame.fromOrientation(0, -X * u3 * v23, 0);
            u17.CFrame = CFrame2 * CFrame.fromOrientation(0, 0, X * 0.5 * u9);
        end;
    end;

    local v29 = math.abs(u11) > 0;

    if u19 ~= v29 then
        u13.MountMoveSignal:Fire(v29);
        u19 = v29;
    end;

    u16:Step(u11, v22, X, u1);
end);
local u30 = {};
local u31 = {};

for _, child in script.InputFunctions:GetChildren() do
    local v32 = require(child);
    u30[v32.Keybind] = v32;
end;

u14:Connect(UserInputService.InputBegan, function(p33) -- Line: 151
    -- upvalues: Parent (copy), UserInputService (copy), u30 (copy), u16 (copy), u31 (copy), u13 (copy), u14 (copy)
    if Parent:GetAttribute("PerformingSkill") ~= nil or UserInputService:GetFocusedTextBox() then
        return;
    end;

    local u34 = u30[p33[p33.UserInputType == Enum.UserInputType.Keyboard and "KeyCode" or "UserInputType"]];
    local u35;

    if u34 then
        u35 = u34.Name or "Skill" .. u34.Keybind.Name;
    else
        u35 = u34;
    end;

    if u34 and u35 then
        if typeof(u34.Check) == "function" and not u34:Check(u16, Parent) or u31[u35] then
            return;
        end;

        Parent:SetAttribute("PerformingSkill", u35);
        u13.MountSkillSignal:Fire(u35, true);
        local v36 = u14:Extend();
        v36:Add(function() -- Line: 170
            -- upvalues: Parent (ref), u13 (ref), u35 (copy), u34 (copy), u31 (ref)
            Parent:SetAttribute("PerformingSkill", nil);
            u13.MountSkillSignal:Fire(u35, false);

            if typeof(u34.Cooldown) == "number" then
                u31[u35] = true;
                task.delay(u34.Cooldown, function() -- Line: 177
                    -- upvalues: u31 (ref), u35 (ref)
                    u31[u35] = false;
                end);
            end;
        end);
        u34:Start(u16, Parent, v36);

        if u34.AutoStop ~= false then
            u34:Stop(u16, Parent, v36);
            v36:Clean();
        end;
    end;
end);

if UserInputService.TouchEnabled then
    local JumpButton = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("TouchGui", (1 / 0)):WaitForChild("TouchControlFrame"):WaitForChild("JumpButton");
    u14:Connect(JumpButton.MouseButton1Down, function(p37) -- Line: 200
        -- upvalues: Parent (copy), UserInputService (copy), u30 (copy), u16 (copy), u31 (copy), u13 (copy), u14 (copy), JumpButton (copy)
        if Parent:GetAttribute("PerformingSkill") ~= nil or UserInputService:GetFocusedTextBox() then
            return;
        end;

        local u38 = u30[Enum.KeyCode.Space];
        local u39;

        if u38 then
            u39 = u38.Name or "Skill" .. u38.Keybind.Name;
        else
            u39 = u38;
        end;

        local BoolValue = Instance.new("BoolValue");
        BoolValue.Value = true;

        if u38 and u39 then
            if typeof(u38.Check) == "function" and not u38:Check(u16, Parent) or u31[u39] then
                return;
            end;

            Parent:SetAttribute("PerformingSkill", u39);
            u13.MountSkillSignal:Fire(u39, true);
            local v40 = u14:Extend();
            v40:Add(function() -- Line: 220
                -- upvalues: Parent (ref), u13 (ref), u39 (copy), u38 (copy), u31 (ref)
                Parent:SetAttribute("PerformingSkill", nil);
                u13.MountSkillSignal:Fire(u39, false);

                if typeof(u38.Cooldown) == "number" then
                    u31[u39] = true;
                    task.delay(u38.Cooldown, function() -- Line: 227
                        -- upvalues: u31 (ref), u39 (ref)
                        u31[u39] = false;
                    end);
                end;
            end);
            JumpButton.MouseButton1Up:Once(function() -- Line: 233
                -- upvalues: BoolValue (copy)
                BoolValue.Value = false;
                task.defer(function() -- Line: 235
                    -- upvalues: BoolValue (ref)
                    BoolValue:Destroy();
                end);
            end);
            u38:Start(u16, Parent, v40, BoolValue);

            if u38.AutoStop ~= false then
                u38:Stop(u16, Parent, v40);
                v40:Clean();
            end;
        end;
    end);
end;

u14:Connect(Parent:GetAttributeChangedSignal("Mount"), function() -- Line: 251
    -- upvalues: Parent (copy), u14 (copy)
    if not Parent:GetAttribute("Mount") then
        u14:Destroy();
    end;
end);