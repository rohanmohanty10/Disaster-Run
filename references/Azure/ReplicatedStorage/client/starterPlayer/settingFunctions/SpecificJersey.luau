 

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
game:GetService("RunService");
game:GetService("UserInputService");
game:GetService("TextChatService");
game:GetService("StarterGui");
game:GetService("MarketplaceService");
game:GetService("AvatarEditorService");
local _ = workspace.CurrentCamera;
local soundUtil = require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
require(ReplicatedStorage.util.raycast);
require(ReplicatedStorage.util.animationUtil);
require(ReplicatedStorage.forum.trove);
require(ReplicatedStorage.forum.fastSignal);
local starterPlayer = ReplicatedStorage.client.starterPlayer;
local packets = require(ReplicatedStorage.packets);
local wiki = require(ReplicatedStorage.wiki);

return function(p1) -- Line: 29
    -- upvalues: Players (copy), starterPlayer (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), wiki (copy), packets (copy)
    p1:destroyContainer();
    local SpecificJersey = Players.LocalPlayer:WaitForChild("setting"):WaitForChild("SpecificJersey");
    local u2 = starterPlayer.Jersey:Clone();
    u2.Parent = p1.playerGui;
    local Frame2 = u2.Frame.Frame2;
    local char = Frame2.char;
    char.ViewportFrame.WorldModel.Preview:FindFirstChildOfClass("Humanoid");
    local u3 = {
        A = SpecificJersey.A.Value,
        B = SpecificJersey.B.Value
    };

    for i = 1, 2 do
        local u4 = i == 1 and "A" or "B";
        local u5 = Frame2.base:Clone();
        u5.Parent = Frame2[u4 .. "Storage"];
        u5.Main.Text = "Default";
        u5.Visible = true;

        if u3[u4] == "none" then
            u5.BackgroundColor3 = Color3.fromRGB(112, 112, 112);
        else
            u5.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        end;

        u5.Button.MouseButton1Up:connect(function() -- Line: 74
            -- upvalues: char (copy), u3 (copy), u4 (copy), u5 (copy), Frame2 (copy), soundUtil (ref), ReplicatedStorage (ref), SoundService (ref)
            char.outfitName.Text = "Default";
            u3[u4] = "none";

            if u3[u4] == "none" then
                u5.BackgroundColor3 = Color3.fromRGB(112, 112, 112);
            else
                u5.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
            end;

            for _, child in Frame2[u4 .. "Storage"]:GetChildren() do
                if child:IsA("Frame") and child ~= u5 then
                    child.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                end;
            end;

            soundUtil:play(ReplicatedStorage.Resources.click, SoundService);
        end);
        local _ = i;
    end;

    for i = 1, 2 do
        local u6 = i == 1 and "A" or "B";
        local u7 = Frame2.base:Clone();
        u7.Parent = Frame2[u6 .. "Storage"];
        u7.Main.Text = "User\'s Clothing";
        u7.Visible = true;

        if u3[u6] == "user" then
            u7.BackgroundColor3 = Color3.fromRGB(112, 112, 112);
        else
            u7.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        end;

        u7.Button.MouseButton1Up:connect(function() -- Line: 110
            -- upvalues: char (copy), u3 (copy), u6 (copy), u7 (copy), Frame2 (copy), soundUtil (ref), ReplicatedStorage (ref), SoundService (ref)
            char.outfitName.Text = "User\'s Clothing";
            u3[u6] = "user";

            if u3[u6] == "user" then
                u7.BackgroundColor3 = Color3.fromRGB(112, 112, 112);
            else
                u7.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
            end;

            for _, child in Frame2[u6 .. "Storage"]:GetChildren() do
                if child:IsA("Frame") and child ~= u7 then
                    child.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                end;
            end;

            soundUtil:play(ReplicatedStorage.Resources.click, SoundService);
        end);
        local _ = i;
    end;

    local v8 = {
        A = {},
        B = {}
    };

    for _, v in wiki.cloth do
        for i, v2 in v do
            local Title = v2.Title;

            if not v8[i][Title] then
                local u9 = Frame2.char:Clone();
                u9.Parent = Frame2[i .. "Storage"];
                u9.outfitName.Text = Title;
                u9.ViewportFrame.WorldModel.Preview.Shirt.ShirtTemplate = v2[1];
                u9.ViewportFrame.WorldModel.Preview.Pants.PantsTemplate = v2[2];
                u9.Visible = true;
                v8[i][Title] = u9;

                if u3[i] == Title then
                    u9.BackgroundColor3 = Color3.fromRGB(112, 112, 112);
                else
                    u9.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                end;

                u9.Button.MouseButton1Click:Connect(function() -- Line: 153
                    -- upvalues: u3 (copy), i (copy), Title (copy), u9 (copy), Frame2 (copy), soundUtil (ref), ReplicatedStorage (ref), SoundService (ref)
                    u3[i] = Title;

                    if u3[i] == Title then
                        u9.BackgroundColor3 = Color3.fromRGB(112, 112, 112);
                    else
                        u9.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                    end;

                    for _, child in Frame2[i .. "Storage"]:GetChildren() do
                        if child:IsA("Frame") and child ~= u9 then
                            child.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                        end;
                    end;

                    soundUtil:play(ReplicatedStorage.Resources.click, SoundService);
                end);
            end;
        end;
    end;

    Frame2.Close.Button.MouseButton1Up:Once(function() -- Line: 175
        -- upvalues: soundUtil (ref), ReplicatedStorage (ref), SoundService (ref), packets (ref), u3 (copy), u2 (copy)
        soundUtil:play(ReplicatedStorage.Resources.click, SoundService);
        packets.bytenet_settingChange.send({
            name = "SpecificJersey",
            value = u3
        });
        u2:Destroy();
    end);
end;