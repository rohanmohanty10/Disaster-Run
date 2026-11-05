  

 

return function(p1) -- Line: 1
    local PathShortcuts = p1.PathShortcuts;
    local TweenService = game:GetService("TweenService");
    local _ = game.Players.LocalPlayer;
    local Parent = script.Parent;
    local Assets = Parent.Assets;
    local u2 = "None";
    local u3 = "";
    local HideBtn = script.Parent:WaitForChild("HideBtn");
    HideBtn.MouseButton1Click:Connect(function() -- Line: 12
        -- upvalues: Parent (copy), TweenService (copy), HideBtn (copy)
        if Parent:GetAttribute("Hidden") then
            Parent:SetAttribute("Hidden", false);
            TweenService:Create(Parent, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0.004, 0.356)
            }):Play();
            HideBtn.Text = "<";

            return;
        end;

        Parent:SetAttribute("Hidden", true);
        TweenService:Create(Parent, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(-0.075, 0.356)
        }):Play();
        HideBtn.Text = ">";
    end);

    function p1.AddPinnedQuest(p4, p5, p6, p7) -- Line: 28
        -- upvalues: Parent (copy)
        p4:SetCurrentPinnedQuestNameInternal(p5);
        p4:UpdatePinnedQuestTasks(p6);
        p4:SetPinnedQuestName(p5);
        p4:ShowPinnedQuestOverlay();
        local v8 = 0;

        for _, _ in p7 or {} do
            v8 = v8 + 1;
        end;

        print(p7);

        if not p7 or v8 <= 0 then
            Parent.Rewards.Visible = false;
            Parent.RewardTitle.Visible = false;
            Parent["2ndMiddleSplitter"].Visible = false;

            return;
        end;

        Parent.Rewards.Visible = true;
        Parent.RewardTitle.Visible = true;
        Parent["2ndMiddleSplitter"].Visible = true;
        p4:UpdatePinnedRewards(p7);
    end;

    function p1.SetCurrentPinnedQuestNameInternal(p9, p10) -- Line: 53
        -- upvalues: u2 (ref)
        u2 = p10;
    end;

    function p1.GetPinnedQuestName(p11) -- Line: 57
        -- upvalues: u2 (ref)
        return u2;
    end;

    function p1.SetLastUnpinnedQuestName(p12, p13) -- Line: 61
        -- upvalues: u3 (ref)
        u3 = p13;
    end;

    function p1.GetLastUnpinnedQuestName(p14) -- Line: 65
        -- upvalues: u3 (ref)
        return u3;
    end;

    function p1.SetPinnedQuestName(p15, p16) -- Line: 69
        -- upvalues: Parent (copy), TweenService (copy)
        Parent.QuestName.Text = p16;
        Parent.QuestName.TextTransparency = 1;
        TweenService:Create(Parent.QuestName, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            TextTransparency = 0,
            MaxVisibleGraphemes = utf8.len(p16)
        }):Play();
        Parent.MiddleSplitter.Size = UDim2.new(0, 0, 0, 1);
        TweenService:Create(Parent.MiddleSplitter, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0.9, 0, 0, 1)
        }):Play();
    end;

    function p1.UpdatePinnedQuestTasks(p17, p18) -- Line: 84
        p17:ClearPinnedQuestTasks();

        for i, _ in p18 do
            p17:MakePinnedTaskLabel(i);
        end;
    end;

    function p1.AutoClosePinnedQuest(u19, p20) -- Line: 92
        local v21 = u19:GetPinnedQuestName();
        print("UGOCLOSE: CURRENT = ", v21);
        local v22 = p20 == v21;
        print("UGOCLOSE: PIN MATCH", v22);

        if v22 then
            u19:HidePinnedQuestOverlay();
            task.delay(0.35, function() -- Line: 99
                -- upvalues: u19 (copy)
                u19:QuestUI_AutoUpdatePinnedQuest();
            end);
        end;
    end;

    function p1.UpdatePinnedRewards(p23, p24) -- Line: 105
        p23:ClearRewards();

        for i, _ in p24 do
            p23:MakePinnedRewardLabel(i);
        end;
    end;

    function p1.ClearPinnedQuestTasks(p25) -- Line: 113
        -- upvalues: Parent (copy)
        for _, child in Parent.Tasks:GetChildren() do
            if child:IsA("TextLabel") then
                child:Destroy();
            end;
        end;
    end;

    function p1.ClearRewards(p26) -- Line: 121
        -- upvalues: Parent (copy)
        for _, child in Parent.Rewards:GetChildren() do
            if child:IsA("TextLabel") then
                child:Destroy();
            end;
        end;
    end;

    function p1.MakePinnedTaskLabel(p27, p28) -- Line: 129
        -- upvalues: Assets (copy), Parent (copy)
        local Name = p28.Name;
        local v29 = {
            TaskValue = p28.Value,
            MaxTaskValue = p28:GetAttribute("MaxValue")
        };
        local v30 = Assets.Task:Clone();
        v30.Name = Name;
        v30.Visible = true;

        if typeof(v29.TaskValue) == "number" then
            local v31 = v29.TaskValue == v29.MaxTaskValue and "rgb(90,255,90)" or "rgb(255,90,90)";
            local TaskValue = v29.TaskValue;

            if typeof(v29.TaskValue) == "number" then
                TaskValue = p27:AbbreviateNumber(TaskValue);
            end;

            local MaxTaskValue = v29.MaxTaskValue;

            if typeof(v29.MaxTaskValue) == "number" then
                MaxTaskValue = p27:AbbreviateNumber(MaxTaskValue);
            end;

            v30.Text = `<font color="{v31}">{TaskValue}/{MaxTaskValue}</font> {Name}`;
        elseif typeof(v29.TaskValue) == "boolean" then
            v30.Text = `<font color="{v29.TaskValue == true and "rgb(90,255,90)" or "rgb(255,90,90)"}">{Name}</font>`;
        end;

        v30.Parent = Parent.Tasks;
    end;

    function p1.MakePinnedRewardLabel(p32, p33) -- Line: 168
        -- upvalues: Assets (copy), Parent (copy)
        local Name = p33.Name;
        local v34 = {
            TaskValue = p33.Value
        };
        local v35 = Assets.Task:Clone();
        v35.Name = Name;
        v35.Visible = true;
        local TaskValue = v34.TaskValue;

        if typeof(v34.TaskValue) == "number" then
            TaskValue = p32:AbbreviateNumber(TaskValue);
        end;

        v35.Text = `<font color="rgb(255,225,103)">{Name} : {TaskValue}</font>`;
        v35.Parent = Parent.Rewards;
    end;

    function p1.ShowPinnedQuestOverlay(p36) -- Line: 187
        -- upvalues: PathShortcuts (copy), Parent (copy), TweenService (copy), HideBtn (copy)
        if PathShortcuts.LinkedPlaces[game.GameId].MainGame ~= game.PlaceId then
            return;
        end;

        Parent.Visible = true;
        Parent.Position = UDim2.fromScale(-0.075, 0.356);
        TweenService:Create(Parent, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(0.004, 0.356)
        }):Play();
        HideBtn.Text = "<";
    end;

    function p1.HidePinnedQuestOverlay(p37) -- Line: 199
        -- upvalues: TweenService (copy), Parent (copy), HideBtn (copy)
        TweenService:Create(Parent, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(-0.075, 0.356)
        }):Play();
        task.delay(0.35, function() -- Line: 203
            -- upvalues: Parent (ref)
            Parent.Visible = false;
        end);
        HideBtn.Text = ">";
    end;
end;