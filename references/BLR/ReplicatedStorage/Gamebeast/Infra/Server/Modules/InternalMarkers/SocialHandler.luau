  

local v1 = {};
game:GetService("Players");
require(script.Parent.Parent.EngagementMarkers);
local ServerClientInfoHandler = require(script.Parent.Parent.ServerClientInfoHandler);
local PlayerStats = require(script.Parent.Parent.PlayerStats);
local ServerGate = require(script.Parent.Parent.ServerGate);
local Cache = ServerGate:GetCache();

local function CreateCacheEntry(p2: userdata) -- Line: 41
    -- upvalues: Cache (copy)
    local v3 = {
        LastClientUpdate = 0
    };
    Cache[p2] = v3;

    return v3;
end;

function v1.GetTotalFriendPlaytime(p4: table, p5: userdata) -- Line: 53
    -- upvalues: Cache (copy), ServerClientInfoHandler (copy)
    local v6 = Cache[p5];

    if v6 == nil or ServerClientInfoHandler:IsClientInfoResolved(p5) == false then
        return nil;
    end;

    Cache[p5] = nil;
    local ClientInfo = ServerClientInfoHandler:GetClientInfo(p5, "hasFriendsOnline");
    local ClientInfo2 = ServerClientInfoHandler:GetClientInfo(p5, "totalFriendPlaytime");

    if ClientInfo then
        return ClientInfo2 + (os.time() - v6.LastClientUpdate);
    end;

    return ClientInfo2;
end;

function v1.Init(p7) -- Line: 72
    -- upvalues: ServerGate (copy), Cache (copy), ServerClientInfoHandler (copy), PlayerStats (copy)
    ServerGate:OnPlayerAdded(function(u8: userdata, p9: any) -- Line: 73
        -- upvalues: Cache (ref), ServerClientInfoHandler (ref), PlayerStats (ref)
        local u10 = {
            LastClientUpdate = 0
        };
        Cache[u8] = u10;
        p9:Add(ServerClientInfoHandler:OnClientInfoChanged(u8, function(p11, p12) -- Line: 76
            -- upvalues: u10 (copy)
            if p11 == "friendClockStart" then
                u10.LastClientUpdate = os.time();
            end;
        end));
        local u13 = 0;
        p9:Add(u8.OnTeleport:Connect(function(p14, p15) -- Line: 83
            -- upvalues: PlayerStats (ref), u8 (copy), u13 (ref)
            if p14 ~= Enum.TeleportState.RequestedFromServer then
                if p14 == Enum.TeleportState.Failed then
                    u13 = u13 - 1;

                    if u13 <= 0 then
                        PlayerStats:SetStat(u8, "teleporting_to", nil);
                    end;
                end;

                return;
            end;

            PlayerStats:SetStat(u8, "teleporting_to", p15);
            u13 = u13 + 1;
        end));
    end);
end;

return v1;