  

local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local FlagUtil = require(CommonUtils:WaitForChild("FlagUtil"));
local ConnectionUtil = require(CommonUtils:WaitForChild("ConnectionUtil"));
local UserFlag = FlagUtil.getUserFlag("UserUpdateInputConnections");
local Vector3_new_ret = Vector3.new();
local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 38
    -- upvalues: u1 (copy), Vector3_new_ret (copy), UserFlag (copy), ConnectionUtil (copy)
    local v2 = setmetatable({}, u1);
    v2.enabled = false;
    v2.moveVector = Vector3_new_ret;
    v2.moveVectorIsCameraRelative = true;
    v2.isJumping = false;

    if UserFlag then
        v2._connections = ConnectionUtil.new();
    end;

    return v2;
end;

function u1.OnRenderStepped(p3: table, p4: number) -- Line: 52
    -- upvalues: UserFlag (copy)
    assert(not UserFlag);
end;

function u1.GetMoveVector(p5) -- Line: 57
    return p5.moveVector;
end;

function u1.IsMoveVectorCameraRelative(p6) -- Line: 61
    return p6.moveVectorIsCameraRelative;
end;

function u1.GetIsJumping(p7) -- Line: 65
    return p7.isJumping;
end;

function u1.Enable(p8: table, p9: boolean) -- Line: 71
    error("BaseCharacterController:Enable must be overridden in derived classes and should not be called.");

    return false;
end;

return u1;