 

 

local CollectionService = game:GetService("CollectionService");
game:GetService("RunService");
game:GetService("Debris");
local v1 = {};

local function Cleanup(u2) -- Line: 8
    -- upvalues: Cleanup (copy)
    local v3 = typeof(u2);

    if v3 ~= "table" then
        if v3 == "RBXScriptConnection" then
            u2:Disconnect();
        elseif v3 == "Instance" then
            if u2:IsA("Tween") then
                u2:Pause();
            elseif u2:IsA("AnimationTrack") then
                u2:Stop();
            end;

            u2:Destroy();
        elseif v3 == "thread" then
            if table.find({ "running", "dead" }, coroutine.status(u2)) then
                print("Failed to Cancel a running or dead task");
            else
                task.cancel(u2);
            end;
        elseif v3 == "userdata" then
            if type(u2.Destroy) == "function" then
                pcall(function() -- Line: 46
                    -- upvalues: u2 (ref)
                    u2:Destroy();
                end);
            end;
        elseif v3 == "function" then
            local success, result = pcall(u2);

            if not success then
                warn("Error executing function:", result);
            end;
        end;

        return;
    end;

    for i, v in ipairs(u2) do
        Cleanup(v);
        u2[i] = nil;
    end;

    table.clear(u2);
end;

function v1.ClearTemp(u4: any, p5: number) -- Line: 61
    -- upvalues: Cleanup (copy)
    if typeof(p5) == "number" then
        task.delay(p5, function() -- Line: 63
            -- upvalues: Cleanup (ref), u4 (ref)
            Cleanup(u4);
            u4 = nil;
        end);
    else
        Cleanup(u4);
    end;
end;

function v1.GetDebris(p6) -- Line: 74
    -- upvalues: CollectionService (copy)
    return CollectionService:GetTagged(p6.Name .. "\'s Debris");
end;

function v1.RemoveDebris(p7) -- Line: 79
    -- upvalues: CollectionService (copy)
    for _, v in CollectionService:GetTagged(p7.Name .. "\'s Debris") do
        v:Destroy();
    end;
end;

function v1.SetDebris(p8: any, p9: userdata) -- Line: 86
    if typeof(p9) == "Instance" then
        p9:AddTag(p8.Name .. "\'s Debris");

        return;
    end;

    if typeof(p9) == "table" then
        for _, v in p9 do
            if typeof(v) == "Instance" then
                v:AddTag(p8.Name .. "\'s Debris");
            end;
        end;
    end;
end;

return v1;