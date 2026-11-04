 

 

local Players = game:GetService("Players");
local u1 = setmetatable({}, {
    __mode = "k"
});

local function getCharacterAncestor(p2: userdata) -- Line: 5
    -- upvalues: Players (copy)
    while p2 and p2 ~= workspace do
        if p2:IsA("Model") and Players:GetPlayerFromCharacter(p2) then
            return p2;
        end;

        p2 = p2.Parent;
    end;

    return nil;
end;

return function(p3) -- Line: 16
    -- upvalues: getCharacterAncestor (copy), Players (copy), u1 (copy)
    local player = p3.player;
    local otherEmoteSounds = p3.setting:WaitForChild("otherEmoteSounds");

    local function isOtherEmoteSound(p4: userdata) -- Line: 20
        -- upvalues: getCharacterAncestor (ref), Players (ref), player (copy)
        if not p4:GetAttribute("EmoteAudio") then
            return false;
        end;

        local v5 = getCharacterAncestor(p4);

        if not v5 then
            return false;
        end;

        local PlayerFromCharacter = Players:GetPlayerFromCharacter(v5);
        local v6;

        if PlayerFromCharacter == nil then
            v6 = false;
        else
            v6 = PlayerFromCharacter ~= player;
        end;

        return v6;
    end;

    local function applyToSound(p7: userdata) -- Line: 34
        -- upvalues: getCharacterAncestor (ref), Players (ref), player (copy), otherEmoteSounds (copy), u1 (ref)
        local v8;

        if p7:GetAttribute("EmoteAudio") then
            local v9 = getCharacterAncestor(p7);

            if v9 then
                local PlayerFromCharacter = Players:GetPlayerFromCharacter(v9);

                if PlayerFromCharacter == nil then
                    v8 = false;
                else
                    v8 = PlayerFromCharacter ~= player;
                end;
            else
                v8 = false;
            end;
        else
            v8 = false;
        end;

        if not v8 then
            return;
        end;

        if otherEmoteSounds.Value then
            local v10 = u1[p7];

            if v10 ~= nil then
                p7.Volume = v10;
                u1[p7] = nil;
            end;
        else
            if u1[p7] == nil then
                u1[p7] = p7.Volume;
            end;

            p7.Volume = 0;
        end;
    end;

    local function refreshAll() -- Line: 53
        -- upvalues: getCharacterAncestor (ref), Players (ref), player (copy), otherEmoteSounds (copy), u1 (ref)
        for _, descendant in workspace:GetDescendants() do
            if descendant:IsA("Sound") then
                local v11;

                if descendant:GetAttribute("EmoteAudio") then
                    local v12 = getCharacterAncestor(descendant);

                    if v12 then
                        local PlayerFromCharacter = Players:GetPlayerFromCharacter(v12);

                        if PlayerFromCharacter == nil then
                            v11 = false;
                        else
                            v11 = PlayerFromCharacter ~= player;
                        end;
                    else
                        v11 = false;
                    end;
                else
                    v11 = false;
                end;

                if v11 then
                    if otherEmoteSounds.Value then
                        local v13 = u1[descendant];

                        if v13 ~= nil then
                            descendant.Volume = v13;
                            u1[descendant] = nil;
                        end;
                    else
                        if u1[descendant] == nil then
                            u1[descendant] = descendant.Volume;
                        end;

                        descendant.Volume = 0;
                    end;
                end;
            end;
        end;
    end;

    workspace.DescendantAdded:Connect(function(u14) -- Line: 61
        -- upvalues: getCharacterAncestor (ref), Players (ref), player (copy), otherEmoteSounds (copy), u1 (ref)
        if not u14:IsA("Sound") then
            return;
        end;

        task.defer(function() -- Line: 66
            -- upvalues: u14 (copy), getCharacterAncestor (ref), Players (ref), player (ref), otherEmoteSounds (ref), u1 (ref)
            if u14.Parent then
                local v15 = u14;
                local v16;

                if v15:GetAttribute("EmoteAudio") then
                    local v17 = getCharacterAncestor(v15);

                    if v17 then
                        local PlayerFromCharacter = Players:GetPlayerFromCharacter(v17);

                        if PlayerFromCharacter == nil then
                            v16 = false;
                        else
                            v16 = PlayerFromCharacter ~= player;
                        end;
                    else
                        v16 = false;
                    end;
                else
                    v16 = false;
                end;

                if not v16 then
                    return;
                end;

                if otherEmoteSounds.Value then
                    local v18 = u1[v15];

                    if v18 ~= nil then
                        v15.Volume = v18;
                        u1[v15] = nil;
                    end;
                else
                    if u1[v15] == nil then
                        u1[v15] = v15.Volume;
                    end;

                    v15.Volume = 0;
                end;
            end;
        end);
        u14:GetAttributeChangedSignal("EmoteAudio"):Connect(function() -- Line: 72
            -- upvalues: u14 (copy), getCharacterAncestor (ref), Players (ref), player (ref), otherEmoteSounds (ref), u1 (ref)
            if u14.Parent then
                local v19 = u14;
                local v20;

                if v19:GetAttribute("EmoteAudio") then
                    local v21 = getCharacterAncestor(v19);

                    if v21 then
                        local PlayerFromCharacter = Players:GetPlayerFromCharacter(v21);

                        if PlayerFromCharacter == nil then
                            v20 = false;
                        else
                            v20 = PlayerFromCharacter ~= player;
                        end;
                    else
                        v20 = false;
                    end;
                else
                    v20 = false;
                end;

                if not v20 then
                    return;
                end;

                if otherEmoteSounds.Value then
                    local v22 = u1[v19];

                    if v22 ~= nil then
                        v19.Volume = v22;
                        u1[v19] = nil;
                    end;
                else
                    if u1[v19] == nil then
                        u1[v19] = v19.Volume;
                    end;

                    v19.Volume = 0;
                end;
            end;
        end);
    end);
    otherEmoteSounds.Changed:Connect(refreshAll);
    refreshAll();
end;