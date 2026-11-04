 

 

local RunService = game:GetService("RunService");
local u1 = 0;
local u2 = {
    meta = nil
};
u2.__index = u2;

local function getJoints(p3) -- Line: 29
    local v4 = {};

    for _, descendant in p3:GetDescendants() do
        if descendant:IsA("Motor6D") then
            table.insert(v4, descendant);
        end;
    end;

    return v4;
end;

local function getRewindList(p5) -- Line: 41
    -- upvalues: u2 (copy)
    local meta = u2.meta;
    local Clock = meta.Clock;
    local v6 = {};

    for _, v in meta.RecordList do
        if Clock - v.Clock < p5 then
            table.insert(v6, table.clone(v));
        end;
    end;

    table.sort(v6, function(p7, p8) -- Line: 60
        return p7.Clock > p8.Clock;
    end);

    return v6;
end;

function u2.new(p9: userdata) -- Line: 67
    -- upvalues: u2 (copy), getJoints (copy)
    local v10 = setmetatable({}, u2);
    v10.Character = p9;
    v10.RootPart = p9:FindFirstChild("HumanoidRootPart");
    v10.Joints = getJoints(p9);
    v10.RecordList = {};
    v10.Clock = 0;
    v10.MaxRecordTime = 5;
    v10.RewindListMax = 0;
    v10.Active = false;
    v10.Rate = 10;
    u2.meta = v10;

    return v10;
end;

function u2.Rewind(p11, p12, p13) -- Line: 86
    -- upvalues: getRewindList (copy)
    p11.Rate = 60;
    p11.RewindSpeed = p13;
    p11.RewindList = getRewindList(p12);
    p11.RewindListMax = #p11.RewindList;
end;

function u2.Destroy(p14) -- Line: 93
    -- upvalues: u2 (copy)
    print("removing record");
    table.clear(p14);
    u2.meta = nil;
end;

RunService.Heartbeat:Connect(function(p15) -- Line: 100
    -- upvalues: u2 (copy), u1 (ref)
    local meta = u2.meta;

    if not (meta and meta.Active) then
        return;
    end;

    u1 = u1 + p15;

    if u1 > 1 / meta.Rate then
        u1 = u1 - 1 / meta.Rate;

        if meta.RewindList then
            local table_remove_ret = table.remove(meta.RewindList, 1);

            if not table_remove_ret then
                meta.RewindList = nil;
                meta.Rate = 10;

                return;
            end;

            local _ = meta.RewindListMax;
            local _ = #meta.RewindList;

            for _, v in meta.Joints do
                v.Transform = table_remove_ret.Joints[v];
            end;

            meta.RootPart.CFrame = meta.RootPart.CFrame:Lerp(table_remove_ret.CFrame, 1 - 1e-6 ^ p15);
            table.clear(table_remove_ret);

            return;
        end;

        meta.Clock = meta.Clock + 0.03333333333333333;
        local v16 = {};

        for _, v in meta.Joints do
            v16[v] = v.Transform;
        end;

        table.insert(meta.RecordList, {
            CFrame = meta.RootPart.CFrame,
            Clock = meta.Clock,
            Joints = v16
        });

        if meta.Clock > meta.MaxRecordTime then
            for i = 1, meta.RewindSpeed or 1 do
                local table_remove_ret = table.remove(meta.RecordList, 1);
                local v17;

                if table_remove_ret then
                    table.clear(table_remove_ret);
                    v17 = i;
                else
                    v17 = i;
                end;
            end;
        end;
    end;
end);

return u2;