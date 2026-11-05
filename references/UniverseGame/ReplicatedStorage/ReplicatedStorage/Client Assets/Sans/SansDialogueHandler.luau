  

 

game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
local Players = game:GetService("Players");
local SansDialogueStuff = script.Parent.SansDialogueStuff;
local u1 = {
    ["!"] = 0.5,
    ["."] = 0.5,
    [","] = 0.5,
    ["?"] = 0.5
};
local u2 = {
    "rbxassetid://" .. 8123052157,
    "rbxassetid://" .. 8124257941,
    "rbxassetid://" .. 8123074557,
    "rbxassetid://" .. 8123075948,
    "rbxassetid://" .. 8123078719,
    "rbxassetid://" .. 8123080609,
    "rbxassetid://" .. 8123082053
};
local u3 = {};

function u3.NewDialogue(u4) -- Line: 24
    -- upvalues: Players (copy), SansDialogueStuff (copy), u2 (copy), u1 (copy), u3 (copy)
    local SoundEffect = game:GetService("SoundService"):WaitForChild("SoundEffect");
    local u5 = u4.Target or Players.LocalPlayer;

    if u5.PlayerGui:FindFirstChild("SansDialogueStuff") then
        u5.PlayerGui:FindFirstChild("SansDialogueStuff"):Destroy();
    end;

    local u6 = SansDialogueStuff:Clone();
    u6.Parent = u5.PlayerGui;
    task.spawn(function() -- Line: 37
        -- upvalues: u4 (copy), u6 (copy), u2 (ref), SoundEffect (copy), u1 (ref), u3 (ref), u5 (copy)
        local v7 = u4.Custom or nil;

        if v7 then
            v7(#u4.Dialogue, {
                Line = u4.Dialogue[u4.CurrentDialogue or 1],
                UI = u6
            });
        end;

        local Expression = u4.Expression;
        local v8 = type(Expression) == "table";
        local _ = u4.CurrentExpression or 1;
        local v9;

        if v8 then
            v9 = Expression[1];
        else
            v9 = Expression;
        end;

        u6.f.Expressions.ExpressionSheet.Image = u2[v9];
        local Dialogue = u4.Dialogue;
        local Dialogue2 = u6.f:FindFirstChild("Dialogue");
        Dialogue2.MaxVisibleGraphemes = 0;
        local v10 = u4.PrefixIgnore or false;
        local v11 = u4.Interval or 0.03;
        local v12 = u4.Voice or true;
        local v13;

        if type(v10) == "table" then
            v13 = v10[1];
        else
            v13 = v10;
        end;

        local v14;

        if type(v11) == "table" then
            v14 = v11[1];
        else
            v14 = v11;
        end;

        local v15;

        if type(v12) == "table" then
            v15 = v12[1];
        else
            v15 = v12;
        end;

        local v16 = type(Dialogue) == "table";
        local v17 = u4.CurrentDialogue or 1;
        Dialogue2.Text = "* " .. Dialogue[v17];

        for i = 1, #Dialogue2.Text do
            if not u6.Parent then
                return;
            end;

            Dialogue2.MaxVisibleGraphemes = i;
            local v18 = string.sub(Dialogue2.Text, i, i);

            if v18 ~= " " and v15 then
                coroutine.wrap(function() -- Line: 103
                    -- upvalues: u6 (ref), SoundEffect (ref)
                    local v19 = u6.f.Talk:Clone();
                    v19.SoundGroup = SoundEffect;
                    v19.Parent = u6.f;
                    v19:Play();
                    v19.Ended:Wait();
                    v19:Destroy();
                end)();
            end;

            task.wait(v13 and (v14 or 0.03) or u1[v18]);
        end;

        task.wait(1);

        if not v16 then
            u6:Destroy();

            return;
        end;

        if #Dialogue == v17 then
            u6:Destroy();

            return;
        end;

        if type(Expression) == "table" then
            table.remove(Expression, 1);
        end;

        table.remove(Dialogue, 1);

        if type(v12) == "table" then
            table.remove(v12, 1);
        end;

        if type(v11) == "table" then
            table.remove(v11, 1);
        end;

        if type(v10) == "table" then
            table.remove(v10, 1);
        end;

        u6:Destroy();
        u3.NewDialogue({
            Target = u5,
            Expression = Expression,
            Dialogue = Dialogue,
            Interval = v11,
            PrefixIgnore = v10,
            Voice = v12
        });
    end);
end;

return u3;