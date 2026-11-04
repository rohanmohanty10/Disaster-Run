 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local roland = require(ReplicatedStorage.shared.style.roland);
local Color3_fromRGB_ret = Color3.fromRGB(255, 200, 60);
local Color3_fromRGB_ret2 = Color3.fromRGB(150, 150, 150);

return function(p1: any, p2: userdata) -- Line: 12
    -- upvalues: ReplicatedStorage (copy), roland (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), RunService (copy)
    local character = p1.character;
    local v3 = p1.charContainer:Extend();
    local Hotbar = p2.Backpack.Hotbar;
    local ballHolder = ReplicatedStorage.workspace.ballHolder;
    local UIGradient = p2.MagicHealth.Health.Frame.UIGradient;
    UIGradient.Rotation = 0;

    local function card_name(p4: string) -- Line: 20
        -- upvalues: roland (ref), ballHolder (copy), character (copy)
        local v5 = roland[p4];

        if not v5 then
            return "";
        end;

        if v5.off and ballHolder.Value ~= character then
            return v5.off;
        end;

        return v5.on;
    end;

    local function refresh() -- Line: 28
        -- upvalues: character (copy), Hotbar (copy), roland (ref), ballHolder (copy)
        local v6 = (character:GetAttribute("RolandHand") or ""):split(",");

        for i = 1, 4 do
            local v7 = Hotbar:FindFirstChild((`skill{i}`));
            local v8;

            if v7 then
                local v9 = v6[i];
                local v10;

                if v9 == nil then
                    v10 = false;
                else
                    v10 = v9 ~= "";
                end;

                v7.Visible = v10;
                local v11;

                if v7.Visible then
                    local v12 = roland[v9];

                    if v12 then
                        if v12.off and ballHolder.Value ~= character then
                            v11 = v12.off;
                        else
                            v11 = v12.on;
                        end;
                    else
                        v11 = "";
                    end;
                else
                    v11 = "";
                end;

                v7.Base.ToolName.Text = v11;
                v7.Base.Reuse.Visible = false;
                v8 = i;
            else
                v8 = i;
            end;
        end;

        local skill5 = Hotbar:FindFirstChild("skill5");

        if skill5 then
            local Attribute = character:GetAttribute("RolandQueue");
            skill5.Visible = Attribute ~= nil;
            local v13;

            if Attribute then
                local v14 = roland[Attribute];

                if v14 then
                    if v14.off and ballHolder.Value ~= character then
                        v13 = v14.off;
                    else
                        v13 = v14.on;
                    end;
                else
                    v13 = "";
                end;
            else
                v13 = "";
            end;

            skill5.Base.ToolName.Text = v13;
            skill5.Base.Reuse.Visible = true;
            skill5.Base.Number.Text = "?";
        end;
    end;

    local skill5 = Hotbar:FindFirstChild("skill5");

    if skill5 then
        skill5.Base.BackgroundColor3 = Color3.new(1, 1, 1);
        skill5.Base.ToolName.TextColor3 = Color3.new(0, 0, 0);
        skill5.Base.ToolName.TextStrokeTransparency = 1;
        skill5.Base.Reuse.TextColor3 = Color3.new(0, 0, 0);
        skill5.Base.Reuse.TextStrokeTransparency = 1;
        skill5.Cooldown.BackgroundColor3 = Color3_fromRGB_ret2;
    end;

    local Tspecialer = Hotbar:FindFirstChild("Tspecialer");

    if Tspecialer then
        local BackgroundColor3 = Tspecialer.Base.BackgroundColor3;
        v3:Connect(character:GetAttributeChangedSignal("RolandRedraw"), function() -- Line: 63
            -- upvalues: Tspecialer (copy), character (copy), Color3_fromRGB_ret (ref), BackgroundColor3 (copy)
            local Base = Tspecialer.Base;
            local v15;

            if character:GetAttribute("RolandRedraw") then
                v15 = Color3_fromRGB_ret;
            else
                v15 = BackgroundColor3;
            end;

            Base.BackgroundColor3 = v15;
        end);
    end;

    v3:Connect(character.AttributeChanged, function(p16) -- Line: 68
        -- upvalues: refresh (copy)
        if p16 == "RolandHand" or p16 == "RolandQueue" then
            refresh();
        end;
    end);
    v3:Connect(ballHolder.Changed, refresh);
    refresh();
    v3:Connect(RunService.RenderStepped, function() -- Line: 76
        -- upvalues: Hotbar (copy), character (copy), UIGradient (copy)
        local skill52 = Hotbar:FindFirstChild("skill5");
        local Attribute = character:GetAttribute("RolandQueueStart");
        local Attribute2 = character:GetAttribute("RolandQueueReady");

        if skill52 and (Attribute and Attribute2) then
            local v17 = Attribute2 - workspace:GetServerTimeNow();
            local v18 = Attribute >= Attribute2 and 0 or math.clamp(v17 / (Attribute2 - Attribute), 0, 1);
            skill52.Cooldown.Visible = v18 > 0;
            skill52.Cooldown.Size = UDim2.new(1, 0, -v18, 0);
            skill52.Base.Reuse.Text = v17 <= 0 and "READY" or `NEXT {math.ceil(v17)}s`;
        end;

        local v19 = os.clock() * 0.6;
        local table_create_ret = table.create(12);

        for i = 0, 11 do
            local v20 = i / 11;
            local v21 = math.sin((v20 * 1.5 - v19) * 3.141592653589793 * 2) * 0.5 + 0.5;
            table_create_ret[i + 1] = ColorSequenceKeypoint.new(v20, Color3.new(v21, v21, v21));
            local _ = i;
        end;

        UIGradient.Color = ColorSequence.new(table_create_ret);
    end);
end;