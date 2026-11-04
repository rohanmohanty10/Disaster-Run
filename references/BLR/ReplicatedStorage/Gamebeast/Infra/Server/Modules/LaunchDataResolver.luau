  

local v1 = {};
local HttpService = game:GetService("HttpService");
game:GetService("Players");
local RunService = game:GetService("RunService");
local Utilities = require(script.Parent.Utilities);
local Signal = require(script.Parent.Parent.Parent.Shared.Modules.Signal);
local ServerGate = require(script.Parent.ServerGate);
local u2 = Signal.new();
local u3 = {};
local u4 = {};

function ResolveData(p5: userdata, p6: any)
    -- upvalues: u3 (copy), u4 (copy), u2 (copy)
    u3[p5] = true;
    u4[p5] = p6;
    u2:Fire(p5, p6);
end;

function v1.OnResolved(p7: table, u8: userdata, u9: function) -- Line: 53
    -- upvalues: u3 (copy), u4 (copy), u2 (copy)
    if u3[u8] then
        task.spawn(function() -- Line: 55
            -- upvalues: u9 (copy), u4 (ref), u8 (copy)
            u9(u4[u8]);
        end);

        return nil;
    end;

    local u10 = nil;
    u10 = u2:Connect(function(p11: userdata, p12: any) -- Line: 62
        -- upvalues: u8 (copy), u10 (ref), u9 (copy)
        if u8 ~= p11 then
            return;
        end;

        u10:Disconnect();
        u9(p12);
    end);

    return u10;
end;

function v1.Init(p13) -- Line: 73
    -- upvalues: Utilities (copy), RunService (copy), HttpService (copy), ServerGate (copy), u4 (copy), u3 (copy)
    Utilities:OnPlayerAdded(function(p14: userdata) -- Line: 74
        -- upvalues: RunService (ref), HttpService (ref), Utilities (ref)
        if RunService:IsStudio() then
            ResolveData(p14, nil);

            return;
        end;

        local LaunchData = p14:GetJoinData().LaunchData;
        local v15 = 0;

        while v15 < 10 and LaunchData == "" do
            task.wait(0.5);
            v15 = v15 + 1;
            LaunchData = p14:GetJoinData().LaunchData;
        end;

        if LaunchData ~= "" then
            local success, result = pcall(function() -- Line: 96
                -- upvalues: LaunchData (ref)
                return game:GetService("EncodingService"):Base64Decode(buffer.fromstring(LaunchData));
            end);

            local function decodeJson(u16: string) -- Line: 100
                -- upvalues: HttpService (ref)
                return pcall(function() -- Line: 101
                    -- upvalues: HttpService (ref), u16 (copy)
                    return HttpService:JSONDecode(u16);
                end);
            end;

            local v17;

            if success then
                v17 = { buffer.tostring(result), LaunchData };
            else
                v17 = { LaunchData };
            end;

            local v18 = nil;

            for _, v in v17 do
                local v19;
                v19, v18 = pcall(function() -- Line: 101
                    -- upvalues: HttpService (ref), v (copy)
                    return HttpService:JSONDecode(v);
                end);

                if v19 then
                    ResolveData(p14, v18);

                    return;
                end;
            end;

            Utilities.GBLog("Failed to decode launch data JSON for player " .. p14.Name .. ": " .. tostring(v18));
        end;

        ResolveData(p14, nil);
    end);
    ServerGate:OnPlayerRemoved(function(p20) -- Line: 129
        -- upvalues: u4 (ref), u3 (ref)
        u4[p20] = nil;
        u3[p20] = nil;
    end);
end;

return v1;