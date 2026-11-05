  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Players = game:GetService("Players");
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local StatsHandler = require(ReplicatedStorage.ReplicatedModules.StatsHandler);
require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
task.wait(0.25);
local u1 = Knit.GetController("MoveInputController");
local u2 = Knit.GetController("CombatController");
local u3 = Knit.GetController("MoveIndicatorController").GetSingleton();
Knit.GetService("MoveService");
local u4 = true;
local LocalPlayer = Players.LocalPlayer;

local function _(p5, p6) -- Line: 30
    return Random.new():NextNumber(p5, p6);
end;

local u7 = _G.Petal("Util");
local u8 = {};

return function(p9, p10) -- Line: 38
    -- upvalues: LocalPlayer (copy), u1 (copy), StatsHandler (copy), u2 (copy), u3 (copy), u4 (ref), u8 (copy), u7 (copy)
    local Character = LocalPlayer.Character;

    if not (Character and Character.Parent) then
        return;
    end;

    local Ref = p10.Ref;

    if not (Ref and Ref.Parent) then
        return;
    end;

    local u11 = u1:GetEquippedMoves();
    local v12 = LocalPlayer.Data.Ability:GetAttribute("AbilityName");
    local v13 = LocalPlayer.Data.Skin:GetAttribute("SkinName");
    local u14 = StatsHandler.GetStats(v12, v13) or StatsHandler.GetStats(v12);

    if not u14 then
        warn(v12, "stats not found");

        return;
    end;

    local function ChooseMove() -- Line: 57
        -- upvalues: u11 (copy), u14 (copy), u2 (ref), Character (copy), u3 (ref)
        local v15 = {};

        for i, v in u11 do
            local v16;

            if u14.Stats then
                v16 = u14.Stats[i] or nil;
            else
                v16 = nil;
            end;

            if v16 and (i ~= "Quickstep" and (i ~= "Block" and not (v16.From and string.find(v16.From, ".Block")))) and not (v16.From and string.find(v16.From, ".Quickstep") or u2.GetCooldown(Character, i)) then
                local v17 = u3:GetItem(v.State, i);

                if v17 and v17.Visible then
                    table.insert(v15, { i, v });
                end;
            end;
        end;

        if #v15 ~= 0 then
            return v15[math.random(1, #v15)];
        end;

        warn("Could not get move");
    end;

    local function RunMove() -- Line: 91
        -- upvalues: ChooseMove (copy), u1 (ref)
        local v18 = ChooseMove();
        local _ = v18[1];
        local v19 = v18[2];
        u1:FireInput(v19.Keybind .. (v19.Held and "+" or ""));
    end;

    local Moves = LocalPlayer.PlayerGui:FindFirstChild("UI"):FindFirstChild("Gameplay"):FindFirstChild("Moves");
    local v20 = 0;

    while Ref and (Ref.Parent and Character.Parent) do
        local v21 = v20 + task.wait(0.02) / 2;
        v20 = math.clamp(v21, 0, 1);

        if u4 then
            u4 = false;
            task.spawn(RunMove);
            task.delay(Random.new():NextNumber(1.8, 3.25), function() -- Line: 115
                -- upvalues: u4 (ref)
                u4 = true;
            end);
        end;

        for i, child in Moves:GetChildren() do
            if child:IsA("TextButton") then
                if not u8[child.Name] then
                    u8[child.Name] = child.BackgroundColor3;
                end;

                local fromHSV = Color3.fromHSV;
                local v22 = os.clock() * 2.5 + i * 2;
                local v23 = fromHSV(0.339111, 0.678431, math.cos(v22) * 0.3 + 0.45);
                child.BackgroundColor3 = child.BackgroundColor3:Lerp(v23, v20);
            end;
        end;
    end;

    for _, child in Moves:GetChildren() do
        if u8[child.Name] then
            u7.Tween(child, 1.25, "Sine", "InOut", {
                BackgroundColor3 = u8[child.Name]
            });
        end;
    end;

    table.clear(u8);
end;