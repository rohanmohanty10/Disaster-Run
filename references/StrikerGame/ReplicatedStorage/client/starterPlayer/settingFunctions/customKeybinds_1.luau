 
 

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
local starterPlayer = require(ReplicatedStorage.client.starterPlayer);
local packets = require(ReplicatedStorage.packets);
local u1 = {};
local u2 = {};

for _, v in Enum.KeyCode:GetEnumItems() do
    if v.Name ~= "Unknown" then
        u1[v.Name] = true;
    end;
end;

for _, v in Enum.UserInputType:GetEnumItems() do
    if v.Name ~= "Unknown" then
        u2[v.Name] = true;
    end;
end;

local u3 = {
    kick = "Kick",
    dash = "Tackle",
    drib = "Dribble",
    modetoggle = "Toggle Mode",
    throwGoal = "Throw / Doberman",
    givmeBall = "Request Ball",
    superDash = "Run",
    skill1 = "Skill 1",
    skill2 = "Skill 2",
    skill3 = "Skill 3",
    skill4 = "Skill 4",
    skill5 = "Skill 5",
    baseAwaken = "Awaken",
    Emote = "Emote"
};
local u4 = {
    kick = 1,
    dash = 2,
    drib = 3,
    modetoggle = 4,
    throwGoal = 5,
    superDash = 6,
    givmeBall = 7,
    baseAwaken = 8,
    Emote = 9,
    skill1 = 10,
    skill2 = 11,
    skill3 = 12,
    skill4 = 13,
    skill5 = 14
};

local function clean(p5) -- Line: 72
    for _, v in p5 do
        if typeof(v) == "RBXScriptConnection" then
            v:Disconnect();
        elseif typeof(v) == "thread" and coroutine.status(v) == "suspended" then
            task.cancel(v);
        end;
    end;

    table.clear(p5);
end;

local function clearButtons(p6) -- Line: 83
    for _, child in p6:GetChildren() do
        if child:IsA("Frame") then
            child:Destroy();
        end;
    end;
end;

local function addButtons(u7, u8, u9, p10) -- Line: 91
    -- upvalues: starterPlayer (copy), u3 (copy), u4 (copy), UserInputService (copy), u1 (copy), u2 (copy), packets (copy)
    for i, v in starterPlayer.cachedKeybinds do
        local v11 = u8:Clone();
        local Button = v11:WaitForChild("Button");
        local Main = v11:WaitForChild("Main");
        Main.Text = u3[i] or "ERROR";
        Button.Text = v;
        v11.LayoutOrder = u4[i];
        local u12 = Main.Text == "Toggle Mode";
        u9[#u9 + 1] = Button.MouseButton1Up:Connect(function() -- Line: 111
            -- upvalues: Button (copy), u9 (copy), UserInputService (ref), u1 (ref), u2 (ref), u7 (copy), u8 (copy), u12 (ref), starterPlayer (ref), i (copy), packets (ref)
            Button.Text = "Awaiting Input";
            u9[#u9 + 1] = UserInputService.InputBegan:Connect(function(p13: userdata, p14: any) -- Line: 114
                -- upvalues: u1 (ref), u2 (ref), u7 (ref), u8 (ref), u9 (ref), u12 (ref), starterPlayer (ref), i (ref), packets (ref)
                if u1[p13.KeyCode.Name] == nil and u2[p13.UserInputType.Name] == nil then
                    update(u7, u8, u9, true);
                    print("?", p13.KeyCode.Name);

                    return;
                end;

                local v15 = u1[p13.KeyCode.Name] ~= nil and p13.KeyCode;

                if not v15 then
                    if u2[p13.UserInputType.Name] == nil then
                        v15 = false;
                    else
                        v15 = p13.UserInputType;
                    end;
                end;

                if not v15 then
                    update(u7, u8, u9, true);
                    print("2", v15);

                    return;
                end;

                if p13.KeyCode == Enum.KeyCode.None then
                    if p13.UserInputType ~= Enum.UserInputType.None then
                        v15 = p13.UserInputType;
                    end;
                else
                    v15 = p13.KeyCode;
                end;

                if not v15 then
                    update(u7, u8, u9, true);

                    return;
                end;

                local Name = v15.Name;

                if not u12 then
                    for i2, v2 in starterPlayer.cachedKeybinds do
                        if v2 == Name then
                            if i2 == "kick" and Name == "None" then
                                starterPlayer.cachedKeybinds[i2] = "MouseButton1";
                            end;

                            update(u7, u8, u9, true);

                            return;
                        end;
                    end;
                end;

                starterPlayer.cachedKeybinds[i] = i == "kick" and Name == "None" and "MouseButton1" or Name;
                update(u7, u8, u9, true);
                local v16 = {};

                for i2, v2 in starterPlayer.cachedKeybinds do
                    v16[i2] = v2;
                end;

                packets.bytenet_settingChange.send({
                    name = script.Name,
                    value = v16
                });
            end);
        end);
        v11.Parent = u7;
    end;
end;

function update(p17, p18, p19)
    -- upvalues: clean (copy), clearButtons (copy), addButtons (copy)
    clean(p19);
    clearButtons(p17);
    addButtons(p17, p18, p19);
end;

local function updateFromServer(p20) -- Line: 191
    -- upvalues: starterPlayer (copy)
    local Children = p20:GetChildren();
    local cachedKeybinds = starterPlayer.cachedKeybinds;

    for _, v in Children do
        cachedKeybinds[v.Name] = v.Value;
    end;
end;

return function(p21: any, p22: userdata, p23: any) -- Line: 200
    -- upvalues: ReplicatedStorage (copy), clean (copy), starterPlayer (copy)
    if not p21.buttonConnections then
        p21.buttonConnections = {};
    end;

    p21:destroyContainer();
    p21[`{script.Name} Button`] = p22;
    local _ = p21.player;
    local playerGui = p21.playerGui;
    local _ = p21.buttonConnections;
    local customKeybinds = p21.setting:FindFirstChild("customKeybinds");
    local u24 = ReplicatedStorage.client.starterPlayer.customKeybinds:Clone();
    local Frame2 = u24:WaitForChild("Frame"):WaitForChild("Frame2");
    local Button = Frame2:WaitForChild("Close"):WaitForChild("Button");
    local ScrollingFrame = Frame2:WaitForChild("ScrollingFrame");
    local Frame = ScrollingFrame:WaitForChild("UIListLayout"):WaitForChild("Frame");
    u24.Parent = playerGui;
    local u25 = {};
    u25[#u25 + 1] = u24.AncestryChanged:Once(function() -- Line: 230
        -- upvalues: clean (ref), u25 (copy)
        clean(u25);
    end);
    u25[#u25 + 1] = Button.MouseButton1Up:Once(function() -- Line: 234
        -- upvalues: u24 (copy)
        u24:Destroy();
    end);
    local Children = customKeybinds:GetChildren();
    local cachedKeybinds = starterPlayer.cachedKeybinds;
    local v26 = {};

    for _, v in Children do
        cachedKeybinds[v.Name] = v.Value;
    end;

    update(ScrollingFrame, Frame, v26);
end;