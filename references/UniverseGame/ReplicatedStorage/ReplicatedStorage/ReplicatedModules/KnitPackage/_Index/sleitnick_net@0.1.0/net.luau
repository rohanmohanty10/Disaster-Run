  

 

local RunService = game:GetService("RunService");

return {
    RemoteEvent = function(p1, p2) -- Line: 25, Name: RemoteEvent
        -- upvalues: RunService (copy)
        local v3 = "RE/" .. p2;

        if RunService:IsServer() then
            local v4 = script:FindFirstChild(v3);

            if not v4 then
                v4 = Instance.new("RemoteEvent");
                v4.Name = v3;
                v4.Parent = script;
            end;

            return v4;
        end;

        local v5 = script:WaitForChild(v3, 999);

        if not v5 then
            error("Failed to find RemoteEvent: " .. v3, 2);
        end;

        return v5;
    end,

    Connect = function(p6, p7, p8) -- Line: 57, Name: Connect
        -- upvalues: RunService (copy)
        if RunService:IsServer() then
            return p6:RemoteEvent(p7).OnServerEvent:Connect(p8);
        end;

        return p6:RemoteEvent(p7).OnClientEvent:Connect(p8);
    end,

    RemoteFunction = function(p9, p10) -- Line: 80, Name: RemoteFunction
        -- upvalues: RunService (copy)
        local v11 = "RF/" .. p10;

        if RunService:IsServer() then
            local v12 = script:FindFirstChild(v11);

            if not v12 then
                v12 = Instance.new("RemoteFunction");
                v12.Name = v11;
                v12.Parent = script;
            end;

            return v12;
        end;

        local v13 = script:WaitForChild(v11, 10);

        if not v13 then
            error("Failed to find RemoteFunction: " .. v11, 2);
        end;

        return v13;
    end,

    Handle = function(p14, p15, p16) -- Line: 109, Name: Handle
        p14:RemoteFunction(p15).OnServerInvoke = p16;
    end,

    Invoke = function(p17, p18, ...) -- Line: 121, Name: Invoke
        return p17:RemoteFunction(p18):InvokeServer(...);
    end,

    Clean = function(p19) -- Line: 131, Name: Clean
        script:ClearAllChildren();
    end
};