 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local u1 = setmetatable({}, {
    __mode = "k"
});
local u2 = setmetatable({}, {
    __mode = "k"
});
local u3 = {};
local u4 = UserInputService.PreferredInput == Enum.PreferredInput.Touch;
local PumpkinSmoke = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("Gear"):WaitForChild("PumpkinSmoke"));

local function concealed(p5) -- Line: 20
    -- upvalues: PumpkinSmoke (copy)
    local v6;

    if p5 == nil then
        v6 = false;
    else
        v6 = p5:GetAttribute("Cloaked") == true and true or (p5:GetAttribute("Ghosted") == true and true or PumpkinSmoke.hidden(p5));
    end;

    return v6;
end;

local function apply(p7) -- Line: 24
    -- upvalues: LocalPlayer (copy), u4 (ref), PumpkinSmoke (copy)
    local v8 = LocalPlayer:GetAttribute("LightsOutDark") == true;
    local v9 = u4;

    if v9 then
        local Parent = p7.Parent;
        local v10;

        if Parent == nil then
            v10 = false;
        else
            v10 = (Parent:GetAttribute("Cloaked") == true or Parent:GetAttribute("Ghosted") == true) and true or PumpkinSmoke.hidden(Parent);
        end;

        v9 = not v10 and (not v8 or p7:GetAttribute("LightsOutSpotted") == true);
    end;

    if p7.Enabled ~= v9 then
        p7.Enabled = v9;
    end;
end;

local function refreshBody(p11) -- Line: 32
    -- upvalues: u1 (copy), LocalPlayer (copy), u4 (ref), PumpkinSmoke (copy)
    for i in u1 do
        if i.Parent == p11 then
            local v12 = LocalPlayer:GetAttribute("LightsOutDark") == true;
            local v13 = u4;

            if v13 then
                local Parent = i.Parent;
                local v14;

                if Parent == nil then
                    v14 = false;
                else
                    v14 = (Parent:GetAttribute("Cloaked") == true or Parent:GetAttribute("Ghosted") == true) and true or PumpkinSmoke.hidden(Parent);
                end;

                v13 = not v14 and (not v12 or i:GetAttribute("LightsOutSpotted") == true);
            end;

            if i.Enabled ~= v13 then
                i.Enabled = v13;
            end;
        end;
    end;
end;

local function watchBody(u15) -- Line: 40
    -- upvalues: u2 (copy), u1 (copy), LocalPlayer (copy), u4 (ref), PumpkinSmoke (copy)
    if not u15 or u2[u15] then
        return;
    end;

    u2[u15] = true;
    u15:GetAttributeChangedSignal("Cloaked"):Connect(function() -- Line: 45
        -- upvalues: u15 (copy), u1 (ref), LocalPlayer (ref), u4 (ref), PumpkinSmoke (ref)
        local v16 = u15;

        for i in u1 do
            if i.Parent == v16 then
                local v17 = LocalPlayer:GetAttribute("LightsOutDark") == true;
                local v18 = u4;

                if v18 then
                    local Parent = i.Parent;
                    local v19;

                    if Parent == nil then
                        v19 = false;
                    else
                        v19 = (Parent:GetAttribute("Cloaked") == true or Parent:GetAttribute("Ghosted") == true) and true or PumpkinSmoke.hidden(Parent);
                    end;

                    v18 = not v19 and (not v17 or i:GetAttribute("LightsOutSpotted") == true);
                end;

                if i.Enabled ~= v18 then
                    i.Enabled = v18;
                end;
            end;
        end;
    end);
    u15:GetAttributeChangedSignal("Ghosted"):Connect(function() -- Line: 48
        -- upvalues: u15 (copy), u1 (ref), LocalPlayer (ref), u4 (ref), PumpkinSmoke (ref)
        local v20 = u15;

        for i in u1 do
            if i.Parent == v20 then
                local v21 = LocalPlayer:GetAttribute("LightsOutDark") == true;
                local v22 = u4;

                if v22 then
                    local Parent = i.Parent;
                    local v23;

                    if Parent == nil then
                        v23 = false;
                    else
                        v23 = (Parent:GetAttribute("Cloaked") == true or Parent:GetAttribute("Ghosted") == true) and true or PumpkinSmoke.hidden(Parent);
                    end;

                    v22 = not v23 and (not v21 or i:GetAttribute("LightsOutSpotted") == true);
                end;

                if i.Enabled ~= v22 then
                    i.Enabled = v22;
                end;
            end;
        end;
    end);
    u15:GetAttributeChangedSignal("Smoked"):Connect(function() -- Line: 51
        -- upvalues: u15 (copy), u1 (ref), LocalPlayer (ref), u4 (ref), PumpkinSmoke (ref)
        local v24 = u15;

        for i in u1 do
            if i.Parent == v24 then
                local v25 = LocalPlayer:GetAttribute("LightsOutDark") == true;
                local v26 = u4;

                if v26 then
                    local Parent = i.Parent;
                    local v27;

                    if Parent == nil then
                        v27 = false;
                    else
                        v27 = (Parent:GetAttribute("Cloaked") == true or Parent:GetAttribute("Ghosted") == true) and true or PumpkinSmoke.hidden(Parent);
                    end;

                    v26 = not v27 and (not v25 or i:GetAttribute("LightsOutSpotted") == true);
                end;

                if i.Enabled ~= v26 then
                    i.Enabled = v26;
                end;
            end;
        end;
    end);
end;

local function track(u28) -- Line: 56
    -- upvalues: u1 (copy), watchBody (copy), LocalPlayer (copy), u4 (ref), PumpkinSmoke (copy)
    if u1[u28] or (u28.Name ~= "RoleMarker" or not u28:IsA("BillboardGui")) then
        return;
    end;

    u1[u28] = true;
    watchBody(u28.Parent);
    local v29 = LocalPlayer:GetAttribute("LightsOutDark") == true;
    local v30 = u4;

    if v30 then
        local Parent = u28.Parent;
        local v31;

        if Parent == nil then
            v31 = false;
        else
            v31 = (Parent:GetAttribute("Cloaked") == true or Parent:GetAttribute("Ghosted") == true) and true or PumpkinSmoke.hidden(Parent);
        end;

        v30 = not v31 and (not v29 or u28:GetAttribute("LightsOutSpotted") == true);
    end;

    if u28.Enabled ~= v30 then
        u28.Enabled = v30;
    end;

    u28:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 64
        -- upvalues: u28 (copy), LocalPlayer (ref), u4 (ref), PumpkinSmoke (ref)
        local v32 = u28;
        local v33 = LocalPlayer:GetAttribute("LightsOutDark") == true;
        local v34 = u4;

        if v34 then
            local Parent = v32.Parent;
            local v35;

            if Parent == nil then
                v35 = false;
            else
                v35 = (Parent:GetAttribute("Cloaked") == true or Parent:GetAttribute("Ghosted") == true) and true or PumpkinSmoke.hidden(Parent);
            end;

            v34 = not v35 and (not v33 or v32:GetAttribute("LightsOutSpotted") == true);
        end;

        if v32.Enabled ~= v34 then
            v32.Enabled = v34;
        end;
    end);
    u28:GetAttributeChangedSignal("LightsOutSpotted"):Connect(function() -- Line: 67
        -- upvalues: u28 (copy), LocalPlayer (ref), u4 (ref), PumpkinSmoke (ref)
        local v36 = u28;
        local v37 = LocalPlayer:GetAttribute("LightsOutDark") == true;
        local v38 = u4;

        if v38 then
            local Parent = v36.Parent;
            local v39;

            if Parent == nil then
                v39 = false;
            else
                v39 = (Parent:GetAttribute("Cloaked") == true or Parent:GetAttribute("Ghosted") == true) and true or PumpkinSmoke.hidden(Parent);
            end;

            v38 = not v39 and (not v37 or v36:GetAttribute("LightsOutSpotted") == true);
        end;

        if v36.Enabled ~= v38 then
            v36.Enabled = v38;
        end;
    end);
end;

local function watch(p40) -- Line: 73
    -- upvalues: track (copy)
    for _, child in p40:GetChildren() do
        track(child);
    end;

    p40.ChildAdded:Connect(track);
end;

local function watchPlayer(p41) -- Line: 80
    -- upvalues: track (copy), u3 (copy), watch (copy)
    if p41.Character then
        local Character = p41.Character;

        for _, child in Character:GetChildren() do
            track(child);
        end;

        Character.ChildAdded:Connect(track);
    end;

    u3[p41] = p41.CharacterAdded:Connect(watch);
end;

for _, v in Players:GetPlayers() do
    local v42;

    if v.Character then
        local Character = v.Character;
        v42 = v;

        for _, child in Character:GetChildren() do
            track(child);
        end;

        Character.ChildAdded:Connect(track);
    else
        v42 = v;
    end;

    u3[v42] = v42.CharacterAdded:Connect(watch);
end;

Players.PlayerAdded:Connect(watchPlayer);
Players.PlayerRemoving:Connect(function(p43) -- Line: 91
    -- upvalues: u3 (copy)
    local v44 = u3[p43];

    if v44 then
        v44:Disconnect();
        u3[p43] = nil;
    end;
end);

local function watchRigs(p45) -- Line: 101
    -- upvalues: track (copy)
    for _, descendant in p45:GetDescendants() do
        track(descendant);
    end;

    p45.DescendantAdded:Connect(track);
end;

local ClientBots = workspace:FindFirstChild("ClientBots");

if ClientBots then
    for _, descendant in ClientBots:GetDescendants() do
        track(descendant);
    end;

    ClientBots.DescendantAdded:Connect(track);
end;

workspace.ChildAdded:Connect(function(p46) -- Line: 111
    -- upvalues: track (copy)
    if p46.Name == "ClientBots" and p46:IsA("Folder") then
        for _, descendant in p46:GetDescendants() do
            track(descendant);
        end;

        p46.DescendantAdded:Connect(track);
    end;
end);
UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function() -- Line: 117
    -- upvalues: u4 (ref), UserInputService (copy), u1 (copy), LocalPlayer (copy), PumpkinSmoke (copy)
    u4 = UserInputService.PreferredInput == Enum.PreferredInput.Touch;

    for i in u1 do
        local v47 = LocalPlayer:GetAttribute("LightsOutDark") == true;
        local v48 = u4;

        if v48 then
            local Parent = i.Parent;
            local v49;

            if Parent == nil then
                v49 = false;
            else
                v49 = (Parent:GetAttribute("Cloaked") == true or Parent:GetAttribute("Ghosted") == true) and true or PumpkinSmoke.hidden(Parent);
            end;

            v48 = not v49 and (not v47 or i:GetAttribute("LightsOutSpotted") == true);
        end;

        if i.Enabled ~= v48 then
            i.Enabled = v48;
        end;
    end;
end);
LocalPlayer:GetAttributeChangedSignal("LightsOutDark"):Connect(function() -- Line: 123
    -- upvalues: u1 (copy), LocalPlayer (copy), u4 (ref), PumpkinSmoke (copy)
    for i in u1 do
        local v50 = LocalPlayer:GetAttribute("LightsOutDark") == true;
        local v51 = u4;

        if v51 then
            local Parent = i.Parent;
            local v52;

            if Parent == nil then
                v52 = false;
            else
                v52 = (Parent:GetAttribute("Cloaked") == true or Parent:GetAttribute("Ghosted") == true) and true or PumpkinSmoke.hidden(Parent);
            end;

            v51 = not v52 and (not v50 or i:GetAttribute("LightsOutSpotted") == true);
        end;

        if i.Enabled ~= v51 then
            i.Enabled = v51;
        end;
    end;
end);
PumpkinSmoke.Changed:Connect(function() -- Line: 129
    -- upvalues: u1 (copy), LocalPlayer (copy), u4 (ref), PumpkinSmoke (copy)
    for i in u1 do
        local v53 = LocalPlayer:GetAttribute("LightsOutDark") == true;
        local v54 = u4;

        if v54 then
            local Parent = i.Parent;
            local v55;

            if Parent == nil then
                v55 = false;
            else
                v55 = (Parent:GetAttribute("Cloaked") == true or Parent:GetAttribute("Ghosted") == true) and true or PumpkinSmoke.hidden(Parent);
            end;

            v54 = not v55 and (not v53 or i:GetAttribute("LightsOutSpotted") == true);
        end;

        if i.Enabled ~= v54 then
            i.Enabled = v54;
        end;
    end;
end);
LocalPlayer:GetAttributeChangedSignal("GameRole"):Connect(function() -- Line: 135
    -- upvalues: u1 (copy), LocalPlayer (copy), u4 (ref), PumpkinSmoke (copy)
    for i in u1 do
        local v56 = LocalPlayer:GetAttribute("LightsOutDark") == true;
        local v57 = u4;

        if v57 then
            local Parent = i.Parent;
            local v58;

            if Parent == nil then
                v58 = false;
            else
                v58 = (Parent:GetAttribute("Cloaked") == true or Parent:GetAttribute("Ghosted") == true) and true or PumpkinSmoke.hidden(Parent);
            end;

            v57 = not v58 and (not v56 or i:GetAttribute("LightsOutSpotted") == true);
        end;

        if i.Enabled ~= v57 then
            i.Enabled = v57;
        end;
    end;
end);