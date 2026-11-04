  

local v1 = {};
game:GetService("HttpService");
local Players = game:GetService("Players");
local PolicyService = game:GetService("PolicyService");
local AssetService = game:GetService("AssetService");
game:GetService("RunService");
local Utilities = require(script.Parent.Parent.Utilities);
local LaunchDataResolver = require(script.Parent.Parent.LaunchDataResolver);
local EngagementMarkers = require(script.Parent.Parent.EngagementMarkers);
local PlayerStats = require(script.Parent.Parent.PlayerStats);
local SocialHandler = require(script.Parent.SocialHandler);
local ServerGate = require(script.Parent.Parent.ServerGate);
local ServerClientInfoHandler = require(script.Parent.Parent.ServerClientInfoHandler);
local Cache = ServerGate:GetCache();
local u2 = {};

function v1.Init(p3) -- Line: 53
    -- upvalues: ServerGate (copy), Cache (copy), Utilities (copy), PolicyService (copy), LaunchDataResolver (copy), EngagementMarkers (copy), PlayerStats (copy), ServerClientInfoHandler (copy), Players (copy), SocialHandler (copy), u2 (copy), AssetService (copy)
    ServerGate:OnPlayerAdded(function(u4: userdata, p5: any) -- Line: 54
        -- upvalues: Cache (ref), Utilities (ref), PolicyService (ref), LaunchDataResolver (ref), EngagementMarkers (ref), PlayerStats (ref), ServerClientInfoHandler (ref)
        p5:Add(u4.CharacterRemoving:Connect(function(p6) -- Line: 56
            -- upvalues: Cache (ref), u4 (copy)
            Cache[u4] = p6.PrimaryPart and p6.PrimaryPart.Position or nil;
        end));
        local JoinData = u4:GetJoinData();

        if JoinData.SourceGameId ~= game.GameId then
            local v7 = Utilities.promiseReturn(1, function() -- Line: 66
                -- upvalues: PolicyService (ref), u4 (copy)
                return PolicyService:GetPolicyInfoForPlayerAsync(u4);
            end);
            local v8;

            if JoinData.ReferredByPlayerId then
                v8 = Utilities.promiseReturn(1, function() -- Line: 73
                    -- upvalues: u4 (copy), JoinData (copy)
                    return u4:IsFriendsWith(JoinData.ReferredByPlayerId);
                end);
            else
                v8 = nil;
            end;

            local u9 = {
                policyInfo = v7,
                publicServer = game.PrivateServerId == "",
                referrer = JoinData.ReferredByPlayerId and JoinData.ReferredByPlayerId ~= 0 and {
                    type = v8 and "friend" or "user",
                    id = JoinData.ReferredByPlayerId
                } or nil
            };
            LaunchDataResolver:OnResolved(u4, function(p10) -- Line: 87
                -- upvalues: u9 (copy), EngagementMarkers (ref), u4 (copy)
                if p10 then
                    if p10._gbDeeplink then
                        u9.referrer = {
                            type = "gamebeastDeeplink",
                            id = p10._gbDeeplink.deeplinkId
                        };
                    elseif not u9.referrer then
                        u9.referrer = {
                            type = "deeplink",
                            id = nil
                        };
                    end;
                end;

                EngagementMarkers:SDKMarker("Login", u9, {
                    position = nil,
                    player = u4
                });
            end);
            PlayerStats:OnDefaultStatsResolved(u4, function() -- Line: 105
                -- upvalues: ServerClientInfoHandler (ref), u4 (copy), PlayerStats (ref)
                ServerClientInfoHandler:UpdateClientData(u4, "joinTime", PlayerStats:GetStat(u4, "join_time"));
            end);
        end;
    end);
    Players.PlayerRemoving:Connect(function(p11) -- Line: 111
        -- upvalues: Cache (ref), ServerClientInfoHandler (ref), Utilities (ref), PlayerStats (ref), SocialHandler (ref), u2 (ref), EngagementMarkers (ref)
        local v12 = Cache[p11];
        local ClientInfo = ServerClientInfoHandler:GetClientInfo(p11, "joinTime");
        local v13 = Utilities.roundNum(os.time() - (ClientInfo or PlayerStats:GetStat(p11, "join_time")), 0.1);
        local TotalFriendPlaytime = SocialHandler:GetTotalFriendPlaytime(p11);
        local v14 = {
            sessionLength = v13
        };
        local v15;

        if TotalFriendPlaytime then
            v15 = Utilities.roundNum(TotalFriendPlaytime / v13, 0.01);
        else
            v15 = nil;
        end;

        v14.sessionLengthPercentageWithFriends = v15;
        local Stat = PlayerStats:GetStat(p11, "teleporting_to");

        if ServerClientInfoHandler:IsClientInfoResolved(p11) == true and (Stat and u2[Stat]) then
            EngagementMarkers:SDKMarker("PlaceTeleport", {
                sourcePlaceId = game.PlaceId,
                destinationPlaceId = Stat,
                sessionLength = Utilities.roundNum(os.time() - PlayerStats:GetStat(p11, "join_time"), 0.1)
            }, {
                player = p11,
                position = v12
            });

            return;
        end;

        EngagementMarkers:SDKMarker("Logout", v14, {
            player = p11,
            position = v12
        });
    end);
    task.spawn(function() -- Line: 140
        -- upvalues: AssetService (ref), u2 (ref), Utilities (ref)
        local success, result = pcall(function() -- Line: 142
            -- upvalues: AssetService (ref), u2 (ref)
            local GamePlacesAsync = AssetService:GetGamePlacesAsync();

            while true do
                for _, v in pairs(GamePlacesAsync:GetCurrentPage()) do
                    if not u2[v.PlaceId] then
                        u2[v.PlaceId] = v;
                    end;
                end;

                if GamePlacesAsync.IsFinished then
                    return;
                end;

                GamePlacesAsync:AdvanceToNextPageAsync();
            end;
        end);

        if not success then
            Utilities.GBWarn("Failed to get places in universe:", result);
        end;
    end);
end;

return v1;