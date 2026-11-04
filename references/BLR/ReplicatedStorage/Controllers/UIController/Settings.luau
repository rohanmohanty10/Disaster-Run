  

local ReplicatedFirst = game:GetService("ReplicatedFirst");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MarketplaceService = game:GetService("MarketplaceService");
local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u2 = u1:FindFirstChildOfClass("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
local Popup = require(ReplicatedStorage.Shared.Popup);
local Trove = require(ReplicatedStorage.Shared.Trove);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local DebugUtil = require(ReplicatedStorage2.Shared.DebugUtil);
local ClientGlobals = require(ReplicatedStorage2.ClientModules.ClientGlobals);
local environment = require(ReplicatedStorage2.Shared.environment);
local u3 = nil;
local PlayerData = ClientGlobals.PlayerData;
local UserInput = ReplicatedFirst.UserInput;
local u4 = nil;
local v5 = Knit.CreateController({
    Name = "Settings"
});
local u6 = tick();
local u7 = {
    ["true"] = {
        Color = Color3.new(0.407843, 0.815686, 0.388235),
        Pos = UDim2.new(0.75, 0, 0.5, 0)
    },
    ["false"] = {
        Color = Color3.new(0.815686, 0.262745, 0.262745),
        Pos = UDim2.new(0.25, 0, 0.5, 0)
    }
};
local u8 = { "ParticleEmitter", "Beam", "Trail", "Fire", "Smoke", "Sparkles" };
local u9 = { "Lobby stuff", "Showroom", "Leaderboards", "VFXPreload" };

function v5.SetValues(p10) -- Line: 43
    -- upvalues: LocalPlayer (copy), u7 (copy), u3 (ref)
    local ScrollingFrame = LocalPlayer.PlayerGui.Settings.BG.BG.ScrollingFrame;
    ScrollingFrame.Music.Val.Text = tostring(p10.SettingsData.Music);
    ScrollingFrame.SFX.Val.Text = tostring(p10.SettingsData.SFX);
    ScrollingFrame.UISFX.Val.Text = tostring(p10.SettingsData.UISFX);
    ScrollingFrame.Emotes.Val.Text = tostring(p10.SettingsData.Emotes);
    ScrollingFrame.Crowd.Val.Bttn.Position = u7[tostring(p10.SettingsData.Crowd)].Pos;
    ScrollingFrame.Crowd.Val.Bttn.BackgroundColor3 = u7[tostring(p10.SettingsData.Crowd)].Color;
    ScrollingFrame.Crowd.Val.BackgroundColor3 = u7[tostring(p10.SettingsData.Crowd)].Color;
    ScrollingFrame.Shadows.Val.Bttn.Position = u7[tostring(p10.SettingsData.Shadows)].Pos;
    ScrollingFrame.Shadows.Val.Bttn.BackgroundColor3 = u7[tostring(p10.SettingsData.Shadows)].Color;
    ScrollingFrame.Shadows.Val.BackgroundColor3 = u7[tostring(p10.SettingsData.Shadows)].Color;
    ScrollingFrame.RunLock.Val.Bttn.Position = u7[tostring(p10.SettingsData.RunLock)].Pos;
    ScrollingFrame.RunLock.Val.Bttn.BackgroundColor3 = u7[tostring(p10.SettingsData.RunLock)].Color;
    ScrollingFrame.RunLock.Val.BackgroundColor3 = u7[tostring(p10.SettingsData.RunLock)].Color;
    ScrollingFrame.CosmeticPhysics.Val.Bttn.Position = u7[tostring(p10.SettingsData.CosmeticPhysics)].Pos;
    ScrollingFrame.CosmeticPhysics.Val.Bttn.BackgroundColor3 = u7[tostring(p10.SettingsData.CosmeticPhysics)].Color;
    ScrollingFrame.CosmeticPhysics.Val.BackgroundColor3 = u7[tostring(p10.SettingsData.CosmeticPhysics)].Color;
    ScrollingFrame.SpinOffWarning.Val.Bttn.Position = u7[tostring(p10.SettingsData.SpinOffWarning)].Pos;
    ScrollingFrame.SpinOffWarning.Val.Bttn.BackgroundColor3 = u7[tostring(p10.SettingsData.SpinOffWarning)].Color;
    ScrollingFrame.SpinOffWarning.Val.BackgroundColor3 = u7[tostring(p10.SettingsData.SpinOffWarning)].Color;
    ScrollingFrame.BallTrajectoryVision.Val.Bttn.Position = u7[tostring(p10.SettingsData.BallTrajectoryVision)].Pos;
    ScrollingFrame.BallTrajectoryVision.Val.Bttn.BackgroundColor3 = u7[tostring(p10.SettingsData.BallTrajectoryVision)].Color;
    ScrollingFrame.BallTrajectoryVision.Val.BackgroundColor3 = u7[tostring(p10.SettingsData.BallTrajectoryVision)].Color;
    ScrollingFrame.AirVolleys.Val.Bttn.Position = u7[tostring(p10.SettingsData.AirVolleys)].Pos;
    ScrollingFrame.AirVolleys.Val.Bttn.BackgroundColor3 = u7[tostring(p10.SettingsData.AirVolleys)].Color;
    ScrollingFrame.AirVolleys.Val.BackgroundColor3 = u7[tostring(p10.SettingsData.AirVolleys)].Color;

    if ScrollingFrame:FindFirstChild("HideOthersCosmetics") then
        local v11 = u7[tostring(p10.SettingsData.HideOthersCosmetics == true)];
        ScrollingFrame.HideOthersCosmetics.Val.Bttn.Position = v11.Pos;
        ScrollingFrame.HideOthersCosmetics.Val.Bttn.BackgroundColor3 = v11.Color;
        ScrollingFrame.HideOthersCosmetics.Val.BackgroundColor3 = v11.Color;
    end;

    if ScrollingFrame:FindFirstChild("DisableNELChatTag") then
        local v12 = u7[tostring(p10.SettingsData.DisableNELChatTag == true)];
        ScrollingFrame.DisableNELChatTag.Val.Bttn.Position = v12.Pos;
        ScrollingFrame.DisableNELChatTag.Val.Bttn.BackgroundColor3 = v12.Color;
        ScrollingFrame.DisableNELChatTag.Val.BackgroundColor3 = v12.Color;
    end;

    if ScrollingFrame:FindFirstChild("DisableEmoteMusic") then
        local v13 = u7[tostring(p10.SettingsData.DisableEmoteMusic == true)];
        ScrollingFrame.DisableEmoteMusic.Val.Bttn.Position = v13.Pos;
        ScrollingFrame.DisableEmoteMusic.Val.Bttn.BackgroundColor3 = v13.Color;
        ScrollingFrame.DisableEmoteMusic.Val.BackgroundColor3 = v13.Color;
    end;

    if ScrollingFrame:FindFirstChild("DisableCustomGoalSound") then
        local v14 = u7[tostring(p10.SettingsData.DisableCustomGoalSound == true)];
        ScrollingFrame.DisableCustomGoalSound.Val.Bttn.Position = v14.Pos;
        ScrollingFrame.DisableCustomGoalSound.Val.Bttn.BackgroundColor3 = v14.Color;
        ScrollingFrame.DisableCustomGoalSound.Val.BackgroundColor3 = v14.Color;
    end;

    if ScrollingFrame:FindFirstChild("DisableCustomAnkleBreakerSound") then
        local v15 = u7[tostring(p10.SettingsData.DisableCustomAnkleBreakerSound == true)];
        ScrollingFrame.DisableCustomAnkleBreakerSound.Val.Bttn.Position = v15.Pos;
        ScrollingFrame.DisableCustomAnkleBreakerSound.Val.Bttn.BackgroundColor3 = v15.Color;
        ScrollingFrame.DisableCustomAnkleBreakerSound.Val.BackgroundColor3 = v15.Color;
    end;

    if ScrollingFrame:FindFirstChild("DisableCustomStealSound") then
        local v16 = u7[tostring(p10.SettingsData.DisableCustomStealSound == true)];
        ScrollingFrame.DisableCustomStealSound.Val.Bttn.Position = v16.Pos;
        ScrollingFrame.DisableCustomStealSound.Val.Bttn.BackgroundColor3 = v16.Color;
        ScrollingFrame.DisableCustomStealSound.Val.BackgroundColor3 = v16.Color;
    end;

    if ScrollingFrame:FindFirstChild("DisableCustomSaveSound") then
        local v17 = u7[tostring(p10.SettingsData.DisableCustomSaveSound == true)];
        ScrollingFrame.DisableCustomSaveSound.Val.Bttn.Position = v17.Pos;
        ScrollingFrame.DisableCustomSaveSound.Val.Bttn.BackgroundColor3 = v17.Color;
        ScrollingFrame.DisableCustomSaveSound.Val.BackgroundColor3 = v17.Color;
    end;

    ScrollingFrame.ContentCreatorTag.Val.Bttn.Position = u7[tostring(p10.SettingsData.ContentCreatorTag)].Pos;
    ScrollingFrame.ContentCreatorTag.Val.Bttn.BackgroundColor3 = u7[tostring(p10.SettingsData.ContentCreatorTag)].Color;
    ScrollingFrame.ContentCreatorTag.Val.BackgroundColor3 = u7[tostring(p10.SettingsData.ContentCreatorTag)].Color;

    if ScrollingFrame:FindFirstChild("TesterTitle") then
        local v18 = u7[tostring(p10.SettingsData.TesterTitle == true)];
        ScrollingFrame.TesterTitle.Val.Bttn.Position = v18.Pos;
        ScrollingFrame.TesterTitle.Val.Bttn.BackgroundColor3 = v18.Color;
        ScrollingFrame.TesterTitle.Val.BackgroundColor3 = v18.Color;
    end;

    ScrollingFrame.FastMode.Val.Bttn.Position = u7[tostring(p10.SettingsData.FastMode)].Pos;
    ScrollingFrame.FastMode.Val.Bttn.BackgroundColor3 = u7[tostring(p10.SettingsData.FastMode)].Color;
    ScrollingFrame.FastMode.Val.BackgroundColor3 = u7[tostring(p10.SettingsData.FastMode)].Color;
    ScrollingFrame.GoalSound.TextBox.Text = p10.CustomData.GoalSound or "0";
    ScrollingFrame.AnkleBreakerSound.TextBox.Text = p10.CustomData.AnkleBreakerSound or "0";

    if ScrollingFrame:FindFirstChild("StealSound") then
        ScrollingFrame.StealSound.TextBox.Text = p10.CustomData.StealSound or "0";
    end;

    if ScrollingFrame:FindFirstChild("SaveSound") then
        ScrollingFrame.SaveSound.TextBox.Text = p10.CustomData.SaveSound or "0";
    end;

    ScrollingFrame.AwakeningOutfit.TextBox.Text = p10.CustomData.AwakeningOutfitId or "0";
    game.Lighting.GlobalShadows = false;

    if p10.SettingsData.CosmeticPhysics == false then
        LocalPlayer:SetAttribute("SmartBones", false);
    else
        LocalPlayer:SetAttribute("SmartBones", true);
    end;

    task.spawn(function() -- Line: 160
        -- upvalues: u3 (ref), ScrollingFrame (copy)
        local BankedGifts = u3:GetBankedGifts();

        if next(BankedGifts) then
            ScrollingFrame.BankedGifts.Visible = true;

            return;
        end;

        ScrollingFrame.BankedGifts.Visible = false;
    end);
end;

function v5.ApplyFastMode(u19) -- Line: 170
    -- upvalues: u8 (copy), u9 (copy)
    local function isInCharacter(p20) -- Line: 173
        for _, v in game.Players:GetPlayers() do
            if v.Character and p20:IsDescendantOf(v.Character) then
                return true;
            end;
        end;

        return false;
    end;

    if u19.SettingsData.FastMode then
        if not u19._fastModeCache then
            u19._fastModeCache = {};
        end;

        for _, v in u8 do
            local v21 = v;

            for _, descendant in workspace:GetDescendants() do
                if descendant:IsA(v21) and (descendant.Enabled ~= nil and (descendant.Enabled == true and not isInCharacter(descendant))) then
                    u19._fastModeCache[descendant] = true;
                    descendant.Enabled = false;
                end;
            end;
        end;

        for _, v in u9 do
            local v22 = workspace:FindFirstChild(v);

            if v22 then
                u19._fastModeCache[v22] = v22.Parent;
                v22.Parent = nil;
            end;
        end;

        if not u19._fastModeMaterials then
            u19._fastModeMaterials = {};
        end;

        if not u19._fastModeColors then
            u19._fastModeColors = {};
        end;

        local function applyToPart(p23) -- Line: 208
            -- upvalues: isInCharacter (copy), u19 (copy)
            if p23:IsA("BasePart") and not isInCharacter(p23) then
                if p23.Material ~= Enum.Material.SmoothPlastic then
                    u19._fastModeMaterials[p23] = p23.Material;
                    p23.Material = Enum.Material.SmoothPlastic;
                end;

                local Color = p23.Color;
                u19._fastModeColors[p23] = Color;
                p23.Color = Color3.new(Color.R * 0.55, Color.G * 0.55, Color.B * 0.55);
            end;
        end;

        for _, descendant in workspace:GetDescendants() do
            applyToPart(descendant);
        end;

        u19._fastModeChildConn = workspace.DescendantAdded:Connect(function(u24) -- Line: 222
            -- upvalues: applyToPart (copy)
            task.defer(function() -- Line: 223
                -- upvalues: u24 (copy), applyToPart (ref)
                if not u24.Parent then
                    return;
                end;

                applyToPart(u24);
            end);
        end);
        game.Lighting.GlobalShadows = false;

        if workspace.StreamingEnabled then
            u19._fastModeCache._origMinRadius = workspace.StreamingMinRadius;
            u19._fastModeCache._origTargetRadius = workspace.StreamingTargetRadius;
            workspace.StreamingMinRadius = 64;
            workspace.StreamingTargetRadius = 128;
        end;
    else
        if u19._fastModeChildConn then
            u19._fastModeChildConn:Disconnect();
            u19._fastModeChildConn = nil;
        end;

        if u19._fastModeCache then
            for i, v in u19._fastModeCache do
                if typeof(i) == "Instance" then
                    if i:IsA("Model") or (i:IsA("Folder") or i:IsA("Part")) then
                        if typeof(v) == "Instance" then
                            i.Parent = v;
                        end;
                    elseif i.Enabled ~= nil then
                        i.Enabled = true;
                    end;
                end;
            end;

            if u19._fastModeCache._origMinRadius then
                workspace.StreamingMinRadius = u19._fastModeCache._origMinRadius;
            end;

            if u19._fastModeCache._origTargetRadius then
                workspace.StreamingTargetRadius = u19._fastModeCache._origTargetRadius;
            end;

            u19._fastModeCache = nil;
        end;

        if u19._fastModeMaterials then
            for i, v in u19._fastModeMaterials do
                if i and i.Parent then
                    i.Material = v;
                end;
            end;

            u19._fastModeMaterials = nil;
        end;

        if u19._fastModeColors then
            for i, v in u19._fastModeColors do
                if i and i.Parent then
                    i.Color = v;
                end;
            end;

            u19._fastModeColors = nil;
        end;
    end;
end;

function v5.FastMode(u25) -- Line: 280
    -- upvalues: LocalPlayer (copy), u6 (ref)
    local FastMode = LocalPlayer.PlayerGui:WaitForChild("Settings"):WaitForChild("BG"):WaitForChild("BG"):WaitForChild("ScrollingFrame"):WaitForChild("FastMode");
    u25.BaseTrove:Connect(FastMode.Val.Bttn.MouseButton1Click, function() -- Line: 283
        -- upvalues: u6 (ref), u25 (copy)
        if u6 > tick() then
            return;
        end;

        u6 = tick() + 0.15;
        u25.SettingsData.FastMode = not u25.SettingsData.FastMode;
        u25:SetValues();
        u25:ApplyFastMode();
        u25.SettingsService.Setting:Fire("FastMode", u25.SettingsData.FastMode);
    end);
    u25:ApplyFastMode();
end;

function v5.Crowd(u26) -- Line: 297
    -- upvalues: LocalPlayer (copy), u6 (ref)
    local Crowd = LocalPlayer.PlayerGui:WaitForChild("Settings"):WaitForChild("BG"):WaitForChild("BG"):WaitForChild("ScrollingFrame"):WaitForChild("Crowd");
    u26.BaseTrove:Connect(Crowd.Val.Bttn.MouseButton1Click, function() -- Line: 300
        -- upvalues: u6 (ref), u26 (copy)
        if u6 > tick() then
            return;
        end;

        u6 = tick() + 0.15;
        u26.SettingsData.Crowd = not u26.SettingsData.Crowd;
        u26:SetValues();
        u26.SettingsService.Setting:Fire("Crowd", u26.SettingsData.Crowd);
    end);
end;

function v5.Shadows(u27) -- Line: 312
    -- upvalues: LocalPlayer (copy), u6 (ref)
    local Shadows = LocalPlayer.PlayerGui:WaitForChild("Settings"):WaitForChild("BG"):WaitForChild("BG"):WaitForChild("ScrollingFrame"):WaitForChild("Shadows");
    u27.BaseTrove:Connect(Shadows.Val.Bttn.MouseButton1Click, function() -- Line: 315
        -- upvalues: u6 (ref), u27 (copy)
        if u6 > tick() then
            return;
        end;

        u6 = tick() + 0.15;
        u27.SettingsData.Shadows = not u27.SettingsData.Shadows;
        game.Lighting.GlobalShadows = false;
        u27:SetValues();
        u27.SettingsService.Setting:Fire("Shadows", u27.SettingsData.Shadows);
    end);
end;

function v5.HideOthersCosmetics(u28) -- Line: 327
    -- upvalues: LocalPlayer (copy), Knit (copy), u6 (ref)
    local HideOthersCosmetics = LocalPlayer.PlayerGui:WaitForChild("Settings"):WaitForChild("BG"):WaitForChild("BG"):WaitForChild("ScrollingFrame"):FindFirstChild("HideOthersCosmetics");

    if not HideOthersCosmetics then
        return;
    end;

    local Controller = Knit.GetController("CosmeticsController");

    if Controller then
        Controller:SetHideOthersCosmetics(u28.SettingsData.HideOthersCosmetics == true);
    end;

    u28.BaseTrove:Connect(HideOthersCosmetics.Val.Bttn.MouseButton1Click, function() -- Line: 335
        -- upvalues: u6 (ref), u28 (copy), Controller (copy)
        if u6 > tick() then
            return;
        end;

        u6 = tick() + 0.15;
        u28.SettingsData.HideOthersCosmetics = u28.SettingsData.HideOthersCosmetics ~= true;
        u28:SetValues();
        u28.SettingsService.Setting:Fire("HideOthersCosmetics", u28.SettingsData.HideOthersCosmetics);

        if Controller then
            Controller:SetHideOthersCosmetics(u28.SettingsData.HideOthersCosmetics);
        end;
    end);
end;

function v5.DisableNELChatTag(u29) -- Line: 347
    -- upvalues: LocalPlayer (copy), u6 (ref)
    local DisableNELChatTag = LocalPlayer.PlayerGui:WaitForChild("Settings"):WaitForChild("BG"):WaitForChild("BG"):WaitForChild("ScrollingFrame"):FindFirstChild("DisableNELChatTag");

    if not DisableNELChatTag then
        return;
    end;

    u29.BaseTrove:Connect(DisableNELChatTag.Val.Bttn.MouseButton1Click, function() -- Line: 351
        -- upvalues: u6 (ref), u29 (copy)
        if u6 > tick() then
            return;
        end;

        u6 = tick() + 0.15;
        u29.SettingsData.DisableNELChatTag = u29.SettingsData.DisableNELChatTag ~= true;
        u29:SetValues();
        u29.SettingsService.Setting:Fire("DisableNELChatTag", u29.SettingsData.DisableNELChatTag);
    end);
end;

function v5.DisableEmoteMusic(u30) -- Line: 360
    -- upvalues: LocalPlayer (copy), u6 (ref)
    local DisableEmoteMusic = LocalPlayer.PlayerGui:WaitForChild("Settings"):WaitForChild("BG"):WaitForChild("BG"):WaitForChild("ScrollingFrame"):FindFirstChild("DisableEmoteMusic");

    if not DisableEmoteMusic then
        return;
    end;

    u30.BaseTrove:Connect(DisableEmoteMusic.Val.Bttn.MouseButton1Click, function() -- Line: 364
        -- upvalues: u6 (ref), u30 (copy)
        if u6 > tick() then
            return;
        end;

        u6 = tick() + 0.15;
        u30.SettingsData.DisableEmoteMusic = u30.SettingsData.DisableEmoteMusic ~= true;
        u30:SetValues();
        u30.SettingsService.Setting:Fire("DisableEmoteMusic", u30.SettingsData.DisableEmoteMusic);
    end);
end;

function v5.DisableCustomGoalSound(u31) -- Line: 373
    -- upvalues: LocalPlayer (copy), u6 (ref)
    local DisableCustomGoalSound = LocalPlayer.PlayerGui:WaitForChild("Settings"):WaitForChild("BG"):WaitForChild("BG"):WaitForChild("ScrollingFrame"):FindFirstChild("DisableCustomGoalSound");

    if not DisableCustomGoalSound then
        return;
    end;

    u31.BaseTrove:Connect(DisableCustomGoalSound.Val.Bttn.MouseButton1Click, function() -- Line: 377
        -- upvalues: u6 (ref), u31 (copy)
        if u6 > tick() then
            return;
        end;

        u6 = tick() + 0.15;
        u31.SettingsData.DisableCustomGoalSound = u31.SettingsData.DisableCustomGoalSound ~= true;
        u31:SetValues();
        u31.SettingsService.Setting:Fire("DisableCustomGoalSound", u31.SettingsData.DisableCustomGoalSound);
    end);
end;

function v5.DisableCustomStealSound(u32) -- Line: 386
    -- upvalues: LocalPlayer (copy), u6 (ref)
    local DisableCustomStealSound = LocalPlayer.PlayerGui:WaitForChild("Settings"):WaitForChild("BG"):WaitForChild("BG"):WaitForChild("ScrollingFrame"):FindFirstChild("DisableCustomStealSound");

    if not DisableCustomStealSound then
        return;
    end;

    u32.BaseTrove:Connect(DisableCustomStealSound.Val.Bttn.MouseButton1Click, function() -- Line: 390
        -- upvalues: u6 (ref), u32 (copy)
        if u6 > tick() then
            return;
        end;

        u6 = tick() + 0.15;
        u32.SettingsData.DisableCustomStealSound = u32.SettingsData.DisableCustomStealSound ~= true;
        u32:SetValues();
        u32.SettingsService.Setting:Fire("DisableCustomStealSound", u32.SettingsData.DisableCustomStealSound);
    end);
end;

function v5.DisableCustomSaveSound(u33) -- Line: 399
    -- upvalues: LocalPlayer (copy), u6 (ref)
    local DisableCustomSaveSound = LocalPlayer.PlayerGui:WaitForChild("Settings"):WaitForChild("BG"):WaitForChild("BG"):WaitForChild("ScrollingFrame"):FindFirstChild("DisableCustomSaveSound");

    if not DisableCustomSaveSound then
        return;
    end;

    u33.BaseTrove:Connect(DisableCustomSaveSound.Val.Bttn.MouseButton1Click, function() -- Line: 403
        -- upvalues: u6 (ref), u33 (copy)
        if u6 > tick() then
            return;
        end;

        u6 = tick() + 0.15;
        u33.SettingsData.DisableCustomSaveSound = u33.SettingsData.DisableCustomSaveSound ~= true;
        u33:SetValues();
        u33.SettingsService.Setting:Fire("DisableCustomSaveSound", u33.SettingsData.DisableCustomSaveSound);
    end);
end;

function v5.DisableCustomAnkleBreakerSound(u34) -- Line: 412
    -- upvalues: LocalPlayer (copy), u6 (ref)
    local DisableCustomAnkleBreakerSound = LocalPlayer.PlayerGui:WaitForChild("Settings"):WaitForChild("BG"):WaitForChild("BG"):WaitForChild("ScrollingFrame"):FindFirstChild("DisableCustomAnkleBreakerSound");

    if not DisableCustomAnkleBreakerSound then
        return;
    end;

    u34.BaseTrove:Connect(DisableCustomAnkleBreakerSound.Val.Bttn.MouseButton1Click, function() -- Line: 416
        -- upvalues: u6 (ref), u34 (copy)
        if u6 > tick() then
            return;
        end;

        u6 = tick() + 0.15;
        u34.SettingsData.DisableCustomAnkleBreakerSound = u34.SettingsData.DisableCustomAnkleBreakerSound ~= true;
        u34:SetValues();
        u34.SettingsService.Setting:Fire("DisableCustomAnkleBreakerSound", u34.SettingsData.DisableCustomAnkleBreakerSound);
    end);
end;

function v5.CosmeticPhysics(u35) -- Line: 425
    -- upvalues: LocalPlayer (copy), u6 (ref)
    local CosmeticPhysics = LocalPlayer.PlayerGui:WaitForChild("Settings"):WaitForChild("BG"):WaitForChild("BG"):WaitForChild("ScrollingFrame"):WaitForChild("CosmeticPhysics");
    u35.BaseTrove:Connect(CosmeticPhysics.Val.Bttn.MouseButton1Click, function() -- Line: 428
        -- upvalues: u6 (ref), u35 (copy)
        if u6 > tick() then
            return;
        end;

        u6 = tick() + 0.15;
        u35.SettingsData.CosmeticPhysics = not u35.SettingsData.CosmeticPhysics;
        u35:SetValues();
        u35.SettingsService.Setting:Fire("CosmeticPhysics", u35.SettingsData.CosmeticPhysics);
    end);
end;

function v5.RunLock(u36) -- Line: 439
    -- upvalues: LocalPlayer (copy), u6 (ref)
    local RunLock = LocalPlayer.PlayerGui:WaitForChild("Settings"):WaitForChild("BG"):WaitForChild("BG"):WaitForChild("ScrollingFrame"):WaitForChild("RunLock");
    u36.BaseTrove:Connect(RunLock.Val.Bttn.MouseButton1Click, function() -- Line: 442
        -- upvalues: u6 (ref), u36 (copy)
        if u6 > tick() then
            return;
        end;

        u6 = tick() + 0.15;
        u36.SettingsData.RunLock = not u36.SettingsData.RunLock;
        u36:SetValues();
        u36.SettingsService.Setting:Fire("RunLock", u36.SettingsData.RunLock);
    end);
end;

function v5.Music(u37) -- Line: 453
    -- upvalues: LocalPlayer (copy), u6 (ref), RunService (copy)
    local Music = LocalPlayer.PlayerGui:WaitForChild("Settings"):WaitForChild("BG"):WaitForChild("BG"):WaitForChild("ScrollingFrame"):WaitForChild("Music");
    u37.BaseTrove:Connect(Music.Inc.MouseButton1Click, function() -- Line: 456
        -- upvalues: u6 (ref), u37 (copy)
        if u6 > tick() then
            return;
        end;

        u6 = tick() + 0.15;

        if u37.SettingsData.Music >= 10 then
            return;
        end;

        local SettingsData = u37.SettingsData;
        SettingsData.Music = SettingsData.Music + 1;
        u37:SetValues();
        u37.SettingsService.Setting:Fire("Music", 1);
    end);
    u37.BaseTrove:Connect(Music.Dec.MouseButton1Click, function() -- Line: 468
        -- upvalues: u6 (ref), u37 (copy)
        if u6 > tick() then
            return;
        end;

        u6 = tick() + 0.15;

        if u37.SettingsData.Music <= 0 then
            return;
        end;

        local SettingsData = u37.SettingsData;
        SettingsData.Music = SettingsData.Music - 1;
        u37:SetValues();
        u37.SettingsService.Setting:Fire("Music", -1);
    end);
    u37.BaseTrove:Connect(RunService.Heartbeat, function() -- Line: 480
        -- upvalues: u37 (copy)
        if u37.SettingsData == nil then
            return;
        end;

        if u37.SettingsData.Music == nil then
            return;
        end;

        game.SoundService.SoundGroup.Volume = u37.SettingsData.Music / 10;
    end);
end;

function v5.SFX(u38) -- Line: 488
    -- upvalues: LocalPlayer (copy), u6 (ref), SoundManager (copy), RunService (copy)
    local SFX = LocalPlayer.PlayerGui:WaitForChild("Settings"):WaitForChild("BG"):WaitForChild("BG"):WaitForChild("ScrollingFrame"):WaitForChild("SFX");
    u38.BaseTrove:Connect(SFX.Inc.MouseButton1Click, function() -- Line: 491
        -- upvalues: u6 (ref), u38 (copy), SoundManager (ref), LocalPlayer (ref)
        if u6 > tick() then
            return;
        end;

        u6 = tick() + 0.15;

        if u38.SettingsData.SFX >= 10 then
            return;
        end;

        local SettingsData = u38.SettingsData;
        SettingsData.SFX = SettingsData.SFX + 1;
        u38:SetValues();
        local v39 = SoundManager.SpawnSound("Kick3", 0.8, LocalPlayer.PlayerGui);
        v39.SoundGroup = nil;
        v39.Volume = v39.Volume * (u38.SettingsData.SFX / 10);
        u38.SettingsService.Setting:Fire("SFX", 1);
    end);
    u38.BaseTrove:Connect(SFX.Dec.MouseButton1Click, function() -- Line: 507
        -- upvalues: u6 (ref), u38 (copy), SoundManager (ref), LocalPlayer (ref)
        if u6 > tick() then
            return;
        end;

        u6 = tick() + 0.15;

        if u38.SettingsData.SFX <= 0 then
            return;
        end;

        local SettingsData = u38.SettingsData;
        SettingsData.SFX = SettingsData.SFX - 1;
        u38:SetValues();
        local v40 = SoundManager.SpawnSound("Kick3", 0.8, LocalPlayer.PlayerGui);
        v40.SoundGroup = nil;
        v40.Volume = v40.Volume * (u38.SettingsData.SFX / 10);
        u38.SettingsService.Setting:Fire("SFX", -1);
    end);
    u38.BaseTrove:Connect(RunService.Heartbeat, function() -- Line: 523
        -- upvalues: u38 (copy), LocalPlayer (ref)
        if u38.SettingsData == nil then
            return;
        end;

        if u38.SettingsData.SFX == nil then
            return;
        end;

        game.SoundService.SFX.Volume = LocalPlayer.Team == game.Teams.Visitor and not u38.SpectatorController.IsSpectating and 0 or u38.SettingsData.SFX / 10;
    end);
end;

function v5.UISFX(u41) -- Line: 535
    -- upvalues: LocalPlayer (copy), u6 (ref), SoundManager (copy), RunService (copy)
    local UISFX = LocalPlayer.PlayerGui:WaitForChild("Settings"):WaitForChild("BG"):WaitForChild("BG"):WaitForChild("ScrollingFrame"):WaitForChild("UISFX");
    u41.BaseTrove:Connect(UISFX.Inc.MouseButton1Click, function() -- Line: 538
        -- upvalues: u6 (ref), u41 (copy), SoundManager (ref), LocalPlayer (ref)
        if u6 > tick() then
            return;
        end;

        u6 = tick() + 0.15;

        if u41.SettingsData.UISFX >= 10 then
            return;
        end;

        local SettingsData = u41.SettingsData;
        SettingsData.UISFX = SettingsData.UISFX + 1;
        u41:SetValues();
        SoundManager.SpawnSound("Click", 0.55, LocalPlayer.PlayerGui);
        u41.SettingsService.Setting:Fire("UISFX", 1);
    end);
    u41.BaseTrove:Connect(UISFX.Dec.MouseButton1Click, function() -- Line: 552
        -- upvalues: u6 (ref), u41 (copy), SoundManager (ref), LocalPlayer (ref)
        if u6 > tick() then
            return;
        end;

        u6 = tick() + 0.15;

        if u41.SettingsData.UISFX <= 0 then
            return;
        end;

        local SettingsData = u41.SettingsData;
        SettingsData.UISFX = SettingsData.UISFX - 1;
        u41:SetValues();
        SoundManager.SpawnSound("Click", 0.55, LocalPlayer.PlayerGui);
        u41.SettingsService.Setting:Fire("UISFX", -1);
    end);
    u41.BaseTrove:Connect(RunService.Heartbeat, function() -- Line: 566
        -- upvalues: u41 (copy)
        if u41.SettingsData == nil then
            return;
        end;

        if u41.SettingsData.UISFX == nil then
            return;
        end;

        game.SoundService.UISFX.Volume = u41.SettingsData.UISFX / 10;
    end);
end;

function v5.Emotes(u42) -- Line: 574
    -- upvalues: LocalPlayer (copy), u6 (ref), SoundManager (copy), RunService (copy)
    local Emotes = LocalPlayer.PlayerGui:WaitForChild("Settings"):WaitForChild("BG"):WaitForChild("BG"):WaitForChild("ScrollingFrame"):WaitForChild("Emotes");
    u42.BaseTrove:Connect(Emotes.Inc.MouseButton1Click, function() -- Line: 577
        -- upvalues: u6 (ref), u42 (copy), SoundManager (ref), LocalPlayer (ref)
        if u6 > tick() then
            return;
        end;

        u6 = tick() + 0.15;

        if u42.SettingsData.Emotes >= 10 then
            return;
        end;

        local SettingsData = u42.SettingsData;
        SettingsData.Emotes = SettingsData.Emotes + 1;
        u42:SetValues();
        SoundManager.SpawnSound("Click", 0.55, LocalPlayer.PlayerGui);
        u42.SettingsService.Setting:Fire("Emotes", 1);
    end);
    u42.BaseTrove:Connect(Emotes.Dec.MouseButton1Click, function() -- Line: 591
        -- upvalues: u6 (ref), u42 (copy), SoundManager (ref), LocalPlayer (ref)
        if u6 > tick() then
            return;
        end;

        u6 = tick() + 0.15;

        if u42.SettingsData.Emotes <= 0 then
            return;
        end;

        local SettingsData = u42.SettingsData;
        SettingsData.Emotes = SettingsData.Emotes - 1;
        u42:SetValues();
        SoundManager.SpawnSound("Click", 0.55, LocalPlayer.PlayerGui);
        u42.SettingsService.Setting:Fire("Emotes", -1);
    end);
    u42.BaseTrove:Connect(RunService.Heartbeat, function() -- Line: 605
        -- upvalues: u42 (copy)
        if u42.SettingsData == nil then
            return;
        end;

        if u42.SettingsData.Emotes == nil then
            return;
        end;

        game.SoundService.Emotes.Volume = u42.SettingsData.Emotes / 10;
        local DisplayEmotes = game.SoundService:FindFirstChild("DisplayEmotes");

        if DisplayEmotes then
            DisplayEmotes.Volume = u42.SettingsData.DisableEmoteMusic == true and 0 or u42.SettingsData.Emotes / 10;
        end;
    end);
end;

function v5.ContentCreatorTag(u43) -- Line: 618
    -- upvalues: LocalPlayer (copy), u6 (ref)
    local success, result = pcall(function() -- Line: 622
        -- upvalues: LocalPlayer (ref)
        return LocalPlayer:GetRankInGroup(34671275);
    end);

    if success and result < 30 then
        return;
    end;

    local ContentCreatorTag = LocalPlayer.PlayerGui:WaitForChild("Settings"):WaitForChild("BG"):WaitForChild("BG"):WaitForChild("ScrollingFrame"):WaitForChild("ContentCreatorTag");
    ContentCreatorTag.Visible = true;
    u43.SettingsData.ContentCreatorTag = false;
    u43.BaseTrove:Connect(ContentCreatorTag.Val.Bttn.MouseButton1Click, function() -- Line: 637
        -- upvalues: u6 (ref), u43 (copy)
        if u6 > tick() then
            return;
        end;

        u6 = tick() + 0.15;
        u43.SettingsData.ContentCreatorTag = not u43.SettingsData.ContentCreatorTag;
        u43:SetValues();
        u43.SettingsService.Setting:Fire("ContentCreatorTag", u43.SettingsData.ContentCreatorTag);
    end);
end;

function v5.TesterTitle(u44) -- Line: 648
    -- upvalues: LocalPlayer (copy), u6 (ref)
    local success, result = pcall(function() -- Line: 652
        -- upvalues: LocalPlayer (ref)
        return LocalPlayer:GetRankInGroup(34671275);
    end);

    if success and result < 20 then
        return;
    end;

    local TesterTitle = LocalPlayer.PlayerGui:WaitForChild("Settings"):WaitForChild("BG"):WaitForChild("BG"):WaitForChild("ScrollingFrame"):FindFirstChild("TesterTitle");

    if not TesterTitle then
        return;
    end;

    TesterTitle.Visible = true;
    u44.SettingsData.TesterTitle = false;
    u44.BaseTrove:Connect(TesterTitle.Val.Bttn.MouseButton1Click, function() -- Line: 669
        -- upvalues: u6 (ref), u44 (copy)
        if u6 > tick() then
            return;
        end;

        u6 = tick() + 0.15;
        u44.SettingsData.TesterTitle = not u44.SettingsData.TesterTitle;
        u44:SetValues();
        u44.SettingsService.Setting:Fire("TesterTitle", u44.SettingsData.TesterTitle);
    end);
end;

function v5.SpinOffWarning(u45) -- Line: 680
    -- upvalues: LocalPlayer (copy), u6 (ref)
    local SpinOffWarning = LocalPlayer.PlayerGui:WaitForChild("Settings"):WaitForChild("BG"):WaitForChild("BG"):WaitForChild("ScrollingFrame"):WaitForChild("SpinOffWarning");
    u45.BaseTrove:Connect(SpinOffWarning.Val.Bttn.MouseButton1Click, function() -- Line: 683
        -- upvalues: u6 (ref), u45 (copy)
        if u6 > tick() then
            return;
        end;

        u6 = tick() + 0.15;
        u45.SettingsData.SpinOffWarning = not u45.SettingsData.SpinOffWarning;
        u45:SetValues();
        u45.SettingsService.Setting:Fire("SpinOffWarning", u45.SettingsData.SpinOffWarning);
    end);
end;

function v5.BallTrajectoryVision(u46) -- Line: 694
    -- upvalues: LocalPlayer (copy), u6 (ref)
    local BallTrajectoryVision = LocalPlayer.PlayerGui:WaitForChild("Settings"):WaitForChild("BG"):WaitForChild("BG"):WaitForChild("ScrollingFrame"):WaitForChild("BallTrajectoryVision");
    u46.BaseTrove:Connect(BallTrajectoryVision.Val.Bttn.MouseButton1Click, function() -- Line: 697
        -- upvalues: u6 (ref), u46 (copy)
        if u6 > tick() then
            return;
        end;

        u6 = tick() + 0.15;
        u46.SettingsData.BallTrajectoryVision = not u46.SettingsData.BallTrajectoryVision;
        u46:SetValues();
        u46.SettingsService.Setting:Fire("BallTrajectoryVision", u46.SettingsData.BallTrajectoryVision);
    end);
end;

function v5.AirVolleys(u47) -- Line: 708
    -- upvalues: LocalPlayer (copy), u6 (ref), Popup (copy)
    local AirVolleys = LocalPlayer.PlayerGui:WaitForChild("Settings"):WaitForChild("BG"):WaitForChild("BG"):WaitForChild("ScrollingFrame"):WaitForChild("AirVolleys");
    u47.BaseTrove:Connect(AirVolleys.Val.Bttn.MouseButton1Click, function() -- Line: 711
        -- upvalues: u6 (ref), Popup (ref), LocalPlayer (ref), u47 (copy)
        if u6 > tick() then
            return;
        end;

        u6 = tick() + 0.15;
        Popup.Popup(LocalPlayer, "[This setting is not recommended on a bad connection.]");
        u47.SettingsData.AirVolleys = not u47.SettingsData.AirVolleys;
        u47:SetValues();
        u47.SettingsService.Setting:Fire("AirVolleys", u47.SettingsData.AirVolleys);
    end);
end;

function v5.ShowHitboxes(p48) -- Line: 724
    -- upvalues: Players (copy)
    local ServerSettings = workspace:WaitForChild("ServerSettings");

    local function applyHitboxVisibility(p49) -- Line: 727
        -- upvalues: Players (ref)
        for _, v in Players:GetPlayers() do
            local Character = v.Character;

            if Character then
                local Hitbox = Character:FindFirstChild("Hitbox");

                if Hitbox then
                    Hitbox.Transparency = p49 and 0.6 or 1;
                    Hitbox.BrickColor = BrickColor.new("Bright red");
                end;
            end;
        end;
    end;

    local function onCharacterAdded(p50) -- Line: 740
        -- upvalues: ServerSettings (copy)
        if not ServerSettings:GetAttribute("ShowHitboxes") then
            return;
        end;

        local Hitbox = p50:WaitForChild("Hitbox", 5);

        if Hitbox then
            Hitbox.Transparency = 0.6;
            Hitbox.BrickColor = BrickColor.new("Bright red");
        end;
    end;

    for _, v in Players:GetPlayers() do
        if v.Character then
            local Character = v.Character;
            local v51 = ServerSettings:GetAttribute("ShowHitboxes") and Character:WaitForChild("Hitbox", 5);

            if v51 then
                v51.Transparency = 0.6;
                v51.BrickColor = BrickColor.new("Bright red");
            end;
        end;

        v.CharacterAdded:Connect(onCharacterAdded);
    end;

    Players.PlayerAdded:Connect(function(p52) -- Line: 756
        -- upvalues: onCharacterAdded (copy)
        p52.CharacterAdded:Connect(onCharacterAdded);
    end);
    ServerSettings:GetAttributeChangedSignal("ShowHitboxes"):Connect(function() -- Line: 760
        -- upvalues: applyHitboxVisibility (copy), ServerSettings (copy)
        applyHitboxVisibility(ServerSettings:GetAttribute("ShowHitboxes"));
    end);
    applyHitboxVisibility(ServerSettings:GetAttribute("ShowHitboxes"));
end;

function v5.KeybindSet(u53) -- Line: 767
    -- upvalues: LocalPlayer (copy), UserInputService (copy), Popup (copy)
    u53.Keybinds = u53.SettingsService:GetBinds();

    while u53.Keybinds == nil do
        u53.Keybinds = u53.SettingsService:GetBinds();
        task.wait(0.1);
    end;

    u53.Keybinds.ConsoleImages = u53.DefaultKeyBinds.ConsoleImages;
    local Keybinds = LocalPlayer.PlayerGui:WaitForChild("Keybinds");
    local u54 = "Steal";
    local u55 = false;
    local u56 = "PC";
    LocalPlayer.PlayerGui:WaitForChild("Settings").BG.BG.ScrollingFrame.Keybinds.Bttn.MouseButton1Click:Connect(function() -- Line: 784
        -- upvalues: Keybinds (copy)
        Keybinds.Enabled = true;
    end);

    local function Change() -- Line: 788
        -- upvalues: Keybinds (copy), UserInputService (ref), LocalPlayer (ref), u53 (copy), u56 (ref), u54 (ref), Popup (ref), u55 (ref)
        for _, child in Keybinds.BG.Binds.Inside:GetChildren() do
            if child:IsA("ImageButton") ~= false then
                child:Destroy();
            end;
        end;

        if UserInputService.GamepadEnabled or UserInputService.TouchEnabled then
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["1"].Keybind.Text = "";
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["2"].Keybind.Text = "";
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["3"].Keybind.Text = "";
        else
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["1"].Keybind.Text = u53.Keybinds[u56].Ability1;
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["2"].Keybind.Text = u53.Keybinds[u56].Ability2;
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["3"].Keybind.Text = u53.Keybinds[u56].Ability3;
        end;

        local v57 = 0;

        for i, v in u53.Keybinds[u56] do
            if LocalPlayer.PlayerGui.InGameUI[`Keybinds{u56}`]:FindFirstChild(i) then
                LocalPlayer.PlayerGui.InGameUI[`Keybinds{u56}`][i].Keybind.Text = v;
            end;

            local v58 = script.Temp:Clone();
            v58.Name = tostring(v57);
            v58.Desc.Text = i;
            v58.Bind.Text = v;
            v58.Parent = Keybinds.BG.Binds.Inside;
            v58.MouseButton1Click:Connect(function() -- Line: 816
                -- upvalues: u54 (ref), i (copy), Popup (ref), LocalPlayer (ref), u55 (ref)
                u54 = i;
                Popup.Popup(LocalPlayer, (`Press any KEY to change {i} button!`));
                u55 = true;
            end);
            v57 = v57 + 1;
        end;
    end;

    Change();
    UserInputService.InputBegan:Connect(function(p59, p60) -- Line: 827
        -- upvalues: u55 (ref), u56 (ref), u53 (copy), Popup (ref), LocalPlayer (ref), u54 (ref), Change (copy)
        if p60 then
            return;
        end;

        if u55 == false then
            return;
        end;

        local v61 = tostring(p59.KeyCode);
        local v62 = tostring(p59.KeyCode);
        local string_len_ret = string.len(v62);
        local string_sub_ret = string.sub(v61, 14, string_len_ret);

        if Enum.KeyCode[string_sub_ret] == nil then
            return;
        end;

        if string_sub_ret == "Unknown" then
            return;
        end;

        u55 = false;

        if p59.UserInputType == Enum.UserInputType.Keyboard then
            u56 = "PC";
        end;

        if p59.UserInputType == Enum.UserInputType.Gamepad1 then
            u56 = "Console";
        end;

        if p59.UserInputType == Enum.UserInputType.Touch then
            u56 = "Mobile";

            return;
        end;

        for _, v in u53.Keybinds[u56] do
            if v == string_sub_ret then
                Popup.Popup(LocalPlayer, "Key is already being used!");

                return;
            end;
        end;

        Popup.Popup(LocalPlayer, (`Changed {u54} to {string_sub_ret}`));
        u53.Keybinds[u56][u54] = string_sub_ret;
        u53.SettingsService.Keybind:Fire(u56, u54, string_sub_ret);
        Change();
    end);
    Keybinds.BG.Exit.MouseButton1Click:Connect(function() -- Line: 852
        -- upvalues: Keybinds (copy)
        Keybinds.Enabled = false;
    end);
    Keybinds:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 856
        -- upvalues: u55 (ref), Change (copy)
        u55 = false;
        Change();
    end);

    if UserInputService.TouchEnabled then
        LocalPlayer.PlayerGui.Settings.BG.BG.ScrollingFrame.Restore.Visible = false;
        LocalPlayer.PlayerGui.Settings.BG.BG.ScrollingFrame.Keybinds.Visible = false;
    end;

    local u63 = tick();
    LocalPlayer.PlayerGui.Settings.BG.BG.ScrollingFrame.Restore.Bttn.MouseButton1Click:Connect(function() -- Line: 867
        -- upvalues: u63 (ref), u53 (copy)
        if u63 > tick() then
            return;
        end;

        u63 = tick() + 0.2;
        u53.SettingsService.Restore:Fire();
        u53.Keybinds = {
            PC = {
                Slide = "E",
                Dribble = "Q",
                Emote = "X",
                Request = "R",
                Awaken = "G",
                Flow = "T",
                Ability1 = "C",
                Ability2 = "V",
                Ability3 = "B"
            },
            Console = {
                Slide = "ButtonR1",
                Dribble = "ButtonR1",
                Emote = "DPadUp",
                Request = "ButtonL1",
                Awaken = "DPadRight",
                Flow = "ButtonL3",
                Ability1 = "ButtonX",
                Ability2 = "ButtonY",
                Ability3 = "ButtonB"
            },
            Mobile = {
                Dribble = { 0.957, 0.572 },
                Emote = { 0.87, 0.337 },
                Awaken = { 0.786, 0.66 },
                Flow = { 0.723, 0.798 },
                Shoot = { 0.875, 0.656 },
                Pass = { 0.874, 0.512 },
                Shiftlock = { 0.955, 0.269 },
                Run = { 0.957, 0.427 }
            }
        };
        u53.Keybinds.ConsoleImages = u53.DefaultKeyBinds.ConsoleImages;
    end);
end;

function v5.BindActionsToKeybinds(p64) -- Line: 911
    -- upvalues: UserInput (copy), PlayerData (copy)
    for _, v in {
        UserInput.GameplayContext.Ability1,
        UserInput.GameplayContext.Ability2,
        UserInput.GameplayContext.Ability3,
        UserInput.GameplayContext.RequestCR
    } do
        local Name = v.Name;

        local function updateInput() -- Line: 921
            -- upvalues: PlayerData (ref), v (copy), Name (copy)
            local v65 = PlayerData.Data and PlayerData.Data.PlayerKeybinds;

            if not v65 then
                return;
            end;

            v.KeyboardAndMouse.KeyCode = Enum.KeyCode[v65.PC[Name]];
            v.Gamepad.KeyCode = Enum.KeyCode[v65.Console[Name]];
        end;

        local v66 = PlayerData.Data and PlayerData.Data.PlayerKeybinds;

        if v66 then
            v.KeyboardAndMouse.KeyCode = Enum.KeyCode[v66.PC[Name]];
            v.Gamepad.KeyCode = Enum.KeyCode[v66.Console[Name]];
        end;

        PlayerData:Listen({ "PlayerKeybinds", Name }, updateInput);
    end;
end;

function v5.KnitStart(u67) -- Line: 935
    -- upvalues: Knit (copy), u4 (ref), LocalPlayer (copy), u3 (ref)
    u67.SpectatorController = Knit.GetController("SpectatorController");
    u67.SettingsService = Knit.GetService("SettingsService");
    u67.SettingsData = u67.SettingsService:GetData();

    while u67.SettingsData == nil do
        u67.SettingsData = u67.SettingsService:GetData();
        task.wait(0.5);
    end;

    u67.SettingsData.ContentCreatorTag = false;
    u67.SettingsData.TesterTitle = false;
    u67.CustomData = u4:GetProfile();
    u67:SetValues();
    u67.BaseTrove:Connect(LocalPlayer.PlayerGui:WaitForChild("Settings"):GetPropertyChangedSignal("Enabled"), function() -- Line: 953
        -- upvalues: LocalPlayer (ref), u67 (copy), u4 (ref)
        local v68 = LocalPlayer:GetAttribute("isCC") ~= nil;
        local v69 = LocalPlayer:GetAttribute("isTester") ~= nil;

        if LocalPlayer.PlayerGui.Settings.Enabled == false then
            if u67.SettingsData then
                table.clear(u67.SettingsData);
                u67.SettingsData = u67.SettingsService:GetData();
            end;
        elseif u67.SettingsData == nil then
            u67.SettingsData = u67.SettingsService:GetData();
        end;

        u67.SettingsData.ContentCreatorTag = v68;
        u67.SettingsData.TesterTitle = v69;
        u67.CustomData = u4:GetProfile();
        u67:SetValues();
    end);
    local ScrollingFrame = LocalPlayer.PlayerGui.Settings.BG.BG.ScrollingFrame;
    ScrollingFrame.AnkleBreakerSound.Set.Activated:Connect(function() -- Line: 978
        -- upvalues: u4 (ref), ScrollingFrame (copy)
        u4:SetSound("AnkleBreakerSound", ScrollingFrame.AnkleBreakerSound.TextBox.Text);
    end);
    ScrollingFrame.GoalSound.Set.Activated:Connect(function() -- Line: 981
        -- upvalues: u4 (ref), ScrollingFrame (copy)
        u4:SetSound("GoalSound", ScrollingFrame.GoalSound.TextBox.Text);
    end);

    if ScrollingFrame:FindFirstChild("StealSound") then
        ScrollingFrame.StealSound.Set.Activated:Connect(function() -- Line: 985
            -- upvalues: u4 (ref), ScrollingFrame (copy)
            u4:SetSound("StealSound", ScrollingFrame.StealSound.TextBox.Text);
        end);
    end;

    if ScrollingFrame:FindFirstChild("SaveSound") then
        ScrollingFrame.SaveSound.Set.Activated:Connect(function() -- Line: 990
            -- upvalues: u4 (ref), ScrollingFrame (copy)
            u4:SetSound("SaveSound", ScrollingFrame.SaveSound.TextBox.Text);
        end);
    end;

    ScrollingFrame.AwakeningOutfit.Set.Activated:Connect(function() -- Line: 994
        -- upvalues: u4 (ref), ScrollingFrame (copy)
        u4:EquipAWKOutfit(ScrollingFrame.AwakeningOutfit.TextBox.Text);
    end);
    local Template = ScrollingFrame.Parent.BankedGifts.Template;
    Template.Parent = nil;
    ScrollingFrame.BankedGifts.Bttn.Activated:Connect(function() -- Line: 1001
        -- upvalues: ScrollingFrame (copy), u3 (ref), Template (copy), LocalPlayer (ref)
        ScrollingFrame.Parent.BankedGifts.Visible = true;
        ScrollingFrame.Visible = false;
        ScrollingFrame.Parent.Parent.Close2.Visible = true;
        ScrollingFrame.Parent.Parent.Close.Visible = false;
        local BankedGifts = u3:GetBankedGifts();

        for _, child in ScrollingFrame.Parent.BankedGifts:GetChildren() do
            if child:IsA("GuiButton") then
                child:Destroy();
            end;
        end;

        for i, v in BankedGifts do
            print(i, v);
            local u70 = Template:Clone();
            local ProductInfo = game:GetService("MarketplaceService"):GetProductInfo(v, Enum.InfoType.Product);
            u70.Title.Text = `{ProductInfo.Name} ({ProductInfo.PriceInRobux})`;
            u70.Parent = ScrollingFrame.Parent.BankedGifts;
            u70:SetAttribute("ReceiptID", i);
            u70:SetAttribute("ID", v);
            u70.Activated:Connect(function() -- Line: 1021
                -- upvalues: LocalPlayer (ref), u70 (copy), ScrollingFrame (ref)
                local Gift = require(script.Parent.Gift);
                LocalPlayer.PlayerGui.Gift.Enabled = true;
                Gift.LastID = u70:GetAttribute("ID");
                Gift.LastReceiptID = u70:GetAttribute("ReceiptID");
                ScrollingFrame.Parent.BankedGifts.Visible = false;
                ScrollingFrame.Visible = true;
                ScrollingFrame.Parent.Parent.Close2.Visible = false;
                ScrollingFrame.Parent.Parent.Close.Visible = true;
            end);
        end;
    end);
    ScrollingFrame.Parent.Parent.Close2.Activated:Connect(function() -- Line: 1034
        -- upvalues: ScrollingFrame (copy)
        ScrollingFrame.Parent.BankedGifts.Visible = false;
        ScrollingFrame.Visible = true;
        ScrollingFrame.Parent.Parent.Close2.Visible = false;
        ScrollingFrame.Parent.Parent.Close.Visible = true;
    end);
    u67:Music();
    u67:SFX();
    u67:UISFX();
    u67:Emotes();
    u67:Crowd();
    u67:Shadows();
    u67:HideOthersCosmetics();
    u67:DisableNELChatTag();
    u67:DisableCustomGoalSound();
    u67:DisableEmoteMusic();
    u67:DisableCustomAnkleBreakerSound();
    u67:DisableCustomStealSound();
    u67:DisableCustomSaveSound();
    u67:RunLock();
    u67:CosmeticPhysics();
    u67:SpinOffWarning();
    u67:BallTrajectoryVision();
    u67:AirVolleys();
    u67:ContentCreatorTag();
    u67:TesterTitle();
    u67:FastMode();
    u67:ShowHitboxes();
    u67:KeybindSet();
    u67:BindActionsToKeybinds();
end;

function v5.KnitInit(u71) -- Line: 1067
    -- upvalues: u3 (ref), Knit (copy), u4 (ref), Trove (copy), LocalPlayer (copy), u1 (ref), u2 (ref), HumanoidRootPart (ref), u7 (copy), DebugUtil (copy), UserInputService (copy), ReplicatedStorage2 (copy), environment (copy), RunService (copy), MarketplaceService (copy), ReplicatedStorage (copy)
    u3 = Knit.GetService("MarketService");
    u4 = Knit.GetService("CustomizationService");
    u71.Keybinds = {
        PC = {
            Slide = "E",
            Dribble = "Q",
            Emote = "X",
            Request = "R",
            Awaken = "G",
            Flow = "T",
            Ability1 = "C",
            Ability2 = "V",
            Ability3 = "B"
        },
        Console = {
            Slide = "ButtonR1",
            Dribble = "ButtonR1",
            Emote = "DPadUp",
            Request = "ButtonL1",
            Awaken = "DPadRight",
            Flow = "ButtonL3",
            Ability1 = "ButtonX",
            Ability2 = "ButtonY",
            Ability3 = "ButtonB"
        },
        Mobile = {
            Dribble = { 0.957, 0.572 },
            Emote = { 0.87, 0.337 },
            Awaken = { 0.786, 0.66 },
            Flow = { 0.723, 0.798 },
            Shoot = { 0.875, 0.656 },
            Pass = { 0.874, 0.512 },
            Shiftlock = { 0.955, 0.269 },
            Run = { 0.957, 0.427 }
        },
        ConsoleImages = {
            [Enum.KeyCode.ButtonL1] = {
                xbox = "rbxassetid://72974413874934",
                ps = "rbxassetid://70466834217349"
            },
            [Enum.KeyCode.ButtonL2] = {
                xbox = "rbxassetid://83697731945448",
                ps = "rbxassetid://138599713361244"
            },
            [Enum.KeyCode.ButtonL3] = {
                xbox = "rbxassetid://93729859351124",
                ps = "rbxassetid://90877672738700"
            },
            [Enum.KeyCode.DPadUp] = {
                xbox = "rbxassetid://88998279874543",
                ps = "rbxassetid://123662468503587"
            },
            [Enum.KeyCode.DPadRight] = {
                xbox = "rbxassetid://89376419969117",
                ps = "rbxassetid://74919166333399"
            },
            [Enum.KeyCode.DPadLeft] = {
                xbox = "rbxassetid://80137534731403",
                ps = "rbxassetid://76560372152681"
            },
            [Enum.KeyCode.DPadDown] = {
                xbox = "rbxassetid://74001736372697",
                ps = "rbxassetid://99809626200804"
            },
            [Enum.KeyCode.ButtonR1] = {
                xbox = "rbxassetid://115268346280207",
                ps = "rbxassetid://115706592561396"
            },
            [Enum.KeyCode.ButtonR2] = {
                xbox = "rbxassetid://89922098499871",
                ps = "rbxassetid://78892629635376"
            },
            [Enum.KeyCode.ButtonR3] = {
                xbox = "rbxassetid://130267784051765",
                ps = "rbxassetid://122958464649802"
            },
            [Enum.KeyCode.ButtonX] = {
                xbox = "rbxassetid://91817919366170",
                ps = "rbxassetid://80479027436990"
            },
            [Enum.KeyCode.ButtonY] = {
                xbox = "rbxassetid://130052377775011",
                ps = "rbxassetid://101128500176794"
            },
            [Enum.KeyCode.ButtonB] = {
                xbox = "rbxassetid://105312766601341",
                ps = "rbxassetid://70974133654990"
            },
            [Enum.KeyCode.ButtonA] = {
                xbox = "rbxassetid://117557825423309",
                ps = "rbxassetid://95717013376600"
            },
            [Enum.KeyCode.ButtonSelect] = {
                xbox = "rbxassetid://99017970804096",
                ps = "rbxassetid://99017970804096"
            },
            [Enum.KeyCode.ButtonStart] = {
                xbox = "rbxassetid://111835518770071",
                ps = "rbxassetid://99017970804096"
            }
        }
    };
    u71.DefaultKeyBinds = table.clone(u71.Keybinds);
    u71.BaseTrove = Trove.new();
    u71.BaseTrove:Connect(LocalPlayer.CharacterAdded, function(p72) -- Line: 1132
        -- upvalues: u1 (ref), u2 (ref), HumanoidRootPart (ref)
        u1 = p72;
        u2 = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
    end);
    u71.BaseTrove:Connect(game.Players.PlayerRemoving, function(p73) -- Line: 1138
        -- upvalues: LocalPlayer (ref), u1 (ref), HumanoidRootPart (ref), u2 (ref), u71 (copy)
        if p73 == LocalPlayer then
            u1 = nil;
            HumanoidRootPart = nil;
            u2 = nil;
            u71.BaseTrove:Destroy();
        end;
    end);
    local Service = Knit.GetService("CustomServerService");
    local ServerSettings = workspace:WaitForChild("ServerSettings");
    local PSPlus = LocalPlayer.PlayerGui.Settings.BG.BG.ScrollingFrame.PSPlus;

    local function setupPSCommand(u74: string, u75: userdata, p76: userdata, u77: string) -- Line: 1152
        -- upvalues: LocalPlayer (ref), Service (copy), ServerSettings (copy), u7 (ref), DebugUtil (ref), UserInputService (ref), Knit (ref), ReplicatedStorage2 (ref)
        p76.Activated:Connect(function() -- Line: 1153
            -- upvalues: u77 (copy), LocalPlayer (ref), Service (ref), u74 (copy)
            if u77 ~= "Targeted" then
                if u77 == "Toggle" or u77 == "Misc" then
                    Service:Execute(u74);
                end;

                return;
            end;

            local Gift = require(script.Parent.Gift);
            LocalPlayer.PlayerGui.Gift:GetPropertyChangedSignal("Enabled"):Once(function() -- Line: 1156
                -- upvalues: Gift (copy), Service (ref), u74 (ref)
                function Gift.ClickHook(p78) -- Line: 1157
                    -- upvalues: Service (ref), u74 (ref)
                    Service:Execute(u74, p78);
                end;
            end);
            LocalPlayer.PlayerGui.Gift.Enabled = true;
        end);

        if u77 == "Toggle" then
            local u79 = u74 == "PauseTimer" and "TimerPaused" or u74;
            local Attribute = ServerSettings:GetAttribute(u79);

            if Attribute == nil then
                Attribute = false;
            end;

            u75.Val.Bttn.Position = u7[tostring(Attribute)].Pos;
            u75.Val.Bttn.BackgroundColor3 = u7[tostring(Attribute)].Color;
            u75.Val.BackgroundColor3 = u7[tostring(Attribute)].Color;
            ServerSettings:GetAttributeChangedSignal(u79):Connect(function() -- Line: 1181
                -- upvalues: ServerSettings (ref), u79 (ref), u75 (copy), u7 (ref)
                local Attribute2 = ServerSettings:GetAttribute(u79);

                if Attribute2 == nil then
                    Attribute2 = false;
                end;

                u75.Val.Bttn.Position = u7[tostring(Attribute2)].Pos;
                u75.Val.Bttn.BackgroundColor3 = u7[tostring(Attribute2)].Color;
                u75.Val.BackgroundColor3 = u7[tostring(Attribute2)].Color;
            end);
        end;

        if u74 == "EnableKeybinds" then
            if DebugUtil.isAdmin(LocalPlayer) then
                return;
            end;

            UserInputService.InputBegan:Connect(function(p80, p81) -- Line: 1198
                -- upvalues: Knit (ref), ReplicatedStorage2 (ref)
                if p81 then
                    return;
                end;

                if p80.KeyCode == Enum.KeyCode.Y then
                    Knit.GetService("BallService").GOD_GrabBall:Fire();

                    return;
                end;

                if p80.KeyCode == Enum.KeyCode.U and workspace.ServerSettings:GetAttribute("EnableKeybinds") then
                    local legacy = Knit.GetController("AbilityController").legacy;

                    for _, v in { "One", "Two", "Three" } do
                        legacy["Ability" .. v] = 0;
                    end;

                    legacy:AbilityCooldown(tostring(1), 0);
                    legacy:AbilityCooldown(tostring(2), 0);
                    legacy:AbilityCooldown(tostring(3), 0);
                    ReplicatedStorage2.AdmResetCDs:FireServer();
                end;
            end);
        end;
    end;

    local _ = PSPlus.Kick;
    local u82 = "Targeted";
    local u83 = "KickPlayer";
    PSPlus.Kick.Set.Activated:Connect(function() -- Line: 1153
        -- upvalues: u82 (copy), LocalPlayer (ref), Service (copy), u83 (copy)
        if u82 ~= "Targeted" then
            if u82 == "Toggle" or u82 == "Misc" then
                Service:Execute(u83);
            end;

            return;
        end;

        local Gift = require(script.Parent.Gift);
        LocalPlayer.PlayerGui.Gift:GetPropertyChangedSignal("Enabled"):Once(function() -- Line: 1156
            -- upvalues: Gift (copy), Service (ref), u83 (ref)
            function Gift.ClickHook(p84) -- Line: 1157
                -- upvalues: Service (ref), u83 (ref)
                Service:Execute(u83, p84);
            end;
        end);
        LocalPlayer.PlayerGui.Gift.Enabled = true;
    end);
    setupPSCommand("ServerLockdown", PSPlus.ServerLockdown, PSPlus.ServerLockdown.Val.Bttn, "Toggle");
    local _ = PSPlus.Awaken;
    local u85 = "Targeted";
    local u86 = "Awaken";
    PSPlus.Awaken.Set.Activated:Connect(function() -- Line: 1153
        -- upvalues: u85 (copy), LocalPlayer (ref), Service (copy), u86 (copy)
        if u85 ~= "Targeted" then
            if u85 == "Toggle" or u85 == "Misc" then
                Service:Execute(u86);
            end;

            return;
        end;

        local Gift = require(script.Parent.Gift);
        LocalPlayer.PlayerGui.Gift:GetPropertyChangedSignal("Enabled"):Once(function() -- Line: 1156
            -- upvalues: Gift (copy), Service (ref), u86 (ref)
            function Gift.ClickHook(p87) -- Line: 1157
                -- upvalues: Service (ref), u86 (ref)
                Service:Execute(u86, p87);
            end;
        end);
        LocalPlayer.PlayerGui.Gift.Enabled = true;
    end);
    local _ = PSPlus.MaxFlow;
    local u88 = "Targeted";
    local u89 = "MaxFlow";
    PSPlus.MaxFlow.Set.Activated:Connect(function() -- Line: 1153
        -- upvalues: u88 (copy), LocalPlayer (ref), Service (copy), u89 (copy)
        if u88 ~= "Targeted" then
            if u88 == "Toggle" or u88 == "Misc" then
                Service:Execute(u89);
            end;

            return;
        end;

        local Gift = require(script.Parent.Gift);
        LocalPlayer.PlayerGui.Gift:GetPropertyChangedSignal("Enabled"):Once(function() -- Line: 1156
            -- upvalues: Gift (copy), Service (ref), u89 (ref)
            function Gift.ClickHook(p90) -- Line: 1157
                -- upvalues: Service (ref), u89 (ref)
                Service:Execute(u89, p90);
            end;
        end);
        LocalPlayer.PlayerGui.Gift.Enabled = true;
    end);
    setupPSCommand("PauseTimer", PSPlus.PauseTimer, PSPlus.PauseTimer.Val.Bttn, "Toggle");
    setupPSCommand("ShowBalancing", PSPlus.ShowBalancing, PSPlus.ShowBalancing.Val.Bttn, "Toggle");
    setupPSCommand("ShowHitboxes", PSPlus.ShowHitboxes, PSPlus.ShowHitboxes.Val.Bttn, "Toggle");

    if game:GetService("RunService"):IsStudio() or environment.env == "Dev" then
        setupPSCommand("TestDummy", PSPlus.TestDummy, PSPlus.TestDummy.Val.Bttn, "Toggle");
    else
        PSPlus.TestDummy.Visible = false;
    end;

    setupPSCommand("EnableKeybinds", PSPlus.EnableKeybinds, PSPlus.EnableKeybinds.Val.Bttn, "Toggle");
    setupPSCommand("NoAbilityCooldown", PSPlus.NoAbilityCooldown, PSPlus.NoAbilityCooldown.Val.Bttn, "Toggle");

    if PSPlus:FindFirstChild("InfiniteAwakening") then
        setupPSCommand("InfiniteAwakening", PSPlus.InfiniteAwakening, PSPlus.InfiniteAwakening.Val.Bttn, "Toggle");
    end;

    if PSPlus:FindFirstChild("InfiniteFlow") then
        setupPSCommand("InfiniteFlow", PSPlus.InfiniteFlow, PSPlus.InfiniteFlow.Val.Bttn, "Toggle");
    end;

    if PSPlus:FindFirstChild("InfiniteStamina") then
        setupPSCommand("InfiniteStamina", PSPlus.InfiniteStamina, PSPlus.InfiniteStamina.Val.Bttn, "Toggle");
    end;

    local _ = PSPlus.SkipTimer;
    local u91 = "Misc";
    local u92 = "SkipTimer";
    PSPlus.SkipTimer.Set.Activated:Connect(function() -- Line: 1153
        -- upvalues: u91 (copy), LocalPlayer (ref), Service (copy), u92 (copy)
        if u91 ~= "Targeted" then
            if u91 == "Toggle" or u91 == "Misc" then
                Service:Execute(u92);
            end;

            return;
        end;

        local Gift = require(script.Parent.Gift);
        LocalPlayer.PlayerGui.Gift:GetPropertyChangedSignal("Enabled"):Once(function() -- Line: 1156
            -- upvalues: Gift (copy), Service (ref), u92 (ref)
            function Gift.ClickHook(p93) -- Line: 1157
                -- upvalues: Service (ref), u92 (ref)
                Service:Execute(u92, p93);
            end;
        end);
        LocalPlayer.PlayerGui.Gift.Enabled = true;
    end);
    PSPlus.GrabBall.Visible = ServerSettings:GetAttribute("EnableKeybinds") or false;
    PSPlus.ResetCooldowns.Visible = ServerSettings:GetAttribute("EnableKeybinds") or false;
    ServerSettings:GetAttributeChangedSignal("EnableKeybinds"):Connect(function() -- Line: 1248
        -- upvalues: ServerSettings (copy), PSPlus (copy)
        local v94 = ServerSettings:GetAttribute("EnableKeybinds") or false;
        PSPlus.GrabBall.Visible = v94;
        PSPlus.ResetCooldowns.Visible = v94;
    end);
    PSPlus.GrabBall.Set.Activated:Connect(function() -- Line: 1254
        -- upvalues: ServerSettings (copy), Knit (ref)
        if not ServerSettings:GetAttribute("EnableKeybinds") then
            return;
        end;

        Knit.GetService("BallService").GOD_GrabBall:Fire();
    end);
    PSPlus.ResetCooldowns.Set.Activated:Connect(function() -- Line: 1259
        -- upvalues: ServerSettings (copy), Knit (ref), ReplicatedStorage2 (ref)
        if not ServerSettings:GetAttribute("EnableKeybinds") then
            return;
        end;

        local legacy = Knit.GetController("AbilityController").legacy;

        for _, v in { "One", "Two", "Three" } do
            legacy["Ability" .. v] = 0;
        end;

        legacy:AbilityCooldown(tostring(1), 0);
        legacy:AbilityCooldown(tostring(2), 0);
        legacy:AbilityCooldown(tostring(3), 0);
        ReplicatedStorage2.AdmResetCDs:FireServer();
    end);

    local function update() -- Line: 1271
        -- upvalues: LocalPlayer (ref), RunService (ref), environment (ref), PSPlus (copy)
        local PSPlus2 = require(script.Parent.Shop):GetGamepasses().PSPlus;
        local v95 = workspace:GetAttribute("CustomServerOwnerId") ~= nil;
        local v96 = workspace:GetAttribute("CustomServerOwnerId") == LocalPlayer.UserId;

        if RunService:IsStudio() or environment.env == "Dev" then
            local RequiresPS = PSPlus.Folder.RequiresPS;
            local RequiresOwner = PSPlus.Folder.RequiresOwner;
            PSPlus.Folder.NotOwned.Visible = false;
            RequiresPS.Visible = false;
            RequiresOwner.Visible = false;

            return;
        end;

        if not v95 then
            local RequiresPS = PSPlus.Folder.RequiresPS;
            local RequiresOwner = PSPlus.Folder.RequiresOwner;
            PSPlus.Folder.NotOwned.Visible = false;
            RequiresPS.Visible = true;
            RequiresOwner.Visible = false;

            return;
        end;

        if not v96 then
            local RequiresPS = PSPlus.Folder.RequiresPS;
            local RequiresOwner = PSPlus.Folder.RequiresOwner;
            PSPlus.Folder.NotOwned.Visible = false;
            RequiresPS.Visible = false;
            RequiresOwner.Visible = true;

            return;
        end;

        if PSPlus2 then
            local RequiresPS = PSPlus.Folder.RequiresPS;
            local RequiresOwner = PSPlus.Folder.RequiresOwner;
            PSPlus.Folder.NotOwned.Visible = false;
            RequiresPS.Visible = false;
            RequiresOwner.Visible = false;

            return;
        end;

        local RequiresPS = PSPlus.Folder.RequiresPS;
        local RequiresOwner = PSPlus.Folder.RequiresOwner;
        PSPlus.Folder.NotOwned.Visible = true;
        RequiresPS.Visible = false;
        RequiresOwner.Visible = false;
    end;

    update();
    workspace:GetAttributeChangedSignal("CustomServerOwnerId", update);
    require(script.Parent.Shop):ObserveGamepasses(update);
    PSPlus.Folder.NotOwned.RobuxButton.Activated:Connect(function() -- Line: 1294
        -- upvalues: MarketplaceService (ref), LocalPlayer (ref), ReplicatedStorage (ref)
        MarketplaceService:PromptGamePassPurchase(LocalPlayer, require(ReplicatedStorage.Shared.Configs.Gamepasses).PSPlus.ID);
    end);
end;

function v5.GetConsoleKeybindImage(p97, p98) -- Line: 1299
    -- upvalues: UserInputService (copy)
    local v99 = p97.DefaultKeyBinds.ConsoleImages[p98];
    local v100 = UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonA) == "ButtonA";
    local v101;

    if v99 then
        local v102;

        if v100 then
            v102 = v99.xbox;
        else
            v102 = v99.ps;
        end;

        v101 = v102 or "";
    else
        v101 = "";
    end;

    return v101;
end;

return v5;