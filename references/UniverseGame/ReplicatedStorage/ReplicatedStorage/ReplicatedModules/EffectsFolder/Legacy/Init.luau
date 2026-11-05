  

 

local CurrentCamera = workspace.CurrentCamera;
local CameraShaker = require(game.ReplicatedStorage.ClientModules:WaitForChild("CameraShaker"));
local u1 = {};

local function camShake() -- Line: 5
    -- upvalues: CameraShaker (copy), CurrentCamera (copy), u1 (copy)
    return CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p2) -- Line: 6
        -- upvalues: CurrentCamera (ref), u1 (ref)
        CurrentCamera.CFrame = u1.CustomCamPart and u1.CustomCamPart.CFrame or CurrentCamera.CFrame * p2;
    end);
end;

local u3 = nil;

return function(p4) -- Line: 12
    -- upvalues: u3 (ref), CameraShaker (copy), CurrentCamera (copy), u1 (copy)
    if u3 then
        return u3;
    end;

    u3 = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p5) -- Line: 6
        -- upvalues: CurrentCamera (ref), u1 (ref)
        CurrentCamera.CFrame = u1.CustomCamPart and u1.CustomCamPart.CFrame or CurrentCamera.CFrame * p5;
    end);
    u3:Start();

    return u3;
end;