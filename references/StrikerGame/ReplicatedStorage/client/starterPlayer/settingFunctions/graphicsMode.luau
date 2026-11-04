 

 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("SoundService");
game:GetService("RunService");
game:GetService("UserInputService");
game:GetService("TextChatService");
game:GetService("StarterGui");
game:GetService("MarketplaceService");
game:GetService("AvatarEditorService");
local _ = workspace.CurrentCamera;
require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
require(ReplicatedStorage.util.raycast);
require(ReplicatedStorage.util.animationUtil);
require(ReplicatedStorage.forum.trove);
require(ReplicatedStorage.forum.fastSignal);
require(ReplicatedStorage.client.starterPlayer);
local packets = require(ReplicatedStorage.packets);
local Mode = require(script:WaitForChild("Mode"));
local u1 = { "High", "Low", "Potato" };

return function(u2: any, p3: userdata, p4: any) -- Line: 33
    -- upvalues: u1 (copy), Mode (copy), packets (copy)
    if not u2.buttonConnections then
        u2.buttonConnections = {};
    end;

    u2[`{script.Name} Button`] = p3;
    local _ = u2.player;
    local _ = u2.playerGui;
    local buttonConnections = u2.buttonConnections;
    local graphicsMode = u2.setting:FindFirstChild("graphicsMode");

    local function update(p5, p6) -- Line: 46
        -- upvalues: u1 (ref), Mode (ref)
        local v7 = u1[p5];
        p6.Text = v7;
        Mode[v7]();
    end;

    if not buttonConnections[script.Name] then
        buttonConnections[script.Name] = graphicsMode.Changed:Connect(function(p8) -- Line: 53
            -- upvalues: u2 (copy), u1 (ref), Mode (ref)
            local v9 = u2[`{script.Name} Button`];
            local v10 = u1[p8];
            v9.Text = v10;
            Mode[v10]();
        end);
    end;

    if not p4 then
        local v11 = graphicsMode.Value + 1;
        packets.bytenet_settingChange.send({
            name = script.Name,
            value = v11 > 3 and 1 or v11
        });

        return;
    end;

    local v12 = u1[p4];
    p3.Text = v12;
    Mode[v12]();
end;