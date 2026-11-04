  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Trove = require(ReplicatedStorage.Shared.Trove);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local u1 = nil;
local u2 = nil;
local workspace_CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local Txt = LocalPlayer.PlayerGui.Onboarding.Txt;
local TutorialInput = LocalPlayer.PlayerGui.TutorialInput;
local PlayerData = ClientGlobals.PlayerData;
local Assets = ReplicatedStorage:WaitForChild("Assets");
local u3 = {
    Slide = {
        Gamepad = "Press R1 to perform a tackle!",
        Touch = "Press the Slide button to perform a tackle!",
        KeyboardAndMouse = "Press <font color=\'#fc9403\'>KB_Slide</font> to slide!"
    },
    Dribble = {
        Gamepad = "AWESOME! Now <font color=\'#fc9403\'>PRESS R1</font> to dribble! (MUST HAVE THE BALL!)",
        Touch = "AWESOME! Now press the <font color=\'#fc9403\'>DRIBBLE BUTTON</font> to dribble! (MUST HAVE THE BALL!)",
        KeyboardAndMouse = "AWESOME! Now press <font color=\'#fc9403\'>KB_Dribble</font> to dribble! (MUST HAVE THE BALL!)"
    }
};
local v4 = Knit.CreateController({
    Name = "Onboarding"
});

local function getKeybind(p5: string) -- Line: 49
    -- upvalues: PlayerData (copy)
    return PlayerData.Data.PlayerKeybinds.PC[p5];
end;

local function clearTutorialInput() -- Line: 53
    -- upvalues: TutorialInput (copy)
    TutorialInput.Adornee = nil;
    TutorialInput.Enabled = false;
end;

local function setTutorialInput(p6: string, p7: any) -- Line: 58
    -- upvalues: TutorialInput (copy), UserInputService (copy), LocalPlayer (copy), clearTutorialInput (copy)
    TutorialInput.Icon.UIScale.Scale = 1;
    TutorialInput.Enabled = true;
    TutorialInput:WaitForChild("Icon").Keybind.Text = UserInputService:GetStringForKeyCode(p7);
    TutorialInput.TextLabel.Text = p6;
    local v8;

    if LocalPlayer.Character then
        v8 = LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
    else
        v8 = nil;
    end;

    TutorialInput.Adornee = v8;

    return clearTutorialInput;
end;

local u9 = nil;

local function typewriteHint(p10: string) -- Line: 68
    -- upvalues: UserInputService (copy), PlayerData (copy), u9 (ref), Txt (copy), SoundManager (copy), LocalPlayer (copy)
    if not p10 then
        return function() -- Line: 69
        end;
    end;

    local v11 = p10:gsub("KB_Dribble", UserInputService:GetStringForKeyCode(PlayerData.Data.PlayerKeybinds.PC.Dribble)):gsub("KB_Slide", UserInputService:GetStringForKeyCode(PlayerData.Data.PlayerKeybinds.PC.Slide));

    if u9 == v11 then
        return function() -- Line: 76
        end;
    end;

    local u12 = true;
    u9 = v11;
    Txt.Text = v11;
    task.spawn(function() -- Line: 83
        -- upvalues: Txt (ref), u12 (ref), SoundManager (ref), LocalPlayer (ref)
        local v13 = 0;

        for _ in utf8.graphemes(Txt.ContentText) do
            v13 = v13 + 1;
        end;

        for i = 1, v13 do
            if u12 then
                Txt.MaxVisibleGraphemes = i;
                SoundManager.SpawnSound(`Type{math.random(1, 2)}`, 0.3, LocalPlayer.PlayerGui, 1);
            end;

            task.wait(0.02);
            local _ = i;
        end;
    end);

    return function() -- Line: 103
        -- upvalues: u12 (ref), Txt (ref)
        u12 = false;
        Txt.Text = "";
        Txt.MaxVisibleGraphemes = -1;
    end;
end;

local function createGuidanceBeam(u14, p15) -- Line: 110
    -- upvalues: LocalPlayer (copy), Assets (copy), RunService (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return nil;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return nil;
    end;

    local u16 = Assets:FindFirstChild("OnboardingBeam"):Clone();
    u16.Parent = HumanoidRootPart;
    u16.CFrame = HumanoidRootPart.CFrame;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = HumanoidRootPart;
    WeldConstraint.Part1 = u16;
    WeldConstraint.Parent = u16;
    p15:Add(u16);
    local EndPoint = u16:FindFirstChild("EndPoint");
    local v17 = u16:FindFirstChildWhichIsA("Beam");
    p15:Add(RunService.RenderStepped:Connect(function() -- Line: 130
        -- upvalues: u16 (copy), u14 (copy), EndPoint (copy)
        if not (u16 and u16.Parent) then
            return;
        end;

        local v18 = nil;

        if typeof(u14) == "Instance" then
            v18 = u14.Position;
        elseif typeof(u14) == "Vector3" then
            v18 = u14;
        end;

        if v18 and EndPoint then
            EndPoint.WorldPosition = v18;
        end;
    end));

    return u16, v17;
end;

local u31 = {
    ["Show Controls"] = {
        enter = function(p19) -- Line: 150, Name: enter
            -- upvalues: typewriteHint (copy)
            p19:Add((typewriteHint("Welcome to your first match! On the bottom right you can see your controls!")));
        end,

        update = function(p20) -- Line: 153, Name: update
        end
    },
    Slide = {
        enter = function(p21) -- Line: 157, Name: enter
            -- upvalues: UserInputService (copy), typewriteHint (copy), u3 (copy), setTutorialInput (copy), PlayerData (copy)
            local PreferredInput = UserInputService.PreferredInput;
            p21:Add((typewriteHint(u3.Slide[PreferredInput.Name])));

            if PreferredInput == Enum.PreferredInput.KeyboardAndMouse then
                p21:Add((setTutorialInput("Slide", PlayerData.Data.PlayerKeybinds.PC.Slide)));
            end;
        end,

        update = function() -- Line: 164, Name: update
        end
    },
    ["Get Ball"] = {
        enter = function(p22) -- Line: 168, Name: enter
            -- upvalues: typewriteHint (copy), clearTutorialInput (copy), ReplicatedStorage (copy), createGuidanceBeam (copy)
            p22:Add((typewriteHint("Great! Go and <font color=\'#fc9403\'>SLIDE</font> into a player to get the ball!")));
            p22:Add(clearTutorialInput);
            local Value = ReplicatedStorage.Football.Value;

            if Value then
                local _, v23 = createGuidanceBeam(Value, p22);
                p22._beamObj = v23;
            end;
        end,

        update = function(p24) -- Line: 178, Name: update
            -- upvalues: UserInputService (copy), ReplicatedStorage (copy), createGuidanceBeam (copy), workspace_CurrentCamera (copy), setTutorialInput (copy), PlayerData (copy), TutorialInput (copy)
            local PreferredInput = UserInputService.PreferredInput;
            local Value = ReplicatedStorage.Football.Value;

            if Value and not p24._beamObj then
                local _, v25 = createGuidanceBeam(Value, p24);
                p24._beamObj = v25;
            end;

            if not Value then
                return;
            end;

            local Magnitude = (workspace_CurrentCamera.Focus.Position - Value.Position).Magnitude;

            if p24._beamObj then
                p24._beamObj.Enabled = Magnitude > 12;
            end;

            if PreferredInput ~= Enum.PreferredInput.KeyboardAndMouse then
                TutorialInput.Adornee = nil;
                TutorialInput.Enabled = false;

                return;
            end;

            if Magnitude >= 24 then
                TutorialInput.Adornee = nil;
                TutorialInput.Enabled = false;

                return;
            end;

            setTutorialInput("Slide", PlayerData.Data.PlayerKeybinds.PC.Slide);
            local UIScale = TutorialInput.Icon.UIScale;
            local v26 = time() * 5;
            UIScale.Scale = math.sin(v26) * 0.1 + 1.1;
        end
    },
    Dribble = {
        enter = function(p27) -- Line: 208, Name: enter
            -- upvalues: UserInputService (copy), typewriteHint (copy), u3 (copy), setTutorialInput (copy), PlayerData (copy)
            local PreferredInput = UserInputService.PreferredInput;
            p27:Add((typewriteHint(u3.Dribble[PreferredInput.Name])));

            if PreferredInput == Enum.PreferredInput.KeyboardAndMouse then
                p27:Add((setTutorialInput("Dribble", PlayerData.Data.PlayerKeybinds.PC.Dribble)));
            end;
        end,

        update = function() -- Line: 215, Name: update
        end
    },
    ["Finish Match"] = {
        enter = function(p28) -- Line: 220, Name: enter
            -- upvalues: typewriteHint (copy)
            p28:Add((typewriteHint("Nice work! Finish the match!")));
        end,

        update = function() -- Line: 223, Name: update
        end
    },
    Styles = {
        lobby = true,

        enter = function(p29) -- Line: 229, Name: enter
            -- upvalues: LocalPlayer (copy)
            local Hint = LocalPlayer.PlayerGui.HUD.Buttons:FindFirstChild("Style").Button.Hint;
            Hint.Visible = true;
            p29:Add(function() -- Line: 232
                -- upvalues: Hint (copy)
                Hint.Visible = false;
            end);
        end,

        update = function(p30) -- Line: 236, Name: update
            -- upvalues: LocalPlayer (copy)
            return LocalPlayer.PlayerGui.Style.Enabled;
        end,

        completed = function() -- Line: 239, Name: completed
        end
    }
};

function v4.KnitStart(p32) -- Line: 244
    -- upvalues: u1 (ref), SoundManager (copy), LocalPlayer (copy), u31 (copy), ReplicatedStorage (copy), Trove (copy), typewriteHint (copy), createGuidanceBeam (copy)
    local u33 = "not loaded";
    u1.ClientReady:Fire();
    u1.SetCurrentStep:Connect(function(p34) -- Line: 248
        -- upvalues: u33 (ref), SoundManager (ref), LocalPlayer (ref)
        if u33 ~= p34 then
            SoundManager.SpawnSound("Notification", 0.3, LocalPlayer.PlayerGui, 1);
        end;

        u33 = p34;
    end);

    while u33 == "not loaded" do
        task.wait();
    end;

    local function isRequiredMatchActive() -- Line: 259
        -- upvalues: u31 (ref), u33 (ref), ReplicatedStorage (ref), LocalPlayer (ref)
        if u31[u33].lobby then
            return true;
        end;

        local v35;

        if ReplicatedStorage.GameValues.State.Value == "Playing" then
            v35 = LocalPlayer.Team ~= game.Teams.Visitor;
        else
            v35 = false;
        end;

        return v35;
    end;

    local function ensureMatchActive() -- Line: 266
        -- upvalues: u31 (ref), u33 (ref), ReplicatedStorage (ref), LocalPlayer (ref), Trove (ref), typewriteHint (ref), createGuidanceBeam (ref)
        local v36;

        if u31[u33].lobby then
            v36 = true;
        elseif ReplicatedStorage.GameValues.State.Value == "Playing" then
            v36 = LocalPlayer.Team ~= game.Teams.Visitor;
        else
            v36 = false;
        end;

        if v36 then
            return;
        end;

        local v37 = Trove.new();
        v37:Add((typewriteHint("Join the match to keep playing!")));
        local SelectTeam = workspace:FindFirstChild("SelectTeam");

        if SelectTeam then
            createGuidanceBeam(SelectTeam, v37);
        end;

        while true do
            local v38;

            if u31[u33].lobby then
                v38 = true;
            elseif ReplicatedStorage.GameValues.State.Value == "Playing" then
                v38 = LocalPlayer.Team ~= game.Teams.Visitor;
            else
                v38 = false;
            end;

            if v38 then
                v37:Destroy();

                if u31[u33] and u31[u33].enter then
                    if u33 == "Show Controls" then
                        typewriteHint("Welcome to your first match! On the bottom right you can see your controls!");

                        return;
                    end;

                    if u33 == "Get Ball" then
                        typewriteHint("Great! Go and <font color=\'#fc9403\'>SLIDE</font> into a player to get the ball!");
                    end;
                end;

                return;
            end;

            task.wait(1);
        end;
    end;

    while u33 do
        local v39;

        if u31[u33].lobby then
            v39 = true;
        elseif ReplicatedStorage.GameValues.State.Value == "Playing" then
            v39 = LocalPlayer.Team ~= game.Teams.Visitor;
        else
            v39 = false;
        end;

        if not (v39 or u31[u33].lobby) then
            ensureMatchActive();
        end;

        local v40 = Trove.new();
        u31[u33].enter(v40);
        local v41 = u33;

        while v41 == u33 do
            local v42;

            if u31[u33].lobby then
                v42 = true;
            elseif ReplicatedStorage.GameValues.State.Value == "Playing" then
                v42 = LocalPlayer.Team ~= game.Teams.Visitor;
            else
                v42 = false;
            end;

            if not (v42 or u31[u33].lobby) then
                v40:Destroy();
                ensureMatchActive();
                v40 = Trove.new();
                u31[u33].enter(v40);
            end;

            if u31[v41].update(v40) then
                u1:ClientCompleteStep(u33);
            end;

            task.wait();
        end;

        v40:Destroy();
        task.wait();
    end;
end;

function v4.KnitInit(p43) -- Line: 321
    -- upvalues: u1 (ref), Knit (copy), u2 (ref)
    u1 = Knit.GetService("OnboardingService");
    u2 = Knit.GetController("Settings");
end;

return v4;