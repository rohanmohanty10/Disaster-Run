  

 

game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
local Players = game:GetService("Players");
local DialogueBox = script.DialogueBox;
local SoundService = game:GetService("SoundService");
local u1 = {
    ["!"] = 0.5,
    ["."] = 0.5,
    [","] = 0.5,
    ["?"] = 0.5
};
local u2 = {
    CharacterConfigs = {}
};

function u2.LoadCharacterConfigs() -- Line: 18
    -- upvalues: u2 (copy)
    local CharacterConfig = script:FindFirstChild("CharacterConfig");

    if not CharacterConfig then
        return warn("No Configuration Found");
    end;

    for _, child in CharacterConfig:GetChildren() do
        if child:IsA("ModuleScript") then
            local v3 = require(child);

            if v3 and v3.CharacterName then
                u2.CharacterConfigs[v3.CharacterName] = v3;
            end;
        end;
    end;
end;

function u2.AddCharacterConfig(p4, p5) -- Line: 34
    -- upvalues: u2 (copy)
    if not (p4 and p5) then
        return;
    end;

    u2.CharacterConfigs[p4] = p5;
end;

function u2.GetCharacterConfig(p6) -- Line: 39
    -- upvalues: u2 (copy)
    return u2.CharacterConfigs[p6];
end;

function u2.NewDialogue(u7) -- Line: 43
    -- upvalues: u2 (copy), SoundService (copy), Players (copy), DialogueBox (copy), u1 (copy)
    local u8 = u7.Character or "Sans";
    local u9 = u2.CharacterConfigs[u8];

    if not u9 then
        warn((`Character configuration not found for {u8}`));

        return;
    end;

    local SoundEffect = SoundService:WaitForChild("SoundEffect");
    local u10 = u7.Target or Players.LocalPlayer;

    if u10.PlayerGui:FindFirstChild("DialogueBox") then
        u10.PlayerGui:FindFirstChild("DialogueBox"):Destroy();
    end;

    local u11 = DialogueBox:Clone();
    u11.Parent = u10.PlayerGui;
    task.spawn(function() -- Line: 62
        -- upvalues: u7 (copy), u11 (copy), u8 (copy), u9 (copy), SoundEffect (copy), u1 (ref), u2 (ref), u10 (copy)
        local v12 = u7.Custom or nil;

        if v12 then
            v12(#u7.Dialogue, {
                Line = u7.Dialogue[u7.CurrentDialogue or 1],
                UI = u11,
                Character = u8,
                Config = u9
            });
        end;

        local Expression = u7.Expression;
        local v13 = type(Expression) == "table";
        local _ = u7.CurrentExpression or 1;
        local v14;

        if v13 then
            v14 = Expression[1];
        else
            v14 = Expression;
        end;

        local ExpressionSheet = u9.ExpressionSheet;

        if ExpressionSheet and #ExpressionSheet >= v14 then
            u11.f.Expressions.ExpressionSheet.Image = ExpressionSheet[v14];
        else
            warn((`Expression index out of bounds for character: {u8}`));
            u11.f.Expressions.ExpressionSheet.Image = "";
        end;

        local Dialogue = u7.Dialogue;
        local Dialogue2 = u11.f:FindFirstChild("Dialogue");
        Dialogue2.MaxVisibleGraphemes = 0;
        local v15 = u7.PrefixIgnore or false;
        local v16 = u7.Interval or 0.03;
        local v17 = u7.Voice or true;
        local v18;

        if type(v15) == "table" then
            v18 = v15[1];
        else
            v18 = v15;
        end;

        local v19;

        if type(v16) == "table" then
            v19 = v16[1];
        else
            v19 = v16;
        end;

        local v20;

        if type(v17) == "table" then
            v20 = v17[1];
        else
            v20 = v17;
        end;

        local v21 = type(Dialogue) == "table";
        local v22 = u7.CurrentDialogue or 1;

        if v18 then
            Dialogue2.Text = Dialogue[v22];
        else
            Dialogue2.Text = "* " .. Dialogue[v22];
        end;

        for i = 1, #Dialogue2.Text do
            if not u11.Parent then
                return;
            end;

            Dialogue2.MaxVisibleGraphemes = i;
            local v23 = string.sub(Dialogue2.Text, i, i);

            if v23 ~= " " and v20 then
                coroutine.wrap(function() -- Line: 134
                    -- upvalues: u9 (ref), SoundEffect (ref), u11 (ref)
                    local v24 = script.Talk:Clone();
                    v24.SoundId = u9.VoiceSound;
                    v24.SoundGroup = SoundEffect;
                    v24.Parent = u11.f;
                    v24:Play();
                    v24.Ended:Wait();
                    v24:Destroy();
                end)();
            end;

            task.wait(v18 and (v19 or 0.03) or (u1[v23] or v19));
        end;

        task.wait(1);

        if not v21 then
            u11:Destroy();

            return;
        end;

        if #Dialogue == v22 then
            u11:Destroy();

            return;
        end;

        if type(Expression) == "table" then
            table.remove(Expression, 1);
        end;

        table.remove(Dialogue, 1);

        if type(v17) == "table" then
            table.remove(v17, 1);
        end;

        if type(v16) == "table" then
            table.remove(v16, 1);
        end;

        if type(v15) == "table" then
            table.remove(v15, 1);
        end;

        u11:Destroy();
        u2.NewDialogue({
            Target = u10,
            Character = u8,
            Expression = Expression,
            Dialogue = Dialogue,
            Interval = v16,
            PrefixIgnore = v15,
            Voice = v17,
            Custom = v12
        });
    end);
end;

u2.LoadCharacterConfigs();

return u2;