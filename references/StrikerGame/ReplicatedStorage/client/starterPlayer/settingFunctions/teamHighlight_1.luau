 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
game:GetService("RunService");
game:GetService("UserInputService");
game:GetService("TextChatService");
game:GetService("StarterGui");
local _ = game.Teams;
game:GetService("MarketplaceService");
game:GetService("AvatarEditorService");
local soundUtil = require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
require(ReplicatedStorage.util.raycast);
require(ReplicatedStorage.util.animationUtil);
require(ReplicatedStorage.forum.trove);
require(ReplicatedStorage.forum.fastSignal);
require(ReplicatedStorage.client.starterPlayer);
local packets = require(ReplicatedStorage.packets);

local function booleansetting(p1: userdata, p2: any) -- Line: 26
    local Frame = p1:WaitForChild("Frame");
    local boolean = Frame:WaitForChild("boolean");
    local UDim2_new_ret = UDim2.new(0, 0, 0, 0);
    local UDim2_new_ret2 = UDim2.new(0.5, 0, 0, 0);
    local Color3_fromRGB_ret = Color3.fromRGB(123, 255, 0);
    local Color3_fromRGB_ret2 = Color3.fromRGB(178, 255, 169);
    local Color3_fromRGB_ret3 = Color3.fromRGB(171, 0, 0);
    local Color3_fromRGB_ret4 = Color3.fromRGB(255, 107, 107);

    if p2 then
        UDim2_new_ret2 = UDim2_new_ret or UDim2_new_ret2;
    end;

    boolean.Position = UDim2_new_ret2;

    if p2 then
        Color3_fromRGB_ret3 = Color3_fromRGB_ret or Color3_fromRGB_ret3;
    end;

    Frame.BackgroundColor3 = Color3_fromRGB_ret3;

    if p2 then
        Color3_fromRGB_ret4 = Color3_fromRGB_ret2 or Color3_fromRGB_ret4;
    end;

    boolean.BackgroundColor3 = Color3_fromRGB_ret4;
end;

return function(p3: any, p4: userdata, p5: any) -- Line: 45
    -- upvalues: booleansetting (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), packets (copy)
    if not p3.buttonConnections then
        p3.buttonConnections = {};
    end;

    p3[`{script.Name} Button`] = p4;
    local _ = p3.player;
    local _ = p3.playerGui;
    local setting = p3.setting;
    local _ = p3.buttonConnections;
    local teamHighlight = setting:FindFirstChild("teamHighlight");
    local Parent = p4.Parent.Parent;
    booleansetting(Parent, teamHighlight.Value);
    p3.buttonConnections[#p3.buttonConnections + 1] = p4.MouseButton1Up:Connect(function() -- Line: 62
        -- upvalues: soundUtil (ref), ReplicatedStorage (ref), SoundService (ref), packets (ref), setting (copy)
        soundUtil:play(ReplicatedStorage.Resources.click, SoundService);
        packets.bytenet_settingChange.send({
            name = script.Name,
            value = not setting.teamHighlight.Value
        });
    end);
    p3.buttonConnections[#p3.buttonConnections + 1] = teamHighlight:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 71
        -- upvalues: teamHighlight (copy), booleansetting (ref), Parent (copy)
        booleansetting(Parent, teamHighlight.Value);
    end);
end;