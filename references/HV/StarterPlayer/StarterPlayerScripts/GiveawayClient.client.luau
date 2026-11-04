 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local Debris = game:GetService("Debris");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local GiveawayEvent = ChickenOrHero:WaitForChild("Admin"):WaitForChild("GiveawayEvent");
local u1 = require(ChickenOrHero.Presentation.GiveawayView).new(LocalPlayer:WaitForChild("PlayerGui"));
local u2 = require(ChickenOrHero.Presentation.GiveawayPicker).new(LocalPlayer, GiveawayEvent);
local u3 = false;

local function staffShown() -- Line: 15
    -- upvalues: LocalPlayer (copy)
    return LocalPlayer:GetAttribute("TestUIHidden") == false;
end;

local u4 = nil;
local u5 = {};
local u6 = 0;
local u7 = false;
local u8 = nil;

local function cue(p9, p10) -- Line: 23
    -- upvalues: u8 (ref), Debris (copy)
    local GameAudio = game.SoundService:FindFirstChild("GameAudio");

    if GameAudio then
        GameAudio = GameAudio:FindFirstChild("04_UI");
    end;

    local v11 = GameAudio and GameAudio:FindFirstChild("MatchSummary") and GameAudio.MatchSummary:FindFirstChild(p9);

    if not (v11 and (v11:IsA("Sound") and require(game:GetService("ReplicatedFirst"):WaitForChild("LazySound")).id(v11) ~= "")) then
        return;
    end;

    if u8 then
        u8:Destroy();
    end;

    u8 = v11:Clone();
    local v12 = u8;
    v12.Volume = v12.Volume * (p10 or 1);
    u8.Looped = false;
    u8.Parent = game.SoundService;
    u8:Play();
    Debris:AddItem(u8, 5);
end;

local function close(p13) -- Line: 41
    -- upvalues: u4 (ref), u5 (copy), u1 (copy), LocalPlayer (copy)
    if p13 and (u4 and u4.id ~= p13) then
        return;
    end;

    if u4 then
        u5[u4.id] = true;
    end;

    u4 = nil;
    u1:hide();
    LocalPlayer:SetAttribute("GlobalWheelOpen", nil);
end;

GiveawayEvent.OnClientEvent:Connect(function(p14, p15) -- Line: 52
    -- upvalues: LocalPlayer (copy), u2 (copy), u3 (ref), u5 (copy), u4 (ref), u7 (ref), UserInputService (copy), u1 (copy), ChickenOrHero (copy), Debris (copy)
    if p14 == "Open" then
        if LocalPlayer:GetAttribute("TestUIHidden") == false then
            u2.open();

            return;
        end;

        u3 = true;

        return;
    end;

    if p14 == "Reply" then
        u2.reply(p15);

        return;
    end;

    if p14 ~= "Show" then
        if p14 ~= "Close" then
            if p14 == "Skipped" then
                local ValleyPanels = require(ChickenOrHero.Presentation.ValleyPanels);
                local v16 = ValleyPanels.screen(LocalPlayer, "GiveawayStatus", 9901);
                local v17 = ValleyPanels.make("TextLabel", v16, "Message", {
                    BackgroundTransparency = 1,
                    TextWrapped = true,
                    TextScaled = true,
                    TextStrokeTransparency = 0.2,
                    AnchorPoint = Vector2.new(0.5, 0),
                    Position = UDim2.fromScale(0.5, 0.15),
                    Size = UDim2.fromScale(0.75, 0.15),
                    Text = p15.message,
                    TextColor3 = ValleyPanels.Gold,
                    TextStrokeColor3 = ValleyPanels.Ink,
                    Font = Enum.Font.GothamBold
                });
                ValleyPanels.make("UITextSizeConstraint", v17, "Limit", {
                    MaxTextSize = 23,
                    MinTextSize = 12
                });
                Debris:AddItem(v16, 7);
            end;

            return;
        end;

        if p15 and (u4 and u4.id ~= p15) then
            return;
        end;

        if u4 then
            u5[u4.id] = true;
        end;

        u4 = nil;
        u1:hide();
        LocalPlayer:SetAttribute("GlobalWheelOpen", nil);

        return;
    end;

    if type(p15) ~= "table" or (u5[p15.id] or workspace:GetServerTimeNow() >= p15.endsAt) then
        return;
    end;

    if u4 and u4.id == p15.id then
        return;
    end;

    u2.hide();
    u3 = false;
    u4 = p15;
    u7 = false;
    LocalPlayer:SetAttribute("GlobalWheelOpen", true);
    local FocusedTextBox = UserInputService:GetFocusedTextBox();

    if FocusedTextBox then
        FocusedTextBox:ReleaseFocus();
    end;

    u1:show(p15, LocalPlayer.UserId);
end);
local u18 = LocalPlayer:GetAttributeChangedSignal("TestUIHidden"):Connect(function() -- Line: 106
    -- upvalues: LocalPlayer (copy), u2 (copy), u3 (ref)
    if LocalPlayer:GetAttribute("TestUIHidden") == false then
        if u3 then
            u3 = false;
            u2.open();
        end;

        return;
    end;

    u2.hide();
end);
RunService:BindToRenderStep("GlobalGiveawayOverlay", Enum.RenderPriority.Camera.Value + 20, function() -- Line: 114
    -- upvalues: u4 (ref), u5 (copy), u1 (copy), LocalPlayer (copy), u6 (ref), cue (copy), u7 (ref)
    if not u4 then
        return;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();

    if u4.endsAt + 1 > ServerTimeNow then
        local v19, v20 = u1:step(ServerTimeNow);

        if v19 and os.clock() - u6 > 0.075 then
            u6 = os.clock();
            cue("CountTick", 0.5);
        end;

        if v20 and not u7 then
            u7 = true;
            cue("LevelUp", 0.85);
        end;

        return;
    end;

    if u4 then
        u5[u4.id] = true;
    end;

    u4 = nil;
    u1:hide();
    LocalPlayer:SetAttribute("GlobalWheelOpen", nil);
end);
LocalPlayer:GetAttributeChangedSignal("ClientReady"):Connect(function() -- Line: 134, Name: sync
    -- upvalues: GiveawayEvent (copy)
    GiveawayEvent:FireServer("Sync");
end);
GiveawayEvent:FireServer("Sync");
script.Destroying:Connect(function() -- Line: 139
    -- upvalues: u18 (copy), u4 (ref), u5 (copy), u1 (copy), LocalPlayer (copy), RunService (copy), u2 (copy), u8 (ref)
    u18:Disconnect();

    if u4 then
        u5[u4.id] = true;
    end;

    u4 = nil;
    u1:hide();
    LocalPlayer:SetAttribute("GlobalWheelOpen", nil);
    RunService:UnbindFromRenderStep("GlobalGiveawayOverlay");
    u2.destroy();
    u1.gui:Destroy();

    if u8 then
        u8:Destroy();
    end;
end);