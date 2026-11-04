 

 

local Players = game:GetService("Players");
local u1 = {
    Keys = table.freeze({ "MusicVolume", "MusicMuted", "EmoteVolume", "EmoteSoundsMuted", "SpectatorHints", "ChatNotificationsEnabled", "AutoRollRunner", "QuestsSeen", "QuestsSeenKey", "QuestTrackerClosed", "HostButtonHidden", "PrivateInvitesOff", "HideBoardRank" })
};
local u2 = false;

function u1.start() -- Line: 25
    -- upvalues: u2 (ref), Players (copy), u1 (copy)
    if u2 then
        return;
    end;

    u2 = true;
    local LocalPlayer = Players.LocalPlayer;
    local SettingsEvent = script.Parent:WaitForChild("SettingsEvent");
    local u3 = false;
    local u4 = 0;

    local function queueSave() -- Line: 33
        -- upvalues: u3 (ref), u4 (ref), u1 (ref), LocalPlayer (copy), SettingsEvent (copy)
        if not u3 then
            return;
        end;

        u4 = u4 + 1;
        local u5 = u4;
        task.delay(1, function() -- Line: 39
            -- upvalues: u5 (copy), u4 (ref), u1 (ref), LocalPlayer (ref), SettingsEvent (ref)
            if u5 ~= u4 then
                return;
            end;

            local v6 = {};

            for _, v in u1.Keys do
                v6[v] = LocalPlayer:GetAttribute(v);
            end;

            SettingsEvent:FireServer("Save", v6);
        end);
    end;

    SettingsEvent.OnClientEvent:Connect(function(p7, p8) -- Line: 50
        -- upvalues: u3 (ref), LocalPlayer (copy), u1 (ref), u4 (ref), SettingsEvent (copy)
        if p7 ~= "Loaded" or (type(p8) ~= "table" or u3) then
            return;
        end;

        local Attribute = LocalPlayer:GetAttribute("QuestsSeenKey");

        for _, v in u1.Keys do
            if p8[v] ~= nil and (v ~= "QuestsSeenKey" or Attribute == nil) then
                LocalPlayer:SetAttribute(v, p8[v]);
            end;
        end;

        u3 = true;
        LocalPlayer:SetAttribute("SettingsLoaded", true);

        if not ((LocalPlayer:GetAttribute("QuestsSeen") ~= true or p8.QuestsSeen == true) and (Attribute == nil or p8.QuestsSeenKey == Attribute)) then
            if not u3 then
                return;
            end;

            u4 = u4 + 1;
            local u9 = u4;
            task.delay(1, function() -- Line: 39
                -- upvalues: u9 (copy), u4 (ref), u1 (ref), LocalPlayer (ref), SettingsEvent (ref)
                if u9 ~= u4 then
                    return;
                end;

                local v10 = {};

                for _, v in u1.Keys do
                    v10[v] = LocalPlayer:GetAttribute(v);
                end;

                SettingsEvent:FireServer("Save", v10);
            end);
        end;
    end);

    for _, v in u1.Keys do
        LocalPlayer:GetAttributeChangedSignal(v):Connect(queueSave);
    end;

    SettingsEvent:FireServer("Get");
end;

return u1;