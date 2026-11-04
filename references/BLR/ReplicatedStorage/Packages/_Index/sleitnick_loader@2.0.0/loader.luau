  

local RunService = game:GetService("RunService");

return {
    LoadChildren = function(p1: userdata, p2: function?) -- Line: 49, Name: LoadChildren
        local v3 = {};

        for _, child in p1:GetChildren() do
            if child:IsA("ModuleScript") and (not p2 or p2(child)) then
                local v4 = require(child);
                v3[child.Name] = v4;
            end;
        end;

        return v3;
    end,

    LoadDescendants = function(p5: userdata, p6: function?) -- Line: 79, Name: LoadDescendants
        -- upvalues: RunService (copy)
        local v7 = {};

        for _, descendant in p5:GetDescendants() do
            if descendant:IsA("ModuleScript") and (not p6 or p6(descendant)) then
                local u8 = RunService:IsServer() and 5 or 1;
                local task_delay_ret = task.delay(u8, function() -- Line: 88
                    -- upvalues: descendant (copy), u8 (copy)
                    task.spawn(error, (`"{descendant.Name}" module took more than {u8}s to be required!`));
                end);
                local v9 = require(descendant);
                v7[descendant.Name] = v9;

                if coroutine.status(task_delay_ret) == "suspended" then
                    pcall(task.cancel, task_delay_ret);
                end;
            end;
        end;

        return v7;
    end,

    MatchesName = function(u10: string) -- Line: 113, Name: MatchesName
        return function(p11: userdata) -- Line: 114
            -- upvalues: u10 (copy)
            return p11.Name:match(u10) ~= nil;
        end;
    end,

    SpawnAll = function(p12: table, p13: string) -- Line: 141, Name: SpawnAll
        for i, v in p12 do
            local u14 = v[p13];

            if type(u14) == "function" then
                task.spawn(function() -- Line: 145
                    -- upvalues: i (copy), u14 (copy), v (copy)
                    debug.setmemorycategory(i);
                    u14(v);
                end);
            end;
        end;
    end
};