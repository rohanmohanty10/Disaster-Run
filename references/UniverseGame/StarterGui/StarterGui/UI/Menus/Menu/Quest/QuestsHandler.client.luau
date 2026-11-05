  

 

local LocalPlayer = game.Players.LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
Knit.OnStart():await();
Knit.GetController("ContainerController");
local QuestGUI = LocalPlayer.PlayerGui:WaitForChild("Core"):WaitForChild("QuestGUI");
local QuestPage = QuestGUI.QuestFrame.QuestPage;
local Assets = QuestGUI.Assets;
local _ = QuestGUI.Close;
local Close = QuestGUI.Close;
script.Parent.MouseButton1Down:Connect(function() -- Line: 19
    -- upvalues: QuestGUI (copy)
    if QuestGUI.Enabled == true then
        return;
    end;

    QuestGUI.Enabled = true;
end);
Close.MouseButton1Down:Connect(function() -- Line: 23
    -- upvalues: QuestGUI (copy)
    if QuestGUI.Enabled == false then
        return;
    end;

    QuestGUI.Enabled = false;
end);
local QuestLines = LocalPlayer:WaitForChild("QuestLines");

local function CreateQuestFrame(p1) -- Line: 32
    -- upvalues: Assets (copy)
    local v2 = Assets.HeaderFrame:Clone();
    v2.Name = p1;
    v2.HeaderTXT.Text = p1;
    v2.Visible = true;

    return v2;
end;

local function CreateTaskFrame(p3) -- Line: 40
    -- upvalues: Assets (copy)
    local v4 = Assets.InfoFrame:Clone();
    v4.InfoTXT.Text = p3;
    v4.Visible = true;

    return v4;
end;

local function updateQuestCanvas() -- Line: 47
    -- upvalues: QuestPage (copy)
    QuestPage.CanvasSize = UDim2.fromOffset(0, QuestPage.UIListLayout.AbsoluteContentSize.Y + 25);
end;

local function AddQuest(p5, p6) -- Line: 51
    -- upvalues: Trove (copy), Assets (copy), QuestPage (copy)
    local v7 = Trove.new();
    v7:AttachToInstance(p5);
    local v8 = p6 or p5.Name;
    local v9 = Assets.HeaderFrame:Clone();
    v9.Name = v8;
    v9.HeaderTXT.Text = v8;
    v9.Visible = true;
    v7:Add(v9);
    v9.Parent = QuestPage;
    local InfoPage = v9.InfoPage;

    local function updateInfoCanvas() -- Line: 59
        -- upvalues: InfoPage (copy)
        if not InfoPage then
            return;
        end;

        InfoPage.CanvasSize = UDim2.fromOffset(0, InfoPage.UIListLayout.AbsoluteContentSize.Y + 25);
    end;

    local function AddTask(u10) -- Line: 64
        -- upvalues: Assets (ref), InfoPage (copy)
        local Name = u10.Name;
        local u11 = Assets.InfoFrame:Clone();
        u11.InfoTXT.Text = Name;
        u11.Visible = true;
        u11.Parent = InfoPage;
        u10.Changed:Connect(function(p12) -- Line: 68, Name: updateProgress
            -- upvalues: u10 (copy), u11 (copy)
            local v13 = u10:GetAttribute("MaxValue");
            u11.EmptyMeter.ProgressTXT.Text = tostring(p12) .. " / " .. tostring(v13);
            u11.EmptyMeter.ProgressMeter.Size = UDim2.new(p12 / v13, 0, 1, 0);
        end);
        u10:GetAttributeChangedSignal("MaxValue"):Connect(function() -- Line: 77
            -- upvalues: u10 (copy), u11 (copy)
            local Value = u10.Value;
            local v14 = u10:GetAttribute("MaxValue");
            u11.EmptyMeter.ProgressTXT.Text = tostring(Value) .. " / " .. tostring(v14);
            u11.EmptyMeter.ProgressMeter.Size = UDim2.new(Value / v14, 0, 1, 0);
        end);
        local Value = u10.Value;
        local v15 = u10:GetAttribute("MaxValue");
        u11.EmptyMeter.ProgressTXT.Text = tostring(Value) .. " / " .. tostring(v15);
        u11.EmptyMeter.ProgressMeter.Size = UDim2.new(Value / v15, 0, 1, 0);

        if not InfoPage then
            return;
        end;

        InfoPage.CanvasSize = UDim2.fromOffset(0, InfoPage.UIListLayout.AbsoluteContentSize.Y + 25);
    end;

    p5.ChildAdded:Connect(function(p16) -- Line: 85
        -- upvalues: AddTask (copy)
        AddTask(p16);
    end);

    for _, child in ipairs(p5:GetChildren()) do
        AddTask(child);
    end;
end;

local u17 = {
    Quests = true
};

local function AddQuestLine(u18) -- Line: 99
    -- upvalues: u17 (copy), AddQuest (copy), QuestPage (copy)
    u18.ChildAdded:Connect(function(p19) -- Line: 101, Name: CheckQuest
        -- upvalues: u17 (ref), u18 (copy), AddQuest (ref), QuestPage (ref)
        if u17[u18.Name] then
            AddQuest(p19);
        else
            AddQuest(p19, u18.Name);
        end;

        QuestPage.CanvasSize = UDim2.fromOffset(0, QuestPage.UIListLayout.AbsoluteContentSize.Y + 25);
    end);

    for _, child in ipairs(u18:GetChildren()) do
        if u17[u18.Name] then
            AddQuest(child);
        else
            AddQuest(child, u18.Name);
        end;

        QuestPage.CanvasSize = UDim2.fromOffset(0, QuestPage.UIListLayout.AbsoluteContentSize.Y + 25);
    end;
end;

QuestLines.ChildAdded:Connect(AddQuestLine);

for _, child in ipairs(QuestLines:GetChildren()) do
    AddQuestLine(child);
end;