  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);
local ItemData = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").ItemData);
local PVEPackage = game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("PVEPackage");
local StatsHandler = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("StatsHandler"));
require(PVEPackage:WaitForChild("LevelingInfo"));
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Stands = require(PathShortcuts.ReplicatedModules:WaitForChild("Stands"));
local BaseStats = require(PathShortcuts.ReplicatedModules:WaitForChild("BaseStats"));
local SubPowers = require(PathShortcuts.ReplicatedModules:WaitForChild("SubPowers"));
Knit:OnStart():await();
local u1 = Knit.GetController("MoveIndicatorController").GetSingleton();
Knit.GetController("CombatController");
local u2 = Knit.GetController("MoveInputController");
local u3 = Knit.GetService("MoveService");
local u4 = Knit.GetService("SubPowerService");
local AbilityService = require(game.ReplicatedStorage.ReplicatedRoot.Services.Gameplay.AbilityService);
local u5 = {};
u5.__index = u5;
local u6 = nil;
local u7 = nil;

local function ResolveInput(p8) -- Line: 32
    -- upvalues: u7 (ref)
    return table.find(u7, p8) or 1;
end;

task.wait();
local u9 = {
    UCoins = {
        Name = "UCoins",
        String = "<font color=\"#ffff00\">UCoins</font>",
        Color = "#ffff00"
    },
    UShards = {
        Name = "Currency",
        String = "<font color=\"#00aaff\"><s>u</s>S</font>"
    }
};

local function GetAbilityMoveset(p10, p11) -- Line: 50
    -- upvalues: AbilityService (copy), TableUtil (copy), StatsHandler (copy)
    local v12 = AbilityService.GetAbilityInfo(p10);

    if v12 and not v12.IsLegacy then
        local v13 = AbilityService.GetAbilityData({
            Ability = p10
        });

        if v13.Moveset then
            if p11 == false then
                return v13.Moveset;
            end;

            return TableUtil.Copy(v13.Moveset, true);
        end;
    end;

    local v14 = StatsHandler.GetStats(p10);

    if v14 and v14.Moveset then
        if p11 == false then
            return v14.Moveset;
        end;

        return TableUtil.Copy(v14.Moveset, true);
    end;
end;

local function GetMoveCapCount(p15) -- Line: 70
    -- upvalues: GetAbilityMoveset (copy)
    local v16 = GetAbilityMoveset(p15);
    local _ = v16.MovesInfo;

    return v16.MoveCap;
end;

local u17 = nil;
local u18 = {};

function u5.new(p19, p20) -- Line: 82
    -- upvalues: u5 (copy), Trove (copy), u7 (ref), u6 (ref)
    local u21 = setmetatable({}, u5);
    u21.UI = p19;
    u21.UIEngine = p20;
    u21.Trove = Trove.new();
    u21.Tooltip = p20.Util.Tooltip.GetFromParent(p19:FindFirstAncestorWhichIsA("ScreenGui"):FindFirstChild("Screen"));
    u7 = p20.Util.Order;
    u6 = p20.Util.Mapping;
    u21.Assets = p19.Assets;
    u21.Cache = {
        Binding = false,
        AbilityId = nil
    };
    u21.MovesSection = u21.UI.MovesSection;
    u21.States = u21.MovesSection.States;
    u21.Preview = u21.UI.Preview;
    u21.MoveEntry = u21.Assets.Move;
    u21.StateEntry = u21.Assets.State;
    u21.UI.ResetButton.MouseButton1Click:Connect(function() -- Line: 109
        -- upvalues: u21 (copy)
        u21:ResetToDefault();
    end);

    return u21;
end;

local u22 = {
    damage = Color3.fromRGB(255, 60, 60),
    heal = Color3.fromRGB(55, 255, 85),

    meter = function() -- Line: 119, Name: meter
        -- upvalues: LocalPlayer (copy)
        return LocalPlayer.Character:GetAttribute("MeterColor") or Color3.fromRGB(124, 165, 255);
    end
};

function CapitalizeSentences(p23)
    return p23:gsub("([^%.%!%?]*[%.%!%?]*)", function(p24) -- Line: 125
        local v25 = p24:match("^%s*(.-)%s*$");
        local v26 = v25:sub(1, 1);

        return string.upper(v26) .. v25:sub(2) .. " ";
    end);
end;

function SpaceOut(p27)
    return p27:gsub("(%l)(%u)", "%1 %2");
end;

function CapitalizeWord(p28)
    return p28:gsub("^%l", string.upper);
end;

function u5.FormatText(p29, p30) -- Line: 140
    -- upvalues: u22 (copy)
    local v31 = string.lower(p30);

    for i, v in u22 do
        if typeof(v) == "function" then
            local v = v();
        end;

        v31 = string.gsub(v31, i, (`<font color="#{v:ToHex()}">{CapitalizeWord(i)}</font>`));
    end;

    return CapitalizeSentences(v31);
end;

function u5.GetAccurateEquippedMovesCount(p32) -- Line: 151
    -- upvalues: u3 (copy)
    local Moveset = p32.Moveset;
    local v33 = u3:GetMovesInfo():expect();
    local v34 = {};
    local MovesInfo = Moveset.MovesInfo;

    if MovesInfo then
        local EquippedMoves = v33.EquippedMoves;
        local _ = v33.UnlockedMoves;

        for i, v in MovesInfo do
            if v.State ~= nil then
                if v34[v.State] == nil then
                    v34[v.State] = {};
                end;

                v34[v.State][i] = v;
            end;
        end;

        local v35 = 0;

        for _, v in v34 do
            for i, v2 in v do
                if (v2.Equipped or EquippedMoves[i]) and v2.MoveCapCount ~= false then
                    v35 = v35 + 1;
                end;
            end;
        end;

        return v35;
    end;

    warn("No move info given");
end;

function u5.AddMove(p36, p37) -- Line: 187
    local Action = p37.Action;
    local Description = p37.Description;
    local MoveName = p37.MoveName;
    local v38 = p37.LayoutOrder or 1;
    local NoFormat = p37.NoFormat;
    local u39 = p36.Moves:FindFirstChild(Action) or p36.MoveEntry:Clone();
    u39.Key.Text = Action;
    u39.Label.Text = MoveName;
    local Label = u39.Description.Label;

    if not NoFormat then
        Description = p36:FormatText(Description);
    end;

    Label.Text = Description;
    u39.Name = Action;
    u39.Visible = true;
    u39.Parent = p36.Moves;
    u39.LayoutOrder = v38;
    p36.Trove:Connect(u39.MouseButton1Click, function() -- Line: 203
        -- upvalues: u39 (copy)
        u39.Description.Visible = not u39.Description.Visible;
    end);
end;

function u5.DrawPreview(p40, p41, p42, p43, p44, p45, p46) -- Line: 208
    -- upvalues: u7 (ref), UserInputService (copy), u18 (copy), GetAbilityMoveset (copy)
    if not p41.Groups[p42] then
        print("State", p42);
    end;

    local v47 = (-p41.Groups[p42].Priority or 1) * (#u7 * 2);
    local v48 = p40.Assets.PreviewState:Clone();
    v48.StateName.Text = SpaceOut(p42);
    v48.Visible = p41.Groups[p42].Show ~= false;

    if not v48.Visible and (p46 and p46.Show) then
        v48.Visible = true;
    end;

    v48.LayoutOrder = v47;
    v48.Name = p42;
    local v49 = UserInputService:GetLastInputType() == Enum.UserInputType.Gamepad1;
    local v50 = v49 and "DefaultConsoleKeybind" or "DefaultKeybind";
    local v51 = v49 and "c" or "k";

    for i, v in p43 do
        local v52 = v[v50];
        local v53 = p40.Assets.PreviewMove:Clone();
        v53.Name = i;
        v53.Label.Text = v.DisplayName or i;
        v53.Key.Text = string.upper(v52 or "");
        v53.Visible = false;

        if v.Equipped and (p45[i] and p45[i][v51] ~= nil) then
            v53.Visible = v48.Visible;
        end;

        if p45[i] and p45[i][v51] ~= nil then
            v53.Visible = v48.Visible;
            local v54 = p45[i][v51] > 10000;
            v53.Key.Text = not u18[p45[i][v51] - (v54 and 10000 or 0)] and "" or string.upper(u18[p45[i][v51] - (v54 and 10000 or 0)]) .. (v54 and "+" or "");
        end;

        v53.LayoutOrder = v47 + (table.find(u7, v53.Key.Text) or 1);
        v53.Parent = p40.Preview.States;
    end;

    local v55 = GetAbilityMoveset(p40.Cache.AbilityName);
    local _ = v55.MovesInfo;

    if v55.MoveCap then
        local EquippedCount = p40.UI.EquippedCount;
        local v56 = p40:GetAccurateEquippedMovesCount();
        local v57 = GetAbilityMoveset(p40.Cache.AbilityName);
        local _ = v57.MovesInfo;
        EquippedCount.Text = `{v56}/{v57.MoveCap} equipped`;
    else
        p40.UI.EquippedCount.Text = "";
    end;

    v48.Parent = p40.Preview.States;
end;

local Moveset = StatsHandler.GetStats("SubPowers").Moveset;

function u5.DisplayStates(u58, p59, p60) -- Line: 265
    -- upvalues: UserInputService (copy), u4 (copy), Moveset (copy), u3 (copy), u2 (copy), LocalPlayer (copy), GetAbilityMoveset (copy), u9 (copy), u1 (copy), u18 (copy), BaseStats (copy)
    local v61 = {};
    local MovesInfo = p59.MovesInfo;

    if not MovesInfo then
        warn("No move info given");

        return;
    end;

    local EquippedMoves = p60.EquippedMoves;
    local UnlockedMoves = p60.UnlockedMoves;
    local u62 = UserInputService:GetLastInputType() == Enum.UserInputType.Gamepad1;

    for i, _ in u4:GetEquippedSubPowers():expect() do
        local v63 = Moveset.MovesInfo[i];

        if v63 then
            if not v61[v63.State] then
                v61[v63.State] = {};
            end;

            v61[v63.State][i] = v63;
        end;
    end;

    for i, v in MovesInfo do
        if v.State ~= nil then
            if v61[v.State] == nil then
                v61[v.State] = {};
            end;

            v61[v.State][i] = v;
        end;
    end;

    u58.Trove:Destroy();

    local function FindInPreview(p64) -- Line: 300
        -- upvalues: u58 (copy)
        return u58.Preview.States:FindFirstChild(p64);
    end;

    local function HandleMoveEquipError(p65, p66) -- Line: 305
        -- upvalues: u58 (copy)
        u58.UIEngine.NewPrompt({
            Delay = 0.25,
            Title = `Failed to equip {p65}`,
            Text = p66
        });
    end;

    local function HandleMoveUnequipError(p67, p68) -- Line: 313
        -- upvalues: u58 (copy)
        u58.UIEngine.NewPrompt({
            Delay = 0.25,
            Title = `Failed to equip {p67}`,
            Text = p68
        });
    end;

    local function OnUnlock(u69, p70, u71) -- Line: 321
        -- upvalues: u58 (copy), u3 (ref)
        u58.UIEngine.NewPrompt({
            Delay = 0.25,
            Title = `Unlock Move ({u69})`,
            Text = `Are you sure you want to unlock this move? Requirements: <br /> {p70}`,
            Options = { "Yes", "No" },

            Callback = function(p72) -- Line: 330, Name: Callback
                -- upvalues: u58 (ref), u3 (ref), u69 (copy), u71 (copy)
                if p72.Choice == 1 then
                    u58.UIEngine:PlaySound("Click");
                    u71((u3:UnlockMove(u69):expect()));
                end;
            end
        });
    end;

    local u73 = { Enum.KeyCode.Unknown };
    local u74 = {
        Enum.KeyCode.DPadUp,
        Enum.KeyCode.DPadDown,
        Enum.KeyCode.DPadLeft,
        Enum.KeyCode.DPadRight
    };

    local function OnBind(p75, u76, u77) -- Line: 351
        -- upvalues: UserInputService (ref), u2 (ref), LocalPlayer (ref), u73 (copy), u74 (copy), u3 (ref), u58 (copy), GetAbilityMoveset (ref)
        local Actions = p75.Actions;
        local u78 = Actions.Rebind.Visible == true;
        local u79 = UserInputService:GetLastInputType() == Enum.UserInputType.Gamepad1;
        Actions.Rebind.Visible = false;
        Actions.SetBind.Visible = true;
        Actions.SetBind.Text = u79 and "DPad + Bind..." or "Bind to...";
        u2.MoveBinding = true;
        local Settings = LocalPlayer:FindFirstChild("Settings");
        local u80 = nil;
        u80 = UserInputService.InputBegan:Connect(function(u81, p82) -- Line: 366
            -- upvalues: u73 (ref), u79 (copy), u74 (ref), Settings (copy), u80 (ref), UserInputService (ref), u2 (ref), u3 (ref), u76 (copy), Actions (copy), u58 (ref), GetAbilityMoveset (ref), u78 (copy), u77 (copy)
            if u81.UserInputType ~= Enum.UserInputType.Keyboard and u81.UserInputType ~= Enum.UserInputType.Gamepad1 then
                u80:Disconnect();
                local v83;

                if u81.UserInputType.Name == "Touch" then
                    v83 = u77;
                else
                    v83 = u81.UserInputType.Name;
                end;

                local v84 = buffer.create((u79 == true and 2 or 1) + #v83);
                buffer.writeu8(v84, 0, u79 == true and 1 or 0);

                if u79 == true then
                    local v85 = u2:GetDPadDirectionByte();
                    buffer.writeu8(v84, 1, v85);
                end;

                buffer.writestring(v84, u79 == true and 2 or 1, v83);
                local v86 = u3:EquipMove(u76, v84):expect();
                u2.MoveBinding = false;

                if v86 and typeof(v86) ~= "string" then
                    if Actions.Parent then
                        Actions.Rebind.Visible = true;
                        Actions.Rebind.Text = string.upper(v83);
                        Actions.SetBind.Visible = false;
                        local v87 = u58.Preview.States:FindFirstChild(u76);

                        if v87 then
                            v87.Visible = true;
                            v87.Key.Text = Actions.Rebind.Text;
                            local v88 = GetAbilityMoveset(u58.Cache.AbilityName);
                            local _ = v88.MovesInfo;

                            if v88.MoveCap then
                                local EquippedCount = u58.UI.EquippedCount;
                                local v89 = u58.GetAccurateEquippedMovesCount(u58);
                                local v90 = GetAbilityMoveset(u58.Cache.AbilityName);
                                local _ = v90.MovesInfo;
                                EquippedCount.Text = `{v89}/{v90.MoveCap} Equipped`;
                            else
                                u58.UI.EquippedCount.Text = "";
                            end;
                        end;
                    end;
                elseif typeof(v86) == "string" then
                    u58.UIEngine.NewPrompt({
                        Delay = 0.25,
                        Title = `Failed to equip {u76}`,
                        Text = v86
                    });
                end;

                if Actions.Parent then
                    if u78 then
                        Actions.Rebind.Visible = true;
                        Actions.SetBind.Visible = false;
                    end;

                    Actions.SetBind.Text = "Bind";
                end;

                return;
            end;

            if table.find(u73, u81.KeyCode) or u79 == true and (table.find(u74, u81.KeyCode) and Settings.DPadAsBinds.Value ~= true) then
                return;
            end;

            u80:Disconnect();
            local u91 = coroutine.running();
            local u92 = nil;
            u92 = UserInputService.InputEnded:Connect(function(p93, p94) -- Line: 376
                -- upvalues: u81 (copy), u92 (ref), u91 (copy)
                if p93.KeyCode == u81.KeyCode and p93.UserInputType == u81.UserInputType then
                    u92:Disconnect();
                    task.spawn(u91, false);
                end;
            end);
            task.spawn(function() -- Line: 382
                -- upvalues: Settings (ref), u92 (ref), u91 (copy)
                local v95 = not (Settings and Settings:FindFirstChild("HeldFidelity")) and 0.5 or Settings:FindFirstChild("HeldFidelity").Value;

                while v95 > 0 and u92.Connected do
                    v95 = v95 - task.wait();
                end;

                if u92.Connected then
                    u92:Disconnect();
                    task.spawn(u91, true);
                end;
            end);
            local v96 = coroutine.yield();
            local v97 = buffer.create((u79 == true and 2 or 1) + #(u81.KeyCode.Name .. (v96 and "+" or "")));
            buffer.writeu8(v97, 0, u79 == true and 1 or 0);

            if u79 == true then
                local v98 = u2:GetDPadDirectionByte();
                buffer.writeu8(v97, 1, v98);
            end;

            buffer.writestring(v97, u79 == true and 2 or 1, u81.KeyCode.Name .. (v96 and "+" or ""));
            local v99 = u3:EquipMove(u76, v97):expect();
            u2.MoveBinding = false;

            if v99 and typeof(v99) ~= "string" then
                if Actions.Parent then
                    Actions.Rebind.Visible = true;
                    Actions.Rebind.Text = string.upper(u81.KeyCode.Name) .. (v96 and "+" or "");
                    Actions.SetBind.Visible = false;
                    local v100 = u58.Preview.States:FindFirstChild(u76);

                    if v100 then
                        v100.Visible = true;
                        v100.Key.Text = Actions.Rebind.Text;
                        local v101 = GetAbilityMoveset(u58.Cache.AbilityName);
                        local _ = v101.MovesInfo;

                        if v101.MoveCap then
                            local EquippedCount = u58.UI.EquippedCount;
                            local v102 = u58.GetAccurateEquippedMovesCount(u58);
                            local v103 = GetAbilityMoveset(u58.Cache.AbilityName);
                            local _ = v103.MovesInfo;
                            EquippedCount.Text = `{v102}/{v103.MoveCap} Equipped`;
                        else
                            u58.UI.EquippedCount.Text = "";
                        end;
                    end;
                end;
            elseif typeof(v99) == "string" then
                u58.UIEngine.NewPrompt({
                    Delay = 0.25,
                    Title = `Failed to equip {u76}`,
                    Text = v99
                });
            end;

            if Actions.Parent then
                if u78 then
                    Actions.Rebind.Visible = true;
                    Actions.SetBind.Visible = false;
                end;

                Actions.SetBind.Text = "Bind";
            end;
        end);
    end;

    local function OnUnbind(p104, p105) -- Line: 483
        -- upvalues: u3 (ref), u58 (copy), GetAbilityMoveset (ref)
        local Actions = p104.Actions;

        if not Actions.Parent then
            return;
        end;

        local v106 = u3:UnequipMove(p105):expect();

        if v106 and typeof(v106) ~= "string" then
            Actions.Rebind.Visible = false;
            Actions.Rebind.Text = "";
            Actions.SetBind.Visible = true;
            local v107 = u58.Preview.States:FindFirstChild(p105);

            if v107 then
                v107.Visible = false;
                local v108 = GetAbilityMoveset(u58.Cache.AbilityName);
                local _ = v108.MovesInfo;

                if not v108.MoveCap then
                    u58.UI.EquippedCount.Text = "";

                    return;
                end;

                local EquippedCount = u58.UI.EquippedCount;
                local v109 = u58.GetAccurateEquippedMovesCount(u58);
                local v110 = GetAbilityMoveset(u58.Cache.AbilityName);
                local _ = v110.MovesInfo;
                EquippedCount.Text = `{v109}/{v110.MoveCap} Equipped`;
            end;
        elseif type(v106) == "string" then
            u58.UIEngine.NewPrompt({
                Delay = 0.25,
                Title = `Failed to equip {p105}`,
                Text = v106
            });
        end;
    end;

    local function Default(p111, p112, p113, p114) -- Line: 510
        -- upvalues: u3 (ref), u58 (copy)
        local Actions = p111.Actions;
        local v115 = u3:EquipMove(p112, {
            Input = p113,
            Platform = p114 and 1 or 0,
            DPadDirection = p114
        }):expect();

        if not Actions.Parent then
            return;
        end;

        if v115 and typeof(v115) ~= "string" then
            Actions.Rebind.Text = string.upper(p113);

            return;
        end;

        if typeof(v115) == "string" then
            u58.UIEngine.NewPrompt({
                Delay = 0.25,
                Title = `Failed to equip {p112}`,
                Text = v115
            });
        end;
    end;

    local function GenerateCostString(p116) -- Line: 524
        -- upvalues: u9 (ref), u58 (copy)
        local v117 = "";

        if not p116 then
            return v117;
        end;

        if p116.AscensionRank then
            v117 = v117 .. `<font color="#00FFFF">Ascension Rank</font>: {p116.AscensionRank}`;
        end;

        for i, v in p116.Currencies or {} do
            if u9[i] then
                v117 = v117 .. `<br />{u9[i].String}: {v}`;
            end;
        end;

        for i, v in p116.Items or {} do
            v117 = v117 .. `<br />{u58.UIEngine:GetItemText(i)}: {v}`;
        end;

        return v117;
    end;

    for _, child in u58.Preview.States:GetChildren() do
        if child:IsA("Frame") or child:IsA("TextButton") then
            child:Destroy();
        end;
    end;

    for i, v in v61 do
        local v118 = u1:GetGroup(i);
        u58.DrawPreview(u58, p59, i, v, u18, EquippedMoves, v118);

        if not u58.States:FindFirstChild(i) then
            local u119 = u58.StateEntry:Clone();
            u119.StateName.Text = SpaceOut(i);
            u119.Visible = p59.Groups[i].Show ~= false;

            if not u119.Visible and (v118 and v118.Show) then
                u119.Visible = true;
            end;

            u119.Name = i;

            if p59.Groups and p59.Groups[i] then
                u119.LayoutOrder = -p59.Groups[i].Priority or 1;
            end;

            for i2, v2 in v do
                local u120 = u58.MoveEntry:Clone();
                u120.MoveName.Text = v2.DisplayName or i2;
                u120.Visible = true;
                u120.Name = i2;
                u120.Parent = u119.MoveFrame;

                if type(v2.Description) == "string" then
                    u120.Description.Description.Label.Text = v2.Description;
                elseif not v2.Description and BaseStats.MovesInfo[i2] then
                    u120.Description.Description.Label.Text = BaseStats.MovesInfo[i2].Description;
                end;

                local v121 = v2[u62 and "DefaultConsoleKeybind" or "DefaultKeybind"];
                local Actions = u120.Actions;

                if v2.DefaultKeybind then
                    if v2.Equipped then
                        Actions.Unlock.Visible = false;
                        Actions.SetBind.Visible = false;
                        Actions.LevelReq.Visible = false;
                        Actions.Rebind.Visible = true;
                        local v122 = not v121 and "UNBOUND" or string.upper(v121) .. (v2.Held and "+" or "");

                        if u62 and v2.DefaultDPadDirection then
                            local v123 = { 2, 3, 0, 1 };
                            local v124 = "";
                            local v125 = { "U", "D", "L", "R" };
                            local v126 = true;

                            for i3 = 1, 4 do
                                if bit32.extract(v2.DefaultDPadDirection, v123[i3]) ~= 0 then
                                    v124 = v124 .. v125[i3];
                                    v126 = false;
                                end;
                            end;

                            if v126 ~= true then
                                v122 = v124 .. " + " .. v122;
                            end;
                        end;

                        Actions.Rebind.Text = v122;
                    elseif v2.Unlocked then
                        Actions.Unlock.Visible = false;
                        Actions.SetBind.Visible = true;
                    end;
                else
                    Actions.Visible = false;
                end;

                if v2.MoveCapCount == false then
                    u120.BackgroundColor3 = Color3.fromRGB(53, 90, 89);
                    u120.LayoutOrder = -1;
                    u120.Actions.Rebind.Unbind.BackgroundColor3 = Color3.fromRGB(93, 29, 29);
                end;

                local v127 = u62 and "c" or "k";

                if EquippedMoves[i2] and EquippedMoves[i2][v127] or UnlockedMoves[i2] then
                    Actions.SetBind.Visible = (not EquippedMoves[i2] or EquippedMoves[i2][v127] == nil) and true or false;
                    Actions.Rebind.Visible = not Actions.SetBind.Visible;
                    Actions.LevelReq.Visible = false;
                    local v128 = EquippedMoves[i2] and EquippedMoves[i2][v127] and EquippedMoves[i2][v127] > 10000;

                    if EquippedMoves[i2] and EquippedMoves[i2][v127] ~= nil then
                        local v129 = EquippedMoves[i2];
                        local v130 = v129[v127];
                        local v131 = not u18[v130 - (v128 and 10000 or 0)] and "" or string.upper(u18[v130 - (v128 and 10000 or 0)]) .. (v128 and "+" or "");

                        if u62 then
                            local v132 = { 2, 3, 0, 1 };
                            local v133 = "";
                            local v134 = { "U", "D", "L", "R" };
                            local v135 = true;

                            for i3 = 1, 4 do
                                if bit32.extract(v129.d, v132[i3]) ~= 0 then
                                    v133 = v133 .. v134[i3];
                                    v135 = false;
                                end;
                            end;

                            if v135 ~= true then
                                v131 = v133 .. " + " .. v131;
                            end;
                        end;

                        Actions.Rebind.Text = v131;
                    end;
                end;

                local lower = string.lower;
                local v136 = string.sub(i2, 1, 1);
                u120.LayoutOrder = string.byte(lower(v136)) + -96;
                Actions.Unlock.Visible = false;
                u58.Trove:Connect(Actions.SetBind.MouseButton1Click, function() -- Line: 696
                    -- upvalues: UserInputService (ref), u58 (copy), u2 (ref), OnBind (copy), u120 (copy), i2 (copy), v2 (copy)
                    if UserInputService:GetLastInputType() == Enum.UserInputType.Touch then
                        u58.UIEngine.NewPrompt({
                            Title = "Disabled",
                            Text = "Keybinding disabled on this device",
                            Delay = 0.25
                        });

                        return;
                    end;

                    if u2.MoveBinding ~= true then
                        OnBind(u120, i2, v2.DefaultKeybind);
                    end;
                end);
                u58.Trove:Connect(Actions.Rebind.MouseButton1Click, function() -- Line: 711
                    -- upvalues: UserInputService (ref), u58 (copy), u2 (ref), OnBind (copy), u120 (copy), i2 (copy), v2 (copy)
                    if UserInputService:GetLastInputType() == Enum.UserInputType.Touch then
                        u58.UIEngine.NewPrompt({
                            Title = "Disabled",
                            Text = "Keybinding disabled on this device",
                            Delay = 0.25
                        });

                        return;
                    end;

                    if u2.MoveBinding ~= true then
                        OnBind(u120, i2, v2.DefaultKeybind);
                    end;
                end);
                u58.Trove:Connect(Actions.Rebind.Unbind.MouseButton1Click, function() -- Line: 725
                    -- upvalues: UserInputService (ref), u58 (copy), OnUnbind (copy), u120 (copy), i2 (copy)
                    if UserInputService:GetLastInputType() == Enum.UserInputType.Touch then
                        u58.UIEngine.NewPrompt({
                            Title = "Disabled",
                            Text = "Keybinding disabled on this device",
                            Delay = 0.25
                        });

                        return;
                    end;

                    OnUnbind(u120, i2);
                end);
                u58.Trove:Connect(Actions.Rebind.Default.MouseButton1Click, function() -- Line: 737
                    -- upvalues: Default (copy), u120 (copy), i2 (copy), u62 (copy), v2 (copy)
                    Default(u120, i2, u62 and v2.DefaultConsoleKeybind or v2.DefaultKeybind, v2.DefaultDPadDirection);
                end);
            end;

            u119.Parent = u58.States;
            u58.Trove:Add(u119);
            u58.Trove:Connect(u119.StateName.Toggle.MouseButton1Click, function() -- Line: 744
                -- upvalues: u119 (copy)
                u119.MoveFrame.Visible = not u119.MoveFrame.Visible;
            end);
        end;
    end;
end;

function u5.ResetToDefault(u137) -- Line: 751
    -- upvalues: u3 (copy), StatsHandler (copy), UserInputService (copy), SubPowers (copy), Moveset (copy), u18 (copy)
    u137.UIEngine.NewPrompt({
        Title = "Reset Keybinds",
        Text = "Are you sure you want reset the keybinds for this ability to their default?",
        Delay = 0.25,
        Options = { "Yes", "No" },

        Callback = function(p138) -- Line: 761, Name: Callback
            -- upvalues: u137 (copy), u3 (ref), StatsHandler (ref), UserInputService (ref), SubPowers (ref), Moveset (ref), u18 (ref)
            if p138.Choice == 1 then
                u137.UIEngine:PlaySound("Click");
                local TouchEnabled = game:GetService("UserInputService").TouchEnabled;
                task.spawn(function() -- Line: 767
                    -- upvalues: u3 (ref), StatsHandler (ref), u137 (ref), UserInputService (ref), SubPowers (ref), Moveset (ref), u18 (ref), TouchEnabled (copy)
                    local EquippedMoves = u3:GetMovesInfo():expect().EquippedMoves;
                    local Moveset2 = StatsHandler.GetStats(u137.Cache.AbilityName).Moveset;
                    local v139 = UserInputService:GetLastInputType() == Enum.UserInputType.Gamepad1;
                    local v140 = {};
                    local v141 = {};

                    for i, v in EquippedMoves do
                        v140[v] = i;
                    end;

                    for i, v in EquippedMoves do
                        local v142 = Moveset2.MovesInfo[i];
                        local v143;

                        if v142 or not SubPowers[i] then
                            v143 = false;
                        else
                            v142 = Moveset.MovesInfo[i];
                            v143 = true;
                        end;

                        if v142 then
                            local v144 = v139 and v142.DefaultConsoleKeybind or v142.DefaultKeybind;
                            local v145 = typeof(v) ~= "boolean";
                            local v146 = v139 and "c" or "k";
                            local v147;

                            if type(v) == "table" then
                                v147 = v[v146];
                            else
                                v147 = false;
                            end;

                            if v145 and v147 then
                                local v148 = v147 >= 10000;
                                local v149 = not u18[v147 - (v148 and 10000 or 0)] and "" or string.upper(u18[v147 - (v148 and 10000 or 0)]) .. (v148 and "+" or "");

                                if TouchEnabled and (not TouchEnabled or v143) then
                                    local v150;

                                    repeat
                                        v150 = math.random(72, 198);
                                    until not v140[v150] and u18[v150];

                                    u3:EquipMove(i, u18[v150]):expect();
                                elseif v149 and v149:upper() ~= v144:upper() then
                                    u3:EquipMove(i, {
                                        Input = v144,
                                        Platform = v139 and 1 or 0,
                                        DPadDirection = v142.DefaultDPadDirection
                                    }):expect();
                                end;
                            else
                                u3:EquipMove(i, {
                                    Input = v144,
                                    Platform = v139 and 1 or 0,
                                    DPadDirection = v142.DefaultDPadDirection
                                }):expect();
                            end;

                            v141[i] = true;
                        else
                            warn("Move info for", i, "not found");
                        end;
                    end;

                    table.clear(v140);
                    table.clear(EquippedMoves);
                end);
            end;
        end
    });
end;

function u5.SetInfo(p151, p152) -- Line: 832
    p151.AbilityName.Text = p152.AbilityName;
    p151.AbilityPrefix.Text = p152.AbilityPrefix;
    p151.AbilityPrefix.TextColor3 = p152.AbilityPrefixColor;
    p151.AbilityDescription.Text = p152.AbilityDescription;
end;

function u5.Load(u153, p154) -- Line: 839
    -- upvalues: Stands (copy), ItemData (copy), u17 (ref), u3 (copy), u18 (copy), StatsHandler (copy), GetAbilityMoveset (copy)
    u153.Trove:Clean();
    u153.Cache.AbilityId = p154;
    u153.Cache.AbilityName = Stands[p154];
    local u155 = ItemData.GetItemInfo((`ABILITY_{p154}`));
    u17 = u3:GetKeybindsMap():expect();

    for i, v in u17 do
        u18[v] = i;
    end;

    if not u153.Tooltip.Connection then
        u153.Tooltip:Connect();
    end;

    task.delay(0.25, function() -- Line: 872
        -- upvalues: StatsHandler (ref), u155 (copy), GetAbilityMoveset (ref), u3 (ref), u153 (copy)
        StatsHandler.GetStats(u155.Name);
        local v156 = GetAbilityMoveset(u155.Name, false);
        local v157 = u3:GetMovesInfo():expect();
        u153.Moveest = v156;
        u153:DisplayStates(v156, v157);
    end);
end;

return u5;