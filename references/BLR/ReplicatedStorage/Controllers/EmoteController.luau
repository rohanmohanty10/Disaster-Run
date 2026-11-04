  

local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
require(ReplicatedStorage.Controllers.CameraController);
local u1 = nil;
local LocalPlayer = Players.LocalPlayer;
local PlayerData = ClientGlobals.PlayerData;
local PlayerGui = ClientGlobals.PlayerGui;
local EmoteWheel = ClientGlobals.PlayerGui.EmoteWheel;
local workspace_CurrentCamera = workspace.CurrentCamera;
local v2 = Knit.CreateController({
    Name = "EmoteController"
});

function v2.Emote(p3) -- Line: 26
    -- upvalues: PlayerGui (copy), EmoteWheel (copy), LocalPlayer (copy)
    PlayerGui.Misc.EmoteTouch.Visible = false;
    PlayerGui.Misc.EmotePc.Visible = false;
    PlayerGui.Misc.EmotesGamepad.Visible = false;
    EmoteWheel.Wheel:GetChildren();
    EmoteWheel.Enabled = not EmoteWheel.Enabled;

    if not EmoteWheel.Enabled then
        LocalPlayer:SetAttribute("EmoteSelected", nil);
    end;
end;

function v2.KnitStart(u4) -- Line: 40
    -- upvalues: Knit (copy), EmoteWheel (copy), LocalPlayer (copy), PlayerData (copy), UserInputService (copy)
    local Service = Knit.GetService("EmoteService");
    local Controller = Knit.GetController("CameraController");
    Knit.GetController("Settings");
    local Shiftlock = Controller.Shiftlock;
    EmoteWheel:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 46
        -- upvalues: EmoteWheel (ref), Shiftlock (ref), Controller (copy)
        if not EmoteWheel.Enabled then
            Controller:SetShiftlock(Shiftlock);

            return;
        end;

        Shiftlock = Controller.Shiftlock;
        Controller:SetShiftlock(false);
    end);

    for _, child in EmoteWheel.Wheel:GetChildren() do
        if child:IsA("ImageButton") ~= false then
            child.MouseButton1Click:Connect(function() -- Line: 58
                -- upvalues: EmoteWheel (ref), LocalPlayer (ref), child (copy), Service (copy), PlayerData (ref)
                EmoteWheel.Enabled = false;
                LocalPlayer:SetAttribute("EmoteSelected", child:GetAttribute("Emote"));
                Service.Emote:Fire(PlayerData.Data.Customization.EmotesEquipped[child.Name]);
            end);
        end;
    end;

    UserInputService.InputBegan:Connect(function(p5, p6) -- Line: 66
        -- upvalues: PlayerData (ref), u4 (copy)
        if p6 then
            return;
        end;

        if not PlayerData.Data then
            return;
        end;

        if p5.KeyCode == Enum.KeyCode[PlayerData.Data.PlayerKeybinds.PC.Emote] or p5.KeyCode == Enum.KeyCode[PlayerData.Data.PlayerKeybinds.Console.Emote] then
            u4:Emote();
        end;
    end);
    LocalPlayer.PlayerGui.Mobile.NoBall.Emote.MouseButton1Click:Connect(function() -- Line: 75
        -- upvalues: u4 (copy)
        u4:Emote();
    end);
    LocalPlayer.PlayerGui.Mobile.Ball.Emote.MouseButton1Click:Connect(function() -- Line: 78
        -- upvalues: u4 (copy)
        u4:Emote();
    end);
    local Emote = LocalPlayer.PlayerGui.Mobile.Ball.Emote;
    local Emote2 = LocalPlayer.PlayerGui.Mobile.NoBall.Emote;

    local function applyEmoteVisibility(p7) -- Line: 86
        -- upvalues: Emote (copy), Emote2 (copy)
        print("call emote visibility func");

        if p7 then
            p7 = p7:GetAttribute("CutsceneChar");
        end;

        print(p7);

        if Emote then
            Emote.Visible = not p7;
        end;

        if Emote2 then
            Emote2.Visible = not p7;
        end;
    end;

    local function hookCutscene(u8) -- Line: 93
        -- upvalues: Emote (copy), Emote2 (copy)
        if not u8 then
            return;
        end;

        print("call emote visibility func");
        local v9;

        if u8 then
            v9 = u8:GetAttribute("CutsceneChar");
        else
            v9 = u8;
        end;

        print(v9);

        if Emote then
            Emote.Visible = not v9;
        end;

        if Emote2 then
            Emote2.Visible = not v9;
        end;

        u8:GetAttributeChangedSignal("CutsceneChar"):Connect(function() -- Line: 96
            -- upvalues: u8 (copy), Emote (ref), Emote2 (ref)
            local v10 = u8;
            print("call emote visibility func");

            if v10 then
                v10 = v10:GetAttribute("CutsceneChar");
            end;

            print(v10);

            if Emote then
                Emote.Visible = not v10;
            end;

            if Emote2 then
                Emote2.Visible = not v10;
            end;
        end);
    end;

    local u11 = LocalPlayer.Character and LocalPlayer.Character;

    if u11 then
        print("call emote visibility func");
        local v12;

        if u11 then
            v12 = u11:GetAttribute("CutsceneChar");
        else
            v12 = u11;
        end;

        print(v12);

        if Emote then
            Emote.Visible = not v12;
        end;

        if Emote2 then
            Emote2.Visible = not v12;
        end;

        u11:GetAttributeChangedSignal("CutsceneChar"):Connect(function() -- Line: 96
            -- upvalues: u11 (copy), Emote (copy), Emote2 (copy)
            local v13 = u11;
            print("call emote visibility func");

            if v13 then
                v13 = v13:GetAttribute("CutsceneChar");
            end;

            print(v13);

            if Emote then
                Emote.Visible = not v13;
            end;

            if Emote2 then
                Emote2.Visible = not v13;
            end;
        end);
    end;

    LocalPlayer.CharacterAdded:Connect(hookCutscene);
    LocalPlayer.PlayerGui.MobileInLobby.Frame.Emote.MouseButton1Click:Connect(function() -- Line: 102
        -- upvalues: u4 (copy)
        u4:Emote();
    end);
    LocalPlayer.PlayerGui.Misc.EmoteTouch.MouseButton1Click:Connect(function() -- Line: 105
        -- upvalues: u4 (copy)
        u4:Emote();
    end);
    local Customization = LocalPlayer.PlayerGui.Customization;
    local u14 = {
        Customization.BG.Wheel:FindFirstChild("1").EmoteViewport,
        Customization.BG.Wheel:FindFirstChild("2").EmoteViewport,
        Customization.BG.Wheel:FindFirstChild("3").EmoteViewport,
        Customization.BG.Wheel:FindFirstChild("4").EmoteViewport
    };
    local u15 = {
        EmoteWheel.Wheel:FindFirstChild("1").EmoteViewport,
        EmoteWheel.Wheel:FindFirstChild("2").EmoteViewport,
        EmoteWheel.Wheel:FindFirstChild("3").EmoteViewport,
        EmoteWheel.Wheel:FindFirstChild("4").EmoteViewport
    };

    for i = 1, 4 do
        PlayerData:Observe({ "Customization", "EmotesEquipped", (tostring(i)) }, function(p16) -- Line: 126
            -- upvalues: u15 (copy), i (copy), u14 (copy)
            u15[i]:SetAttribute("Emote", p16);
            u14[i]:SetAttribute("Emote", p16);
        end);
        local _ = i;
    end;
end;

function v2.KnitInit(p17) -- Line: 133
    -- upvalues: u1 (ref), Knit (copy), LocalPlayer (copy), workspace_CurrentCamera (copy)
    u1 = Knit.GetService("EmoteService");
    LocalPlayer.CharacterAdded:Connect(function(p18) -- Line: 136
        -- upvalues: workspace_CurrentCamera (ref)
        workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
        workspace_CurrentCamera.CameraSubject = p18:WaitForChild("Humanoid", 60);
    end);
end;

return v2;