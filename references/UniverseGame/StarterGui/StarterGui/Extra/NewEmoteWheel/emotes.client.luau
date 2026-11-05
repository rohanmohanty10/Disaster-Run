  

 

local u1 = false;
local run = game.ReplicatedStorage.Emotes.run;
local LocalPlayer = game.Players.LocalPlayer;
local TweenService = game:GetService("TweenService");
local Check = require(game.StarterPlayer.StarterPlayerScripts.Input.Check);
local u2 = {
    CheckStunned = true,
    CheckDisabled = true,
    CheckActive = true,
    CheckTimestop = true
};
local u3 = false;
local u4 = {};
local u5 = 1;
local u6 = { {
        gpid = nil,
        emotes = { "DefaultDance", "TortureDance", "CaramellDansen", "Smug", "LoseControl", "Infestation", "FNF", "PAC-MAN" }
    }, {
        gpid = 13675608,
        emotes = { "SmoothMoves", "SmoothCriminal", "Kazotsky", "IevanPolkka", "God-Step", "90s", "Rodeo", "Cshearer" }
    } };

local function openclose() -- Line: 40
    -- upvalues: u1 (ref), TweenService (copy)
    u1 = not u1;

    if u1 then
        TweenService:Create(script.Parent.f, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, 0, 0.1, 0),
            Size = UDim2.new(0.8, 0, 0.8, 0)
        }):Play();
        coroutine.resume(coroutine.create(function() -- Line: 44
            -- upvalues: u1 (ref)
            wait(0.25);

            if u1 then
                script.Parent.Enabled = true;
            end;
        end));

        return;
    end;

    TweenService:Create(script.Parent.f, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
        Position = UDim2.new(0.495, 0, 0.5, 0),
        Size = UDim2.new(0.8, 0, 0, 0)
    }):Play();
    coroutine.resume(coroutine.create(function() -- Line: 52
        -- upvalues: u1 (ref)
        wait(0.25);

        if u1 then
            script.Parent.Enabled = false;
        end;
    end));
end;

local function updatepage() -- Line: 60
    -- upvalues: u5 (ref), u6 (copy), u4 (copy)
    u5 = math.clamp(u5, 1, #u6);
    local v7 = u6[u5].gpid == nil and true or game:GetService("MarketplaceService"):UserOwnsGamePassAsync(game.Players.LocalPlayer.UserId, u6[u5].gpid);

    for i, v in pairs(u4) do
        v.Text = u6[u5].emotes[i];
        v.TextTransparency = v7 and 0 or 0.69;
    end;
end;

for _, descendant in pairs(script.Parent:GetDescendants()) do
    if descendant.ClassName == "TextButton" then
        u4[#u4 + 1] = descendant;
    end;
end;

for i, v in pairs(u4) do
    v.Text = u6[1].emotes[i];
    v.MouseButton1Down:Connect(function() -- Line: 77
        -- upvalues: u6 (copy), u5 (ref), v (copy), Check (copy), LocalPlayer (copy), u2 (copy), u1 (ref), u3 (ref), run (copy), openclose (copy)
        local v8 = table.find(u6[u5].emotes, v.Text);
        local v9 = u6[u5].gpid == nil and true or game:GetService("MarketplaceService"):UserOwnsGamePassAsync(game.Players.LocalPlayer.UserId, u6[u5].gpid);

        if Check.CanAttack(LocalPlayer, "Emote", u2) and (v8 and (u1 and v9)) then
            u3 = true;
            run:FireServer();
            run:FireServer(v.Text);
            openclose();
        end;
    end);
end;

game:GetService("UserInputService").InputBegan:Connect(function(p10, p11) -- Line: 89
    -- upvalues: openclose (copy)
    if p11 then
        return;
    end;

    if p10.KeyCode == Enum.KeyCode.Period then
        openclose();
    end;
end);
script.Parent.f.af.right.MouseButton1Click:Connect(function() -- Line: 96
    -- upvalues: u5 (ref), updatepage (copy)
    u5 = u5 + 1;
    updatepage();
end);
script.Parent.f.af.left.MouseButton1Click:Connect(function() -- Line: 100
    -- upvalues: u5 (ref), updatepage (copy)
    u5 = u5 - 1;
    updatepage();
end);
game:GetService("RunService").RenderStepped:Connect(function() -- Line: 104
    -- upvalues: u3 (ref), LocalPlayer (copy), Check (copy), u2 (copy), run (copy)
    if u3 and (LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 or not Check.CanAttack(LocalPlayer, "Emote", u2)) then
        u3 = false;
        run:FireServer();
    end;
end);