 

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerStorage");
game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
game:GetService("CollectionService");
game:GetService("Lighting");
local SoundService = game:GetService("SoundService");
game:GetService("TextService");
game:GetService("ContentProvider");
local v1 = {};
local workspace_CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local _ = LocalPlayer.PlayerGui;
local Mouse = LocalPlayer:GetMouse();
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local u2 = {
    Enum.KeyCode.E,
    Enum.KeyCode.R,
    Enum.KeyCode.T,
    Enum.KeyCode.Y,
    Enum.KeyCode.H
};
local u3 = {
    KeypadOne = "1",
    KeypadTwo = "2",
    KeypadThree = "3",
    KeypadFour = "4",
    KeypadFive = "5",
    KeypadSix = "6",
    KeypadSeven = "7",
    KeypadEight = "8",
    KeypadNine = "9",
    KeypadZero = "0",
    One = "1",
    Two = "2",
    Three = "3",
    Four = "4",
    Five = "5",
    Six = "6",
    Seven = "7",
    Eight = "8",
    Nine = "9",
    Zero = "0"
};
local u4 = { "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Zero" };

function v1.QTE(u5: any, u6: any, p7: number, p8: number, u9: boolean) -- Line: 41
    -- upvalues: u3 (copy), LocalPlayer (copy), u4 (copy), u2 (copy), ReplicatedStorage (copy), UserInputService (copy), TweenService (copy), Debris (copy), soundUtil (copy), SoundService (copy)
    if typeof(u5) == "EnumItem" and u3[u5.Name] then
        local v10 = u3[u5.Name];
        local Character = LocalPlayer.Character;

        if Character then
            for i = 4, 5 do
                local v11 = `copiedskill{i}`;

                if typeof(Character:GetAttribute(v11)) == "string" and string.split(Character:GetAttribute((`copiedskill{i}`)), "|")[2] == v10 then
                    u5 = Enum.KeyCode[u4[i]];
                    break;
                end;

                local _ = i;
            end;
        end;
    end;

    local u12 = 0;

    local function spawnQTE() -- Line: 60
        -- upvalues: u5 (ref), u2 (ref), u6 (copy), ReplicatedStorage (ref), LocalPlayer (ref), UserInputService (ref), u3 (ref), TweenService (ref), Debris (ref), u12 (ref), u9 (copy), soundUtil (ref), SoundService (ref)
        u5 = u5 or u2[Random.new():NextInteger(1, #u2)];
        local u13 = u6 - 0.15;
        local v14 = ReplicatedStorage.Resources.Qte:Clone();
        v14.Parent = LocalPlayer.PlayerGui;
        local QTE = v14.QTE;
        local u15 = false;
        local v16 = nil;
        local v17 = nil;

        if UserInputService.TouchEnabled then
            QTE.TextLabel.Text = "Click";
            v17 = QTE.Button.MouseButton1Click:Once(function() -- Line: 78
                -- upvalues: u15 (ref)
                u15 = true;
            end);
        else
            local v18 = (UserInputService.GamepadEnabled or UserInputService.TouchEnabled) and not table.find({
                Enum.UserInputType.Keyboard,
                Enum.UserInputType.MouseButton1,
                Enum.UserInputType.MouseButton2,
                Enum.UserInputType.MouseMovement,
                Enum.UserInputType.MouseWheel
            }, UserInputService:GetLastInputType());

            if v18 then
                u5 = Enum.KeyCode.ButtonB;
                QTE.TextLabel.Text = "B";
            else
                local Name = u5.Name;
                local v19 = u3[Name];

                if v19 then
                    Name = v19 or Name;
                end;

                QTE.TextLabel.Text = Name;
            end;

            v16 = UserInputService.InputBegan:Connect(function(p20: userdata, p21: any) -- Line: 97
                -- upvalues: u5 (ref), u15 (ref)
                if p21 then
                    return;
                end;

                if p20.KeyCode == u5 then
                    u15 = true;
                end;
            end);
        end;

        local u22 = TweenService:Create(QTE.Prototype.UIStroke, TweenInfo.new(u13, Enum.EasingStyle.Linear), {
            Thickness = 0
        });
        u22:Play();
        task.delay(u13, function() -- Line: 109
            -- upvalues: QTE (copy), TweenService (ref), u6 (ref), u13 (copy)
            QTE.TextLabel.BackgroundColor3 = Color3.new(0, 255, 0);
            TweenService:Create(QTE.TextLabel, TweenInfo.new(u6 - u13, Enum.EasingStyle.Linear), {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            }):Play();
        end);
        local os_clock_ret = os.clock();

        repeat
            task.wait();
        until u6 <= os.clock() - os_clock_ret or u15;

        if v16 then
            v16:Disconnect();
        end;

        if v17 then
            v17:Disconnect();
        end;

        TweenService:Create(QTE, TweenInfo.new(0.25), {
            GroupTransparency = 1
        }):Play();
        Debris:AddItem(v14, 0.5);

        local function check(p23: boolean) -- Line: 128
            -- upvalues: u12 (ref), u9 (ref), soundUtil (ref), ReplicatedStorage (ref), SoundService (ref), TweenService (ref), QTE (copy), u22 (copy)
            if p23 then
                u12 = u12 + 1;
            end;

            if u9 ~= true then
                soundUtil:play(ReplicatedStorage.Resources[p23 and "qteW" or "qteF"], SoundService);
            end;

            TweenService:Create(QTE.Prototype.UIStroke, TweenInfo.new(0.25), {
                Thickness = 0.2,
                Color = p23 and Color3.new(255, 255, 255) or Color3.fromRGB(0, 0, 0)
            }):Play();

            if not p23 then
                u22:Cancel();
            end;
        end;

        if os.clock() - os_clock_ret < u6 then
            if u13 <= os.clock() - os_clock_ret and u15 then
                check(true);
            else
                check(false);
            end;
        else
            check(false);
        end;

        u5 = nil;
    end;

    if p7 then
        for i = 1, p7 do
            spawnQTE();
            task.wait(u6 + (p8 or 0.05));
            local _ = i;
        end;
    else
        spawnQTE();
    end;

    return u12;
end;

function v1.GetHioriPosition() -- Line: 168
    return shared.hioriMarker or workspace.map.centrePoint.CFrame;
end;

function v1.GetKiyoraSide() -- Line: 172
    return shared.kiyoraSide or 0;
end;

function v1.kaiser_shot_flow_aim() -- Line: 176
    return shared.kaiser_shot_flow_aim;
end;

local function getOptionValue(p24, p25) -- Line: 180
    if typeof(p24) == "table" then
        return p24[p25];
    end;
end;

function v1.GetClosestToMouse(p26, p27) -- Line: 186
    -- upvalues: LocalPlayer (copy), UserInputService (copy), workspace_CurrentCamera (copy), Mouse (copy), actionUtil (copy)
    local Character = LocalPlayer.Character;
    local v28 = Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart;
    local v29 = (UserInputService.GamepadEnabled or UserInputService.TouchEnabled) and Vector2.new(workspace_CurrentCamera.ViewportSize.X / 2, workspace_CurrentCamera.ViewportSize.Y / 2) or Vector2.new(Mouse.X, Mouse.Y, Mouse.Hit.Position);
    local v30 = nil;
    local v31 = nil;

    for _, child in ipairs(workspace.characters:GetChildren()) do
        if child ~= Character then
            local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart");
            local v32 = child:FindFirstChildOfClass("Humanoid");

            if v32 and (v32.Health > 0 and HumanoidRootPart) then
                local v33 = actionUtil.checksameTeam(Character, child);
                local v34;

                if typeof(p27) == "table" then
                    v34 = p27.All;
                else
                    v34 = nil;
                end;

                if (v34 or v33) and p26 > (HumanoidRootPart.Position - v28.Position).Magnitude then
                    local v35, v36 = workspace_CurrentCamera:WorldToScreenPoint(HumanoidRootPart.Position);
                    local Vector2_new_ret = Vector2.new(v35.X, v35.Y);

                    if v36 then
                        local Magnitude = (v29 - Vector2_new_ret).Magnitude;

                        if not (v30 and (v31 and Magnitude >= v31)) then
                            v31 = Magnitude;
                            v30 = child;
                        end;
                    end;
                end;
            end;
        end;
    end;

    return v30;
end;

function v1.movement_direction() -- Line: 226
    return shared.moveVector or Vector3.new(0, 0, 0);
end;

return v1;