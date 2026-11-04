  

local v1 = {};
local Players = game:GetService("Players");
local ClientInfoHandler = require(script.Parent.ClientInfoHandler);
local u2 = {};
local u3 = 0;

local function UpdateFriendCache() -- Line: 39
    -- upvalues: Players (copy), u2 (copy), ClientInfoHandler (copy), u3 (ref)
    local u4 = 0;
    local success, result = pcall(function() -- Line: 41
        -- upvalues: Players (ref), u4 (ref), u2 (ref)
        local FriendsAsync = Players:GetFriendsAsync(Players.LocalPlayer.UserId);

        while true do
            local CurrentPage = FriendsAsync:GetCurrentPage();

            for _, v in ipairs(CurrentPage) do
                if Players:GetPlayerByUserId(v.Id) then
                    u4 = u4 + 1;
                end;

                u2[v.Id] = true;
            end;

            if FriendsAsync.IsFinished then
                return;
            end;

            FriendsAsync:AdvanceToNextPageAsync();
        end;
    end);
    local v5 = ClientInfoHandler:GetClientInfo("hasFriendsOnline") or false;

    if v5 == true and u4 <= 0 then
        ClientInfoHandler:UpdateClientInfo("totalFriendPlaytime", (ClientInfoHandler:GetClientInfo("totalFriendPlaytime") or 0) + os.time() - ClientInfoHandler:GetClientInfo("friendClockStart"));
    elseif u4 > 0 and v5 == false then
        ClientInfoHandler:UpdateClientInfo("friendClockStart", os.time());
    end;

    u3 = u4;
    ClientInfoHandler:UpdateClientInfo("hasFriendsOnline", u3 > 0);

    return success, result;
end;

function v1.Init(p6) -- Line: 80
    -- upvalues: Players (copy), u2 (copy), u3 (ref), UpdateFriendCache (copy)
    task.spawn(function() -- Line: 81
        -- upvalues: Players (ref), u2 (ref), u3 (ref), UpdateFriendCache (ref)
        Players.PlayerAdded:Connect(function(p7: userdata) -- Line: 82
            -- upvalues: u2 (ref), u3 (ref)
            if u2[p7.UserId] then
                u3 = u3 + 1;
            end;
        end);
        Players.PlayerRemoving:Connect(function(p8: userdata) -- Line: 88
            -- upvalues: u2 (ref), u3 (ref)
            if u2[p8.UserId] then
                u3 = u3 - 1;
            end;
        end);
        UpdateFriendCache();

        while task.wait(600) do
            UpdateFriendCache();
        end;
    end);
end;

return v1;