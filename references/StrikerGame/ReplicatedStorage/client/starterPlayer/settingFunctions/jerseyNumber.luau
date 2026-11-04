 

 

game:GetService("Players");
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
    -- upvalues: starterPlayer (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), packets (copy)
    p1:destroyContainer();
    local u2 = starterPlayer.SFX:Clone();
    u2.Parent = p1.playerGui;
    u2.Frame.Frame2.PitchRow.Visible = false;
    u2.Frame.Frame2.TimestampRow.Visible = false;
    u2.Frame.Frame2.SoundIdLabel.Text = "Jersey #";
    u2.Frame.Frame2.Search.TextBox.PlaceholderText = "(number here)";
    u2.Frame.Frame2.Close.Button.MouseButton1Up:Once(function() -- Line: 39
        -- upvalues: soundUtil (ref), ReplicatedStorage (ref), SoundService (ref), u2 (copy), packets (ref)
        soundUtil:play(ReplicatedStorage.Resources.click, SoundService);
        local success, result = pcall(function() -- Line: 42
            -- upvalues: u2 (ref)
            return tonumber(u2.Frame.Frame2.Search.TextBox.Text);
        end);
        packets.bytenet_settingChange.send({
            name = "jerseyNumber",
            value = success and result and result or 99
        });
        u2:Destroy();
    end);
end;