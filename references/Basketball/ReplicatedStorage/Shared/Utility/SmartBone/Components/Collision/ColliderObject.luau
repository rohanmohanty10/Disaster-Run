 
 

local Collider = require(script.Parent:WaitForChild("Collider"));
local SB_VERBOSE_LOG = require(script.Parent.Parent.Parent:WaitForChild("Dependencies"):WaitForChild("Utilities")).SB_VERBOSE_LOG;
local u1 = {};
u1.__index = u1;

function u1.new(p2: table, u3: userdata) -- Line: 57
    -- upvalues: u1 (copy)
    local u4 = setmetatable({
        m_Awake = true,
        m_LastSleepCycle = 0,
        Destroyed = false,
        m_Object = u3,
        Colliders = {}
    }, u1);
    u4:m_LoadColliderTable(p2);
    u4.DestroyConnection = u3:GetPropertyChangedSignal("Parent"):Connect(function() -- Line: 68
        -- upvalues: u3 (copy), u4 (copy)
        if u3.Parent == nil then
            u4.Destroyed = true;
        end;
    end);

    return u4;
end;

function u1.m_LoadCollider(p5: table, p6: table) -- Line: 80
    -- upvalues: Collider (copy)
    local Vector3_new_ret = Vector3.new(p6.ScaleX, p6.ScaleY, p6.ScaleZ);
    local Vector3_new_ret2 = Vector3.new(p6.OffsetX, p6.OffsetY, p6.OffsetZ);
    local Vector3_new_ret3 = Vector3.new(p6.RotationX, p6.RotationY, p6.RotationZ);
    local v7 = Collider.new();
    v7.Scale = Vector3_new_ret;
    v7.Offset = Vector3_new_ret2;
    v7.Rotation = Vector3_new_ret3;
    v7.Type = p6.Type;
    v7:SetObject(p5.m_Object);
    table.insert(p5.Colliders, v7);
end;

function u1.m_LoadColliderTable(p8: table, p9: table) -- Line: 98
    for _, v in p9 do
        p8:m_LoadCollider(v);
    end;
end;

function u1.GetObject(p10) -- Line: 108
    return p10.m_Object;
end;

function u1.GetCollisions(p11, p12, p13) -- Line: 116
    debug.profilebegin("ColliderObject::GetCollisions");

    if not p11.m_Object then
        debug.profileend();

        return {};
    end;

    if #p11.Colliders == 0 then
        debug.profileend();

        return {};
    end;

    debug.profilebegin("Sleep Cycle");

    if os.clock() - p11.m_LastSleepCycle >= 0.2 then
        p11.m_LastSleepCycle = os.clock();

        if p11.m_Object:IsDescendantOf(workspace) then
            p11.m_Awake = true;
        else
            p11.m_Awake = false;
        end;
    end;

    debug.profileend();

    if not p11.m_Awake then
        debug.profileend();

        return {};
    end;

    debug.profilebegin("Determine Collisions");
    local v14 = {};

    for _, v in p11.Colliders do
        debug.profilebegin("Determine collision");
        local ClosestPoint, v15, v16 = v:GetClosestPoint(p12, p13);
        debug.profileend();

        if ClosestPoint then
            table.insert(v14, {
                ClosestPoint = v15,
                Normal = v16
            });
        end;
    end;

    debug.profileend();
    debug.profileend();

    return v14;
end;

function u1.Step(p17) -- Line: 164
    debug.profilebegin("ColliderObject::Step");

    for _, v in p17.Colliders do
        v:Step();
    end;

    debug.profileend();
end;

function u1.DrawDebug(p18, p19, p20, p21, p22) -- Line: 177
    for _, v in p18.Colliders do
        v:DrawDebug(p18, p19, p20, p21, p22);
        v.InNarrowphase = false;
    end;
end;

function u1.Destroy(p23) -- Line: 185
    -- upvalues: SB_VERBOSE_LOG (copy)
    task.synchronize();
    SB_VERBOSE_LOG((`Collider object destroying, object: {p23.m_Object}`));
    p23.DestroyConnection:Disconnect();

    if #p23.Colliders ~= 0 then
        for _, v in p23.Colliders do
            v:Destroy();
        end;
    end;

    setmetatable(p23, nil);
    task.desynchronize();
end;

return u1;