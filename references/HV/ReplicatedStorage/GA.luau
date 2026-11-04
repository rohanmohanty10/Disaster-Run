 

 

local function waitForDependency(p1: userdata, p2: string) -- Line: 19
    local v3 = p1:WaitForChild(p2, 30);
    local v4 = "[GA] Missing SDK dependency " .. p1:GetFullName() .. "." .. p2 .. " after 30s; install the complete GA package.";
    assert(v3, v4);

    return v3;
end;

if game:GetService("RunService"):IsServer() then
    local l_require = require;
    local l_script = script;
    local Server = l_script:WaitForChild("Server", 30);
    local v5 = "[GA] Missing SDK dependency " .. l_script:GetFullName() .. ".Server after 30s; install the complete GA package.";
    assert(Server, v5);
    local ServerAnalytics = Server:WaitForChild("ServerAnalytics", 30);
    local v6 = "[GA] Missing SDK dependency " .. Server:GetFullName() .. ".ServerAnalytics after 30s; install the complete GA package.";
    assert(ServerAnalytics, v6);

    return l_require(ServerAnalytics);
end;

local l_require = require;
local l_script = script;
local Client = l_script:WaitForChild("Client", 30);
local v7 = "[GA] Missing SDK dependency " .. l_script:GetFullName() .. ".Client after 30s; install the complete GA package.";
assert(Client, v7);
local ClientAnalytics = Client:WaitForChild("ClientAnalytics", 30);
local v8 = "[GA] Missing SDK dependency " .. Client:GetFullName() .. ".ClientAnalytics after 30s; install the complete GA package.";
assert(ClientAnalytics, v8);

return l_require(ClientAnalytics);