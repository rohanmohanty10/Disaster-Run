 

 

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

return function(p1) -- Line: 27
    -- upvalues: starterPlayer (copy), Players (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), packets (copy)
    p1:destroyContainer();
    local u2 = p1:createContainer();
    local Value = p1.setting:FindFirstChild("DuoMvp").Value;
    local v3 = u2:Clone(starterPlayer.DuoMvp);
    v3.Parent = p1.playerGui;
    local Frame2 = v3.Frame.Frame2;
    local success, result = pcall(function() -- Line: 57
        -- upvalues: Players (ref)
        return Players:GetFriendsAsync(Players.LocalPlayer.UserId);
    end);

    local function parse(p4) -- Line: 61
        local v5 = {};

        while true do
            for _, v in p4:GetCurrentPage() do
                table.insert(v5, v);
            end;

            if p4.IsFinished then
                return v5;
            end;

            p4:AdvanceToNextPageAsync();
        end;
    end;

    if not success then
        pcall(game.Destroy, v3);

        return;
    end;

    local v6 = parse(result);
    local u7 = false;
    Frame2.Close.Button.MouseButton1Up:Connect(function() -- Line: 84
        -- upvalues: u7 (ref), soundUtil (ref), ReplicatedStorage (ref), SoundService (ref), packets (ref), Value (ref), u2 (copy)
        u7 = true;
        soundUtil:play(ReplicatedStorage.Resources.click, SoundService);
        packets.bytenet_settingChange.send({
            name = "DuoMvp",
            value = Value
        });
        u2:Destroy();
    end);

    for _, v in v6 do
        if u7 then
            break;
        end;

        local u8 = Frame2.base:Clone();
        u8.Name = v.Id;
        u8.Main.Text = v.DisplayName;
        u8.identifier.Text = v.Username;
        u8.icon.Image = "";

        if Value == v.Id then
            u8.BackgroundColor3 = Color3.fromRGB(255, 255, 127);
        end;

        coroutine.wrap(function() -- Line: 110
            -- upvalues: Players (ref), v (copy), u8 (copy)
            local success2, result2 = pcall(function() -- Line: 111
                -- upvalues: Players (ref), v (ref)
                return Players:GetUserThumbnailAsync(v.Id, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150);
            end);

            if success2 then
                u8.icon.Image = result2;
            end;
        end)();
        u8.Parent = Frame2.Storage;
        u8.Visible = true;
        u8.Button.MouseButton1Up:connect(function() -- Line: 121
            -- upvalues: soundUtil (ref), ReplicatedStorage (ref), SoundService (ref), Value (ref), v (copy), u8 (copy), Frame2 (copy)
            soundUtil:play(ReplicatedStorage.Resources.click, SoundService);

            if Value == v.Id then
                Value = 0;
            else
                u8.BackgroundColor3 = Color3.fromRGB(255, 255, 127);
                Value = v.Id;
            end;

            for _, child in Frame2.Storage:GetChildren() do
                if child:IsA("Frame") and (child.BackgroundColor3 ~= Color3.fromRGB(255, 255, 255) and tonumber(child.Name) ~= tonumber(Value)) then
                    child.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                end;
            end;
        end);
        task.wait(0.085);
    end;
end;