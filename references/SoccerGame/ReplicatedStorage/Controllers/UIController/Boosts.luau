  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u2 = u1:FindFirstChildOfClass("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local _ = HumanoidRootPart:WaitForChild("RootJoint").C0;
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local Trove = require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local StylesLotteryController = require(ReplicatedStorage2.Shared.StylesLotteryController);
local StyleEventData = require(ReplicatedStorage2.Shared.Configs.StyleEventData);
local FormatNumber = require(ReplicatedStorage2.Shared.FormatNumber);
local v3 = Knit.CreateController({
    Name = "Boosts"
});

function v3.KnitStart(u4) -- Line: 28
    -- upvalues: ReplicatedStorage (copy), StylesLotteryController (copy), LocalPlayer (copy), StyleEventData (copy), Essentials (copy), FormatNumber (copy)
    u4.Data = ReplicatedStorage.Data:InvokeServer();

    while u4.Data == nil do
        u4.Data = ReplicatedStorage.Data:InvokeServer();
        task.wait(0.2);
    end;

    u4.BaseTrove:Connect(ReplicatedStorage.Boost.OnClientEvent, function(p5) -- Line: 35
        -- upvalues: u4 (copy)
        table.clear(u4.Data);
        u4.Data = p5;
    end);
    local u6 = {};
    local u7 = {};
    local u8 = {};

    for i in StylesLotteryController.GetRarityChances("Normal") do
        local v9 = LocalPlayer.PlayerGui.Boosts.Boosts.Rarity:Clone();
        v9.Parent = LocalPlayer.PlayerGui.Boosts.Boosts;
        u6[i] = v9;
    end;

    for i in StylesLotteryController.GetRarityChances("Lucky") do
        local v10 = LocalPlayer.PlayerGui.Boosts.Boosts.Rarity:Clone();
        v10.Parent = LocalPlayer.PlayerGui.Boosts.Boosts;
        u7[i] = v10;
    end;

    if StyleEventData.Enabled then
        for i in StylesLotteryController.GetRarityChances("Event") do
            local v11 = LocalPlayer.PlayerGui.Boosts.Boosts.Rarity:Clone();
            v11.Parent = LocalPlayer.PlayerGui.Boosts.Boosts;
            u8[i] = v11;
        end;
    end;

    task.spawn(function() -- Line: 62
        -- upvalues: LocalPlayer (ref), u4 (copy), Essentials (ref), StylesLotteryController (ref), u6 (copy), FormatNumber (ref), u7 (copy), StyleEventData (ref), u8 (copy)
        while task.wait(0.5) do
            if LocalPlayer.PlayerGui.Style.Enabled or (LocalPlayer.PlayerGui.Flow.Enabled or LocalPlayer.PlayerGui.Customization.Enabled) then
                LocalPlayer.PlayerGui.Boosts.Enabled = false;
            else
                LocalPlayer.PlayerGui.Boosts.Enabled = true;

                if u4.Data ~= nil and u4.Data.Boosts ~= nil then
                    if u4.Data.Boosts.CashBoost <= 0 then
                        LocalPlayer.PlayerGui.Boosts.Boosts.Cash.Visible = false;
                    else
                        local Boosts = u4.Data.Boosts;
                        Boosts.CashBoost = Boosts.CashBoost - 0.5;
                        LocalPlayer.PlayerGui.Boosts.Boosts.Cash.Visible = true;
                        LocalPlayer.PlayerGui.Boosts.Boosts.Cash.Text = " 2x CASH BOOST: " .. Essentials:formatCompleteTime(u4.Data.Boosts.CashBoost);
                    end;

                    if u4.Data.Boosts.ExpBoost <= 0 then
                        LocalPlayer.PlayerGui.Boosts.Boosts.Exp.Visible = false;
                    else
                        local Boosts = u4.Data.Boosts;
                        Boosts.ExpBoost = Boosts.ExpBoost - 0.5;
                        LocalPlayer.PlayerGui.Boosts.Boosts.Exp.Visible = true;
                        LocalPlayer.PlayerGui.Boosts.Boosts.Exp.Text = " 2x EXP BOOST: " .. Essentials:formatCompleteTime(u4.Data.Boosts.ExpBoost);
                    end;

                    local RarityChances, v12 = StylesLotteryController.GetRarityChances("Normal");

                    for i, v in u6 do
                        local v13 = v12[i];

                        if v13 then
                            v.Text = `{RarityChances[i]}% {i:upper()} BOOST (NORMALS): {FormatNumber.AdaptiveClockString(v13 - workspace:GetServerTimeNow())}`;
                            v.Visible = true;
                        else
                            v.Visible = false;
                        end;
                    end;

                    local RarityChances2, v14 = StylesLotteryController.GetRarityChances("Lucky");

                    for i, v in u7 do
                        local v15 = v14[i];

                        if v15 then
                            v.Text = `[LUCKIES] {RarityChances2[i]}% {i:upper()}: {FormatNumber.AdaptiveClockString(v15 - workspace:GetServerTimeNow())}`;
                            v.Visible = true;
                        else
                            v.Visible = false;
                        end;
                    end;

                    if StyleEventData.Enabled then
                        local RarityChances3, v16 = StylesLotteryController.GetRarityChances("Event");

                        for i, v in u8 do
                            local v17 = v16[i];

                            if v17 then
                                v.Text = `[SNOWLOCK] {RarityChances3[i]}% {i:upper()}: {FormatNumber.AdaptiveClockString(v17 - workspace:GetServerTimeNow())}`;
                                v.Visible = true;
                            else
                                v.Visible = false;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end);
end;

function v3.KnitInit(u18) -- Line: 127
    -- upvalues: Trove (copy), LocalPlayer (copy), u1 (ref), u2 (ref), HumanoidRootPart (ref)
    u18.BaseTrove = Trove.new();
    u18.BaseTrove:Connect(LocalPlayer.CharacterAdded, function(p19) -- Line: 130
        -- upvalues: u1 (ref), u2 (ref), HumanoidRootPart (ref)
        u1 = p19;
        u2 = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
    end);
    u18.BaseTrove:Connect(game.Players.PlayerRemoving, function(p20) -- Line: 136
        -- upvalues: LocalPlayer (ref), u1 (ref), HumanoidRootPart (ref), u2 (ref), u18 (copy)
        if p20 == LocalPlayer then
            u1 = nil;
            HumanoidRootPart = nil;
            u2 = nil;
            u18.BaseTrove:Destroy();
        end;
    end);
end;

return v3;