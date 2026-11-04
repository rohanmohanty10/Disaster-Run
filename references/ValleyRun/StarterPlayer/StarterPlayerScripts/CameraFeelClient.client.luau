 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local LocalPlayer = Players.LocalPlayer;
local Movement = game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Movement");
local CameraFeelConfig = require(Movement:WaitForChild("CameraFeelConfig"));
local MovementProfiles = require(Movement:WaitForChild("MovementProfiles"));
local u1 = require(Movement:WaitForChild("CameraCollision")).new(workspace);
local u2 = {};

local function spring(p3, p4, p5, p6) -- Line: 13
    -- upvalues: u2 (copy), CameraFeelConfig (copy)
    local v7 = u2[p3];

    if not v7 then
        v7 = {
            x = 0,
            v = 0
        };
        u2[p3] = v7;
    end;

    local v8 = p6 or CameraFeelConfig.SpringFrequency;
    local v9 = v7.x - p4;
    local math_exp_ret = math.exp(-v8 * p5);
    local v10 = v7.v + v8 * v9;
    v7.x = p4 + (v9 + v10 * p5) * math_exp_ret;
    v7.v = (v7.v - v8 * v10 * p5) * math_exp_ret;

    return v7.x;
end;

local function kick(p11, p12) -- Line: 28
    -- upvalues: u2 (copy)
    local v13 = u2[p11];

    if not v13 then
        v13 = {
            x = 0,
            v = 0
        };
        u2[p11] = v13;
    end;

    v13.v = v13.v + p12;
end;

local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = Vector3.new(0, 0, 0);
local u21 = Vector3.new(0, 0, 0);
local u22 = true;
local u23 = 0;
local u24 = 0;
local u25 = 0;
local u26 = true;
local u27 = nil;
local u28 = nil;
local u29 = nil;
local u30 = nil;
local u31 = nil;
local u32 = {};
local u33 = nil;
local u34 = nil;
local u35 = false;
local u36 = false;

local function removeLastEffect() -- Line: 49
    -- upvalues: u27 (ref), u28 (ref), u29 (ref), u30 (ref), u31 (ref)
    if u27 then
        if u27.CFrame == u28 then
            u27.CFrame = u29;
        end;

        if u27.FieldOfView == u30 then
            u27.FieldOfView = u31;
        end;
    end;

    u27 = nil;
    u28 = nil;
    u29 = nil;
    u30 = nil;
    u31 = nil;
end;

local function clear() -- Line: 60
    -- upvalues: u27 (ref), u28 (ref), u29 (ref), u30 (ref), u31 (ref), u2 (copy), u20 (ref), u21 (ref), u25 (ref), u22 (ref), u23 (ref), u24 (ref)
    if u27 then
        if u27.CFrame == u28 then
            u27.CFrame = u29;
        end;

        if u27.FieldOfView == u30 then
            u27.FieldOfView = u31;
        end;
    end;

    u27 = nil;
    u28 = nil;
    u29 = nil;
    u30 = nil;
    u31 = nil;
    table.clear(u2);
    u20 = Vector3.new(0, 0, 0);
    u21 = Vector3.new(0, 0, 0);
    u25 = 0;
    u22 = true;
    u23 = 0;
    u24 = 0;
end;

local function boostOnly(p37, p38, p39) -- Line: 72
    -- upvalues: spring (copy), CameraFeelConfig (copy), u27 (ref), u28 (ref), u29 (ref), u31 (ref), u30 (ref)
    local v40 = spring("boost", not p39 and 0 or CameraFeelConfig.AdrenalineFOV, p38, CameraFeelConfig.AdrenalineFOVFrequency);
    u27 = p37;
    u28 = nil;
    u29 = nil;
    u31 = p37.FieldOfView;
    local v41 = u31 + math.clamp(v40, 0, CameraFeelConfig.AdrenalineFOV * 1.5);
    p37.FieldOfView = math.clamp(v41, 1, 120);
    u30 = p37.FieldOfView;
end;

table.insert(u32, UserInputService.WindowFocused:Connect(function() -- Line: 81
    -- upvalues: u26 (ref)
    u26 = true;
end));
table.insert(u32, UserInputService.WindowFocusReleased:Connect(function() -- Line: 87
    -- upvalues: u26 (ref)
    u26 = false;
end));
RunService:BindToRenderStep("ChickenOrHeroCameraFeelReset", Enum.RenderPriority.Input.Value - 1, removeLastEffect);
RunService:BindToRenderStep("ChickenOrHeroCameraFeel", Enum.RenderPriority.Camera.Value + 2, function(p42) -- Line: 92
    -- upvalues: MovementProfiles (copy), LocalPlayer (copy), u14 (ref), u27 (ref), u28 (ref), u29 (ref), u30 (ref), u31 (ref), u2 (copy), u20 (ref), u21 (ref), u25 (ref), u22 (ref), u23 (ref), u24 (ref), u35 (ref), u15 (ref), u16 (ref), u17 (ref), u18 (ref), u34 (ref), u33 (ref), u26 (ref), GuiService (copy), UserInputService (copy), CameraFeelConfig (copy), u36 (ref), spring (copy), u19 (ref), u1 (copy)
    local v43 = MovementProfiles.get(LocalPlayer:GetAttribute("GameRole"), LocalPlayer);
    local Character = LocalPlayer.Character;

    if Character ~= u14 then
        if u27 then
            if u27.CFrame == u28 then
                u27.CFrame = u29;
            end;

            if u27.FieldOfView == u30 then
                u27.FieldOfView = u31;
            end;
        end;

        u27 = nil;
        u28 = nil;
        u29 = nil;
        u30 = nil;
        u31 = nil;
        table.clear(u2);
        u20 = Vector3.new(0, 0, 0);
        u21 = Vector3.new(0, 0, 0);
        u25 = 0;
        u22 = true;
        u23 = 0;
        u24 = 0;
        u14 = Character;
        u35 = false;
        local v44;

        if Character then
            v44 = Character:FindFirstChildOfClass("Humanoid");
        else
            v44 = Character;
        end;

        u15 = v44;
        local v45;

        if Character then
            v45 = Character:FindFirstChild("HumanoidRootPart");
        else
            v45 = Character;
        end;

        u16 = v45;
        local v46;

        if Character then
            v46 = Character:GetAttribute("DashCount");
        else
            v46 = Character;
        end;

        u17 = v46;

        if Character then
            Character = Character:GetAttribute("TackleStartedAt");
        end;

        u18 = Character;
    end;

    if u14 and not (u15 and u16) then
        u15 = u14:FindFirstChildOfClass("Humanoid");
        u16 = u14:FindFirstChild("HumanoidRootPart");
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v47 = u14 and u14:GetAttribute("MovementReset");

    if workspace_CurrentCamera ~= u34 then
        if u27 then
            if u27.CFrame == u28 then
                u27.CFrame = u29;
            end;

            if u27.FieldOfView == u30 then
                u27.FieldOfView = u31;
            end;
        end;

        u27 = nil;
        u28 = nil;
        u29 = nil;
        u30 = nil;
        u31 = nil;
        table.clear(u2);
        u20 = Vector3.new(0, 0, 0);
        u21 = Vector3.new(0, 0, 0);
        u25 = 0;
        u22 = true;
        u23 = 0;
        u24 = 0;
        u34 = workspace_CurrentCamera;
        u35 = false;
    end;

    if v47 ~= u33 then
        u33 = v47;
        u35 = false;
    end;

    local v48 = u26 and (workspace_CurrentCamera and (u15 and u16));

    if v48 then
        if u15.Health > 0 then
            v48 = not (u15.Sit or u15.PlatformStand);

            if v48 then
                if workspace_CurrentCamera.CameraSubject == u15 and workspace_CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
                    v48 = not GuiService.MenuIsOpen;

                    if v48 then
                        if UserInputService:GetFocusedTextBox() == nil and (LocalPlayer:GetAttribute("ReleaseCameraForUI") ~= true and (LocalPlayer:GetAttribute("ChoiceSpotlightActive") ~= true and (LocalPlayer:GetAttribute("CutsceneActive") ~= true and (LocalPlayer:GetAttribute("ScreenPresentationActive") ~= true and LocalPlayer:GetAttribute("ReleaseCursorForControls") ~= true)))) then
                            v48 = u14:GetAttribute("MovementLocked") ~= true;
                        else
                            v48 = false;
                        end;
                    end;
                else
                    v48 = false;
                end;
            end;
        else
            v48 = false;
        end;
    end;

    local v49 = v48 and CameraFeelConfig.Enabled and CameraFeelConfig.Intensity > 0;
    local v50;

    if v48 then
        v50 = LocalPlayer:GetAttribute("AdrenalineFeel") == true;
    else
        v50 = v48;
    end;

    if v50 and not u36 then
        local AdrenalineKick = CameraFeelConfig.AdrenalineKick;
        local boost = u2.boost;

        if not boost then
            boost = {
                x = 0,
                v = 0
            };
            u2.boost = boost;
        end;

        boost.v = boost.v + AdrenalineKick;
    end;

    u36 = v50;

    if not v49 then
        local boost = u2.boost;

        if v48 and (v50 or boost and (math.abs(boost.x) > 0.01 or math.abs(boost.v) > 0.01)) then
            local math_min_ret = math.min(p42, 0.1);

            if math_min_ret > 0 then
                local v51 = spring("boost", not v50 and 0 or CameraFeelConfig.AdrenalineFOV, math_min_ret, CameraFeelConfig.AdrenalineFOVFrequency);
                u27 = workspace_CurrentCamera;
                u28 = nil;
                u29 = nil;
                u31 = workspace_CurrentCamera.FieldOfView;
                local v52 = u31 + math.clamp(v51, 0, CameraFeelConfig.AdrenalineFOV * 1.5);
                workspace_CurrentCamera.FieldOfView = math.clamp(v52, 1, 120);
                u30 = workspace_CurrentCamera.FieldOfView;
            end;

            return;
        end;

        if u27 then
            if u27.CFrame == u28 then
                u27.CFrame = u29;
            end;

            if u27.FieldOfView == u30 then
                u27.FieldOfView = u31;
            end;
        end;

        u27 = nil;
        u28 = nil;
        u29 = nil;
        u30 = nil;
        u31 = nil;
        table.clear(u2);
        u20 = Vector3.new(0, 0, 0);
        u21 = Vector3.new(0, 0, 0);
        u25 = 0;
        u22 = true;
        u23 = 0;
        u24 = 0;
        local v53 = u14 and u14:GetAttribute("DashCount");
        u17 = v53;
        local v54 = u14 and u14:GetAttribute("TackleStartedAt");
        u18 = v54;
        u35 = false;

        return;
    end;

    local math_min_ret = math.min(p42, 0.1);

    if math_min_ret <= 0 then
        return;
    end;

    local CFrame2 = workspace_CurrentCamera.CFrame;
    local AssemblyLinearVelocity = u16.AssemblyLinearVelocity;
    local Vector3_new_ret = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z);

    if not u35 then
        u21 = Vector3_new_ret;
        u20 = Vector3_new_ret;
        u23 = 0;
        u24 = 0;
        u22 = u15.FloorMaterial ~= Enum.Material.Air;
        u17 = u14:GetAttribute("DashCount");
        u18 = u14:GetAttribute("TackleStartedAt");
        u35 = true;
    end;

    u21 = u21:Lerp(Vector3_new_ret, 1 - math.exp(math_min_ret * -12));
    local v55 = CFrame2:VectorToObjectSpace(u21);
    local Magnitude = u21.Magnitude;
    local math_clamp_ret = math.clamp(Magnitude / v43.MaxSpeed, 0, 1);
    local v56 = CFrame2:VectorToObjectSpace((u21 - u20) / math_min_ret);
    local v57 = u15.FloorMaterial ~= Enum.Material.Air;
    local v58 = u14:GetAttribute("DashCount") or 0;

    if u17 ~= nil and u17 < v58 then
        local v59 = v55.X / math.max(Magnitude, 1);
        local math_clamp_ret2 = math.clamp(v59, -1, 1);
        local v60 = v43.Dash.Mode == "RunBoost" and (CameraFeelConfig.RunBoostKickScale or 1) or 1;
        local v61 = -math_clamp_ret2 * CameraFeelConfig.DashRollKick * v60;
        local roll = u2.roll;

        if not roll then
            roll = {
                x = 0,
                v = 0
            };
            u2.roll = roll;
        end;

        roll.v = roll.v + v61;
        local v62 = CameraFeelConfig.DashPitchKick * v60;
        local pitch = u2.pitch;

        if not pitch then
            pitch = {
                x = 0,
                v = 0
            };
            u2.pitch = pitch;
        end;

        pitch.v = pitch.v + v62;
        local v63 = CameraFeelConfig.DashPullbackKick * v60;
        local pullback = u2.pullback;

        if not pullback then
            pullback = {
                x = 0,
                v = 0
            };
            u2.pullback = pullback;
        end;

        pullback.v = pullback.v + v63;
        local v64 = CameraFeelConfig.DashFOV * 22 * v60;
        local fov = u2.fov;

        if not fov then
            fov = {
                x = 0,
                v = 0
            };
            u2.fov = fov;
        end;

        fov.v = fov.v + v64;
    end;

    u17 = v58;
    local Attribute = u14:GetAttribute("TackleStartedAt");
    local v65 = u14:GetAttribute("TackleDuration") or 0;
    local v66;

    if u14:GetAttribute("TackleActive") == true and type(Attribute) == "number" then
        v66 = workspace:GetServerTimeNow() < Attribute + v65;
    else
        v66 = false;
    end;

    if v66 and (type(u18) ~= "number" or math.abs(Attribute - u18) > 0.1) then
        local DivePitchKick = CameraFeelConfig.DivePitchKick;
        local pitch = u2.pitch;

        if not pitch then
            pitch = {
                x = 0,
                v = 0
            };
            u2.pitch = pitch;
        end;

        pitch.v = pitch.v + DivePitchKick;
        local DivePullbackKick = CameraFeelConfig.DivePullbackKick;
        local pullback = u2.pullback;

        if not pullback then
            pullback = {
                x = 0,
                v = 0
            };
            u2.pullback = pullback;
        end;

        pullback.v = pullback.v + DivePullbackKick;
        local v67 = CameraFeelConfig.DiveFOV * 18;
        local fov = u2.fov;

        if not fov then
            fov = {
                x = 0,
                v = 0
            };
            u2.fov = fov;
        end;

        fov.v = fov.v + v67;
    end;

    u18 = Attribute;
    local Attribute2 = u14:GetAttribute("CameraKickAt");

    if Attribute2 ~= nil and Attribute2 ~= u19 then
        local v68 = tonumber(u14:GetAttribute("CameraKickPower")) or 1;
        local math_clamp_ret2 = math.clamp(v68, 0, 1.5);
        local v69 = -CameraFeelConfig.LandingKick * 4 * math_clamp_ret2;
        local vertical = u2.vertical;

        if not vertical then
            vertical = {
                x = 0,
                v = 0
            };
            u2.vertical = vertical;
        end;

        vertical.v = vertical.v + v69;
        local v70 = (math.random() < 0.5 and -1 or 1) * CameraFeelConfig.DashRollKick * 2 * math_clamp_ret2;
        local roll = u2.roll;

        if not roll then
            roll = {
                x = 0,
                v = 0
            };
            u2.roll = roll;
        end;

        roll.v = roll.v + v70;
        local v71 = CameraFeelConfig.DashPitchKick * 1.5 * math_clamp_ret2;
        local pitch = u2.pitch;

        if not pitch then
            pitch = {
                x = 0,
                v = 0
            };
            u2.pitch = pitch;
        end;

        pitch.v = pitch.v + v71;
        local v72 = CameraFeelConfig.DashFOV * 26 * math_clamp_ret2;
        local fov = u2.fov;

        if not fov then
            fov = {
                x = 0,
                v = 0
            };
            u2.fov = fov;
        end;

        fov.v = fov.v + v72;
    end;

    u19 = Attribute2;

    if v57 then
        if not (u22 or (u23 < 0.12 or u24 > -3)) then
            local v73 = -CameraFeelConfig.LandingKick;
            local vertical = u2.vertical;

            if not vertical then
                vertical = {
                    x = 0,
                    v = 0
                };
                u2.vertical = vertical;
            end;

            vertical.v = vertical.v + v73;
        end;

        u23 = 0;
        u24 = 0;
    else
        u23 = u23 + math_min_ret;
        u24 = math.min(u24, AssemblyLinearVelocity.Y);
    end;

    u22 = v57;
    u20 = u21;
    local v74 = spring("gait", v57 and math_clamp_ret and math_clamp_ret or 0, math_min_ret, 10);
    u25 = u25 + (CameraFeelConfig.StepFrequency + math_clamp_ret * 0.6) * 3.141592653589793 * 2 * math_min_ret;
    local v75 = spring("roll", -math.clamp(v55.X / v43.MaxSpeed, -1, 1) * math.rad(CameraFeelConfig.RunRollDegrees), math_min_ret);
    local v76 = -math.rad(CameraFeelConfig.MaxRollDegrees);
    local math_rad_ret = math.rad(CameraFeelConfig.MaxRollDegrees);
    local math_clamp_ret2 = math.clamp(v75, v76, math_rad_ret);
    local v77 = spring("pitch", math.clamp(-v56.Z / (v43.Acceleration * 3), -1, 1) * math.rad(CameraFeelConfig.AccelerationPitchDegrees), math_min_ret);
    local v78 = -math.rad(CameraFeelConfig.MaxPitchDegrees);
    local math_rad_ret2 = math.rad(CameraFeelConfig.MaxPitchDegrees);
    local math_clamp_ret3 = math.clamp(v77, v78, math_rad_ret2);
    local v79 = spring("lateral", -math.clamp(v55.X / v43.MaxSpeed, -1, 1) * CameraFeelConfig.LateralLag, math_min_ret);
    local v80 = spring("vertical", 0, math_min_ret);
    local v81 = spring("pullback", math_clamp_ret * 0.16 + (v66 and CameraFeelConfig.DivePullback or 0), math_min_ret);
    local math_clamp_ret4 = math.clamp(v81, 0, CameraFeelConfig.MaxPullback);
    local v82 = spring("fov", math_clamp_ret * CameraFeelConfig.RunFOV, math_min_ret, CameraFeelConfig.FOVFrequency);
    local v83 = CameraFeelConfig.RunFOV + math.max(CameraFeelConfig.DashFOV, CameraFeelConfig.DiveFOV);
    local math_clamp_ret5 = math.clamp(v82, 0, v83);
    local v84 = spring("boost", not v50 and 0 or CameraFeelConfig.AdrenalineFOV, math_min_ret, CameraFeelConfig.AdrenalineFOVFrequency);
    local v85 = math_clamp_ret5 + math.clamp(v84, 0, CameraFeelConfig.AdrenalineFOV * 1.5);
    local math_clamp_ret6 = math.clamp(CameraFeelConfig.Intensity, 0, 1.5);
    local v86 = v79 + math.sin(u25) * CameraFeelConfig.BobSide * v74;
    local v87 = math.clamp(v80, -0.15, 0.15) + math.sin(u25 * 2) * CameraFeelConfig.BobHeight * v74;
    local v88 = Vector3.new(v86, v87, math_clamp_ret4) * math_clamp_ret6;
    local Position = (CFrame2 * CFrame.new(v88)).Position;
    local v89 = u1:constrain(CFrame2.Position, Position, u14);
    u27 = workspace_CurrentCamera;
    u29 = CFrame2;
    u31 = workspace_CurrentCamera.FieldOfView;
    u28 = CFrame.new(v89) * CFrame2.Rotation * CFrame.Angles(math_clamp_ret3 * math_clamp_ret6, 0, math_clamp_ret2 * math_clamp_ret6);
    u30 = math.clamp(u31 + v85 * math_clamp_ret6, 1, 120);
    workspace_CurrentCamera.CFrame = u28;
    workspace_CurrentCamera.FieldOfView = u30;
    u30 = workspace_CurrentCamera.FieldOfView;
    u28 = workspace_CurrentCamera.CFrame;
end);
script.Destroying:Connect(function() -- Line: 283
    -- upvalues: RunService (copy), u32 (copy), u27 (ref), u28 (ref), u29 (ref), u30 (ref), u31 (ref), u2 (copy), u20 (ref), u21 (ref), u25 (ref), u22 (ref), u23 (ref), u24 (ref)
    RunService:UnbindFromRenderStep("ChickenOrHeroCameraFeelReset");
    RunService:UnbindFromRenderStep("ChickenOrHeroCameraFeel");

    for _, v in u32 do
        v:Disconnect();
    end;

    if u27 then
        if u27.CFrame == u28 then
            u27.CFrame = u29;
        end;

        if u27.FieldOfView == u30 then
            u27.FieldOfView = u31;
        end;
    end;

    u27 = nil;
    u28 = nil;
    u29 = nil;
    u30 = nil;
    u31 = nil;
    table.clear(u2);
    u20 = Vector3.new(0, 0, 0);
    u21 = Vector3.new(0, 0, 0);
    u25 = 0;
    u22 = true;
    u23 = 0;
    u24 = 0;
end);