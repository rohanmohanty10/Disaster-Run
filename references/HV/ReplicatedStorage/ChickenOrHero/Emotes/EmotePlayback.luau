 

 

local EmoteCatalog = require(script.Parent.EmoteCatalog);
local u1 = {};
local u2 = {};

function u1.loop(u3) -- Line: 8
    u3.Looped = true;

    if u3.Length > 0 then
        return;
    end;

    task.spawn(function() -- Line: 11
        -- upvalues: u3 (copy)
        local v4 = os.clock() + 10;

        while u3.Length <= 0 and os.clock() < v4 do
            task.wait(0.1);
        end;

        u3.Looped = true;
    end);
end;

function u1.once(u5) -- Line: 18
    u5.Looped = false;

    if u5.Length > 0 then
        return;
    end;

    task.spawn(function() -- Line: 21
        -- upvalues: u5 (copy)
        local v6 = os.clock() + 10;

        while u5.Length <= 0 and os.clock() < v6 do
            task.wait(0.1);
        end;

        u5.Looped = false;
    end);
end;

local u7 = {};

function u1.preload(p8) -- Line: 32
    -- upvalues: u7 (copy)
    if u7[p8] then
        return;
    end;

    u7[p8] = true;
    local Animation = Instance.new("Animation");
    Animation.AnimationId = p8;
    pcall(function() -- Line: 36
        -- upvalues: Animation (copy)
        local v9 = { Animation };
        game:GetService("ContentProvider"):PreloadAsync(v9);
    end);
    Animation:Destroy();
end;

local u10 = false;

function u1.watch() -- Line: 40
    -- upvalues: u10 (ref), EmoteCatalog (copy), u1 (copy)
    if u10 or not game:GetService("RunService"):IsClient() then
        return;
    end;

    u10 = true;
    local u11 = {};
    local u12 = {};
    local u13 = {};
    local u14 = {};

    for _, v in EmoteCatalog.Entries do
        local v15 = EmoteCatalog.assetId(v.Id);

        if v15 then
            u11[v15] = true;

            if v.Knife or (v.Kind or v.Prop) then
                u13[v15] = true;
            end;

            if v.Cheers then
                u14[v15] = v.Id;
            end;
        end;

        local v16 = EmoteCatalog.introId(v.Id);

        if v16 then
            u12[v16] = v15 or true;
        end;
    end;

    local function cheering(u17, p18, u19) -- Line: 50
        -- upvalues: EmoteCatalog (ref)
        local HumanoidRootPart = u17:FindFirstChild("HumanoidRootPart");

        if not HumanoidRootPart or #EmoteCatalog.Cheers == 0 then
            return;
        end;

        local Sound = Instance.new("Sound");
        Sound.Name = "EmoteCheer";
        Sound.Volume = EmoteCatalog.CheerVolume;
        Sound.RollOffMaxDistance = 80;
        Sound.Parent = HumanoidRootPart;
        local u20 = {};
        table.insert(u20, p18.DidLoop:Connect(function() -- Line: 54, Name: cheer
            -- upvalues: Sound (copy), EmoteCatalog (ref)
            Sound.SoundId = "rbxassetid://" .. EmoteCatalog.Cheers[math.random(1, #EmoteCatalog.Cheers)];
            Sound.TimePosition = 0;
            Sound:Play();
        end));
        table.insert(u20, p18.Stopped:Connect(function() -- Line: 58, Name: finish
            -- upvalues: u20 (copy), Sound (copy)
            for _, v in u20 do
                v:Disconnect();
            end;

            table.clear(u20);
            Sound:Destroy();
        end));
        local AttributeChangedSignal = u17:GetAttributeChangedSignal("EmoteId");
        table.insert(u20, AttributeChangedSignal:Connect(function() -- Line: 63
            -- upvalues: u17 (copy), u19 (copy), u20 (copy), Sound (copy)
            if u17:GetAttribute("EmoteId") ~= u19 then
                for _, v in u20 do
                    v:Disconnect();
                end;

                table.clear(u20);
                Sound:Destroy();
            end;
        end));
        table.insert(u20, u17.AncestryChanged:Connect(function() -- Line: 64
            -- upvalues: u17 (copy), u20 (copy), Sound (copy)
            if not u17.Parent then
                for _, v in u20 do
                    v:Disconnect();
                end;

                table.clear(u20);
                Sound:Destroy();
            end;
        end));
        Sound.SoundId = "rbxassetid://" .. EmoteCatalog.Cheers[math.random(1, #EmoteCatalog.Cheers)];
        Sound.TimePosition = 0;
        Sound:Play();
    end;

    local function asEmote(p21, p22, p23) -- Line: 67
        -- upvalues: EmoteCatalog (ref), u1 (ref), u14 (copy), cheering (copy)
        local v24 = os.clock() + 0.5;

        while os.clock() < v24 and p22.IsPlaying do
            local Attribute = p21:GetAttribute("EmoteId");

            if type(Attribute) == "string" and EmoteCatalog.assetId(Attribute) == p23 then
                u1.loop(p22);

                if u14[p23] == Attribute then
                    cheering(p21, p22, Attribute);
                end;

                return;
            end;

            task.wait(0.05);
        end;
    end;

    local function bind(u25) -- Line: 79
        -- upvalues: u12 (copy), u1 (ref), u11 (copy), u13 (copy), asEmote (copy)
        local Humanoid = u25:WaitForChild("Humanoid", 10);

        if Humanoid then
            Humanoid = Humanoid:WaitForChild("Animator", 10);
        end;

        if not Humanoid then
            return;
        end;

        Humanoid.AnimationPlayed:Connect(function(p26) -- Line: 82
            -- upvalues: u12 (ref), u1 (ref), u11 (ref), u13 (ref), asEmote (ref), u25 (copy)
            local Animation = p26.Animation;

            if Animation then
                Animation = Animation.AnimationId;
            end;

            if Animation and u12[Animation] then
                u1.once(p26);

                if type(u12[Animation]) == "string" then
                    task.spawn(u1.preload, u12[Animation]);
                end;

                return;
            end;

            if not (Animation and u11[Animation]) then
                return;
            end;

            if u13[Animation] then
                task.spawn(asEmote, u25, p26, Animation);

                return;
            end;

            u1.loop(p26);
        end);
    end;

    local Players = game:GetService("Players");

    local function joined(p27) -- Line: 97
        -- upvalues: bind (copy)
        if p27.Character then
            task.spawn(bind, p27.Character);
        end;

        p27.CharacterAdded:Connect(function(p28) -- Line: 99
            -- upvalues: bind (ref)
            task.spawn(bind, p28);
        end);
    end;

    for _, v in Players:GetPlayers() do
        if v.Character then
            task.spawn(bind, v.Character);
        end;

        v.CharacterAdded:Connect(function(p29) -- Line: 99
            -- upvalues: bind (copy)
            task.spawn(bind, p29);
        end);
    end;

    Players.PlayerAdded:Connect(joined);

    local function fetchOwned(p30) -- Line: 108
        -- upvalues: EmoteCatalog (ref), u1 (ref)
        if type(p30) ~= "table" then
            return;
        end;

        for i, v in p30 do
            local v31;

            if v == true then
                v31 = EmoteCatalog.get(i);
            else
                v31 = false;
            end;

            if v31 and typeof(v31.HidePieces) == "CFrame" then
                local v32 = EmoteCatalog.introId(i);
                local v33 = EmoteCatalog.assetId(i);

                if v32 then
                    task.spawn(u1.preload, v32);
                end;

                if v33 then
                    task.spawn(u1.preload, v33);
                end;
            end;
        end;
    end;

    local function listen(u34, u35, u36) -- Line: 119
        -- upvalues: fetchOwned (copy)
        task.spawn(function() -- Line: 120
            -- upvalues: u34 (copy), u35 (copy), fetchOwned (ref), u36 (copy)
            local v37 = u34 and u34:WaitForChild(u35, 30);

            if v37 then
                v37.OnClientEvent:Connect(function(p38, p39) -- Line: 123
                    -- upvalues: fetchOwned (ref), u36 (ref)
                    if p38 == "State" and type(p39) == "table" then
                        fetchOwned(p39[u36]);
                    end;
                end);

                return;
            end;

            warn("EmotePlayback: no " .. u35 .. ", owned emotes\' clips aren\'t fetched ahead");
        end);
    end;

    local script_Parent = script.Parent;
    local u40 = "EmoteEvent";
    local u41 = "owned";
    task.spawn(function() -- Line: 120
        -- upvalues: script_Parent (copy), u40 (copy), fetchOwned (copy), u41 (copy)
        local v42 = script_Parent and script_Parent:WaitForChild(u40, 30);

        if v42 then
            v42.OnClientEvent:Connect(function(p43, p44) -- Line: 123
                -- upvalues: fetchOwned (ref), u41 (ref)
                if p43 == "State" and type(p44) == "table" then
                    fetchOwned(p44[u41]);
                end;
            end);

            return;
        end;

        warn("EmotePlayback: no " .. u40 .. ", owned emotes\' clips aren\'t fetched ahead");
    end);
    local Weapons = script.Parent.Parent:FindFirstChild("Weapons");
    local u45 = "ArmoryEvent";
    local u46 = "emotes";
    task.spawn(function() -- Line: 120
        -- upvalues: Weapons (copy), u45 (copy), fetchOwned (copy), u46 (copy)
        local v47 = Weapons and Weapons:WaitForChild(u45, 30);

        if v47 then
            v47.OnClientEvent:Connect(function(p48, p49) -- Line: 123
                -- upvalues: fetchOwned (ref), u46 (ref)
                if p48 == "State" and type(p49) == "table" then
                    fetchOwned(p49[u46]);
                end;
            end);

            return;
        end;

        warn("EmotePlayback: no " .. u45 .. ", owned emotes\' clips aren\'t fetched ahead");
    end);
    require(script.Parent.EmoteSync).start();
end;

function u1.load(u50, p51) -- Line: 131
    -- upvalues: EmoteCatalog (copy), u2 (copy), u1 (copy)
    if not EmoteCatalog.get(p51) then
        return nil;
    end;

    local v52 = EmoteCatalog.assetId(p51);

    if not v52 and (EmoteCatalog.StudioPreview and game:GetService("RunService"):IsStudio()) then
        local v53 = u2[p51];

        if v53 then
            v52 = v53;
        else
            local Clips = script.Parent:FindFirstChild("Clips");

            if Clips then
                Clips = Clips:FindFirstChild(p51);
            end;

            if Clips then
                local v54;
                v54, v52 = pcall(function() -- Line: 139
                    -- upvalues: Clips (copy)
                    return game:GetService("AnimationClipProvider"):RegisterAnimationClip(Clips);
                end);

                if v54 then
                    u2[p51] = v52;
                else
                    v52 = v53;
                end;
            else
                v52 = v53;
            end;
        end;
    end;

    if not v52 then
        return nil;
    end;

    local Animation = Instance.new("Animation");
    Animation.AnimationId = v52;
    Animation.Name = "ValleyEmote_" .. p51;
    local success, result = pcall(function() -- Line: 146
        -- upvalues: u50 (copy), Animation (copy)
        return u50:LoadAnimation(Animation);
    end);
    Animation:Destroy();

    if not success then
        return nil;
    end;

    result.Name = "ValleyEmote_" .. p51;
    result.Priority = Enum.AnimationPriority.Action4;
    u1.loop(result);

    return result;
end;

function u1.intro(u55, p56) -- Line: 152
    -- upvalues: EmoteCatalog (copy), u1 (copy)
    local v57 = EmoteCatalog.introId(p56);

    if not v57 then
        return nil;
    end;

    local Animation = Instance.new("Animation");
    Animation.AnimationId = v57;
    Animation.Name = "ValleyEmoteIntro_" .. p56;
    local success, result = pcall(function() -- Line: 155
        -- upvalues: u55 (copy), Animation (copy)
        return u55:LoadAnimation(Animation);
    end);
    Animation:Destroy();

    if not success then
        return nil;
    end;

    result.Name = "ValleyEmoteIntro_" .. p56;
    result.Priority = Enum.AnimationPriority.Action4;
    u1.once(result);

    return result;
end;

function u1.dispose(u58) -- Line: 160
    if u58 then
        u58:Stop(0.12);
        task.delay(0.2, function() -- Line: 161
            -- upvalues: u58 (copy)
            u58:Destroy();
        end);
    end;
end;

return u1;