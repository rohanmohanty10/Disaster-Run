  

 

local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 15
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2.enabled = false;
    v2.moveVector = Vector3.new(0, 0, 0);
    v2.moveVectorIsCameraRelative = true;
    v2.isJumping = false;

    return v2;
end;

function u1.OnRenderStepped(p3, p4) -- Line: 24
end;

function u1.GetMoveVector(p5) -- Line: 28
    return p5.moveVector;
end;

function u1.IsMoveVectorCameraRelative(p6) -- Line: 32
    return p6.moveVectorIsCameraRelative;
end;

function u1.GetIsJumping(p7) -- Line: 36
    return p7.isJumping;
end;

function u1.Enable(p8, p9) -- Line: 42
    error("BaseCharacterController:Enable must be overridden in derived classes and should not be called.");

    return false;
end;

return u1;