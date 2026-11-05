  

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");

return function(u1) -- Line: 4
    -- upvalues: Players (copy), ReplicatedStorage (copy)
    local _ = u1.Xtal;
    local LocalPlayer = Players.LocalPlayer;
    local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
    local Knit = require(PathShortcuts.KnitPath.Knit);
    local Trove = require(PathShortcuts.KnitPath.Trove);
    ReplicatedStorage:WaitForChild("Remotes");
    local QuestLines = LocalPlayer:WaitForChild("QuestLines");
    local v2 = Trove.new();
    Knit.OnStart():await();
    local u3 = require(script.QuestUI).new(script.Parent, u1);

    for _, child in ipairs(QuestLines:GetChildren()) do
        u3:AddQuestlineEntry(child);
    end;

    v2:Connect(QuestLines.ChildAdded, function(p4) -- Line: 25
        -- upvalues: u3 (copy)
        u3:AddQuestlineEntry(p4);
    end);
    v2:Connect(QuestLines.ChildRemoved, function(p5) -- Line: 28
        -- upvalues: u3 (copy)
        u3:RemoveQuestlineEntry(p5);
    end);

    function u1.QuestUI_AutoUpdatePinnedQuest(p6, p7, p8) -- Line: 32
        -- upvalues: u3 (copy)
        u3:AutoUpdate_PinnedQuest(p7, p8);
    end;

    script.Parent.Refresh.MouseButton1Click:Connect(function() -- Line: 37
        -- upvalues: u1 (copy), QuestLines (copy), u3 (copy)
        u1:PlaySound("Click");

        for _, child in ipairs(QuestLines:GetChildren()) do
            u3:RemoveQuestlineEntry(child);
        end;

        for _, child in ipairs(QuestLines:GetChildren()) do
            u3:AddQuestlineEntry(child);
        end;
    end);
    script.Parent:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 47
        -- upvalues: QuestLines (copy), u3 (copy)
        for _, child in ipairs(QuestLines:GetChildren()) do
            u3:RemoveQuestlineEntry(child);
        end;

        for _, child in ipairs(QuestLines:GetChildren()) do
            u3:AddQuestlineEntry(child);
        end;
    end);
    script.Parent.Discard.Visible = false;
    script.Parent.Discard.MouseButton1Click:Connect(function() -- Line: 57
        -- upvalues: u1 (copy), u3 (copy)
        u1:PlaySound("Click");
        u3:DiscardQuestline();
    end);
end;