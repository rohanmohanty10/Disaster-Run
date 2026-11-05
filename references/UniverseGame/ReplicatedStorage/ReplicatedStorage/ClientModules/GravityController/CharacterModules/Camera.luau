  

 

local u1 = {};
u1.__index = u1;
u1.ClassName = "Camera";

function u1.new(p2) -- Line: 9
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    local PlayerModule = require(p2.Player.PlayerScripts:WaitForChild("PlayerModule"));
    v3.Controller = p2;
    v3.CameraModule = PlayerModule:GetCameras();
    init(v3);

    return v3;
end;

function init(u4)
    function u4.CameraModule.GetUpVector(p5, p6) -- Line: 27
        -- upvalues: u4 (copy)
        return u4.Controller._gravityUp;
    end;
end;

function u1.Destroy(p7) -- Line: 34
    function p7.CameraModule.GetUpVector(p8, p9) -- Line: 35
        return Vector3.new(0, 1, 0);
    end;
end;

return u1;