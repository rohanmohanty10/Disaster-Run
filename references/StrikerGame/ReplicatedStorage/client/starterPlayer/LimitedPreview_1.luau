 
 

game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("ServerScriptService");
game:GetService("MarketplaceService");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("SoundService");
game:GetService("StarterGui");
local TextChatService = game:GetService("TextChatService");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("Teams");
require(ReplicatedStorage2:WaitForChild("query"));
local _ = TextChatService.ChatWindowConfiguration;
local _ = workspace.CurrentCamera;
require(ReplicatedStorage2.util.PassClient);
require(ReplicatedStorage.TopbarIcon);
local replication = require(ReplicatedStorage2.client.replication);
require(ReplicatedStorage2.util.soundUtil);
require(ReplicatedStorage2.util.actionUtil);
require(ReplicatedStorage2.util.raycast);
require(ReplicatedStorage2.util.animationUtil);
local trove = require(ReplicatedStorage2.forum.trove);
require(ReplicatedStorage2.forum.fastSignal);
local packets = require(ReplicatedStorage2.packets);
require(ReplicatedStorage2.wiki);
require(ReplicatedStorage2.emoteWiki);
local v1 = {};
local LocalPlayer = Players.LocalPlayer;

function v1.Preview_MVP(u2, u3) -- Line: 45
    -- upvalues: LocalPlayer (copy), packets (copy), ReplicatedStorage (copy), ReplicatedStorage2 (copy), replication (copy)
    local u4 = LocalPlayer:FindFirstChild("setting") and LocalPlayer.setting:FindFirstChild("NoVFXAtAll");
    local u5;

    if u4 then
        u5 = u4.Value;
    else
        u5 = u4;
    end;

    if u4 then
        u4.Value = false;
    end;

    packets.bytenet_previewMvp.send({
        load = true,
        mvp = u3
    });
    local folder = u2.folder;
    local mvpAssets = ReplicatedStorage.Resources.mvpAssets;

    if folder and folder:IsDescendantOf(mvpAssets) then
        while folder.Parent ~= mvpAssets and folder:IsDescendantOf(mvpAssets) do
            folder = folder.Parent;
        end;

        if folder.Parent == mvpAssets and not folder:GetAttribute("LazyLoaded") then
            folder:GetAttributeChangedSignal("LazyLoaded"):Wait();
        end;
    end;

    for _, child in LocalPlayer.PlayerGui:GetChildren() do
        if child:IsA("ScreenGui") and (child.Name == "Menu" or child.Name == "Lobby") then
            child.Enabled = false;
        end;
    end;

    local u6 = {
        character = ReplicatedStorage.Resources.Rig:Clone()
    };
    u6.character.Name = "Cutscene Boy";
    u6.character.HumanoidRootPart.Anchored = true;
    u6.character:PivotTo(workspace.map.PrimaryPart.CFrame * CFrame.new(0, 2.25, 0));
    u6.character.Parent = workspace.Effects;
    local u7 = nil;
    local v8;

    if typeof(u2.resolveRoles) == "function" then
        v8 = u2.resolveRoles(u6.character) or nil;
    else
        v8 = nil;
    end;

    local v9 = v8 and v8.animation or u2.animation;

    if v9 then
        u7 = u6.character.Humanoid:loadAnimation(v9);
        u7:Play(0);

        repeat
            task.wait();
        until u7.Length ~= 0;
    end;

    local v10 = math.random(1, 2) == 1 and "A" or "B";
    local u11 = { u6.character };
    local u12 = {};

    for i = 1, 4 do
        local v13 = ReplicatedStorage.Resources.Rig:Clone();
        v13.HumanoidRootPart.Anchored = true;
        v13.Parent = workspace.Effects;
        table.insert(u11, v13);
        local _ = i;
    end;

    for i = 1, 5 do
        local v14 = ReplicatedStorage.Resources.Rig:Clone();
        v14.HumanoidRootPart.Anchored = true;
        v14.Parent = workspace.Effects;
        table.insert(u12, v14);
        local _ = i;
    end;

    local length = u2.length;
    local score_length = u2.score_length;
    local customCFrame = u2.customCFrame;
    local teamate = u2.teamate;
    local u15;

    if v8 and v8.teamateAnimation ~= nil then
        u15 = v8.teamateAnimation or nil;
    else
        u15 = u2.teamateAnimation;
    end;

    local _ = v10 == "A" and "B" or "A";
    local _ = u2.otherTeam;
    local u16;

    if u2.otherTeam then
        u16 = u12;
    else
        u16 = u11;
    end;

    local u17 = {};
    local u18 = {};

    if u2.everyone then
        u16 = {};

        for _, v in ipairs(u12) do
            table.insert(u16, v);
        end;

        for _, v in ipairs(u11) do
            table.insert(u16, v);
        end;
    end;

    if u2.tpMe then
        u6.character:PivotTo(customCFrame or workspace.map.something.mvpCF.CFrame);
    end;

    if u2.pause then
        task.delay(u2.pause, function() -- Line: 141
            -- upvalues: u7 (ref)
            if u7 then
                u7:AdjustSpeed(0);
            end;
        end);
    end;

    if teamate and u15 then
        task.spawn(function() -- Line: 149
            -- upvalues: u16 (ref), u6 (copy), u17 (copy), teamate (copy), ReplicatedStorage2 (ref), u2 (copy), customCFrame (copy), u18 (copy), u15 (copy)
            for _, v in u16 do
                if v ~= u6.character then
                    table.insert(u17, v);
                end;
            end;

            for i = 1, teamate do
                local v19 = u17[i];

                if v19 then
                    v19.PrimaryPart.Anchored = true;
                else
                    v19 = ReplicatedStorage2.Resources.mvpAssets[`Rig{i}`]:Clone();
                    v19.Parent = workspace.Effects;
                    table.insert(u17, v19);
                end;

                local v20;

                if v19 then
                    if u2.enemiesToUser == nil then
                        v19:PivotTo(customCFrame and customCFrame or workspace.map.something.mvpCF.CFrame);
                    else
                        print("new_weld");
                        local enemiesToUser = u2.enemiesToUser;

                        if typeof(enemiesToUser) == "table" then
                            enemiesToUser = enemiesToUser[i];
                        end;

                        v19.HumanoidRootPart.CFrame = u6.character.HumanoidRootPart.CFrame * enemiesToUser;
                    end;

                    u18[i] = v19;
                    v19.Humanoid:loadAnimation(u15[i]):Play(0);
                    v20 = i;
                else
                    v20 = i;
                end;
            end;
        end);
    end;

    if u2 and u2.scorelengthvariants then
        local v21 = u6.character:GetAttribute("strike") or 0;
        local v22 = (1 / 0);
        local v23 = nil;
        local v24 = nil;

        for _, v in ipairs(u2.scorelengthvariants) do
            local v25 = v[1];

            if v25 < v22 then
                v24 = v;
                v22 = v25;
            end;

            if v25 <= v21 then
                v23 = v;
            end;
        end;

        if v23 ~= nil then
            v24 = v23;
        end;

        score_length = v24[2];
        length = v24[3] or length;
    end;

    local coroutine_wrap_ret = coroutine.wrap(replication["mvp_" .. u3]);
    local character = u6.character;
    local v26 = {};
    local v27;

    if u2.randomiseBetween then
        v27 = Random.new():NextInteger(u2.randomiseBetween.min, u2.randomiseBetween.max);
    else
        v27 = nil;
    end;

    v26.chosen = v27;
    coroutine_wrap_ret(character, length, v26, u18);

    if score_length then
        replication.mvpGoal(0, 0, v10, score_length, u2.score_type, u2.score_goaway, u2.score_offset, u2.score_scale);
    end;

    task.delay(u2.length + 3, function() -- Line: 274
        -- upvalues: u4 (copy), u5 (copy), packets (ref), u3 (copy), LocalPlayer (ref), u12 (copy), u11 (copy), u18 (copy), u6 (copy)
        if u4 and u4.Parent then
            u4.Value = u5;
        end;

        packets.bytenet_previewMvp.send({
            load = false,
            mvp = u3
        });

        if LocalPlayer and LocalPlayer.Character then
            LocalPlayer.Character:SetAttribute("Cutscene", nil);
            LocalPlayer.character:SetAttribute("disableRotate", nil);
            LocalPlayer.character:SetAttribute("lockrotation", nil);
        end;

        for _, child in LocalPlayer.PlayerGui:GetChildren() do
            if child:IsA("ScreenGui") and (child.Name == "Menu" or child.Name == "Lobby") then
                child.Enabled = true;
            end;
        end;

        for _, v in u12 do
            pcall(game.Destroy, v);
        end;

        for _, v in u11 do
            pcall(game.Destroy, v);
        end;

        for _, v in u18 do
            pcall(game.Destroy, v);
        end;

        for i, v in LocalPlayer.Character:GetAttributes() do
            print(i, v);
        end;

        pcall(game.Destroy, u6.character);
    end);
end;

function v1.Preview_EMOTE(p28, p29) -- Line: 312
    -- upvalues: LocalPlayer (copy), trove (copy), ReplicatedStorage (copy), replication (copy)
    local u30 = LocalPlayer:FindFirstChild("setting") and LocalPlayer.setting:FindFirstChild("NoVFXAtAll");
    local u31;

    if u30 then
        u31 = u30.Value;
    else
        u31 = u30;
    end;

    if u30 then
        u30.Value = false;
    end;

    local u32 = trove.new();
    local u33 = ReplicatedStorage.Resources.Rig:Clone();
    u33.Parent = workspace.Effects;
    u33:PivotTo(CFrame.new(0, 10000, 0));
    local v34 = p28.animation or p28.equipanimation;
    local sound = p28.sound;
    local Folder = Instance.new("Folder");
    Folder.Name = "EmoteReference";
    Folder.Parent = u33;
    local v35 = nil;

    for _, child in LocalPlayer.PlayerGui:GetChildren() do
        if child:IsA("ScreenGui") and (child.Name == "Menu" or child.Name == "Lobby") then
            child.Enabled = false;
        end;
    end;

    print("Loading anim");

    if v34 then
        v35 = u33.Humanoid:loadAnimation(v34);
        v35:Play(0);

        repeat
            task.wait();
        until v35.Length ~= 0;
    end;

    print("Anim loaded, loading sound");

    if sound then
        local v36 = sound:Clone();
        v36.Parent = u33.HumanoidRootPart;
        v36:Play();

        repeat
            task.wait();
        until v36.TimeLength ~= 0;
    end;

    print("Sound loaded");

    if not (replication[p29 .. "Emote"] or script:FindFirstChild(p29 .. "Emote")) then
        pcall(game.Destroy, u33);

        return;
    end;

    local u37 = script:FindFirstChild(p29 .. "Emote") and require(script:FindFirstChild(p29 .. "Emote")) or replication[p29 .. "Emote"];
    workspace.CurrentCamera.CameraSubject = u33.Humanoid;
    task.spawn(function() -- Line: 362
        -- upvalues: u37 (copy), u33 (copy), Folder (copy)
        u37(u33, Folder);
    end);

    if v34 then
        local Parent = v34.Parent;

        if Parent.Name == "DrFaust" then
            local v38 = Parent.Hat:Clone();
            v38.Parent = u33;
            v38.Join.Part0 = u33.Head;
        end;
    end;

    local u39 = script.indicator:Clone();
    u39.Parent = LocalPlayer.PlayerGui;
    local u40 = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):FindFirstChildWhichIsA("Humanoid");
    u32:Add(function() -- Line: 381
        -- upvalues: u33 (copy), u39 (copy), u30 (copy), u31 (copy), u40 (copy), LocalPlayer (ref)
        pcall(game.Destroy, u33);
        pcall(game.Destroy, u39);

        if u30 and u30.Parent then
            u30.Value = u31;
        end;

        workspace.CurrentCamera.CameraSubject = u40;

        for _, child in LocalPlayer.PlayerGui:GetChildren() do
            if child:IsA("ScreenGui") and (child.Name == "Menu" or child.Name == "Lobby") then
                child.Enabled = true;
            end;
        end;
    end);
    u32:Add(u40:GetPropertyChangedSignal("MoveDirection"):Once(function() -- Line: 395
        -- upvalues: u32 (copy)
        u32:Destroy();
    end));

    if v35 then
        u32:Add(v35.Stopped:Once(function() -- Line: 400
            -- upvalues: u32 (copy)
            u32:Destroy();
        end));
    end;
end;

return v1;