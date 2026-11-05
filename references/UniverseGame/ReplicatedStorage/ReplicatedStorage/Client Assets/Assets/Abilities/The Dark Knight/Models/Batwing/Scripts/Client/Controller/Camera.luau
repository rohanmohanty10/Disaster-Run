  

 

local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local CurrentCamera = game:GetService("Workspace").CurrentCamera;
local DriverSeat = script.Parent.Parent.Parent.Parent.DriverSeat;

return {
    Enabled = false,
    Pitch = 0,
    Yaw = 0,
    IsManual = false,
    LastManualInput = 0,
    TrailingOffset = Vector3.new(0, 0, 0),
    LookAhead = Vector3.new(0, 0, 0),
    GimbalCFrame = CFrame.identity,
    RelativeCameraCFrame = CFrame.identity,
    Parameters = {
        Height = 12,
        Distance = 37,
        LookAheadAmount = 3,
        LookAheadHeightScale = 0.5,
        LookAheadSpeed = 10,
        TrailingCatchupSpeed = 15,
        GimbalSpeedAuto = 5,
        GimbalSpeedManual = 15,
        CameraSpeedAuto = 5,
        CameraSpeedManual = 15,
        ResetToAutoTime = 3,
        MaxPitch = 1.3962634015954636,
        MinPitch = -1.3962634015954636,
        VelocityDirThreshold = 10
    },

    LerpCFrame = function(p1, p2, p3, p4) -- Line: 38, Name: LerpCFrame
        return p2:Lerp(p3, (math.clamp(p4, 0, 1)));
    end,

    GetPitchYawFromVector = function(p5, p6) -- Line: 42, Name: GetPitchYawFromVector
        local Unit = p6.Unit;
        local v7 = math.clamp(Unit.Y, -1, 1);

        return math.asin(v7), math.atan2(Unit.X, Unit.Z);
    end,

    OnInputChanged = function(p8, p9) -- Line: 49, Name: OnInputChanged
        -- upvalues: UserInputService (copy)
        if p9.UserInputType == Enum.UserInputType.MouseMovement and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
            local Delta = p9.Delta;
            p8.IsManual = true;
            p8.LastManualInput = os.clock();
            local v10 = p8.Pitch - math.rad(Delta.Y * 0.3);
            p8.Pitch = math.clamp(v10, p8.Parameters.MinPitch, p8.Parameters.MaxPitch);
            p8.Yaw = (p8.Yaw - math.rad(Delta.X * 0.3)) % 6.283185307179586;
        end;
    end,

    Enable = function(u11) -- Line: 60, Name: Enable
        -- upvalues: DriverSeat (copy), CurrentCamera (copy), UserInputService (copy), RunService (copy)
        if u11.Enabled then
            return;
        end;

        u11.Enabled = true;

        if not DriverSeat then
            return;
        end;

        CurrentCamera:SetAttribute("CamDisabled", true);
        CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        u11.GimbalCFrame = DriverSeat.CFrame - DriverSeat.Position;
        u11.RelativeCameraCFrame = DriverSeat.CFrame:ToObjectSpace(CurrentCamera.CFrame);
        u11.TrailingOffset = Vector3.new(0, 0, 0);
        u11.LookAhead = Vector3.new(0, 0, 0);
        local v12, v13 = u11:GetPitchYawFromVector(DriverSeat.CFrame.LookVector);
        u11.Pitch = v12;
        u11.Yaw = v13;
        UserInputService.InputChanged:Connect(function(p14) -- Line: 77
            -- upvalues: u11 (copy)
            u11:OnInputChanged(p14);
        end);
        RunService:BindToRenderStep("ChaseCamera", Enum.RenderPriority.Camera.Value, function(p15) -- Line: 81
            -- upvalues: u11 (copy)
            u11:Update(p15);
        end);
    end,

    Disable = function(p16) -- Line: 86, Name: Disable
        -- upvalues: RunService (copy), UserInputService (copy), CurrentCamera (copy)
        if not p16.Enabled then
            return;
        end;

        p16.Enabled = false;
        RunService:UnbindFromRenderStep("ChaseCamera");
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
        CurrentCamera:SetAttribute("CamDisabled", nil);
        CurrentCamera.CameraType = Enum.CameraType.Custom;
    end,

    Update = function(p17, p18) -- Line: 97, Name: Update
        -- upvalues: DriverSeat (copy), CurrentCamera (copy)
        if not (DriverSeat and DriverSeat.Parent) then
            return;
        end;

        local AssemblyLinearVelocity = DriverSeat.AssemblyLinearVelocity;
        local v19 = AssemblyLinearVelocity.Magnitude >= p17.Parameters.VelocityDirThreshold and AssemblyLinearVelocity and AssemblyLinearVelocity or DriverSeat.CFrame.LookVector;
        local v20 = os.clock();

        if p17.IsManual and v20 - p17.LastManualInput > p17.Parameters.ResetToAutoTime then
            p17.IsManual = false;
        end;

        if not p17.IsManual then
            local v21, v22 = p17:GetPitchYawFromVector(v19);
            p17.Pitch = v21;
            p17.Yaw = v22;
        end;

        local v23 = p17.IsManual and p17.Parameters.GimbalSpeedManual or p17.Parameters.GimbalSpeedAuto;
        local v24 = CFrame.fromEulerAnglesYXZ(p17.Pitch, p17.Yaw, 0);
        p17.GimbalCFrame = p17:LerpCFrame(p17.GimbalCFrame, v24, p18 * v23);
        p17.LookAhead = p17.LookAhead:Lerp(v19 * p17.Parameters.LookAheadAmount * (p17.IsManual and 0 or 1), p18 * p17.Parameters.LookAheadSpeed);
        p17.TrailingOffset = p17.TrailingOffset - v19 * p18;
        p17.TrailingOffset = p17.TrailingOffset:Lerp(Vector3.new(), p18 * p17.Parameters.TrailingCatchupSpeed);
        local v25 = p17.IsManual and p17.Parameters.CameraSpeedManual or p17.Parameters.CameraSpeedAuto;
        local v26 = p17.TrailingOffset + Vector3.new(0, p17.Parameters.Height, 0) + p17.GimbalCFrame:PointToWorldSpace((Vector3.new(0, 0, p17.Parameters.Distance)));
        local v27 = p17.LookAhead + Vector3.new(0, p17.Parameters.Height * p17.Parameters.LookAheadHeightScale - 3, 0);
        p17.RelativeCameraCFrame = p17:LerpCFrame(p17.RelativeCameraCFrame, CFrame.lookAt(v26, v27, Vector3.new(0, 1, 0)), p18 * v25);
        CurrentCamera.CFrame = CFrame.new(DriverSeat.Position) * p17.RelativeCameraCFrame;
        CurrentCamera.Focus = CFrame.new(DriverSeat.Position);
    end
};