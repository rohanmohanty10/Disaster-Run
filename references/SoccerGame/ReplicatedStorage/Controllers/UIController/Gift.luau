  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u2 = u1:FindFirstChildOfClass("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.Essentials);
local Trove = require(ReplicatedStorage.Shared.Trove);
local u3 = Knit.CreateController({
    Name = "Gift"
});

function u3.RegisterButton(u4: table, u5: userdata, u6: number?) -- Line: 20
    -- upvalues: LocalPlayer (copy)
    u5.MouseButton1Click:Connect(function() -- Line: 21
        -- upvalues: u4 (copy), LocalPlayer (ref), u6 (copy), u5 (copy)
        print("Activate");

        if u4.ButtonDb > tick() then
            return;
        end;

        LocalPlayer.PlayerGui.Gift.Enabled = true;
        u4.LastID = u6 or u5:GetAttribute("ID");
        u4.LastReceiptID = u5:GetAttribute("ReceiptID");
    end);
end;

function u3.GiftPlayer(p7) -- Line: 32
    -- upvalues: LocalPlayer (copy)
    local Descendants = LocalPlayer.PlayerGui:GetDescendants();

    for _, v in pairs(Descendants) do
        if v.Name == "Gift" and (v:IsA("ImageButton") ~= false and (v.Parent:IsA("Frame") ~= false or (v.Parent:IsA("ImageLabel") or (v.Parent:IsA("ScreenGui") ~= false or v.Parent:IsA("ImageButton"))))) then
            p7:RegisterButton(v);
        end;
    end;
end;

function u3.SpawnPlayers(p8) -- Line: 44
    -- upvalues: Players (copy), ReplicatedStorage (copy), LocalPlayer (copy)
    local Players2 = Players:GetPlayers();

    local function playerAdded(p9) -- Line: 47
        -- upvalues: ReplicatedStorage (ref), Players (ref), LocalPlayer (ref)
        local v10 = ReplicatedStorage.Assets.UI.PlayerForGift:Clone();
        v10.Name1.Text = p9.Name;
        v10.Photo.Image = Players:GetUserThumbnailAsync(p9.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size352x352);
        v10:SetAttribute("userId", p9.UserId);
        v10.Parent = LocalPlayer.PlayerGui.Gift.BG.Players.Players;
    end;

    for _, v in pairs(Players2) do
        playerAdded(v);
    end;

    table.clear(Players2);
    p8.Trove:Connect(Players.PlayerAdded, playerAdded);
    p8.Trove:Connect(Players.PlayerRemoving, function(p11) -- Line: 64
        -- upvalues: LocalPlayer (ref)
        local Children = LocalPlayer.PlayerGui.Gift.BG.Players.Players:GetChildren();

        for _, v in pairs(Children) do
            if v:IsA("ImageButton") and v:GetAttribute("userId") == p11.UserId then
                v:Destroy();
            end;
        end;

        table.clear(Children);
    end);
end;

function u3.KnitStart(u12) -- Line: 81
    -- upvalues: Knit (copy), Trove (copy), LocalPlayer (copy), u3 (copy), Popup (copy)
    local Service = Knit.GetService("GiftService");
    u12.ButtonDb = tick();
    u12.LastID = 0;
    u12.LastReceiptID = nil;
    u12.BttnTrove = Trove.new();
    local Name1 = LocalPlayer.PlayerGui.Gift.BG.Players.Players.OfflineUser.Name1;
    u12.Trove:Connect(Service.Return, function() -- Line: 91
        -- upvalues: u12 (copy)
        u12.ButtonDb = tick();
    end);
    u12.Trove:Connect(LocalPlayer.PlayerGui.Gift:GetPropertyChangedSignal("Enabled"), function() -- Line: 95
        -- upvalues: u12 (copy), LocalPlayer (ref), u3 (ref), Service (copy), Name1 (copy)
        u12.BttnTrove:Clean();

        if LocalPlayer.PlayerGui.Gift.Enabled == false then
            u12.ClickHook = nil;
        end;

        local Children = LocalPlayer.PlayerGui.Gift.BG.Players.Players:GetChildren();

        for _, v in pairs(Children) do
            if v:IsA("ImageButton") ~= false then
                u12.BttnTrove:Connect(v.MouseButton1Click, function() -- Line: 105
                    -- upvalues: u12 (ref), u3 (ref), v (copy), Service (ref), LocalPlayer (ref), Name1 (ref)
                    if u12.ButtonDb > tick() then
                        return;
                    end;

                    u12.ButtonDb = tick() + 2;
                    print("click hook =", u3.ClickHook, u12.LastID);

                    if u3.ClickHook then
                        u3.ClickHook(game.Players:FindFirstChild(v.Name1.Text));
                    else
                        Service.Gift:Fire(v:GetAttribute("userId"), u12.LastID, u12.LastReceiptID);
                    end;

                    LocalPlayer.PlayerGui.Gift.Enabled = false;
                    Name1.Text = "";
                end);
            end;
        end;

        table.clear(Children);
    end);
    u12.Trove:Connect(Name1.FocusLost, function(p13) -- Line: 124
        -- upvalues: Name1 (copy), Popup (ref), u3 (ref), Service (copy), u12 (copy), LocalPlayer (ref)
        if not p13 then
            return;
        end;

        local success, result = pcall(function() -- Line: 127
            -- upvalues: Name1 (ref)
            return game.Players:GetUserIdFromNameAsync(Name1.Text);
        end);

        if not success then
            Popup.Popup(nil, "Could not find user!");

            return;
        end;

        if u3.ClickHook then
            local v14 = game.Players:FindFirstChild(Name1.Text);

            if not v14 then
                Popup.Popup(nil, "Player not in game!");

                return;
            end;

            u3.ClickHook(v14);
        else
            Service.Gift:Fire(result, u12.LastID, u12.LastReceiptID);
        end;

        LocalPlayer.PlayerGui.Gift.Enabled = false;
        Name1.Text = "";
    end);
    u12.Trove:Connect(LocalPlayer.PlayerGui.Gift.BG.Exit.MouseButton1Click, function() -- Line: 154
        -- upvalues: LocalPlayer (ref), Name1 (copy)
        LocalPlayer.PlayerGui.Gift.Enabled = false;
        Name1.Text = "";
    end);
    u12:SpawnPlayers();
    u12:GiftPlayer();
end;

function u3.KnitInit(u15) -- Line: 163
    -- upvalues: Trove (copy), LocalPlayer (copy), u1 (ref), u2 (ref), HumanoidRootPart (ref), Players (copy)
    u15.Trove = Trove.new();
    u15.Trove:Connect(LocalPlayer.CharacterAdded, function(p16) -- Line: 166
        -- upvalues: u1 (ref), u2 (ref), HumanoidRootPart (ref)
        u1 = p16;
        u2 = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
    end);
    u15.Trove:Connect(Players.PlayerRemoving, function(p17) -- Line: 172
        -- upvalues: LocalPlayer (ref), u1 (ref), HumanoidRootPart (ref), u2 (ref), u15 (copy)
        if p17 == LocalPlayer then
            u1 = nil;
            HumanoidRootPart = nil;
            u2 = nil;
            u15.Trove:Destroy();
        end;
    end);
end;

return u3;