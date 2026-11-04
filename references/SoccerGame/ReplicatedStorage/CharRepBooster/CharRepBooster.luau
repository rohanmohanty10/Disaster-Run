  

local RunService = game:GetService("RunService");
local u5 = {
    GetServerComponent = function(p1) -- Line: 25, Name: GetServerComponent
        -- upvalues: RunService (copy)
        local v2 = RunService:IsServer();
        assert(v2, "Server Component can only be utilized on the server");

        return require(script.Components.ServerComponent);
    end,

    GetClientComponent = function(p3) -- Line: 30, Name: GetClientComponent
        -- upvalues: RunService (copy)
        local v4 = RunService:IsClient();
        assert(v4, "Client Component can only be utilized on the client");

        return require(script.Components.ClientComponent);
    end
};
task.defer(function() -- Line: 35
    -- upvalues: RunService (copy), u5 (copy)
    if RunService:IsServer() then
        u5:GetServerComponent();

        return;
    end;

    u5:GetClientComponent();
end);

return u5;