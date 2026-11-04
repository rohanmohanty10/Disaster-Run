 

 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("SoundService");
game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
game:GetService("TextChatService");
game:GetService("StarterGui");
game:GetService("MarketplaceService");
game:GetService("AvatarEditorService");
require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
require(ReplicatedStorage.util.raycast);
require(ReplicatedStorage.util.animationUtil);
require(ReplicatedStorage.forum.trove);
require(ReplicatedStorage.forum.fastSignal);
require(ReplicatedStorage.client.starterPlayer);
local packets = require(ReplicatedStorage.packets);
local GamepadContainer = require(ReplicatedStorage.client.GamepadContainer);

local function getGamepadButtonName(p1) -- Line: 26
    -- upvalues: UserInputService (copy)
    return UserInputService:GetStringForKeyCode(p1):gsub("^Button", "");
end;

local function clean(p2) -- Line: 30
    for _, v in p2 do
        if typeof(v) == "RBXScriptConnection" then
            v:Disconnect();
        elseif typeof(v) == "thread" and coroutine.status(v) == "suspended" then
            task.cancel(v);
        end;
    end;

    table.clear(p2);
end;

local function clearButtons(p3) -- Line: 41
    for _, child in p3:GetChildren() do
        if child:IsA("Frame") then
            child:Destroy();
        end;
    end;
end;

local function addButtons(u4, u5, u6, p7) -- Line: 49
    -- upvalues: GamepadContainer (copy), UserInputService (copy), packets (copy)
    for i, v in GamepadContainer do
        local ButtonName = v.ButtonName;
        local Name = v.Name;
        local KeyCode = v.KeyCode;
        local v8 = u5:Clone();
        local Button = v8:WaitForChild("Button");
        v8:WaitForChild("Main").Text = ButtonName or Name;
        Button.Text = UserInputService:GetStringForKeyCode(KeyCode):gsub("^Button", "");
        u6[#u6 + 1] = Button.MouseButton1Up:Connect(function() -- Line: 66
            -- upvalues: Button (copy), u6 (copy), UserInputService (ref), GamepadContainer (ref), i (copy), u4 (copy), u5 (copy), packets (ref)
            Button.Text = "Awaiting Input";
            u6[#u6 + 1] = UserInputService.InputBegan:Connect(function(p9: userdata) -- Line: 68
                -- upvalues: GamepadContainer (ref), i (ref), u4 (ref), u5 (ref), u6 (ref), packets (ref)
                if p9.KeyCode == Enum.KeyCode.None then
                    return;
                end;

                GamepadContainer[i].KeyCode = p9.KeyCode;
                update(u4, u5, u6, true);
                local v10 = {};

                for i2, v2 in GamepadContainer do
                    v10[i2] = v2.KeyCode.Value;
                end;

                packets.bytenet_settingChange.send({
                    name = script.Name,
                    value = v10
                });
            end);
        end);
        v8.Parent = u4;
    end;
end;

function update(p11, p12, p13)
    -- upvalues: clean (copy), clearButtons (copy), addButtons (copy)
    clean(p13);
    clearButtons(p11);
    addButtons(p11, p12, p13);
end;

local function updateFromServer(p14) -- Line: 96
    -- upvalues: GamepadContainer (copy)
    local v15 = GamepadContainer;

    for _, child in p14:GetChildren() do
        local v16 = tonumber(child.Name);
        local v17 = Enum.KeyCode:FromValue(child.Value);

        if v15[v16] then
            v15[v16].KeyCode = v17;
        end;
    end;
end;

return function(p18: any, p19: userdata, p20: any) -- Line: 111
    -- upvalues: ReplicatedStorage (copy), clean (copy), updateFromServer (copy)
    if not p18.isGamepad then
        return;
    end;

    if not p18.buttonConnections then
        p18.buttonConnections = {};
    end;

    p18:destroyContainer();
    p18[`{script.Name} Button`] = p19;
    local _ = p18.player;
    local playerGui = p18.playerGui;
    local _ = p18.buttonConnections;
    local consoleRemapping = p18.setting:FindFirstChild("consoleRemapping");
    local u21 = ReplicatedStorage.client.starterPlayer.ConsoleRemapping:Clone();
    local Frame2 = u21:WaitForChild("Frame"):WaitForChild("Frame2");
    local Button = Frame2:WaitForChild("Close"):WaitForChild("Button");
    local ScrollingFrame = Frame2:WaitForChild("ScrollingFrame");
    local Frame = ScrollingFrame:WaitForChild("UIListLayout"):WaitForChild("Frame");
    u21.Parent = playerGui;
    local u22 = {};
    u22[#u22 + 1] = u21.AncestryChanged:Once(function() -- Line: 141
        -- upvalues: clean (ref), u22 (copy)
        clean(u22);
    end);
    u22[#u22 + 1] = Button.MouseButton1Up:Once(function() -- Line: 145
        -- upvalues: u21 (copy)
        u21:Destroy();
    end);
    updateFromServer(consoleRemapping);
    update(ScrollingFrame, Frame, {});
end;