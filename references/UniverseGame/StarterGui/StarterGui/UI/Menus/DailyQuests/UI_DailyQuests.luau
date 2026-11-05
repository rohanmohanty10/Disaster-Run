  

 

Color3.fromRGB(255, 106, 106);
Color3.fromRGB(138, 255, 138);
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local _ = game:GetService("Players").LocalPlayer;
local Trove = require(ReplicatedStorage.ReplicatedRoot.Libraries.Classes.Trove);
local QuestTemplate = require(script.QuestTemplate);
local Parent = script.Parent;
local Quests = Parent.Quests;
local Info = Parent.Info;

local function ScaleBar(p1, p2, p3) -- Line: 18
    p1.Size = UDim2.fromScale(p2 / p3, 1);
    p1.Visible = p2 / p3 ~= 0;
end;

local function MakeQuestButton(p4, p5) -- Line: 23
    -- upvalues: Trove (copy), QuestTemplate (copy)
    local u6 = Trove.new();
    local Current = p5.Current;
    local Required = p5.Required;
    local u7 = u6:Add(QuestTemplate());
    u7.NameLabel.Text = p4;
    u7.ProgressLabel.Text = `Progress: {math.round(Current * 100) / 100}/{Required}`;
    local Bar = u7.ProgressBar.Bar;
    local v8 = Current;
    local v9 = Required;
    Bar.Size = UDim2.fromScale(v8 / v9, 1);
    Bar.Visible = v8 / v9 ~= 0;
    u7.Holder.BackgroundColor3 = Color3.fromRGB(255, 106, 106):Lerp(Color3.fromRGB(138, 255, 138), Current / Required);
    u7.Holder.UIStroke.Color = Color3.fromRGB(255, 106, 106):Lerp(Color3.fromRGB(138, 255, 138), Current / Required);
    u7.Seperator.BackgroundColor3 = Color3.fromHex("#ffb7b7"):Lerp(Color3.fromHex("#b5ffb4"), Current / Required);
    local u10 = {};

    return {
        SetProgress = function(p11) -- Line: 42, Name: SetProgress
            -- upvalues: Current (ref), u7 (copy), Required (ref)
            Current = p11;
            u7.ProgressLabel.Text = `Progress: {math.round(Current * 100) / 100}/{Required}`;
            local Bar2 = u7.ProgressBar.Bar;
            local v12 = Current;
            local v13 = Required;
            Bar2.Size = UDim2.fromScale(v12 / v13, 1);
            Bar2.Visible = v12 / v13 ~= 0;
        end,

        SetRequired = function(p14) -- Line: 49, Name: SetRequired
            -- upvalues: Required (ref), u7 (copy), Current (ref)
            Required = p14;
            u7.ProgressLabel.Text = `Progress: {math.round(Current * 100) / 100}/{Required}`;
            local Bar2 = u7.ProgressBar.Bar;
            local v15 = Current;
            local v16 = Required;
            Bar2.Size = UDim2.fromScale(v15 / v16, 1);
            Bar2.Visible = v15 / v16 ~= 0;
        end,

        GetTrove = function() -- Line: 56, Name: GetTrove
            -- upvalues: Trove (ref)
            return Trove;
        end,

        GetInstance = function() -- Line: 60, Name: GetInstance
            -- upvalues: u7 (copy)
            return u7;
        end,

        GetConnection = function() -- Line: 64, Name: GetConnection
            -- upvalues: u10 (copy)
            return u10;
        end,

        GetCurrent = function() -- Line: 68, Name: GetCurrent
            -- upvalues: Current (ref)
            return Current;
        end,

        GetRequired = function() -- Line: 72, Name: GetRequired
            -- upvalues: Required (ref)
            return Required;
        end,

        Destroy = function() -- Line: 76, Name: Destroy
            -- upvalues: u6 (copy)
            u6:Destroy();
        end
    };
end;

return function(u17) -- Line: 82
    -- upvalues: MakeQuestButton (copy), Quests (copy), Parent (copy), Info (copy)
    local Knit = u17.Knit;
    Knit.OnStart():await();
    local u18 = Knit.GetService("PlayerDataService");
    local u19 = Knit.GetService("ShopService");
    local u20 = {};
    local v21 = DateTime.now();
    local v22 = v21:ToUniversalTime();
    local u23 = v21.UnixTimestamp + (86400 - (v22.Hour * 3600 + v22.Minute * 60 + v22.Second));
    local u24 = os.time();

    local function Update() -- Line: 98
        -- upvalues: u20 (copy), u18 (copy), MakeQuestButton (ref), Quests (ref), Parent (ref), u24 (ref), u23 (ref), Info (ref)
        for _, v in u20 do
            v.Destroy();
        end;

        for i, v in u18:GetDailyQuests():expect() do
            local v25 = MakeQuestButton(i, v);
            local v26 = v25.GetInstance();
            v26.Visible = true;
            v26.Parent = Quests;
            u20[i] = v25;
        end;

        while Parent.Visible do
            u24 = os.time();

            if u23 <= u24 then
                local v27 = DateTime.now();
                local v28 = v27:ToUniversalTime();
                u23 = v27.UnixTimestamp + (86400 - (v28.Hour * 3600 + v28.Minute * 60 + v28.Second));
            end;

            local v29 = math.max(0, u23 - u24);
            local v30 = math.floor(v29 / 3600);
            local v31 = math.floor(v29 % 3600 / 60);
            Info.TimerLabel.Text = string.format("Refreshes in: %02d:%02d:%02d", v30, v31, v29 % 60);
            task.wait(1);
        end;
    end;

    Info.Refresh.MouseButton1Click:Connect(function() -- Line: 134
        -- upvalues: u17 (copy), u19 (copy), u18 (copy)
        u17:PlaySound("Click");
        local v32 = u19:GetCurrencyType("UFragments"):expect();
        local v33 = v32 - 1;

        if v32 >= 1 then
            u17:ServerNewPrompt({
                Title = "Refresh Daily Quests?",
                Delay = 2,
                Text = `Note that this costs 1 uFragment, After this purchase you will have {v33 == 0 and "<font color=\'#ff5050\'>no</font>" or v33} uFragment{v33 == 1 and "" or "s"} left after this`,
                Options = { "Yes", "No" },

                Callback = function(p34) -- Line: 146, Name: Callback
                    -- upvalues: u17 (ref), u18 (ref), u19 (ref)
                    if p34.Choice ~= 1 then
                        return;
                    end;

                    u17:SetMenu(nil);
                    u18:RefreshDailyQuests();
                    local v35 = u19:GetCurrencyType("UFragments"):expect();
                    u17:ServerNewPrompt({
                        Title = "Completed Purchase",
                        Text = `You have {v35 == 0 and "<font color=\'#ff5050\'>no</font>" or v35} uFragment{v35 == 1 and "" or "s"} left`
                    });
                end
            });

            return;
        end;

        u17:ServerNewPrompt({
            Title = "Not enough uFragments",
            Text = "Need 1 uFragment to purchase this item"
        });
    end);
    Info.Shop.MouseButton1Click:Connect(function() -- Line: 167
        -- upvalues: Parent (ref), u17 (copy)
        Parent.Visible = false;
        u17:PlaySound("Click");
        u17:OpenDailyQuestShop();
    end);
    Parent:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 173
        -- upvalues: Parent (ref), Update (copy)
        if Parent.Visible then
            Update();
        end;
    end);

    function u17.ShowDailyQuests(p36) -- Line: 179
        -- upvalues: Parent (ref)
        p36:SetMenu("Daily Quests");
        Parent.Visible = true;
    end;

    if Parent.Visible then
        task.spawn(Update);
    end;
end;