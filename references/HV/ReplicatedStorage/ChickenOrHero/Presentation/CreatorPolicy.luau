 

 

local u2 = {
    PlayerBlockers = { "InMatch", "AdminTransferring", "ServerBrowserTransferring", "ScreenPresentationActive", "AdminRefreshActive", "GlobalWheelOpen", "FairPlayNoticeOpen" },

    authorized = function(p1) -- Line: 5, Name: authorized
        return p1:GetAttribute("CreatorAuthorized") == true and true or p1:GetAttribute("ContentTeam") == true;
    end
};

function u2.camera(p3) -- Line: 7
    -- upvalues: u2 (copy)
    return u2.authorized(p3) or p3:GetAttribute("PrivateServerHost") == true;
end;

function u2.lobby(p4, p5) -- Line: 8
    -- upvalues: u2 (copy)
    if not u2.camera(p4) or p4:GetAttribute("ClientReady") ~= true then
        return false;
    end;

    local v6;

    if p5:GetAttribute("GlobalPaused") == true then
        v6 = p5:GetAttribute("PauseExemptUserId") == p4.UserId and true or p5:GetAttribute("PauseFreesEveryone") == true;
    else
        v6 = false;
    end;

    if not v6 and (p4:GetAttribute("GameRole") or "Lobby") ~= "Lobby" then
        return false;
    end;

    local v7 = p5:GetAttribute("GlobalPaused") and not v6;

    if p5:GetAttribute("MapChanging") or v7 then
        return false;
    end;

    for _, v in u2.PlayerBlockers do
        if p4:GetAttribute(v) == true and (not v6 or v ~= "InMatch") then
            return false;
        end;
    end;

    return true;
end;

return table.freeze(u2);