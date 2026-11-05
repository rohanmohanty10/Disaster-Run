  

 

Vector2.new();
require(script.Parent:WaitForChild("CameraUtils"));
local CameraInput = require(script.Parent:WaitForChild("CameraInput"));
local Players = game:GetService("Players");
local BaseCamera = require(script.Parent:WaitForChild("BaseCamera"));
local u1 = setmetatable({}, BaseCamera);
u1.__index = u1;

function u1.new() -- Line: 20
    -- upvalues: BaseCamera (copy), u1 (copy)
    local v2 = BaseCamera.new();
    local v3 = setmetatable(v2, u1);
    v3.cameraType = Enum.CameraType.Fixed;
    v3.lastUpdate = tick();
    v3.lastDistanceToSubject = nil;

    return v3;
end;

function u1.GetModuleName(p4) -- Line: 30
    return "LegacyCamera";
end;

function u1.SetCameraToSubjectDistance(p5, p6) -- Line: 35
    -- upvalues: BaseCamera (copy)
    return BaseCamera.SetCameraToSubjectDistance(p5, p6);
end;

function u1.Update(p7, p8) -- Line: 39
    -- upvalues: Players (copy), CameraInput (copy)
    if p7.cameraType then
        local v9 = tick();
        local CurrentCamera = workspace.CurrentCamera;
        local CFrame2 = CurrentCamera.CFrame;
        local Focus = CurrentCamera.Focus;
        local LocalPlayer = Players.LocalPlayer;

        if p7.lastUpdate == nil or v9 - p7.lastUpdate > 1 then
            p7.lastDistanceToSubject = nil;
        end;

        local v10 = p7:GetSubjectPosition();

        if p7.cameraType == Enum.CameraType.Fixed then
            if v10 and (LocalPlayer and CurrentCamera) then
                local v11 = p7:GetCameraToSubjectDistance();
                local v12 = p7:CalculateNewLookVectorFromArg(nil, CameraInput.getRotation());
                Focus = CurrentCamera.Focus;
                CFrame2 = CFrame.new(CurrentCamera.CFrame.p, CurrentCamera.CFrame.p + v11 * v12);
            end;
        elseif p7.cameraType == Enum.CameraType.Attach then
            local v13 = p7:GetSubjectCFrame();
            local v14 = CurrentCamera.CFrame:ToEulerAnglesYXZ();
            local _, v15 = v13:ToEulerAnglesYXZ();
            local v16 = v14 - CameraInput.getRotation().Y;
            local v17 = math.clamp(v16, -1.3962634015954636, 1.3962634015954636);
            Focus = CFrame.new(v13.p) * CFrame.fromEulerAnglesYXZ(v17, v15, 0);
            CFrame2 = Focus * CFrame.new(0, 0, p7:StepZoom());
        else
            if p7.cameraType ~= Enum.CameraType.Watch then
                return CurrentCamera.CFrame, CurrentCamera.Focus;
            end;

            if v10 and (LocalPlayer and CurrentCamera) then
                local v18 = nil;

                if v10 == CurrentCamera.CFrame.p then
                    warn("Camera cannot watch subject in same position as itself");

                    return CurrentCamera.CFrame, CurrentCamera.Focus;
                end;

                local v19 = p7:GetHumanoid();

                if v19 and v19.RootPart then
                    local v20 = v10 - CurrentCamera.CFrame.p;
                    v18 = v20.unit;

                    if p7.lastDistanceToSubject and p7.lastDistanceToSubject == p7:GetCameraToSubjectDistance() then
                        p7:SetCameraToSubjectDistance(v20.magnitude);
                    end;
                end;

                local v21 = p7:GetCameraToSubjectDistance();
                local v22 = p7:CalculateNewLookVectorFromArg(v18, CameraInput.getRotation());
                Focus = CFrame.new(v10);
                CFrame2 = CFrame.new(v10 - v21 * v22, v10);
                p7.lastDistanceToSubject = v21;
            end;
        end;

        p7.lastUpdate = v9;

        return CFrame2, Focus;
    end;
end;

return u1;