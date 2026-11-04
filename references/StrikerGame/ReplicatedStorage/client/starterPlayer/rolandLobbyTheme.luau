 

 

local SoundService = game:GetService("SoundService");
local Teams = game:GetService("Teams");

return function(p1) -- Line: 4
    -- upvalues: SoundService (copy), Teams (copy)
    local player = p1.player;
    local otherEmoteSounds = p1.setting:WaitForChild("otherEmoteSounds");
    local SoundGroup = Instance.new("SoundGroup");
    SoundGroup.Name = "RolandLobbyThemeMute";
    SoundGroup.Volume = 0;
    SoundGroup.Parent = SoundService;

    local function apply(p2: userdata) -- Line: 13
        -- upvalues: player (copy), Teams (ref), otherEmoteSounds (copy), SoundGroup (copy)
        local v3 = p2:GetAttribute("Holder") == player.UserId;
        local v4;

        if player.Team == Teams.lobby then
            v4 = v3 or otherEmoteSounds.Value;
        else
            v4 = false;
        end;

        local v5;

        if v4 then
            v5 = nil;
        else
            v5 = SoundGroup;
        end;

        p2.SoundGroup = v5;
    end;

    local function apply_all() -- Line: 19
        -- upvalues: SoundService (ref), player (copy), Teams (ref), otherEmoteSounds (copy), SoundGroup (copy)
        for _, child in SoundService:GetChildren() do
            if child:IsA("Sound") and child.Name:find("^RolandLobbyTheme") then
                local v6 = child:GetAttribute("Holder") == player.UserId;
                local v7;

                if player.Team == Teams.lobby then
                    v7 = v6 or otherEmoteSounds.Value;
                else
                    v7 = false;
                end;

                local v8;

                if v7 then
                    v8 = nil;
                else
                    v8 = SoundGroup;
                end;

                child.SoundGroup = v8;
            end;
        end;
    end;

    SoundService.ChildAdded:Connect(function(u9) -- Line: 27
        -- upvalues: player (copy), Teams (ref), otherEmoteSounds (copy), SoundGroup (copy)
        if u9:IsA("Sound") and u9.Name:find("^RolandLobbyTheme") then
            local v10 = u9:GetAttribute("Holder") == player.UserId;
            local v11;

            if player.Team == Teams.lobby then
                v11 = v10 or otherEmoteSounds.Value;
            else
                v11 = false;
            end;

            local v12;

            if v11 then
                v12 = nil;
            else
                v12 = SoundGroup;
            end;

            u9.SoundGroup = v12;
            u9:GetAttributeChangedSignal("Holder"):Connect(function() -- Line: 30
                -- upvalues: u9 (copy), player (ref), Teams (ref), otherEmoteSounds (ref), SoundGroup (ref)
                local v13 = u9;
                local v14 = v13:GetAttribute("Holder") == player.UserId;
                local v15;

                if player.Team == Teams.lobby then
                    v15 = v14 or otherEmoteSounds.Value;
                else
                    v15 = false;
                end;

                local v16;

                if v15 then
                    v16 = nil;
                else
                    v16 = SoundGroup;
                end;

                v13.SoundGroup = v16;
            end);
        end;
    end);
    player:GetPropertyChangedSignal("Team"):Connect(apply_all);
    otherEmoteSounds.Changed:Connect(apply_all);
    apply_all();
end;