  

 

local VRService = game:GetService("VRService");
local Workspace = game:GetService("Workspace");
local u1 = {
    ChaseCamera = require(script.ChaseCamera),
    InteriorCamera = require(script.InteriorCamera),
    FixedCamera = require(script.FixedCamera)
};
local CameraModes = require(script.CameraModes);
local CurrentCamera = Workspace.CurrentCamera;
local CycleCameraMode = script.CycleCameraMode;
local u2 = nil;
local u3 = 1;
local u4 = false;

local function setMode(p5) -- Line: 19
    -- upvalues: u3 (ref), CameraModes (copy), u1 (copy)
    u3 = p5;
    local v6 = CameraModes[u3];

    for i, v in u1 do
        if i == v6.module then
            v:setParameters(v6.parameters);
            v:enable();
        else
            v:disable();
        end;
    end;
end;

local function cycleCameraMode() -- Line: 35
    -- upvalues: u3 (ref), CameraModes (copy), setMode (copy)
    local v7 = u3 + 1;
    setMode(#CameraModes < v7 and 1 or v7);
end;

return {
    enable = function(p8) -- Line: 45, Name: enable
        -- upvalues: u4 (ref), VRService (copy), CurrentCamera (copy), u2 (ref), CycleCameraMode (copy), cycleCameraMode (copy), setMode (copy), u3 (ref)
        if u4 then
            return;
        end;

        if VRService.VREnabled then
            return;
        end;

        u4 = true;
        CurrentCamera:SetAttribute("CamDisabled", true);
        u2 = CycleCameraMode.Event:Connect(cycleCameraMode);
        CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        setMode(u3);
    end,

    disable = function(p9) -- Line: 65, Name: disable
        -- upvalues: u4 (ref), CurrentCamera (copy), u2 (ref), u1 (copy)
        if not u4 then
            return;
        end;

        u4 = false;
        CurrentCamera:SetAttribute("CamDisabled", nil);

        if u2 then
            u2:Disconnect();
            u2 = nil;
        end;

        CurrentCamera.CameraType = Enum.CameraType.Custom;

        for _, v in u1 do
            v:disable();
        end;
    end
};