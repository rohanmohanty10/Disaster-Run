 
 

local RunService = game:GetService("RunService");

local function NormalizeSteps(p1: table) -- Line: 26
    local v2 = {};

    if #p1 > 0 then
        for _, v in p1 do
            if type(v) == "table" and (type(v.Frame) == "number" and type(v.Callback) == "function") then
                table.insert(v2, v);
            end;
        end;
    else
        for i, v in p1 do
            if type(i) == "number" and type(v) == "function" then
                table.insert(v2, {
                    Frame = i,
                    Callback = v
                });
            end;
        end;
    end;

    table.sort(v2, function(p3, p4) -- Line: 43
        return p3.Frame < p4.Frame;
    end);

    return v2;
end;

return function(p5: table) -- Line: 50
    -- upvalues: NormalizeSteps (copy), RunService (copy)
    local u6 = 1;
    local u7 = NormalizeSteps(p5);

    if #u7 == 0 then
        return function() -- Line: 55
        end;
    end;

    local os_clock_ret = os.clock();
    local u8 = nil;

    local function Cleanup() -- Line: 61
        -- upvalues: u8 (ref)
        if u8 then
            u8:Disconnect();
            u8 = nil;
        end;
    end;

    u8 = RunService.RenderStepped:Connect(function() -- Line: 69, Name: OnRenderStepped
        -- upvalues: os_clock_ret (copy), u6 (ref), u7 (copy), u8 (ref)
        local v9 = os.clock() - os_clock_ret;

        while u6 <= #u7 do
            local v10 = u7[u6];

            if v9 < v10.Frame / 60 then
                break;
            end;

            local success, result = pcall(v10.Callback);

            if not success then
                warn("[Sequencer] Callback Error: ", result);
            end;

            u6 = u6 + 1;
        end;

        if u6 > #u7 and u8 then
            u8:Disconnect();
            u8 = nil;
        end;
    end);

    return Cleanup;
end;