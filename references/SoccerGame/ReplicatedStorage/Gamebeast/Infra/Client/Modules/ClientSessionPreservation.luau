  

local v1 = {};
game:GetService("ReplicatedStorage");
local TeleportService = game:GetService("TeleportService");
require(script.Parent.Parent.Parent.Shared.Modules.Signal);
require(script.Parent.Parent.Parent.Shared.Modules.GetRemote);
local u2 = {
    sessionId = true,
    joinTime = true,
    friendClockStart = true,
    hasFriendsOnline = true,
    totalFriendPlaytime = true
};

function v1.UpdateStoredData(p3: table, p4: string, p5: any) -- Line: 45
    -- upvalues: u2 (copy), TeleportService (copy)
    if u2[p4] == nil then
        return;
    end;

    local StoredData = p3:GetStoredData();
    StoredData[p4] = p5;
    TeleportService:SetTeleportSetting("GAMEBEAST_SESSION", StoredData);
end;

function v1.GetStoredData(p6) -- Line: 56
    -- upvalues: TeleportService (copy)
    return TeleportService:GetTeleportSetting("GAMEBEAST_SESSION") or {};
end;

return v1;