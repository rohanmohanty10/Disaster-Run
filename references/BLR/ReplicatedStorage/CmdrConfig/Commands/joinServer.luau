  

local MessagingService = game:GetService("MessagingService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");
local TeleportService = game:GetService("TeleportService");
local ProfileManager = require(ServerScriptService.Profile.ProfileManager);
local Promise = require(ReplicatedStorage.Packages.Promise);
local u1 = {};
task.spawn(function() -- Line: 14
    -- upvalues: MessagingService (copy), Players (copy), u1 (copy)
    MessagingService:SubscribeAsync("JoinServerQuery", function(p2) -- Line: 15
        -- upvalues: Players (ref), MessagingService (ref), u1 (ref)
        local Data = p2.Data;

        if Data.from ~= nil then
            if Players:GetPlayerByUserId(Data.userId) and game.PrivateServerId == "" then
                MessagingService:PublishAsync("JoinServerQuery", {
                    userId = Data.userId,
                    to = Data.from,
                    jobId = game.JobId
                });
            end;

            return;
        end;

        if Data.to ~= game.JobId or u1[Data.userId] == nil then
            return;
        end;

        u1[Data.userId](Data.jobId);
        u1[Data.userId] = nil;
    end);
end);

return function(u3, u4) -- Line: 36
    -- upvalues: Promise (copy), u1 (copy), MessagingService (copy), ProfileManager (copy), TeleportService (copy)
    local success, result = pcall(function() -- Line: 37
        -- upvalues: u4 (copy)
        return game.Players:GetUserIdFromNameAsync(u4);
    end);
    print(success, result);

    if not (success and result) then
        return `{u4} is not a valid player name.`;
    end;

    u3:Reply("Querying, please wait...");
    local _, v6 = Promise.any({ Promise.delay(5), Promise.new(function(p5) -- Line: 50
            -- upvalues: u1 (ref), result (copy), MessagingService (ref)
            u1[result] = p5;
            MessagingService:PublishAsync("JoinServerQuery", {
                userId = result,
                from = game.JobId
            });
        end) }):await();
    u1[result] = nil;

    if typeof(v6) == "number" then
        return "User doesn\'t seem to be playing the game or is in an unreachable server.";
    end;

    local TeleportOptions = Instance.new("TeleportOptions");
    TeleportOptions.ServerInstanceId = v6;
    ProfileManager.Profiles[u3.Executor].Teleporting = true;
    ProfileManager.Profiles[u3.Executor]:ListenToHopReady(function() -- Line: 68
        -- upvalues: u3 (copy), TeleportService (ref), TeleportOptions (copy)
        task.spawn(function() -- Line: 69
            -- upvalues: u3 (ref), TeleportService (ref), TeleportOptions (ref)
            while u3.Executor:IsDescendantOf(game) do
                u3.Executor:SetAttribute("TeleportingToPlace", true);
                pcall(function() -- Line: 77
                    -- upvalues: TeleportService (ref), u3 (ref), TeleportOptions (ref)
                    TeleportService:TeleportAsync(game.PlaceId, { u3.Executor }, TeleportOptions);
                end);
                task.wait(5);
            end;
        end);
    end);
    ProfileManager.Profiles[u3.Executor]:Release();

    return "Off you go! We\'ll keep trying to teleport you until you get into the server, sit tight!";
end;