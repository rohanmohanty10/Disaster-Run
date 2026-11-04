  

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local Utils = require(script.Parent.Utils);
local v1 = RunService:IsServer();
local u2 = RunService:IsClient();
local u3;

if Utils.ShouldMock then
    u3 = nil;
elseif v1 then
    u3 = Instance.new("Folder");
    u3.Name = "Remotes";
    u3.Parent = script.Parent.Parent;
else
    local Remotes = script.Parent.Parent:WaitForChild("Remotes", 60);
    u3 = assert(Remotes, "Did you forget to require the Replion module on the server?");
end;

local function get(p4: string) -- Line: 33
    -- upvalues: RunService (copy), u3 (ref), u2 (copy)
    local v5;

    if RunService:IsClient() then
        v5 = u3:WaitForChild(p4, 60);
    else
        v5 = u3:FindFirstChild(p4);
    end;

    if v5 then
        return v5;
    end;

    if u2 then
        error("Did you forget to require the Replion module on the server?");
    end;

    local RemoteEvent = Instance.new("RemoteEvent");
    RemoteEvent.Name = p4;
    RemoteEvent.Parent = u3;

    return RemoteEvent;
end;

return table.freeze({
    get = get,

    create = function(p6: table) -- Line: 48, Name: create
        -- upvalues: get (copy)
        for _, v in p6 do
            get(v);
        end;
    end,

    sendTo = function(p7: any, p8: string, ...) -- Line: 54, Name: sendTo
        -- upvalues: Utils (copy), get (copy), Players (copy)
        if Utils.ShouldMock then
            return;
        end;

        local v9 = get(p8);

        if p7 == "All" then
            v9:FireAllClients(...);

            return;
        end;

        if type(p7) == "table" then
            for _, v in p7 do
                if v:IsDescendantOf(Players) then
                    v9:FireClient(v, ...);
                end;
            end;

            return;
        end;

        if typeof(p7) == "Instance" and p7:IsA("Player") then
            v9:FireClient(p7, ...);

            return;
        end;

        error("Invalid replicateTo!");
    end
});