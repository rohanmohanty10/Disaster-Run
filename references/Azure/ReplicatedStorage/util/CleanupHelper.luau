 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
require(ReplicatedStorage.forum.trove);
local v1 = {};
local u2 = {
    __index = v1
};

function v1.new() -- Line: 25
    -- upvalues: u2 (copy)
    local v3 = {
        _cleanup = {},
        _start = os.clock()
    };

    return setmetatable(v3, u2);
end;

function v1.Restart(p4) -- Line: 33
    p4._start = os.clock();

    for _, v in ipairs(p4._cleanup) do
        v.EmittedAt = 0;
    end;
end;

function v1.Add(p5, p6) -- Line: 40
    local _cleanup = p5._cleanup;
    local v7 = {
        Parent = p6,
        EmittedAt = os.clock() - p5._start
    };
    table.insert(_cleanup, v7);

    if p5.Trove then
        return p5.Trove:Add(p6);
    end;

    return p6;
end;

function v1.Clone(p8, p9) -- Line: 52
    return p8:Add((p9:Clone()));
end;

function v1.GetTimeLeft(p10) -- Line: 57
    -- upvalues: vfxUtil (copy)
    local v11 = os.clock() - p10._start;
    local v12 = 0;

    for _, v in ipairs(p10._cleanup) do
        local v13 = vfxUtil.getEmittersLifetime(v.Parent) + v.EmittedAt - v11;
        v12 = math.max(v12, v13);
    end;

    return math.max(v12, 0);
end;

function v1.Refresh(p14) -- Line: 67
    for i = #p14._cleanup, 1, -1 do
        p14._cleanup[i] = nil;
        local _ = i;
    end;

    p14:Restart();
end;

return v1;