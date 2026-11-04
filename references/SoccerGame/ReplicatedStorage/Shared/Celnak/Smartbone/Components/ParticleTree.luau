  

local Random_new_ret = Random.new(1029410295159813);
local u1 = {};
u1.__index = u1;

function u1.new(p2: userdata, p3: userdata, p4: vector) -- Line: 7
    -- upvalues: Random_new_ret (copy), u1 (copy)
    local v5 = {
        BoneTotalLength = 0,
        DistanceFromCamera = 100,
        Force = Vector3.new(0, 0, 0),
        RestGravity = Vector3.new(0, 0, 0),
        ObjectMove = Vector3.new(0, 0, 0),
        ObjectPreviousPosition = Vector3.new(0, 0, 0),
        WindOffset = Random_new_ret:NextNumber(0, 1000000),
        Root = p2:IsA("Bone") and p2 and p2 or nil,
        RootPart = p3,
        LockedDirection = p2:GetAttribute("LockedDirection") or CFrame.new(0, 0, -1),
        RootWorldToLocal = p2.WorldCFrame:ToObjectSpace(p2.CFrame),
        Particles = {},
        LocalCFrame = p2.WorldCFrame,
        LocalGravity = p2.CFrame:PointToWorldSpace(p4).Unit * p4.Magnitude
    };

    return setmetatable(v5, u1);
end;

return u1;