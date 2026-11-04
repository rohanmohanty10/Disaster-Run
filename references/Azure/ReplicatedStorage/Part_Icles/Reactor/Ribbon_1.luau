 
 

local GeometryService = game:GetService("GeometryService");
local RunService = game:GetService("RunService");
local v1 = {};
local u2 = setmetatable({}, {
    __mode = "k"
});

local function sweep(u3) -- Line: 29
    -- upvalues: GeometryService (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.Size = u3.tool;
    local success, result = pcall(function() -- Line: 33
        -- upvalues: GeometryService (ref), Part (copy), u3 (copy)
        return GeometryService:SweepPartAsync(Part, u3.frames);
    end);
    Part:Destroy();

    if not success or typeof(result) ~= "Instance" then
        return nil;
    end;

    local Size = result.Size;
    local v4 = {
        X = Size.X,
        Y = Size.Y,
        Z = Size.Z,
        [u3.straight] = u3.length
    };
    result.Size = Vector3.new(v4.X, v4.Y, v4.Z);

    return result;
end;

function v1.cutter(p5) -- Line: 47
    -- upvalues: u2 (copy), sweep (copy), RunService (copy)
    local v6 = u2[p5.key];

    if not v6 then
        v6 = {};
        u2[p5.key] = v6;
    end;

    local v7 = v6[p5.lengthwise];

    if not v7 then
        v7 = {
            making = true
        };
        v6[p5.lengthwise] = v7;
        v7.cutter = sweep(p5);
        v7.making = false;
    end;

    while v7.making do
        RunService.Heartbeat:Wait();
    end;

    return v7.cutter;
end;

return v1;