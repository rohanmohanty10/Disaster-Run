  

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local BaseCamera = require(script.Parent:WaitForChild("BaseCamera"));
local CameraInput = require(script.Parent:WaitForChild("CameraInput"));
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"));
local ZoomController = require(script.Parent:WaitForChild("ZoomController"));
local VehicleCameraCore = require(script:WaitForChild("VehicleCameraCore"));
local VehicleCameraConfig = require(script:WaitForChild("VehicleCameraConfig"));
local LocalPlayer = Players.LocalPlayer;
local _ = CameraUtils.map;
local Spring = CameraUtils.Spring;
local mapClamp = CameraUtils.mapClamp;
local sanitizeAngle = CameraUtils.sanitizeAngle;

local function pitchVelocity(p1, p2) -- Line: 25
    local v3 = p2.XVector:Dot(p1);

    return math.abs(v3);
end;

local function yawVelocity(p4, p5) -- Line: 30
    local v6 = p5.YVector:Dot(p4);

    return math.abs(v6);
end;

local u7 = 0.016666666666666666;
RunService.Stepped:Connect(function(p8, p9) -- Line: 36
    -- upvalues: u7 (ref)
    u7 = p9;
end);
local u10 = setmetatable({}, BaseCamera);
u10.__index = u10;

function u10.new() -- Line: 43
    -- upvalues: BaseCamera (copy), u10 (copy)
    local v11 = BaseCamera.new();
    local v12 = setmetatable(v11, u10);
    v12:Reset();

    return v12;
end;

function u10.Reset(p13) -- Line: 49
    -- upvalues: VehicleCameraCore (copy), Spring (copy), VehicleCameraConfig (copy), CameraUtils (copy)
    p13.vehicleCameraCore = VehicleCameraCore.new(p13:GetSubjectCFrame());
    p13.pitchSpring = Spring.new(0, -math.rad(VehicleCameraConfig.pitchBaseAngle));
    p13.yawSpring = Spring.new(0, 0);
    p13.lastPanTick = 0;
    local CurrentCamera = workspace.CurrentCamera;
    local v14;

    if CurrentCamera then
        v14 = CurrentCamera.CameraSubject;
    else
        v14 = CurrentCamera;
    end;

    assert(CurrentCamera);
    assert(v14);
    assert(v14:IsA("VehicleSeat"));
    local v15 = v14:GetConnectedParts(true);
    local v16, v17 = CameraUtils.getLooseBoundingSphere(v15);
    p13.assemblyRadius = math.max(v17, 0.001);
    p13.assemblyOffset = v14.CFrame:Inverse() * v16;
    p13:_StepInitialZoom();
end;

function u10._StepInitialZoom(p18) -- Line: 73
    -- upvalues: ZoomController (copy), VehicleCameraConfig (copy)
    local v19 = ZoomController.GetZoomRadius();
    p18:SetCameraToSubjectDistance((math.max(v19, p18.assemblyRadius * VehicleCameraConfig.initialZoomRadiusMul)));
end;

function u10._StepRotation(p20, p21, p22) -- Line: 80
    -- upvalues: CameraInput (copy), sanitizeAngle (copy), VehicleCameraConfig (copy), mapClamp (copy)
    local yawSpring = p20.yawSpring;
    local pitchSpring = p20.pitchSpring;
    local v23 = CameraInput.getRotation(true);
    local v24 = -v23.Y;
    yawSpring.pos = sanitizeAngle(yawSpring.pos + -v23.X);
    pitchSpring.pos = sanitizeAngle((math.clamp(pitchSpring.pos + v24, -1.3962634015954636, 1.3962634015954636)));

    if CameraInput.getRotationActivated() then
        p20.lastPanTick = os.clock();
    end;

    local v25 = -math.rad(VehicleCameraConfig.pitchBaseAngle);
    local v26 = math.rad(VehicleCameraConfig.pitchDeadzoneAngle);

    if os.clock() - p20.lastPanTick > VehicleCameraConfig.ugocorrectDelay then
        local v27 = mapClamp(p22, VehicleCameraConfig.ugocorrectMinCarSpeed, VehicleCameraConfig.ugocorrectMaxCarSpeed, 0, VehicleCameraConfig.ugocorrectResponse);
        yawSpring.freq = v27;
        pitchSpring.freq = v27;

        if yawSpring.freq < 0.001 then
            yawSpring.vel = 0;
        end;

        if pitchSpring.freq < 0.001 then
            pitchSpring.vel = 0;
        end;

        local v28 = sanitizeAngle(v25 - pitchSpring.pos);

        if math.abs(v28) <= v26 then
            pitchSpring.goal = pitchSpring.pos;
        else
            pitchSpring.goal = v25;
        end;
    else
        yawSpring.freq = 0;
        yawSpring.vel = 0;
        pitchSpring.freq = 0;
        pitchSpring.vel = 0;
        pitchSpring.goal = v25;
    end;

    return CFrame.fromEulerAnglesYXZ(pitchSpring:step(p21), yawSpring:step(p21), 0);
end;

function u10._GetThirdPersonLocalOffset(p29) -- Line: 143
    -- upvalues: VehicleCameraConfig (copy)
    return p29.assemblyOffset + Vector3.new(0, p29.assemblyRadius * VehicleCameraConfig.verticalCenterOffset, 0);
end;

function u10._GetFirstPersonLocalOffset(p30, p31) -- Line: 147
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character and Character.Parent then
        local Head = Character:FindFirstChild("Head");

        if Head and Head:IsA("BasePart") then
            return p31:Inverse() * Head.Position;
        end;
    end;

    return p30:_GetThirdPersonLocalOffset();
end;

function u10.Update(p32) -- Line: 161
    -- upvalues: u7 (ref), mapClamp (copy)
    local CurrentCamera = workspace.CurrentCamera;
    local v33;

    if CurrentCamera then
        v33 = CurrentCamera.CameraSubject;
    else
        v33 = CurrentCamera;
    end;

    local vehicleCameraCore = p32.vehicleCameraCore;
    assert(CurrentCamera);
    assert(v33);
    assert(v33:IsA("VehicleSeat"));
    local v34 = u7;
    u7 = 0;
    local v35 = p32:GetSubjectCFrame();
    local v36 = p32:GetSubjectVelocity();
    local v37 = p32:GetSubjectRotVelocity();
    local v38 = v36:Dot(v35.ZVector);
    local v39 = math.abs(v38);
    local v40 = v35.YVector:Dot(v37);
    local v41 = math.abs(v40);
    local v42 = v35.XVector:Dot(v37);
    local v43 = math.abs(v42);
    local v44 = p32:StepZoom();
    local v45 = p32:_StepRotation(v34, v39);
    local v46 = mapClamp(v44, 0.5, p32.assemblyRadius, 1, 0);
    local v47 = p32:_GetThirdPersonLocalOffset():Lerp(p32:_GetFirstPersonLocalOffset(v35), v46);
    vehicleCameraCore:setTransform(v35);
    local v48 = vehicleCameraCore:step(v34, v43, v41, v46);
    local v49 = CFrame.new(v35 * v47) * v48 * v45;

    return v49 * CFrame.new(0, 0, v44), v49;
end;

function u10.ApplyVRTransform(p50) -- Line: 206
end;

function u10.EnterFirstPerson(p51) -- Line: 210
    p51.inFirstPerson = true;
    p51:UpdateMouseBehavior();
end;

function u10.LeaveFirstPerson(p52) -- Line: 215
    p52.inFirstPerson = false;
    p52:UpdateMouseBehavior();
end;

return u10;