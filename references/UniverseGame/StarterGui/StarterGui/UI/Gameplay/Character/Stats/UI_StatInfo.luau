  

 

return function(p1) -- Line: 1
    local Parent = script.Parent;
    local u2 = require(p1.Knit.Util.Trove).new();
    require(p1.Knit.Util.Timer);
    require(p1.Knit.Util.Promise);
    local ReplicatedRoot = game:GetService("ReplicatedStorage").ReplicatedRoot;
    p1.Knit.GetService("LevelService");
    local v3 = p1.Knit.GetService("TraitService");
    local u4 = p1.Knit.GetService("StatService");
    local TagService = require(ReplicatedRoot.Services.TagService);
    require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").PVEPackage.TraitHandler);
    game:GetService("RunService");
    local v5 = v3:GetTraitsMetadata():expect();
    local _ = v5.RarityColors;
    local _ = v5.RarityIndices;
    local _ = v5.StatRanges;
    local u6 = p1.Util.Tooltip.GetFromParent(p1.UI:FindFirstChild("Screen"));
    game:GetService("TweenService");
    local u7 = {
        ["Damage Dealt"] = {
            Stats = {
                Attack = true
            },
            Multipliers = {
                DamageMultiplier = true
            },
            Color = Color3.fromRGB(255, 120, 120)
        },
        ["Damage Received"] = {
            Inverse = true,
            Stats = {
                Defense = true
            },
            Multipliers = {
                DamageReceivalMultiplier = true
            },
            Color = Color3.fromRGB(120, 170, 255)
        },
        ["Attack Speed"] = {
            Multipliers = {
                TimescaleMultiplier = true,
                TimescaleDivider = true
            },
            Color = Color3.fromRGB(255, 241, 90)
        },
        ["Movement Speed"] = {
            Multipliers = {
                WalkSpeedMultiplier = true,
                WalkSpeedDivider = true
            },
            Color = Color3.fromRGB(209, 255, 111)
        },
        Heal = {
            Multipliers = {
                HealReceivalMultiplier = true
            },
            Color = Color3.fromRGB(99, 255, 125)
        }
    };
    local u8 = {};

    for _, v in u7 do
        for i in v.Multipliers do
            u8[i] = true;
        end;
    end;

    local function ComputeDamageMultFromStat(p9) -- Line: 86
        return 1 + p9 / (p9 + 200);
    end;

    local function ComputeReductionFromStat(p10) -- Line: 91
        return 1 - p10 / (p10 + 200);
    end;

    local function ChildColor(p11, p12) -- Line: 95
        local v13, v14, v15 = p11:ToHSV();

        return Color3.fromHSV(v13, v14 * (0.6 - p12 / 10), v15);
    end;

    local function Colorize(p16, p17) -- Line: 100
        return `<font color="#{p17:ToHex()}">{p16}</font>`;
    end;

    local function AddTreeLine(p18, p19, p20, p21) -- Line: 104
        return p18 .. p19 .. (p20 and "└── " or "├── ") .. p21 .. "<br />";
    end;

    local function CharacterAdded(p22) -- Line: 108
        -- upvalues: u2 (copy), u7 (copy), TagService (copy), u6 (copy), u8 (copy), u4 (copy), Parent (copy)
        u2:Clean();
        p22:WaitForChild("Humanoid");
        game.Players.LocalPlayer:WaitForChild("Data"):WaitForChild("Ability");
        local Tags = game.Players.LocalPlayer:WaitForChild("Tags");
        local u23 = {};
        local u24 = {};
        local u25 = false;

        local function UpdateInfo() -- Line: 120
            -- upvalues: u25 (ref), u7 (ref), TagService (ref), Tags (copy), u23 (copy), u6 (ref)
            if not u25 then
                return;
            end;

            task.wait();
            local v26 = "";

            for i, v in u7 do
                local u27 = v.Stats or {};
                local v28 = v.Multipliers or {};
                local Color = v.Color;
                local v29 = {};

                for i2 in v28 do
                    if TagService.GetTotal(Tags, i2, 1) ~= 1 then
                        for _, v2 in TagService.GetTagsWithName(Tags, i2) do
                            local v30;

                            if v2.Name:find("Divider") then
                                v30 = 1 / v2.Value;
                            else
                                v30 = v2.Value;
                            end;

                            local v31 = {
                                Text = `{v2.Name}{not v2:GetAttribute("Source") and "" or ` ({v2:GetAttribute("Source")})`}: <b>{string.format("%.2f", v30)}x</b>`,
                                Multiplier = v30
                            };
                            table.insert(v29, v31);
                        end;
                    end;
                end;

                local u32 = {};

                local function AddStat(p33, p34, p35) -- Line: 156
                    -- upvalues: u27 (copy), u32 (copy)
                    if not u27[p33] or p35 == 0 then
                        return;
                    end;

                    local v36 = u32[p33];

                    if not v36 then
                        v36 = {
                            Total = 0,
                            Multiplier = 1,
                            Lines = {}
                        };
                        u32[p33] = v36;
                    end;

                    v36.Total = v36.Total + p35;
                    table.insert(v36.Lines, {
                        Source = p34,
                        Value = p35
                    });
                end;

                for i2, v2 in u23.Base do
                    AddStat(i2, "Base", v2);
                end;

                for i2, v2 in u23.External do
                    for i3, v4 in v2 do
                        if type(v4) == "number" then
                            AddStat(i3, not i2 and "External" or `External ({i2})`, v4);
                        end;
                    end;
                end;

                local v37 = 1;
                local v38 = {};

                for i2, v2 in u32 do
                    local v39 = 1;

                    if i2 == "Attack" then
                        local Total = v2.Total;
                        v39 = 1 + Total / (Total + 200);
                    elseif i2 == "Defense" then
                        local Total = v2.Total;
                        v39 = 1 - Total / (Total + 200);
                    end;

                    v2.Multiplier = v39;
                    v37 = v37 * v39;
                    table.insert(v38, i2);
                end;

                local v40 = #v38 > 0;
                local v41 = 1;

                for _, v2 in v29 do
                    v41 = v41 * v2.Multiplier;
                end;

                local v42 = `<b>{i} ({string.format("%.2f", v41 * v37)}x)</b><br />`;
                v26 = v26 .. `<font color="#{Color:ToHex()}">{v42}</font>`;

                if #v29 > 0 then
                    local v43 = `<b>Multipliers ({string.format("%.2f", v41)}x)</b>`;
                    local v44, v45, v46 = Color:ToHSV();
                    v26 = v26 .. "" .. (v40 and "├── " or "└── ") .. `<font color="#{Color3.fromHSV(v44, v45 * 0.6, v46):ToHex()}">{v43}</font>` .. "<br />";
                    local v47 = v40 and "│   " or "    ";

                    for i2, v2 in v29 do
                        local Text = v2.Text;
                        local v48, v49, v50 = Color:ToHSV();
                        v26 = v26 .. v47 .. (i2 == #v29 and "└── " or "├── ") .. `<font color="#{Color3.fromHSV(v48, v49 * 0.39999999999999997, v50):ToHex()}">{Text}</font>` .. "<br />";
                    end;
                end;

                if v40 then
                    local v51 = `<b>Stats ({string.format("%.2f", v37)}x)</b>`;
                    local v52, v53, v54 = Color:ToHSV();
                    v26 = v26 .. "" .. "└── " .. `<font color="#{Color3.fromHSV(v52, v53 * 0.6, v54):ToHex()}">{v51}</font>` .. "<br />";

                    for i2, v2 in v38 do
                        local v55 = u32[v2];
                        local v56 = i2 == #v38;
                        local v57 = `<b>{v2}: {v55.Total} ({string.format("%.2f", v55.Multiplier)}x)</b>`;
                        local v58, v59, v60 = Color:ToHSV();
                        v26 = v26 .. "    " .. (v56 and "└── " or "├── ") .. `<font color="#{Color3.fromHSV(v58, v59 * 0.39999999999999997, v60):ToHex()}">{v57}</font>` .. "<br />";
                        local v61 = "    " .. (v56 and "    " or "│   ");

                        for i3, v4 in v55.Lines do
                            local v62 = i3 == #v55.Lines;
                            local v63 = `{v4.Source}: <b>{v4.Value > 0 and "+" or ""}{v4.Value}</b>`;
                            local v64, v65, v66 = Color:ToHSV();
                            v26 = v26 .. v61 .. (v62 and "└── " or "├── ") .. `<font color="#{Color3.fromHSV(v64, v65 * 0.3, v66):ToHex()}">{v63}</font>` .. "<br />";
                        end;
                    end;
                end;
            end;

            u6:SetText((`<font family="rbxasset://fonts/families/RobotoMono.json">{v26}</font>`));
        end;

        local function StatsUpdated() -- Line: 303
            -- upvalues: UpdateInfo (copy)
            UpdateInfo();
        end;

        local function MultsUpdated(p67) -- Line: 307
            -- upvalues: u8 (ref), u7 (ref), UpdateInfo (copy)
            if not u8[p67.Name] then
                return;
            end;

            for _, v in u7 do
                for _, _ in v do

                end;
            end;

            UpdateInfo();
        end;

        local u68 = {};

        local function HookTag(u69) -- Line: 331
            -- upvalues: u8 (ref), u68 (copy), u7 (ref), UpdateInfo (copy)
            if not u8[u69.Name] then
                return;
            end;

            if u68[u69] then
                return;
            end;

            u68[u69] = u69:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 338
                -- upvalues: u69 (copy), u8 (ref), u7 (ref), UpdateInfo (ref)
                if not u8[u69.Name] then
                    return;
                end;

                for _, v in u7 do
                    for _, _ in v do

                    end;
                end;

                UpdateInfo();
            end);

            if not u8[u69.Name] then
                return;
            end;

            for _, v in u7 do
                for _, _ in v do

                end;
            end;

            UpdateInfo();
        end;

        local function UnhookTag(p70) -- Line: 344
            -- upvalues: u68 (copy), u8 (ref), u7 (ref), UpdateInfo (copy)
            if u68[p70] then
                u68[p70]:Disconnect();
                u68[p70] = nil;
            end;

            if not u8[p70.Name] then
                return;
            end;

            for _, v in u7 do
                for _, _ in v do

                end;
            end;

            UpdateInfo();
        end;

        for _, child in Tags:GetChildren() do
            HookTag(child);
        end;

        u2:Connect(Tags.ChildAdded, HookTag);
        u2:Connect(Tags.ChildRemoved, UnhookTag);
        u2:Add(function() -- Line: 359
            -- upvalues: u68 (copy)
            for _, v in u68 do
                v:Disconnect();
            end;

            table.clear(u68);
        end);
        u2:Connect(u4.StatsUpdated, function(p71) -- Line: 366
            -- upvalues: u23 (copy), UpdateInfo (copy)
            local External = p71.External;
            u23.Base = p71.Base;
            u23.External = External;
            UpdateInfo();
        end);
        u2:Connect(Parent.MouseEnter, function() -- Line: 373
            -- upvalues: u25 (ref), UpdateInfo (copy), u6 (ref)
            u25 = true;
            task.spawn(UpdateInfo);
            u6:SetTitle("Multipliers");
            u6:Show();
        end);
        u2:Connect(Parent.MouseLeave, function() -- Line: 381
            -- upvalues: u25 (ref), u6 (ref)
            u25 = false;
            u6:Hide();
        end);
        u2:Add(function() -- Line: 386
            -- upvalues: u23 (copy), u24 (copy)
            table.clear(u23);
            table.clear(u24);
        end);
    end;

    if p1.Character then
        task.spawn(CharacterAdded, p1.Character);
    end;

    p1.Player.CharacterAdded:Connect(CharacterAdded);
end;