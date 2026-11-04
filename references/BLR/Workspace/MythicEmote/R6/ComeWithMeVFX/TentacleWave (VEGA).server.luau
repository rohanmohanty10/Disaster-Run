  

local RunService = game:GetService("RunService");
local script_Parent = script.Parent;
local u1 = {};
local u2 = 0;

local function setup() -- Line: 13
    -- upvalues: script_Parent (copy), u1 (copy)
    local ball = script_Parent:FindFirstChild("ball", true);

    if not ball then
        print("[TentacleWave] no ball");

        return;
    end;

    for i, child in ball:GetChildren() do
        local start = child:FindFirstChild("start");
        local v3 = child:FindFirstChild("end");

        if start and v3 then
            local v4 = {
                en = v3,
                base = v3.CFrame,
                dir = (v3.Position - start.Position).Unit,
                beams = {},
                ph = (i - 1) * 1.37,
                f = 0.85 + i * 7 % 5 * 0.08
            };

            for _, child2 in child:GetChildren() do
                if child2:IsA("Beam") then
                    table.insert(v4.beams, {
                        b = child2,
                        c0 = child2.CurveSize0,
                        c1 = child2.CurveSize1,
                        w0 = child2.Width0,
                        w1 = child2.Width1
                    });
                end;
            end;

            table.insert(u1, v4);
        end;
    end;

    print(("[TentacleWave] tentacles %d"):format(#u1));
end;

local os_clock_ret = os.clock();
local u5 = nil;
u5 = RunService.RenderStepped:Connect(function() -- Line: 30
    -- upvalues: script_Parent (copy), u5 (ref), u2 (ref), setup (copy), os_clock_ret (copy), u1 (copy)
    if not script_Parent.Parent then
        u5:Disconnect();

        return;
    end;

    u2 = u2 + 1;

    if u2 == 30 then
        setup();
    end;

    if u2 <= 30 then
        return;
    end;

    local v6 = os.clock() - os_clock_ret;

    for _, v in u1 do
        local v7 = 1.7592918860102844 * v.f * v6 + v.ph;
        local math_sin_ret = math.sin(v7);
        local math_sin_ret2 = math.sin(v7 - 1.9);
        local v8 = math.sin(v7 * 0.5) * 0.5 + 0.5;
        local v9 = v;

        for _, v2 in v.beams do
            v2.b.CurveSize0 = v2.c0 + math_sin_ret * 3.2;
            v2.b.CurveSize1 = v2.c1 + math_sin_ret2 * 3.2;
            local v10 = 1 + (v8 - 0.5) * 2 * 0.12;
            v2.b.Width0 = v2.w0 * v10;
            v2.b.Width1 = v2.w1 * v10;
        end;

        local Position = v9.base.Position;
        local v11 = math.sin(v7 * 0.8) * 0.9;
        local v12 = math.cos(v7 * 0.6) * 0.9 * 0.6;
        local v13 = math.sin(v7 * 0.7 + 1) * 0.9;
        local Vector3_new_ret = Vector3.new(v11, v12, v13);
        v9.en.CFrame = CFrame.new(Position + Vector3_new_ret - v9.dir * (v8 * 0.06 * Position.Magnitude)) * v9.base.Rotation;
    end;
end);