 
 

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
    local u2 = starterPlayer.VFXRecolor:Clone();
    u2.Parent = p1.playerGui;
    local VFXRecolor = Players.LocalPlayer:WaitForChild("setting"):WaitForChild("VFXRecolor");
    local Value = VFXRecolor.Red.Value;
    local Value2 = VFXRecolor.Green.Value;
    local Value3 = VFXRecolor.Blue.Value;
    local Value4 = VFXRecolor.Alpha.Value;
    u2.Frame.EndColor.BackgroundColor3 = Color3.new(255, 255, 255):Lerp(Color3.fromRGB(Value, Value2, Value3), Value4);

    local function update() -- Line: 38
        -- upvalues: u2 (copy), Value (ref), Value2 (ref), Value3 (ref), Value4 (ref)
        u2.Frame.EndColor.BackgroundColor3 = Color3.new(255, 255, 255):Lerp(Color3.fromRGB(Value, Value2, Value3), Value4);
    end;

    for _, child in u2.Frame:GetChildren() do
        if child:IsA("TextBox") then
            child:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 45
                -- upvalues: child (copy), Value (ref), Value2 (ref), Value3 (ref), Value4 (ref), u2 (copy)
                if child.Name == "Red" then
                    Value = tonumber(child.Text) or 0;
                end;

                if child.Name == "Green" then
                    Value2 = tonumber(child.Text) or 0;
                end;

                if child.Name == "Blue" then
                    Value3 = tonumber(child.Text) or 0;
                end;

                if child.Name == "Alpha" then
                    Value4 = tonumber(child.Text) or 0;
                end;

                u2.Frame.EndColor.BackgroundColor3 = Color3.new(255, 255, 255):Lerp(Color3.fromRGB(Value, Value2, Value3), Value4);
            end);
        end;
    end;

    u2.Frame.LEAVE.MouseButton1Up:Once(function() -- Line: 63
        -- upvalues: soundUtil (ref), ReplicatedStorage (ref), SoundService (ref), packets (ref), Value (ref), Value2 (ref), Value3 (ref), Value4 (ref), u2 (copy)
        soundUtil:play(ReplicatedStorage.Resources.click, SoundService);
        packets.bytenet_settingChange.send({
            name = "VFXRecolor",
            value = {
                Value,
                Value2,
                Value3,
                Value4
            }
        });
        u2:Destroy();
    end);
end;