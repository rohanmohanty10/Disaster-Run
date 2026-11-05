 

 

local l__InGameExplorer_Shared__1 = game:GetService("ReplicatedStorage"):WaitForChild("InGameExplorer_Shared");
local l__Maid__2 = require(l__InGameExplorer_Shared__1:WaitForChild("InGameExplorerShared"):WaitForChild("Maid"));
local l__InGameExplorer_RemoteFunction__3 = l__InGameExplorer_Shared__1:WaitForChild("InGameExplorer_RemoteFunction");
local l__InGameExplorer_RemoteEvent__4 = l__InGameExplorer_Shared__1:WaitForChild("InGameExplorer_RemoteEvent");
local l__InGameExplorerShared__5 = require(l__InGameExplorer_Shared__1:WaitForChild("InGameExplorerShared"));
local l__Replicator__6 = require(l__InGameExplorer_Shared__1:WaitForChild("Replicator"));
local l__LogShared__7 = require(l__InGameExplorer_Shared__1:WaitForChild("LogShared"));
local v1, _ = unpack(l__InGameExplorer_RemoteFunction__3:InvokeServer());
local u2 = l__Replicator__6.new(l__InGameExplorer_RemoteEvent__4, l__InGameExplorer_RemoteFunction__3, v1, l__InGameExplorerShared__5);
local l__vLuau__8 = require(script.vLuau);
local u3 = {};
l__InGameExplorer_RemoteEvent__4.OnClientEvent:Connect(function(u4, p5, ...) --[[ Line: 21 ]]
    -- upvalues: l__vLuau__8 (copy), u3 (copy), l__Maid__2 (copy), l__LogShared__7 (copy), l__InGameExplorer_RemoteEvent__4 (copy), u2 (copy)
    if p5 == "SendCode" then
        l__vLuau__8((...))();
    elseif p5 == "AdminListen" then
        if u3[u4] then
            return;
        end;
        local v6 = {
            maid = l__Maid__2.new()
        };
        l__InGameExplorer_RemoteEvent__4:FireServer("InitHistory", u4, (l__LogShared__7:GetHistory()));
        l__LogShared__7:AddEvent(v6.maid, function(p7) --[[ Line: 38 ]]
            -- upvalues: l__InGameExplorer_RemoteEvent__4 (ref), u4 (copy)
            l__InGameExplorer_RemoteEvent__4:FireServer("LogHistoryEntry", u4, p7);
        end);
        u3[u4] = v6;
    elseif p5 == "AdminStoppedListening" and u3[u4] then
        u3[u4].maid:Cleanup();
        u3[u4] = nil;
    end;
    if u2[p5] then
        u2[p5](u2, u4, ...);
    end;
end);