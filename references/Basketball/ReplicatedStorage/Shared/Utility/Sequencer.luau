 
 

local RunService = game:GetService("RunService");

local function NormalizeSteps(p1: table) -- Line: 25
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

    table.sort(v2, function(p3, p4) -- Line: 42
        return p3.Frame < p4.Frame;
    end);

    return v2;
end;

return function(p5: table, p6: table?) -- Line: 54
    -- upvalues: NormalizeSteps (copy), RunService (copy)
    local v7 = p6 or {};
    local u8 = v7.FPS or 60;
    local v9 = v7.PassedTime or 0;
    local u10 = 1;
    local u11 = NormalizeSteps(p5);

    if #u11 == 0 then
        return function() -- Line: 64
        end;
    end;

    local u12 = os.clock() - v9;
    local u13 = nil;

    local function Cleanup() -- Line: 70
        -- upvalues: u13 (ref)
        if u13 then
            u13:Disconnect();
            u13 = nil;
        end;
    end;

    u13 = RunService.RenderStepped:Connect(function() -- Line: 78, Name: OnRenderStepped
        -- upvalues: u12 (copy), u10 (ref), u11 (copy), u8 (copy), u13 (ref)
        local v14 = os.clock() - u12;

        while u10 <= #u11 do
            local v15 = u11[u10];

            if v14 < v15.Frame / u8 then
                break;
            end;

            local success, result = pcall(v15.Callback);

            if not success then
                warn("[Sequencer] Callback Error: ", result, v15);
            end;

            u10 = u10 + 1;
        end;

        if u10 > #u11 and u13 then
            u13:Disconnect();
            u13 = nil;
        end;
    end);

    return Cleanup;
end;