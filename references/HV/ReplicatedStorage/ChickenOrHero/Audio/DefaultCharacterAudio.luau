 

 

local Players = game:GetService("Players");
local v1 = {};
local u2 = {
    Climbing = true,
    Died = true,
    GettingUp = true,
    Swimming = true,
    Jumping = true,
    Landing = true,
    Splash = true,
    FreeFalling = true,
    Running = true
};

function v1.start(p3) -- Line: 5
    -- upvalues: u2 (copy), Players (copy)
    local u4 = {};
    local u5 = {};
    local PlayerScripts = p3:WaitForChild("PlayerScripts");
    table.insert(u4, PlayerScripts.ChildAdded:Connect(function(p6) -- Line: 8, Name: disable
        -- upvalues: u5 (copy)
        if p6.Name == "RbxCharacterSounds" and p6:IsA("LocalScript") then
            if u5[p6] == nil then
                u5[p6] = p6.Enabled;
            end;

            p6.Enabled = false;
        end;
    end));
    local u7 = {};
    local u8 = {};

    for _, child in PlayerScripts:GetChildren() do
        if child.Name == "RbxCharacterSounds" and child:IsA("LocalScript") then
            if u5[child] == nil then
                u5[child] = child.Enabled;
            end;

            child.Enabled = false;
        end;
    end;

    local function cleanCharacter(p9) -- Line: 16
        -- upvalues: u7 (copy)
        local v10 = u7[p9];

        if v10 then
            v10:Disconnect();
            u7[p9] = nil;
        end;
    end;

    local function character(p11, u12) -- Line: 19
        -- upvalues: u7 (copy), u2 (ref)
        local v13 = u7[p11];

        if v13 then
            v13:Disconnect();
            u7[p11] = nil;
        end;

        local function removeDefault(p14) -- Line: 21
            -- upvalues: u12 (copy), u2 (ref)
            local HumanoidRootPart = u12:FindFirstChild("HumanoidRootPart");

            if u2[p14.Name] and (p14:IsA("Sound") or p14:IsA("AudioPlayer")) and p14.Parent == HumanoidRootPart then
                p14:Destroy();

                return;
            end;

            if p14.Name == "RbxCharacterSoundsEmitter" and p14:IsA("AudioEmitter") then
                p14:Destroy();
            end;
        end;

        u7[p11] = u12.DescendantAdded:Connect(removeDefault);

        for _, descendant in u12:GetDescendants() do
            removeDefault(descendant);
        end;
    end;

    table.insert(u4, Players.PlayerAdded:Connect(function(u15) -- Line: 29, Name: add
        -- upvalues: u8 (copy), character (copy)
        u8[u15] = u15.CharacterAdded:Connect(function(p16) -- Line: 30
            -- upvalues: character (ref), u15 (copy)
            character(u15, p16);
        end);

        if u15.Character then
            character(u15, u15.Character);
        end;
    end));
    table.insert(u4, Players.PlayerRemoving:Connect(function(p17) -- Line: 33, Name: remove
        -- upvalues: u7 (copy), u8 (copy)
        local v18 = u7[p17];

        if v18 then
            v18:Disconnect();
            u7[p17] = nil;
        end;

        if u8[p17] then
            u8[p17]:Disconnect();
            u8[p17] = nil;
        end;
    end));

    for _, v in Players:GetPlayers() do
        u8[v] = v.CharacterAdded:Connect(function(p19) -- Line: 30
            -- upvalues: character (copy), v (copy)
            character(v, p19);
        end);

        if v.Character then
            character(v, v.Character);
        end;
    end;

    return function() -- Line: 39
        -- upvalues: u4 (copy), u8 (copy), u7 (copy), u5 (copy)
        for _, v in u4 do
            v:Disconnect();
        end;

        for i in u8 do
            local v20 = u7[i];

            if v20 then
                v20:Disconnect();
                u7[i] = nil;
            end;

            if u8[i] then
                u8[i]:Disconnect();
                u8[i] = nil;
            end;
        end;

        for i, v in u5 do
            if i.Parent then
                i.Enabled = v;
            end;
        end;
    end;
end;

return v1;